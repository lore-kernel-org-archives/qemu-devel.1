Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4ADC2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB9F2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll3Yft3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB9F2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjuZ-0007UR-76
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 11:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jOjs6-0002xn-JH
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jOjs4-0002AT-93
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:38 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jOjs4-0002AF-49
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:36 -0400
Received: by mail-ot1-x344.google.com with SMTP id f52so245143otf.8
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=60zYU/qYsLmR5TFYPhM3vkVS2aNqUcRYbedGqccHM3A=;
 b=ll3Yft3AfMrAvz5YpGU01fy/hk+g4buQcWP77E/vkNNBcsBqBaWv8uE1yF3Bdx2adD
 j8QldQ2acPW7VefUbB0ZwearI3XxFzpa4xQPj8IU71vs+5GPBLPpIDH+nvFhevrTRoDb
 zJukb2LCPS5so8sAE3IOJoPqrxd2On9NdAkh4eXiZ5DkTt8Xm6oLcihU0U9dNAFdtoFR
 bcwX+7JkHemlvv3dy/v0sUXPY00XpDmyuEOKP3Bx3LwPaOvySwZ5S1aCQcOLxEbO1GZA
 h3ALlyPsmtXr28pl1ujr2MPkfl6EDtklehT7yBOayVXeuJJLh8wb6ncEUvtRVfLPx5/Z
 BeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=60zYU/qYsLmR5TFYPhM3vkVS2aNqUcRYbedGqccHM3A=;
 b=NfWf24OBZmEyPu1SMyfT2tDebU1Ffkx1s5ikovzQ6YHlxR/9QghNxrmz33VVO+7l4e
 zY03OR9zd3shwxKdTQJzTCgSZENbxT8EDpeGczCsswxlr7DhVk47ntmfv8vG5mJ+Espp
 wARFWe8ZLzdlLjbwvE1lHShQLH7VTHj916rS/F0ACfvP5t6dnadKfORk/GmHuiHzRjQN
 YAKBOD+KMRwR9AjLza3nm3WC6NGcXJ3S7rjYXFigE139cxBZO9P2dGrvr4la4rsLHZqY
 MzO5hD3dU0ojcQM4kT1+WJGCm13a4ysbwQdbLaROXl3bNLHHkS3S2ii2DhkF03dPh2Cs
 H2Ng==
X-Gm-Message-State: AGi0PuYl7iICjQRJrfgkMhYedGR5PIuSgjvx5Q+D35v5EtR+Z1vpg6Ph
 EFQFOIfmK6Rzt3fLFfnIXUMlSy3W438=
X-Google-Smtp-Source: APiQypJhqI5kLlaYIVwTY1Vtkw3rF5vV/pm8DuC78Ao/sHEYAQnn0EzOcq5LKSzDSL4jDZs7lIBJXw==
X-Received: by 2002:a9d:37c9:: with SMTP id x67mr22678923otb.207.1586964155040; 
 Wed, 15 Apr 2020 08:22:35 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l186sm6420434oia.46.2020.04.15.08.22.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 15 Apr 2020 08:22:34 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 4/4] qga: Restrict guest-file-read count to 48 MB to
 avoid crashes
Date: Wed, 15 Apr 2020 10:22:02 -0500
Message-Id: <20200415152202.14463-5-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415152202.14463-1-mdroth@linux.vnet.ibm.com>
References: <20200415152202.14463-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

On [*] Daniel Berrangé commented:

  The QEMU guest agent protocol is not sensible way to access huge
  files inside the guest. It requires the inefficient process of
  reading the entire data into memory than duplicating it again in
  base64 format, and then copying it again in the JSON serializer /
  monitor code.

  For arbitrary general purpose file access, especially for large
  files, use a real file transfer program or use a network block
  device, not the QEMU guest agent.

To avoid bug reports as BZ#1594054 (CVE-2018-12617), follow his
suggestion to put a low, hard limit on "count" in the guest agent
QAPI schema, and don't allow count to be larger than 48 MB.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg693176.html

Fixes: CVE-2018-12617
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1594054
Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
*update schema documentation to indicate 48MB limit instead of 10MB
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands.c       | 9 ++++++++-
 qga/qapi-schema.json | 6 ++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/qga/commands.c b/qga/commands.c
index 5611117372..efc8b90281 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "guest-agent-core.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
@@ -24,6 +25,12 @@
 #define GUEST_EXEC_MAX_OUTPUT (16*1024*1024)
 /* Allocation and I/O buffer for reading guest-exec out_data/err_data - 4KB */
 #define GUEST_EXEC_IO_SIZE (4*1024)
+/*
+ * Maximum file size to read - 48MB
+ *
+ * (48MB + Base64 3:4 overhead = JSON parser 64 MB limit)
+ */
+#define GUEST_FILE_READ_COUNT_MAX (48 * MiB)
 
 /* Note: in some situations, like with the fsfreeze, logging may be
  * temporarilly disabled. if it is necessary that a command be able
@@ -560,7 +567,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
     }
     if (!has_count) {
         count = QGA_READ_COUNT_DEFAULT;
-    } else if (count < 0 || count >= UINT32_MAX) {
+    } else if (count < 0 || count > GUEST_FILE_READ_COUNT_MAX) {
         error_setg(errp, "value '%" PRId64 "' is invalid for argument count",
                    count);
         return NULL;
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index f6fcb59f34..4be9aad48e 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -266,11 +266,13 @@
 ##
 # @guest-file-read:
 #
-# Read from an open file in the guest. Data will be base64-encoded
+# Read from an open file in the guest. Data will be base64-encoded.
+# As this command is just for limited, ad-hoc debugging, such as log
+# file access, the number of bytes to read is limited to 48 MB.
 #
 # @handle: filehandle returned by guest-file-open
 #
-# @count: maximum number of bytes to read (default is 4KB)
+# @count: maximum number of bytes to read (default is 4KB, maximum is 48MB)
 #
 # Returns: @GuestFileRead on success.
 #
-- 
2.17.1


