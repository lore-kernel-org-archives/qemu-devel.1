Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78044C282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5102171F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="D1VUC5aB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5102171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHai3-0005hu-1W
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 17:06:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHafM-0004BD-Uh
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hHafL-0003po-IA
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:38277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hHafL-0003pP-83
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1555707798;
	bh=3KaVlh88FX6Q8sq3QL4dnddPyHR4V6q2P/4djUCR4xM=;
	h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
	b=D1VUC5aBsd0REkTCx+FoxG19ViY4iKx464ushan/hNHvHztsgH1PFo3JaY6z21azc
	KogJcZbmML8iqJ8F1QTI0RJuzTYdmrcd7yLQBPsqsvBaF1NQLRRkEd5afFNMh0GGyA
	ZQ0qmv4fBQ2XF/I4FDBsI/aY9SD2/tXb2aYu/+lY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.96] ([90.214.132.136]) by mail.gmx.com (mrgmx005
	[212.227.17.184]) with ESMTPSA (Nemesis) id 1M2O6e-1hFwVP0cAA-003vpv;
	Fri, 19 Apr 2019 23:03:18 +0200
From: Nick Hudson <nick.hudson@gmx.co.uk>
To: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <fd03477a-f688-c2ab-72c6-bca9a53fa291@gmx.co.uk>
Date: Fri, 19 Apr 2019 22:03:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dS0giBq+53b/m2UW+COMEFexmf6i4h8TN9xd5ZUL7ytkwa8eaLN
	cnIVNrgxUokKxlR/0MGE/cygLoF8GZYLL7gYH8PSJL8ne/6kq20kL64lEMwWK/7YP38ZByL
	jtDsV98ei4jXD2ctDOXaP+gwYi/6wquyG4z0PyKN97SnH/mcIydeAX/TjPN4y92aWYrNAun
	+iuKFYeS++yWuzys7vReQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zcKO0MYqsqA=:3i4CXbFhBsT6mD6cgwRDx5
	THWIFo32Iyu31RbcLEmVALDffWlRGtHGThBeaz1B2KenkJxXRKsrDruJ5NM2AtHO1R2Mx/Cu/
	Ky/nlov4WXDgrlGPNRi2Fvn0Ntct+pJPowg8fnCS0/QaFD5aVsJmYKEhqKWjDqV/hCZofvnIX
	yW/70Xn4F40etB/qGc6HTRJ3UHj3MQB2aDp77Yr08jdyb4F+GjtbgXojoOVSzpA986mlKBcAK
	+doOQ4AolswLBs7415ZdAuAx7PaliyHMCZLk+Nqjy8EE0jMNYNL+CjylS/R7CgLLChDZoxK/K
	m99L3EXHwioTjNiv/0nqJ39ETH3rBVkAdEVIDyNVndbVZWrEuE7TPLZFlgEjfaoMtXMVHd/Vv
	ErDeXTh/eARBX3WMENzt9rNfpPsrEdN4wToPEDtZn/6NdGI/eYvJwXFQUVid41Xf+X4G1jWuJ
	X2MAxwzlsgazaqE1oL5zBd79ONo7RMsYcaXmn0aSgTteMucIic0+aQHFqFSg1D4Z7vS5mrge9
	NA3jTzIO2LzAgbr4dPxQJIc8EGidVgpcxMe/71jqVOHZWwNbd1No2ynOnBdQYjBBqi2SyYoAQ
	5tbefYaSw/h8bSyOdtad6xTcr9xiYrtyWGTWthjr6roFKS6LEkmhmjaGnav7UMa56wNAhPWuv
	OFgficxn4r2+TsjXmTAbQ95u1AeUtysmoI0KHWdktVfr3dEnRkGejd0s8XujHifb3k3ZNUwLG
	nHYY9mnw7NOUHXyCn5T+G5fRflBBfbgbZlVFMt53WdB6xwT8xWMr23b+qCcPTAK5HyLqwgS6F
	CjHPoBzD06s8HjaUJwlMJ+Jmw1r6ntogEJfPs4q2z9LHah+eHzrhwpRPDqpAyDb3puqTjRvDp
	fceQnia8WMC5xwIbCXafsLmuiSRkgU7aLqyex3TDPL39+xzFzAUVBgf9gITpReOU9AlO/fdLI
	7c0P4NCYYcA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
Subject: [Qemu-devel] [PATCH v1 1/2] Implement the pcxl and pcxl2 Fast TLB
 Insert, instructions as used by NetBSD (and OpenBSD)
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419210310.gmxP2zop4_e4LiH7xolStV48LhFZ8qiFotyGLoLCnfU@z>

Implement the pcxl and pcxl2 Fast TLB Insert instructions as used by NetBS=
D (and OpenBSD)

See
     https://parisc.wiki.kernel.org/images-parisc/a/a9/Pcxl2_ers.pdf
     page 13-9 (195/206)

Signed-off-by: Nick Hudson <skrll@netbsd.org>
=2D--
 target/hppa/insns.decode |  3 +++
 target/hppa/translate.c  | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 098370c2f0..f0dd71dd08 100644
=2D-- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -133,6 +133,9 @@ ixtlbx          000001 b:5 r:5 sp:2 0100000 addr:1 0 0=
0000      data=3D1
 ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
                 sp=3D%assemble_sr3x data=3D0
 +# pcxl and pcxl2 Fast TLB Insert instructions
+ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
+
 pxtlbx          000001 b:5 x:5 sp:2 0100100 local:1 m:1 -----   data=3D1
 pxtlbx          000001 b:5 x:5 ... 000100 local:1 m:1 -----     \
                 sp=3D%assemble_sr3x data=3D0
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 43b74367ea..860a659818 100644
=2D-- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2518,6 +2518,60 @@ static bool trans_pxtlbx(DisasContext *ctx, arg_pxt=
lbx *a)
 #endif
 }
 +/* Implement the pcxl and pcxl2 Fast TLB Insert instructions.
+ * See
+ *     https://parisc.wiki.kernel.org/images-parisc/a/a9/Pcxl2_ers.pdf
+ *     page 13-9 (195/206) */
+static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
+{
+    CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
+#ifndef CONFIG_USER_ONLY
+    TCGv_tl addr;
+    TCGv_reg reg;
+    TCGv_reg ar, sr;
+    TCGv_tl atl, stl;
+
+    nullify_over(ctx);
+
+//    if (not (pcx or pcxl2))
+//        return gen_illegal(ctx);
+
+    ar =3D get_temp(ctx);
+    sr =3D get_temp(ctx);
+    atl =3D get_temp_tl(ctx);
+    stl =3D get_temp_tl(ctx);
+    addr =3D get_temp_tl(ctx);
+
+
+    if (a->data) {
+        gen_helper_ixtlbxf_d(cpu_env);
+        tcg_gen_ld_reg(sr, cpu_env, offsetof(CPUHPPAState, cr[CR_ISR]));
+        tcg_gen_ld_reg(ar, cpu_env, offsetof(CPUHPPAState, cr[CR_IOR]));
+    } else {
+        gen_helper_ixtlbxf_i(cpu_env);
+        tcg_gen_ld_reg(sr, cpu_env, offsetof(CPUHPPAState, cr[CR_IIASQ]))=
;
+        tcg_gen_ld_reg(ar, cpu_env, offsetof(CPUHPPAState, cr[CR_IIAOQ]))=
;
+    }
+
+    tcg_gen_extu_reg_tl(atl, ar);
+    tcg_gen_extu_reg_tl(stl, sr);
+    tcg_gen_shli_i64(stl, stl, 32);
+    tcg_gen_or_tl(addr, atl, stl);
+    reg =3D load_gpr(ctx, a->r);
+    if (a->addr) {
+        gen_helper_itlba(cpu_env, addr, reg);
+    } else {
+        gen_helper_itlbp(cpu_env, addr, reg);
+    }
+
+    /* Exit TB for TLB change if mmu is enabled.  */
+    if (ctx->tb_flags & PSW_C) {
+        ctx->base.is_jmp =3D DISAS_IAQ_N_STALE;
+    }
+    return nullify_end(ctx);
+#endif
+}
+
 static bool trans_lpa(DisasContext *ctx, arg_ldst *a)
 {
     CHECK_MOST_PRIVILEGED(EXCP_PRIV_OPR);
=2D-
2.17.1




