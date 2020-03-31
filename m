Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2E4C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EDFA2078B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5un7EZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EDFA2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHal-0007tW-BB
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJHXq-0002kP-Pa
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJHXp-0007vg-D5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:07:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41174
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJHXp-0007vP-98
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585663628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwF8hbu4xZl3dLIjwlZr2OJsZXfk81SSvzv3n2GE69A=;
 b=N5un7EZxfCnCmvkdPNBEeqQpDH8ELtd/SqcLkq9lgLGhNOKyxMr5fo0jaOwOpcVKXu9r7K
 LjTZbokGdXB540rKNYLTwMVakwA0WZZfYlLJtMD939hL/pqG+eRPFBfg2wTh3DgsR07vQt
 CmmHRNX+lI0xAokiI1PDh6JC9Rf2VzY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-wvkI5LplMMGxw4HoJo6vWQ-1; Tue, 31 Mar 2020 10:07:05 -0400
X-MC-Unique: wvkI5LplMMGxw4HoJo6vWQ-1
Received: by mail-wr1-f70.google.com with SMTP id u16so10054393wrp.14
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uUPU6s8/wt1p8Ho/mqxi5+dJOTfJbsMKE80XrqhvBkk=;
 b=EstnNdOyoJNTg8snJkFV/pfGK8UV6M+T8BQxDNjPXE0H41Krbbs3cN61BCpImjjFgu
 1+Lgs2iTkc/7wE54t61Bwh4/uImCKRflaiFu/4Mxscvarp/BLmPuMKEEAQPK5z1glLsZ
 SaR1t0RUDJpWqXNd9Kup1f1dKrSylXPtOF4soY2fpXtibt1OyyKRvg42jJ8aQVRdbk6/
 IjY+iZeQe1z3YMJA3Wc7XRmow2zxfGZ8fESrDK6keRNx5EIU90gBc6KQBgwFxBKO9nNC
 XOU/94c3JZdTkXSuD2gBNv7aKUfQWnG0DREV9Vla3gVlUZKHX0AVU1bitokyWn9n3Ml7
 lfKQ==
X-Gm-Message-State: ANhLgQ2ILdfpPZX6k0cxN1GbFWOeq1uwNJGuPsk5fs6NcinHYjzLgBmf
 E0IjO+/aDXGWcboJ3BGSGFbejpd0W+S4gpoLcQ97Dg4t9agVdC3eXuK+fsRAE6nUpp3IU+3ggMy
 192Z5JPqktgKkrgQ=
X-Received: by 2002:a1c:770a:: with SMTP id t10mr3713745wmi.150.1585663624108; 
 Tue, 31 Mar 2020 07:07:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtbpUO9Uac5SNE5Kfxg/r7yRyX6u8wlwnp7lMRIowj1RzZs7ifjSR9Pt457xYJa1SrxSNtcNA==
X-Received: by 2002:a1c:770a:: with SMTP id t10mr3713725wmi.150.1585663623866; 
 Tue, 31 Mar 2020 07:07:03 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id m19sm3916474wml.48.2020.03.31.07.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:07:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 4/4] qga: Restrict guest-file-read count to 10 MB
 to avoid crashes
Date: Tue, 31 Mar 2020 16:06:38 +0200
Message-Id: <20200331140638.16464-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200331140638.16464-1-philmd@redhat.com>
References: <20200331140638.16464-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Sameeh Jubran <sjubran@redhat.com>, Basil Salman <basil@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On https://www.mail-archive.com/qemu-devel@nongnu.org/msg693176.html
Daniel Berrang=C3=A9 commented:

  The QEMU guest agent protocol is not sensible way to access huge
  files inside the guest. It requires the inefficient process of
  reading the entire data into memory than duplicating it again in
  base64 format, and then copying it again in the JSON serializer /
  monitor code.

  For arbitrary general purpose file access, especially for large
  files, use a real file transfer program or use a network block
  device, not the QEMU guest agent.

To avoid bug reports as BZ#1594054, follow his suggestion to put a
low, hard limit on "count" in the guest agent QAPI schema, and don't
allow count to be larger than 10 MB.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054
Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qga/qapi-schema.json | 6 ++++--
 qga/commands.c       | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index f6fcb59f34..7758d9daf8 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -266,11 +266,13 @@
 ##
 # @guest-file-read:
 #
-# Read from an open file in the guest. Data will be base64-encoded
+# Read from an open file in the guest. Data will be base64-encoded.
+# As this command is just for limited, ad-hoc debugging, such as log
+# file access, the number of bytes to read is limited to 10 MB.
 #
 # @handle: filehandle returned by guest-file-open
 #
-# @count: maximum number of bytes to read (default is 4KB)
+# @count: maximum number of bytes to read (default is 4KB, maximum is 10MB=
)
 #
 # Returns: @GuestFileRead on success.
 #
diff --git a/qga/commands.c b/qga/commands.c
index 8ee1244ebb..c130d1b0f5 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -11,6 +11,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "guest-agent-core.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
@@ -18,11 +19,14 @@
 #include "qemu/base64.h"
 #include "qemu/cutils.h"
 #include "qemu/atomic.h"
+#include "commands-common.h"
=20
 /* Maximum captured guest-exec out_data/err_data - 16MB */
 #define GUEST_EXEC_MAX_OUTPUT (16*1024*1024)
 /* Allocation and I/O buffer for reading guest-exec out_data/err_data - 4K=
B */
 #define GUEST_EXEC_IO_SIZE (4*1024)
+/* Maximum file size to read - 10MB */
+#define GUEST_FILE_READ_COUNT_MAX (10 * MiB)
=20
 /* Note: in some situations, like with the fsfreeze, logging may be
  * temporarilly disabled. if it is necessary that a command be able
@@ -559,7 +563,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool=
 has_count,
     }
     if (!has_count) {
         count =3D QGA_READ_COUNT_DEFAULT;
-    } else if (count < 0 || count >=3D UINT32_MAX) {
+    } else if (count < 0 || count > GUEST_FILE_READ_COUNT_MAX) {
         error_setg(errp, "value '%" PRId64 "' is invalid for argument coun=
t",
                    count);
         return NULL;
--=20
2.21.1


