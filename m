Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E185C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B40217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qzAQeB+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B40217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47633 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9X2-0001VD-7J
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:42:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MU-0007SI-0U
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9MT-000672-0W
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9MS-00066i-Qb
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:08 -0400
Received: by mail-pl1-x642.google.com with SMTP id d3so3129847plj.11
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=fAXpZvlDsepPUFQXEdmtR99aNvFnqvXET4zfpT6bZ/Q=;
	b=qzAQeB+RIATfRdck8iCJFBZ5cOBmMRdlNXKP+kiT0oaPRt+Fmi4QG9IFqEhHUXbHBQ
	5fLlQMW9PKxqIPmW81yLXaTzRjgpsor3L/CQeX4Q0MiKSufnwSpBO2P1mpYSw5PIxDSX
	N6JpSgHv5NBG/2zKOvfx8ZNtpPBRtNZcsnV/DtU8/St5qDIY0SDoGS+G/sJEkl8ih3uo
	sRKq5/icAOkOkn1WN53mVritvZnGi0rYUpUV95HYWfjqs5J2b0h5DuQVfSThH6Jmzjg3
	JHnWCSAHuKQInQTe/pVVv+geVzMZ2TojV2STVtk2rGhcp6BeZKn7l3vbsmDvsEE6qTH8
	YErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fAXpZvlDsepPUFQXEdmtR99aNvFnqvXET4zfpT6bZ/Q=;
	b=R99T7L4XTcSIsx0jm4hl3AC3ffLtS5UcTDC7uia0NxYA2afNMc02hUnFsGrmriK7kD
	WCXmEaAVUJQ4viPCAw7o+vKv+sbDrW9YzdrXSGPdRaDxGkOiqZsmIT8x1XJX3FZfx6ew
	+juH7U4uDUDb2jNpsjGKjdiUhBL/coUA+arTCkIsutuh7lMvTYhBAYpGoEoHBRTczch2
	8NuXDPXpSvsRdJOGv6BFBhk1J3w2T21RUJs+v2kSu91MDLqXrZfMsPuT8cC/vQrjSLEV
	A+4sLRwOPFaeHXkrO9WOcJWX4bbq2gUAgjMF6yxg47ah/F6re2v7Y6NiovEPGxbR+8/1
	qKFQ==
X-Gm-Message-State: APjAAAWebavP8jEFJZrScpvYeBnj7jR5IC5IA34rDQwFgTg5ryWKYhXa
	Bp7b6dpSwzZRQhiB7qgtmPWbiAaFwGU=
X-Google-Smtp-Source: APXvYqw9iV4oY/WR6JwCUR4C5FpbPYMec2tHtBQEOvYEkbe9DFrCUxl6K8A1irrr9bkyE/m1GnMNIQ==
X-Received: by 2002:a17:902:9a4a:: with SMTP id
	x10mr14592810plv.113.1557509467521; 
	Fri, 10 May 2019 10:31:07 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:37 -0700
Message-Id: <20190510173049.28171-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v6 13/25] linux-user: Call qcrypto_init if not
 using -seed
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 7e704845c0..e455bff1b7 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -39,6 +39,7 @@
 #include "trace/control.h"
 #include "target_elf.h"
 #include "cpu_loop-common.h"
+#include "crypto/init.h"
 
 char *exec_path;
 
@@ -688,17 +689,27 @@ int main(int argc, char **argv, char **envp)
     if (seed_optarg == NULL) {
         seed_optarg = getenv("QEMU_RAND_SEED");
     }
-    if (seed_optarg != NULL) {
-        unsigned long long seed;
+    {
+        Error *err = NULL;
+        if (seed_optarg != NULL) {
+            unsigned long long seed;
 
-        /* This will go away with the last user of rand(). */
-        if (parse_uint_full(seed_optarg, &seed, 0) != 0) {
-            fprintf(stderr, "Invalid seed number: %s\n", seed_optarg);
-            exit(EXIT_FAILURE);
+            /* This will go away with the last user of rand(). */
+            if (parse_uint_full(seed_optarg, &seed, 0) != 0) {
+                fprintf(stderr, "Invalid seed number: %s\n", seed_optarg);
+                exit(EXIT_FAILURE);
+            }
+            srand(seed);
+
+            qemu_guest_random_seed_main(seed_optarg, &err);
+        } else {
+            /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
+            qcrypto_init(&err);
+        }
+        if (err) {
+            error_reportf_err(err, "cannot initialize crypto: ");
+            exit(1);
         }
-        srand(seed);
-
-        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
     }
 
     target_environ = envlist_to_environ(envlist, NULL);
-- 
2.17.1


