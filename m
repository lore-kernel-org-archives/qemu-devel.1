Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB10CC43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8579120645
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiBUIWX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8579120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56404 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haet7-0008OP-Qq
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39457)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQH-0007Qx-Tu
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haeQA-0007ip-Tq
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haeQ3-0007ax-Jt
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id x17so12457325wrl.9
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u6koW8F7IGLYBhWLi4hkXE4YWzeq3RGbqG4uQxIjef0=;
 b=uiBUIWX9CE3A3gtpLKCkEj9wi8N3WsoIRjqX3OR6DQkwLD2pccKsXeZyFJk/pggek+
 HHSwL/z4L298J0hopFiI8buAInr3v6u+M9ZTNz0QJAmkPpkYs8JeA4GPd+3CVL7mJWR0
 58R9RgL7lMn2ctppdc4l9d6IV4nQgzKJf0IlNBlLyvon/s0pIlflTizUn1eSwcOl7IzQ
 +qun+a5xs9MiwtgCQOr1dYE9sYtzs8YSFSCXRapfnouxixgE9OsAQ6QTnGFRNQ4gBeCm
 J9iu8QoVJOGCycuhS/QRQEqc2h+MxtZG7nhPJ8y4KKAFNXa+VVqjegzTh3MEKZYuUsrG
 VmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u6koW8F7IGLYBhWLi4hkXE4YWzeq3RGbqG4uQxIjef0=;
 b=SV9Kou2hkJxHlWtbxL0zPRmckC62bYdWfEkmqy/4P4mG6oRmxLAzzvIO/0vUQMVt56
 i4E78Doi2V2mKeulyKAn7l3z/11sFhNb9/doHHQgILhcVSERi6A809MCLQC/RAxDLEK6
 VNghbEuhVGfbt0MLL+QLp72L52hpC9TsIMjGwa8dQy8aaz14PUTg0t9195WwONzox7qt
 0noAlw8d7jmqHeLptWu1RE7NXIjuWyU8mpO1vZ9/w907lz5b8jkePfQh6U98fRrzCnVO
 nnjxyXoBSKblFcb4GbgWHOuwmRp+HGpidY7yj2Lr0XEaYjEuNQx/eIMVcqE9NCwtr3Rc
 Jt9g==
X-Gm-Message-State: APjAAAW8r/94MC7Vz4owkR0H+HUcGAAhFvrmXGzIcP+ka0resPckl9ew
 I3PmRtP0iGH1JOymSfstdMoJlQ==
X-Google-Smtp-Source: APXvYqxyLMCSJ7kGXSvRs5HaYh6Dum5ZGFptgm3zAawvOLBUicBOBH/CIyEVIbvnCdjEBa7+eOyueg==
X-Received: by 2002:adf:8307:: with SMTP id 7mr32563552wrd.86.1560250460995;
 Tue, 11 Jun 2019 03:54:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.54.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:54:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:34 +0100
Message-Id: <20190611105351.9871-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2 25/42] target/arm: Convert VSUB to decodetree
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the VSUB instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 10 ++++++++++
 target/arm/translate.c         |  6 +-----
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 14aeb25f597..12da3b8acb8 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1461,3 +1461,13 @@ static bool trans_VADD_dp(DisasContext *s, arg_VADD_sp *a)
 {
     return do_vfp_3op_dp(s, gen_helper_vfp_addd, a->vd, a->vn, a->vm, false);
 }
+
+static bool trans_VSUB_sp(DisasContext *s, arg_VSUB_sp *a)
+{
+    return do_vfp_3op_sp(s, gen_helper_vfp_subs, a->vd, a->vn, a->vm, false);
+}
+
+static bool trans_VSUB_dp(DisasContext *s, arg_VSUB_sp *a)
+{
+    return do_vfp_3op_dp(s, gen_helper_vfp_subd, a->vd, a->vn, a->vm, false);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index cd1f24798b1..18d4f9933ad 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1386,7 +1386,6 @@ static inline void gen_vfp_##name(int dp)                             \
     tcg_temp_free_ptr(fpst);                                          \
 }
 
-VFP_OP2(sub)
 VFP_OP2(div)
 
 #undef VFP_OP2
@@ -3110,7 +3109,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             rn = VFP_SREG_N(insn);
 
             switch (op) {
-            case 0 ... 6:
+            case 0 ... 7:
                 /* Already handled by decodetree */
                 return 1;
             default:
@@ -3296,9 +3295,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
             for (;;) {
                 /* Perform the calculation.  */
                 switch (op) {
-                case 7: /* sub: fn - fm */
-                    gen_vfp_sub(dp);
-                    break;
                 case 8: /* div: fn / fm */
                     gen_vfp_div(dp);
                     break;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index d911f12dfd0..de56f44efc9 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -132,3 +132,8 @@ VADD_sp      ---- 1110 0.11 .... .... 1010 .0.0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp
 VADD_dp      ---- 1110 0.11 .... .... 1011 .0.0 .... \
              vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+VSUB_sp      ---- 1110 0.11 .... .... 1010 .1.0 .... \
+             vm=%vm_sp vn=%vn_sp vd=%vd_sp
+VSUB_dp      ---- 1110 0.11 .... .... 1011 .1.0 .... \
+             vm=%vm_dp vn=%vn_dp vd=%vd_dp
-- 
2.20.1


