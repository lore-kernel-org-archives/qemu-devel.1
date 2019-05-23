Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36CEC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3872075B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOpxkuiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3872075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43117 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTuet-0001Jp-Ve
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:49:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZt-00066C-EI
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hTuZr-00039p-EB
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:41 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:41858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hTuZp-00031p-EX
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:44:37 -0400
Received: by mail-yb1-xb44.google.com with SMTP id d2so2783293ybh.8
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=OnMHZ0fdYIXqikgMNKphGLIOokAtEwVDQyD+tAg9EUc=;
	b=FOpxkuiLmyiUfliFGoath1TzofiBGDO+2qccUdK2Mq+8TzGuYqAcBfE0JRXgmG3WBz
	Zxj+sOAc/Ndis9bhcGChu6NhwqhoEzXw2vMZQ8FKnIvX1PJuCvaTqxD+S+ypMjtNbFw0
	p5SMMFtxEMMmYTJ+60T19DdXy7rvkmnwQSQqiCjLy9qJUx8M2drGNv++EO38x2d+Xgik
	WOQsPaY6yJ+nLoV2qyQdNsBpDuaa2ykWO40DZlhypPsrb95Jh0XPQWgij5zM/+68y/JF
	WGOIb+WHUKAsJHJKfgV9OmznUpFTFALjumZXt3HcXwbKQGfyYZIisHF4owdAWR8PII7n
	jEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=OnMHZ0fdYIXqikgMNKphGLIOokAtEwVDQyD+tAg9EUc=;
	b=NgLWQaKgQvhtBTFdTxv1VYqkPUSG71rB+o6ycHmzKiJZAVgjkaRJzhpCpBobOdKAzv
	qKszdf7/MCb89eTS1FNruurrr19WKJNMAyQ7Wr/KV8O6JyEdizGUsokKSbh/4LAegd+e
	Q64I/bzgzOMDTJv6kwVTN9N+zEIU8FMhA7f7Aeic451Nv/nYT/y5VJAW4aOr3aqs636K
	4f7Ti7Lmk2XoKPwDtn0na+/S3WM1zr6U+dclUhO1m6MvVMhKpZnoGmRtPvPt+HbC8Ts2
	ie1IiFi8WsTUQtUC2w6H9bqYcyv0j3uB4Yed0Qo2cKEMY81E82T0lb83jDnJ9c10DesH
	1b8g==
X-Gm-Message-State: APjAAAWk7fqfeX5oNk1Jw0fDqAr3kLFUa04VI8Y+GP6tWX+UlY879s5Q
	Ax0EcBL2eAnH6KOFbsEwlSnezxCk
X-Google-Smtp-Source: APXvYqxRPhec6oKkwVoPPUpAwDTWE7/4UBTRvgqZ+0HfsilI0Ger5lJl8O6oAOBUqnjsESYXh5lZJg==
X-Received: by 2002:a5b:707:: with SMTP id g7mr45570918ybq.267.1558644272992; 
	Thu, 23 May 2019 13:44:32 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id p12sm87590ywg.72.2019.05.23.13.44.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:44:32 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:44:03 -0400
Message-Id: <20190523204409.21068-6-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523204409.21068-1-jan.bobek@gmail.com>
References: <20190523204409.21068-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RISU v3 05/11] risu_i386: implement missing
 CPU-specific functions
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

risu_i386.c is expected to implement the following functions:

- advance_pc
- get_reginfo_paramreg, set_ucontext_paramreg
- get_risuop
- get_pc

This patch adds the necessary code. We use EAX as the parameter
register and opcode "UD1 %xxx,%eax" for triggering RISU actions.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/risu_i386.c b/risu_i386.c
index 2d2f325..06d95e5 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -25,12 +25,37 @@ static int insn_is_ud2(uint32_t insn)
 
 void advance_pc(void *vuc)
 {
-    /* We assume that this is either UD1 or UD2.
-     * This would need tweaking if we want to test
-     * expected undefs on x86.
+    ucontext_t *uc = (ucontext_t *) vuc;
+
+    /*
+     * We assume that this is UD1 as per get_risuop below.
+     * This would need tweaking if we want to test expected undefs.
      */
-    ucontext_t *uc = vuc;
-    uc->uc_mcontext.gregs[REG_EIP] += 2;
+    uc->uc_mcontext.gregs[REG_E(IP)] += 3;
+}
+
+void set_ucontext_paramreg(void *vuc, uint64_t value)
+{
+    ucontext_t *uc = (ucontext_t *) vuc;
+    uc->uc_mcontext.gregs[REG_E(AX)] = value;
+}
+
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->gregs[REG_E(AX)];
+}
+
+int get_risuop(struct reginfo *ri)
+{
+    if ((ri->faulting_insn & 0xf8ffff) == 0xc0b90f) { /* UD1 %xxx,%eax */
+        return (ri->faulting_insn >> 16) & 7;
+    }
+    return -1;
+}
+
+uintptr_t get_pc(struct reginfo *ri)
+{
+    return ri->gregs[REG_E(IP)];
 }
 
 int send_register_info(int sock, void *uc)
-- 
2.20.1


