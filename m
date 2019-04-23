Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4F2C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 06:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8410B20674
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 06:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HguY+EN7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8410B20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48979 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIp42-0004QT-QA
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 02:37:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIp2q-0003mW-69
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIp2o-00079O-VC
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:49929)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hIp2o-00078H-MK
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1556001387;
	bh=pmDnzOzOC4jTZY7Mf1z/kzgc/Rod/nem/QwdT1LwwK8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HguY+EN7v6asxk0pturCHDmxCuy8Ayb12K4YlEtxtl9I65dpGPsK2eippUBZvgAK5
	4bmIl1i94o6adI1X3JA1S3pneyqTwLj7WQ1QVZ/Ok8ILVUHfSHbtw3tHAJYHEwvazt
	ohCLHMfC30sGqtguzaZODHDSEuDdWFVhinIEaJ+g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from zoom.local ([2.122.11.66]) by mail.gmx.com (mrgmx005
	[212.227.17.184]) with ESMTPSA (Nemesis) id 1MFKGZ-1h3ekM2LSj-00FgFK;
	Tue, 23 Apr 2019 08:36:27 +0200
Received: by zoom.local (Postfix, from userid 1000)
	id 205539C5572; Tue, 23 Apr 2019 07:36:23 +0100 (BST)
From: Nick Hudson <nick.hudson@gmx.co.uk>
To: Richard Henderson <rth@twiddle.net>
Date: Tue, 23 Apr 2019 07:36:20 +0100
Message-Id: <20190423063621.8203-2-nick.hudson@gmx.co.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423063621.8203-1-nick.hudson@gmx.co.uk>
References: <20190423063621.8203-1-nick.hudson@gmx.co.uk>
X-Provags-ID: V03:K1:/bB0en8Fti4Ks+rBK+GoqLVEAng0vg8KMlhZP+0p7DpVrHjTVFl
	cxW4O77jBa9keQScqTj+9Z9H4DwPKKoMQTP8/alPFtx7FYWWYBLbxyjM1FGw9vJa/WB3hK/
	5jRq++rzhLDxRUgOEPavlnEjCJSIaRu68soxZ/NvPC/OBzHvJPLR+/iUAs8cHhMjJbP42Ly
	ujWH4L6OBzdRS7rlZ/xHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:56cGzvnJ5fo=:pV3dvxN4KatIsGtGnqHsfn
	oYPllHCWwAn8C5jKZnt9/Vtx2LuEqtWsQD2zVqK5HOAESGtqKzVM+gO47uJpQ2e/ftfFWdrTV
	tla8Vab8b6zPopqnuorgR8uGdJjc89lYY+tr2FbN/Hn9LPbypMkmLuLnUSOofNyrCpXy0UYj9
	gB/v4fcealTXLj/o2twjLVMqdOzU3OqUG+dhMWLKxhwFhh60dOb/G+DgPj7S8mWZftAJvN8Lg
	16IkCeoOXTyqw0OlFjIhcw+mrgtWB/ZmkoaHyed2SWc3LTm8xqg3ts2t/LQWbE7q0//C8GIMZ
	zF+SdlVeK3Wtrje6HEENaPtKBnpMBH1PYHQJeDFsiIHegdTKdKkF4Ieik/rdhxrKbo3InZZd6
	98izPAi6ti1+QXeMCLT6b6fGpYVQrf6JUT+O5gzWyG8ABVcnwetq2ROkKSYMM/fwVOEAWVlZQ
	fa4LOyJHnZ5MeBQfNDZnaP2+oLSu5px9ptL85vnncgjrvM3Tjh1QL0wA31JPenpOtuHgyVtL4
	fwxGwvJ6pDm3LgvtYRkwmz+wOvrTG/sicWGSGS4xlwkR395IidGsMgftkTW/ilYxdutwh2pAO
	XbKsrndr6K4G/OP4sNtGXQZ6YhMkoSYK4bEvB3/tvie4GIa/UthhHTNTgV21KJFoEIprqKtnB
	HcPSWntwKsrtTbvHVlZLtXPtOOCO9VvdJHN1txUjSmltFtz/5Kfd3J5RpPBjdFALBSWK2hEsl
	Py27x/NLq6D6PTIlVfqDV4qbCU6hh6w+sxNt3rwa6JM1FjjvBGaylmrQLmQMCkyJBTN/+F0By
	q5KzqDujAGBsel+1A2xBzotGaMB5U5d/rwwhrhg3W6NQEtxXE5EzbQMS8+M00BjB5/EiyRbhP
	EIPhSCsa4zFqv604y9StBSnNpuPXwAbQGCYNoSrI1ucsfRskRtVIC0y88JydwA
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.18
Subject: [Qemu-devel] [PATCH v3 1/2] Implement the pcxl and pcxl2 Fast TLB
 Insert instructions as used by NetBSD (and OpenBSD)
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
Cc: Nick Hudson <skrll@netbsd.org>,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423063620.A9JNWDCm8nAEBkSNMQZBX0y-QlFAFTxYZVYOF_yz8QQ@z>

From: Nick Hudson <skrll@netbsd.org>

See
     https://parisc.wiki.kernel.org/images-parisc/a/a9/Pcxl2_ers.pdf
     page 13-9 (195/206)

Signed-off-by: Nick Hudson <skrll@netbsd.org>
=2D--
 target/hppa/insns.decode |  3 +++
 target/hppa/translate.c  | 52 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

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
index 43b74367ea..8d59990cfe 100644
=2D-- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2518,6 +2518,58 @@ static bool trans_pxtlbx(DisasContext *ctx, arg_pxt=
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
+/*    if (not (pcxl or pcxl2))
+          return gen_illegal(ctx); */
+
+    ar =3D get_temp(ctx);
+    sr =3D get_temp(ctx);
+    atl =3D get_temp_tl(ctx);
+    stl =3D get_temp_tl(ctx);
+    addr =3D get_temp_tl(ctx);
+
+
+    if (a->data) {
+        tcg_gen_ld_reg(sr, cpu_env, offsetof(CPUHPPAState, cr[CR_ISR]));
+        tcg_gen_ld_reg(ar, cpu_env, offsetof(CPUHPPAState, cr[CR_IOR]));
+    } else {
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


