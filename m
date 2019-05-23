Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2BEC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1489321019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ua91iBkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1489321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33162 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTl2q-00044V-9c
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:33:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkv4-0005YP-7L
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkv0-00018Z-E5
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkv0-0000vi-54
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id t5so5201080wmh.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=gOs6U+dajCIf3344cfmtEQwYTSo5fWlyTxBlW4SM4Qo=;
	b=Ua91iBkfhzDSZQQT09/eD2aY088HPqcnVLS2CalLdrbg+I7Wm6cAzwk0yOoAZw/XTp
	ji+ZVfSeo/LwsbeAM4XF1xGY8HEA/bBUXziozpCdlhdKmIiItoW+vNH9vc1Q7Yfq1rKJ
	ok6Fk0m5LNwAwqlaXPb8xv8ahFi79rfgzXbsXE9DVUVgJkiGaimSPovZshbkata4oOUo
	8QIPfbxrmUtU3YOe6WCbxw/4KwEeUe8w00m1oFHnnz4J7sOHypPielcFDgunnnCZsoaS
	FqYxoUlgsRnk/8Av6mB0hb2xbTehlxpmWZS9ObRdS4s1XnGppBTnpSHZLrlLrQupqULu
	GE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=gOs6U+dajCIf3344cfmtEQwYTSo5fWlyTxBlW4SM4Qo=;
	b=f7U80Ady3KLzVh8ARMAx0lOAcCp4TKqBe4uqevIaKS8Dl+fNv18J+/wMYWtPJXtcHJ
	kGCjb1xpec+2EUgmXh6CMfRBzE6TT2zJbKWNbhefAdPR9Zf0XofAzqTP9mRqDLhvJjdw
	H23rMD1nB8XS7xpOjaykHBXXf2EFBfTvy4L63rXfPq0xg69tf8e154GMOsh8UyS0J6Zx
	gdTYV6i0YG8YfoKimDIV/HPDHE2ohQEQD/Q6BN59nvBeceCpeG9Ud7YgHA2GolFHi7Ly
	AT8BqkE6jg8qoof2gbuu3GVqDJdkIq5XO/U/sC+XM43SSs6iufawVHtPeJ744QfRxG6a
	k4zA==
X-Gm-Message-State: APjAAAVZ2yX0P0pWxdRyhkm0fibA5E2iEMdZpzneRGcI2f7issOhRxoO
	oMbFewS/C8WswQNwpSjTLoG02Q==
X-Google-Smtp-Source: APXvYqxDXOk8OIbH1AftaZR7AH+fWPSUYu97i6t2jDIKByxY+eNPDlIsD835xCJOgpnOR7VpiwtD4A==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr5246214wmf.35.1558607138901;
	Thu, 23 May 2019 03:25:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id 24sm7218895wmo.3.2019.05.23.03.25.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:35 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 340541FF87;
	Thu, 23 May 2019 11:25:33 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:12 +0100
Message-Id: <20190523102532.10486-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 08/28] target/arm: correct return values for
 WRITE/READ in arm-semi
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The documentation says the write should return the number of bytes not
written on an error (0 means everything was written). Read provides a
buffer length and the return value should be the buffer length - bytes
actually read. Remove the incorrect FIXME's and return the correct
values.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/arm/arm-semi.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index a3bbef18ef7..3ae8f05d51b 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -334,13 +334,15 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         } else {
             s = lock_user(VERIFY_READ, arg1, len, 1);
             if (!s) {
-                /* FIXME - should this error code be -TARGET_EFAULT ? */
-                return (uint32_t)-1;
+                /* Return bytes not written on error */
+                return len;
             }
             ret = set_swi_errno(ts, write(arg0, s, len));
             unlock_user(s, arg1, 0);
-            if (ret == (uint32_t)-1)
-                return -1;
+            if (ret == (uint32_t)-1) {
+                ret = 0;
+            }
+            /* Return bytes not written */
             return len - ret;
         }
     case TARGET_SYS_READ:
@@ -355,15 +357,17 @@ target_ulong do_arm_semihosting(CPUARMState *env)
         } else {
             s = lock_user(VERIFY_WRITE, arg1, len, 0);
             if (!s) {
-                /* FIXME - should this error code be -TARGET_EFAULT ? */
-                return (uint32_t)-1;
+                /* return bytes not read */
+                return len;
             }
             do {
                 ret = set_swi_errno(ts, read(arg0, s, len));
             } while (ret == -1 && errno == EINTR);
             unlock_user(s, arg1, len);
-            if (ret == (uint32_t)-1)
-                return -1;
+            if (ret == (uint32_t)-1) {
+                ret = 0;
+            }
+            /* Return bytes not read */
             return len - ret;
         }
     case TARGET_SYS_READC:
-- 
2.20.1


