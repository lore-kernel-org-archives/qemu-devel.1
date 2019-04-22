Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD439C282CE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 12:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B03B2077C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 12:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="E2daNP6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B03B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36991 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIYLU-0005lv-SP
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 08:46:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIYJz-0004eN-8z
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nick.hudson@gmx.co.uk>) id 1hIY9a-0005Qk-M9
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:34:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:57409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nick.hudson@gmx.co.uk>)
	id 1hIY9a-0005Pp-DR
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 08:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1555936456;
	bh=/PzhFyJo/5/oer7KIAlvwSBy5oxejhchk1Rhil8/rEU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E2daNP6/S5c6XMn7j6NDWEWcme3EhQKh5TKfVRU7moQUPmd8PuplkpPMrpAaMt/hp
	TY7ZqgiSgW3I2esIfzKjdDxUw3rylaMPY2fkCEnBghDXg2KuFWjf+BfQgOsKUKZ7YT
	zHcGGEMGEfdB/NLf3I8UFQGyuBkzen/5h9CKiYmU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from zoom.local ([2.122.11.66]) by mail.gmx.com (mrgmx103
	[212.227.17.174]) with ESMTPSA (Nemesis) id 0MAy40-1h8bzv3ohA-00A0Gp;
	Mon, 22 Apr 2019 14:34:16 +0200
Received: by zoom.local (Postfix, from userid 1000)
	id 9ADFE9C5571; Mon, 22 Apr 2019 13:34:14 +0100 (BST)
From: Nick Hudson <nick.hudson@gmx.co.uk>
To: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 Apr 2019 13:34:10 +0100
Message-Id: <20190422123411.5178-2-nick.hudson@gmx.co.uk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190422123411.5178-1-nick.hudson@gmx.co.uk>
References: <20190422123411.5178-1-nick.hudson@gmx.co.uk>
X-Provags-ID: V03:K1:zr2QrhgbcgTatwbjElJWUbMN4d4dty8AiSua9h8gfi/agz/Fpor
	jZRjSpMt1vLi52VP+fuQ81j4u6yaCUdCwD86MWAcpGNWzfxvGrcYC900kVVlLuKft8tqMqn
	S0mHGJoJvm/+RhLge2IGrWBsCr2dtJJD4jFMwws3ZFuFRLPh0rQWwjbGWL/gYVlGqsLD/dP
	nYt9KYnJQm5TkPsFlLtiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:amRl5QXQvc0=:W1mVqdLMosYyD1xehemfi3
	ptUuR50l3icNJS4mrvZ9MbmZ7WWvSqYig1r7Yt9ah1zoWzM8Q00pmEgjHOB8YGYiEdLy5bC3y
	TxkdrEil13Ev7hKHQSG3eReQz3ipa40kkv25klF1pqr3SkHiuKKKh21pkI6rTIIrmDdBZ0fsg
	TjtE/inCCa/UAge6ETdMig3aUgpzCvFgAX/gilFNHM7ClM69nEDksFs+rqmIUQMf1q7aBSqCF
	JFG4i1NsjHMaGTepLu8RU5gg8U3PFX5oXaQJoB+RfgFWRgaERFCbEm4anG0KZa0w+lm5/ykWW
	uxuHibVG1TS8IeBz27RB96FUyaed5oNLFxZdPnJ0gcm3W9woUIiTJBOIOH6Rd27tq08uNbSO1
	MTZwO2O/wTYpQLySxPVT7k15gwM20/m+YsLb8HuicpkxkGC0CK4h3rfH3T9aF6BLWNp7Ibfd+
	gy3TJ5atAoBWeAC9XFWPW+rTsydES0eo7mypNrcOUBKwzthzLP1FLOxUIHmZOnxVPaHbkwVmC
	NO+TyguF4+6uhescoy0RgXysvkSYsjwZO5dsRYlLdpfcrGoqNXrAm3lXbO4AGoy0bMc5eMOew
	lgUGCggOdoUVL1ZiwNwTInIia+aaHUHVaJzyEUyQIRi62WdbGi4hgI+TbyTZ/ijAOMCIhv21v
	AcdTQGWEfgGIRD4zgaQVF3P2bwVgTI5JH5+x18XhV80FntoKWBpkD56akCGvLoxsrT9TlVn9o
	tRwWzYEWNeKP7rEb4zgxKPXm0/VrsNaoi0tF33+yntdBbIUrin79SxIjfgKUnv0/B/tpMZq2C
	HWtmreCXxJAZ0SVKQ0iX16UUo0moANgSXa9RcsxbkfA83s/17/yLG9VQDvWOTtii/dr9BaUON
	6kXif1c69TC6lAasuWYWSNc1Bqt8UEpUda/eFWTcHHHorncNwqlv3Yfal6eRP7
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.22
Subject: [Qemu-devel] [PATCH v2 1/2] Implement the pcxl and pcxl2 Fast TLB
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
Message-ID: <20190422123410.SVa8Y_gDrUQ75HY6NOr2-8yHuehtbnP5cxszH_KoCaE@z>

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
index 43b74367ea..6038cbc3dd 100644
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


