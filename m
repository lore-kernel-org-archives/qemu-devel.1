Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3CCC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 18:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289F92077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 18:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejoz1qIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289F92077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50537 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK5Vs-0007G7-C3
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 14:23:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UG-00063p-NG
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UF-0006Nr-Fi
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:16 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:47053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK5UF-0006Mb-8m
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id j11so2091608pff.13
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=oU5HGPgJ+DQOZUnHAyoa1yAy/pkjT0xbkkdnad1zEYs=;
	b=ejoz1qIQ6WVHzQnSYm1TtP0hrHqwyuFm0PbitYelaH26diVMwvlALWYRjyI+k72jh5
	F2Yw7nEuB6iQb5YRwl11V6cbIGQanUmgrBdfbT66VPQXFnpD14GCF7hZwpBX5JCpnPrc
	6DfHQkxvMifu+f/V5xnUZIAb83qsOBGI9UCtCGDiZjF4+qa2rpQja/2MWx6bd7FBzA0E
	USSNTGJp3NG8bJ140+Edfiv6dhPwGNQeZ/DmLuFVGleyVlN9S026YXBKMt/iYY1KZEmQ
	ikZ/l+0LeKLHAs4ikgP4HUjmCJFsnA4X+MrnYysqxlbLAD+bHuopJIbvTbX4t4lFLPp+
	NJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=oU5HGPgJ+DQOZUnHAyoa1yAy/pkjT0xbkkdnad1zEYs=;
	b=iX0uCjO/XPTTB4oh+hBCZZnMM1KM1uW6hYixRi8JPyZQcuNbFcFVT+6xIHn8LhLIQv
	Y079sw4Qecnz6dcQhJR15B4ytdfOAYPF3CO9hXKi2AbY+yXF0tOoDgSHtoJsKAsV4XPX
	9//NK8zPtTGV6YOx4j318B8bxGS6tniDcnmpLmQvHeaCgPnKlF+u/JWWokcXUAaaWPxG
	189tQkQH6UGArNx9qVd39ybDVBUGzGnrAsumi+mHMmZLENw1Ru2ZznDhtMCTggx2qlOo
	h2EcIrnK7xguskVTj9jbVZeGRWAjdmRo4IDDk/0FVVQYkNZW5ApMIgw4n6xyy/jXckJg
	QJYw==
X-Gm-Message-State: APjAAAWFE6ywNIaW9nkPwKVBuQuyAtIRDnMjnI8zFOKihf2ptVPp6aln
	jq8G/4NWAV/c5Vf/Tp7SDpyNKMwU8ks=
X-Google-Smtp-Source: APXvYqzrz37qj71Q456w2bpgKckkIT/Wjm8eOzIIryCjFZFFcAL3wH2NhWcJl9akAvUPxFT0GgNe1Q==
X-Received: by 2002:a62:7089:: with SMTP id
	l131mr49804065pfc.158.1556302933326; 
	Fri, 26 Apr 2019 11:22:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	c28sm15977095pgm.42.2019.04.26.11.22.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 11:22:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 11:22:09 -0700
Message-Id: <20190426182210.10442-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426182210.10442-1-richard.henderson@linaro.org>
References: <20190426182210.10442-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::431
Subject: [Qemu-devel] [PULL 1/2] target/hppa: Implement Fast TLB Insert
 instructions
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
Cc: Nick Hudson <skrll@netbsd.org>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426182209.r5NFJba5gxVQZBFRumQ83nVsRoLr1xUoUsG6h4H9V1I@z>

From: Nick Hudson <skrll@netbsd.org>

These instructions are present on pcxl and pcxl2 machines,
and are used by NetBSD and OpenBSD.  See

     https://parisc.wiki.kernel.org/images-parisc/a/a9/Pcxl2_ers.pdf
     page 13-9 (195/206)

Signed-off-by: Nick Hudson <skrll@netbsd.org>
Message-Id: <20190423063621.8203-2-nick.hudson@gmx.co.uk>
[rth: Use extending loads, locally managed temporaries.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c  | 54 ++++++++++++++++++++++++++++++++++++++++
 target/hppa/insns.decode |  3 +++
 2 files changed, 57 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 43b74367ea..aa140c6c72 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2518,6 +2518,60 @@ static bool trans_pxtlbx(DisasContext *ctx, arg_pxtlbx *a)
 #endif
 }
 
+/*
+ * Implement the pcxl and pcxl2 Fast TLB Insert instructions.
+ * See
+ *     https://parisc.wiki.kernel.org/images-parisc/a/a9/Pcxl2_ers.pdf
+ *     page 13-9 (195/206)
+ */
+static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    TCGv_tl addr, atl, stl;
+    TCGv_reg reg;
+
+    nullify_over(ctx);
+
+    /*
+     * FIXME:
+     *  if (not (pcxl or pcxl2))
+     *    return gen_illegal(ctx);
+     *
+     * Note for future: these are 32-bit systems; no hppa64.
+     */
+
+    atl = tcg_temp_new_tl(ctx);
+    stl = tcg_temp_new_tl(ctx);
+    addr = tcg_temp_new_tl(ctx);
+
+    tcg_gen_ld32u_i64(stl, cpu_env,
+                      a->data ? offsetof(CPUHPPAState, cr[CR_ISR])
+                      : offsetof(CPUHPPAState, cr[CR_IIASQ]));
+    tcg_gen_ld32u_i64(atl, cpu_env,
+                      a->data ? offsetof(CPUHPPAState, cr[CR_IOR])
+                      : offsetof(CPUHPPAState, cr[CR_IIAOQ]));
+    tcg_gen_shli_i64(stl, stl, 32);
+    tcg_gen_or_tl(addr, atl, stl);
+    tcg_temp_free_tl(atl);
+    tcg_temp_free_tl(stl);
+
+    reg = load_gpr(ctx, a->r);
+    if (a->addr) {
+        gen_helper_itlba(cpu_env, addr, reg);
+    } else {
+        gen_helper_itlbp(cpu_env, addr, reg);
+    }
+    tcg_temp_free_tl(addr);
+
+    /* Exit TB for TLB change if mmu is enabled.  */
+    if (ctx->tb_flags & PSW_C) {
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+    }
+    return nullify_end(ctx);
+#endif
+}
+
 static bool trans_lpa(DisasContext *ctx, arg_ldst *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 098370c2f0..f0dd71dd08 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -133,6 +133,9 @@ ixtlbx          000001 b:5 r:5 sp:2 0100000 addr:1 0 00000      data=1
 ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
                 sp=%assemble_sr3x data=0
 
+# pcxl and pcxl2 Fast TLB Insert instructions
+ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
+
 pxtlbx          000001 b:5 x:5 sp:2 0100100 local:1 m:1 -----   data=1
 pxtlbx          000001 b:5 x:5 ... 000100 local:1 m:1 -----     \
                 sp=%assemble_sr3x data=0
-- 
2.17.1


