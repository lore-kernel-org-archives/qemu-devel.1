Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEAFC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A677F2072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBNdStsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A677F2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioX9e-00012l-1y
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3q-0001dU-4Y
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3n-0003lu-LE
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:05 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:42538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX3n-0003lV-Eo; Mon, 06 Jan 2020 13:25:03 -0500
Received: by mail-qk1-x741.google.com with SMTP id z14so39012652qkg.9;
 Mon, 06 Jan 2020 10:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6Myf4ZWmr4nE4JAJE8+rypGdemGPMt6KifqXfy2qX4M=;
 b=BBNdStsnR86XbL41pOc8DijV7GPqR46FvkotpzYm449GLuY7kU1qnOn0nKQiNf1uvS
 DhUxUGtVM0M7J5op78fqT8N66vKJR2dQODcEHb31rzpxoUBCbP0eqq0P97ghSs5rCG7R
 XUGg4r4ldA8QUDUJ7zj2cAWLfC1SE+JHNykcEDL7F1Yi0m4C+63MS2E4V4G0U9IW7Vqk
 hoW9YyZIA7MkYzdCu2aME/rI8JTLIyK+0tdxBstBg7ZkcGmxMhMW0rkkJCSjFNfx76jh
 KbzqHKCTNmzkDqxt7pIfBxSR36Gg/D0G/c2KYZJnI6PeAPIcdpufi18OidMBs+TEOtlS
 jthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6Myf4ZWmr4nE4JAJE8+rypGdemGPMt6KifqXfy2qX4M=;
 b=g1J1FdUFOJ4ogP6SbSAgBjHHIDbRUVKNEZi+YKg+WF4gQOPn8Eozdx2FixaQe06Afl
 uKgOZSbL2Gl3DrQc9uSmboz/4BnLIfTOdIZTt1SIkpl2Y9IDnOtkCl91XwoYEWPU3GK8
 Es5pvbKRU1XmgeQLK+MMP8GnD8Kpde6et5y5czCtSoyEZpzh0vqbJvJDbPFHGzDEsMAk
 T2qMySwWUXP03BLmn+FiPWsx0Ix/VxnqYpPR0vtV2W9bR+PNr+Qa4mkMS3RFFs8vnu5E
 JeFeE3947L+ZWF7DHh6oJJH68v0U8c9pRMmMnM9tbNMMcxxjaRkOo1RcmALtHnIUc5P9
 NSHA==
X-Gm-Message-State: APjAAAUh+lPw18YDJg4HTRNtthXgOWWE/R4IK8Af9xpIcHBXxbGy490Z
 lvOxl3tMUk+pVt2m7mSlaH4znWqP
X-Google-Smtp-Source: APXvYqy+sEo/5P9jgzxK2PvQhLOP0hE9C4PXCbzbNZ+mUJ+LarIsGOdiT0jcUwA2uNynUVAd7dPVaA==
X-Received: by 2002:a37:a54b:: with SMTP id o72mr83397639qke.313.1578335102807; 
 Mon, 06 Jan 2020 10:25:02 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:02 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/59] mips-semi.c: remove 'uhi_done' label in
 helper_do_semihosting()
Date: Mon,  6 Jan 2020 15:23:32 -0300
Message-Id: <20200106182425.20312-7-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: qemu-trivial@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The label 'uhi_done' is a simple 'return' call and can
be removed for a bit more clarity in the code.

CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Aleksandar Markovic <amarkovic@wavecomp.com>
CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/mips/mips-semi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/mips/mips-semi.c b/target/mips/mips-semi.c
index 35bdfd7c77..10a710c1e8 100644
--- a/target/mips/mips-semi.c
+++ b/target/mips/mips-semi.c
@@ -218,7 +218,7 @@ static int copy_argn_to_target(CPUMIPSState *env, int arg_num,
         if (!p) {                               \
             gpr[2] = -1;                        \
             gpr[3] = EFAULT;                    \
-            goto uhi_done;                      \
+            return;                             \
         }                                       \
     } while (0)
 
@@ -228,14 +228,14 @@ static int copy_argn_to_target(CPUMIPSState *env, int arg_num,
         if (!p) {                                       \
             gpr[2] = -1;                                \
             gpr[3] = EFAULT;                            \
-            goto uhi_done;                              \
+            return;                                     \
         }                                               \
         p2 = lock_user_string(addr2);                   \
         if (!p2) {                                      \
             unlock_user(p, addr, 0);                    \
             gpr[2] = -1;                                \
             gpr[3] = EFAULT;                            \
-            goto uhi_done;                              \
+            return;                                     \
         }                                               \
     } while (0)
 
@@ -272,7 +272,7 @@ void helper_do_semihosting(CPUMIPSState *env)
         if (gpr[4] < 3) {
             /* ignore closing stdin/stdout/stderr */
             gpr[2] = 0;
-            goto uhi_done;
+            return;
         }
         gpr[2] = close(gpr[4]);
         gpr[3] = errno_mips(errno);
@@ -302,7 +302,7 @@ void helper_do_semihosting(CPUMIPSState *env)
             gpr[2] = fstat(gpr[4], &sbuf);
             gpr[3] = errno_mips(errno);
             if (gpr[2]) {
-                goto uhi_done;
+                return;
             }
             gpr[2] = copy_stat_to_target(env, &sbuf, gpr[5]);
             gpr[3] = errno_mips(errno);
@@ -314,14 +314,14 @@ void helper_do_semihosting(CPUMIPSState *env)
     case UHI_argnlen:
         if (gpr[4] >= semihosting_get_argc()) {
             gpr[2] = -1;
-            goto uhi_done;
+            return;
         }
         gpr[2] = strlen(semihosting_get_arg(gpr[4]));
         break;
     case UHI_argn:
         if (gpr[4] >= semihosting_get_argc()) {
             gpr[2] = -1;
-            goto uhi_done;
+            return;
         }
         gpr[2] = copy_argn_to_target(env, gpr[4], gpr[5]);
         break;
@@ -369,6 +369,5 @@ void helper_do_semihosting(CPUMIPSState *env)
         fprintf(stderr, "Unknown UHI operation %d\n", op);
         abort();
     }
-uhi_done:
     return;
 }
-- 
2.24.1


