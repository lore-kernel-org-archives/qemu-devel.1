Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274A7C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BCA20665
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8kaIRy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BCA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwnl-0007p9-5m
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:07:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwUB-0004Zy-5U
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwU8-0004EB-4Z
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwU7-00035y-N5
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id x17so3323023wrl.9
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=O5grNllV+sv27kAA5O3rl1i8qW/FtM8e/iepHVf3KD8=;
	b=p8kaIRy4pZWp1AK0+YjVMmUWTVQxxPrT3d5rzcuG+7xKitRD1gc9N1kKuqrO/vjL+f
	fKmx+2O9OzWJIQzC42CK31rdK8J6QrWAcSswUzCgrT3VsB8jPcQgS5ei9Cblf3P7lrUQ
	CoUBaVKB59i+KxtZaKwWFrpLNIC0ma0yKMksOokoFPcICBHDz4QfomgOUtBQV3E4rwU6
	9CBUJQCKlzOUpOWgcdjjCXhcR3HgjBucwdpryWsP6HLNGqT4A6KkMrUH3YE70ANwEiRx
	aRrHdffAUDWgB3+/gJ4d/EIQhNVzq2unFwMkFoNVWL+AZS8AY6uoP7SBHq9axK5SR/mx
	jzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=O5grNllV+sv27kAA5O3rl1i8qW/FtM8e/iepHVf3KD8=;
	b=PY/Lz5wZNT2lwd0kfyThD1tWoJHJ7+k6Wl0YRZhyj659m1UuVIgpjm0LG3VyZfNTIr
	9/8JSK2E5EiWCmLtnrWnGEoXP2ZfZAhA9Lb3NlGeHEjPIAkr/pvxAwQFaZqtbKn8/Upf
	8J7Mlr7KdJBMOkGubG+2r5ca5KSQWs33XTa1s8YSzA0ZKSjBcNQIwKEU9bdXL6Y8XcYK
	HU0bkdlqYG11QjXT12OA/yXoRU9escKdWhcaQvtKVsAF53VM+WkaLRKYCz/Ge481FdLR
	HHrC+bKAhhGRALS2gF/nW4ucCym8v6InmpfQLVj6o/rYyzDmdzqcG7qWRJy0TrKWgJBC
	rJMg==
X-Gm-Message-State: APjAAAWZNU7N6AFadnR3PZBatrxVGY7SBi4aCeUgHr8hjHn6NE2MM0YC
	LFH6fwWtybtcqkaZVaVooXfRMA==
X-Google-Smtp-Source: APXvYqz1q6bLJI+Vj7CpTmKUxNMjB2p68bB+/xd2pWJyorFWeGVK4i3ODMpdNovY/VfC+Mj4d2jhBg==
X-Received: by 2002:adf:e309:: with SMTP id b9mr30659068wrj.135.1559843195961; 
	Thu, 06 Jun 2019 10:46:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:49 +0100
Message-Id: <20190606174609.20487-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 22/42] target/arm: Convert VMUL to decodetree
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VMUL instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  5 +----
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 8532bf4abcd..a2afe82b349 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1417,3 +1417,13 @@ static bool trans_VNMLA_dp(DisasContext *s, arg_VNMLA_sp *a)
 {
     return do_vfp_3op_dp(s, gen_VNMLA_dp, a->vd, a->vn, a->vm, true);
 }
+
+static bool trans_VMUL_sp(DisasContext *s, arg_VMUL_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_helper_vfp_muls, a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VMUL_dp(DisasContext *s, arg_VMUL_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_helper_vfp_muld, a->vd, a->vn, a->vm, false);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 73b30ed33d1..226f1006ced 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3112,7 +3112,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 3:
+            case 0 ... 4:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3298,9 +3298,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 4: /* mul: fn * fm */
-                    gen_vfp_mul(dp);
-                    break;
                 case 5: /* nmul: -(fn * fm) */
                     gen_vfp_mul(dp);
                     gen_vfp_neg(dp);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index c50d2c3ebf3..d7fcb9709a9 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -117,3 +117,8 @@ VNMLA_sp     ---- 1110 0.01 .... .... 1010 .1.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VNMLA_dp     ---- 1110 0.01 .... .... 1011 .1.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VMUL_sp      ---- 1110 0.10 .... .... 1010 .0.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VMUL_dp      ---- 1110 0.10 .... .... 1011 .0.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


