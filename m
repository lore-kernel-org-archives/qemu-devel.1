Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94B7C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 10:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81180206DA
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 10:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1Yif6eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81180206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNa7f-0004Su-MU
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 06:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1jNa6T-0003ou-Kr
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 06:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changbin.du@gmail.com>) id 1jNa6S-0004FZ-Fx
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 06:44:41 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <changbin.du@gmail.com>)
 id 1jNa6S-0004F5-8f
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 06:44:40 -0400
Received: by mail-pl1-x641.google.com with SMTP id v2so2383291plp.9
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 03:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P/BkFFFE0kL0UxA6yxiSebZm+uJIjXAGvFH5F/PCQ18=;
 b=M1Yif6egcr3WpMikWyBTKh+tvgWEQrmO85kdpwg/GgIBAY8urGz0OZOeZrDSCMMkwm
 ibArNDAnwRbeTM13Z1m7ptFo74Vod+FQHT67P2r7qikYM2Mx/mBfssIdxJwIRA0gg6hT
 ZyUXs94wogRI2tcCWt9nT7aWHKd9xM+/M34NOCcBNxRAuVejPGLafb02/Qs8j0nhi5PX
 kvp/UqboBDlVQ65zXvuH3jpNn/2ted8CqiFUO54Hh3HU54bCdD3XL1/1PIUC1i0CRjDA
 +hUOtc6DvtI6fwGXhhhBvvPyf5xN1EmtIcKMv5HVHj7SEtCqLtn+SUZ//+3DEAWq2+ad
 rBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P/BkFFFE0kL0UxA6yxiSebZm+uJIjXAGvFH5F/PCQ18=;
 b=VLnVrDPimVWWbb82sR6OgvpkxrNAzmcZGppQawjmqxfL71SD+/XrmU4TTNAa1Q18vi
 Xtqzf1bwFz/aXu/JuWWfOfPfg3e8fvpn85VE7mnmZOOcKxthpRs+JU+APT8PotOXrAyy
 416TU9VElYBXLWQHOtor4k9Yo/v8ci3jSpo8ezzmo/LzPGslIvlXJxWzM5o6VaGJKFNV
 Uzu9rg5/mfMrGkFq0DVSm5SHh0sJPTPV8F+0Ib1UkVPk5146i/CmSereH3kj0bnEra4n
 IoLUV9X/hO0v+AhQbBJRBORtycp95TVZyXh9oVB6e4QZW/CrVXS0n4+kdaGSKllSK/u2
 I4MQ==
X-Gm-Message-State: AGi0PuY16qmpSPlhURsaxi4NGoQkjcSZPmErRKopEXb/QCLDOFewACCM
 N59TpJInExTVB6wfWuD021A=
X-Google-Smtp-Source: APiQypL+V8lBoSbP/t0iBRywE0BL5tpDIO6Nwi1aGtoSIbu+3cSuXWUNNxDdaj0dFGeBYfK8EHLmaw==
X-Received: by 2002:a17:90a:757:: with SMTP id
 s23mr15556873pje.166.1586688278582; 
 Sun, 12 Apr 2020 03:44:38 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id 63sm6029985pfe.96.2020.04.12.03.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 03:44:37 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] gdbstub: Fix segment fault for i386 and m68k
Date: Sun, 12 Apr 2020 18:44:21 +0800
Message-Id: <20200412104421.77975-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: qemu-devel@nongnu.org, Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With GByteArray, we should pass the object itself but not to plus an offset.

gdb log:
Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
__memmove_avx_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:384
384	../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S: No such file or directory.

Fixes: a010bdbe71 ("gdbstub: extend GByteArray to read register helpers")
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 target/i386/gdbstub.c | 2 +-
 target/m68k/helper.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index f3d23b614e..b98a99500a 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -106,7 +106,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
         floatx80 *fp = (floatx80 *) &env->fpregs[n - IDX_FP_REGS];
         int len = gdb_get_reg64(mem_buf, cpu_to_le64(fp->low));
-        len += gdb_get_reg16(mem_buf + len, cpu_to_le16(fp->high));
+        len += gdb_get_reg16(mem_buf, cpu_to_le16(fp->high));
         return len;
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 014657c637..cad4083895 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -109,8 +109,8 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
 {
     if (n < 8) {
         int len = gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
-        len += gdb_get_reg16(mem_buf + len, 0);
-        len += gdb_get_reg64(mem_buf + len, env->fregs[n].l.lower);
+        len += gdb_get_reg16(mem_buf, 0);
+        len += gdb_get_reg64(mem_buf, env->fregs[n].l.lower);
         return len;
     }
     switch (n) {
-- 
2.25.1


