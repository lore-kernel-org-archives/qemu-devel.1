Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_MSGID_YAHOO,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C6C282E1
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 07:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE83E20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 07:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hMmzi2GJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE83E20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUnlh-0005Ma-Qr
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 03:40:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1hUnka-0004cc-DK
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1hUncU-0004ku-CI
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:31:04 -0400
Received: from sonic314-48.consmr.mail.sg3.yahoo.com ([106.10.240.172]:38116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1hUncS-0004im-Vg
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1558855855; bh=nJDhTYoF5BMQpZWgNBuvAWMTxFzwnMZo864YYhno/dU=;
	h=From:To:Cc:Subject:Date:From:Subject;
	b=hMmzi2GJAk02g0OIMGHUVmqrLJz7aEwopOJsrNNtrbxNFN09BK6kqmaGcS8lkm/v9qm8T5TTnfEZQJilziHBA8mMtHFYaBt9Xh5r+6z2WG9/zkgIGIuEN0xr2TXvSozC78MEIDvTTfiZ5vSrpz6HUbl4N3o2as/bVmTO5XOB9Zikg7/xwspyhmjfmyVqQK98Av0msoPa0mGrsr8tlsGqGmhdjuL6XBO/rNHmUNAxxwBgvuz4r98uHWdML8zPXUcDR8McbrvfaEyKb4OKqRh00K5oduAaA20sbU/uRz5ZUSbzeaIEpZnTxLazqr+GANuiBvAZlbTF0CuERQqlrqiiFw==
X-YMail-OSG: KQuUfvEVM1le0q9SxPoQcCKzbzN3Q4AkKyzQ3eAx1yXKpae3QjXjEQB21pThW5S
	5mNvm1eTWaaEbCD99gIFQPh83iiv_R.baLaN8sdq.AJLu1TbwXSK3IJLNI.WHn7ofEb0c5dF6VrM
	_4Xc1Tp2EU3RucyqdeRK83sVpzYGxMwYpRCiYa4vxlMoifnUdVkbamownF6mcAxPV12gZ12MH6.r
	ylpoPISRfYtYUXwaRL3cJuPhklDqZT6E3rp2UVo2wdBSLIi4a6t6N5mHzSke0MONA8VKSqZ8EZcu
	IngjJIsbg.rFsVvuNHj7TNYMoOSo9xKf5Gc2_2iPDo3JGrQzhAynbP1GD7dMTiaLPtEtms0SR8XH
	MoYC5rlNbDiXlw8vR2W1d9c2.DhfNaR0EUx8GfqGmulpb44z2_Z08xXseJEUrBMfwCZV8emWODBl
	XalBTuAWUV25Qg6Sm9i6Xr54RSKK4G9dNLICXiZTcTR4hmqDgNid976_m0JK4qdhImrZB1JOhexg
	ESBFr5N8uf0QorEq_Jp3uFFA.dujFnr5f7bTGkv0Y7uaX8e6lVfYOfkKIllRMXeurmDnZB2_9mtr
	NZnuI3Nwar4o7Xj31gRBJGTgRRozbhHxhc3k3ACSNiKjPV6FsJMHpi.kq2c1pWQ.AIJisKjaDymT
	mW5Dg.ebgoB2Q8fImENahVFG9qNBK1cQXSyKQVic3_CHuV4TI8PiUfsGy3VG32ORGjetin.qr8zO
	g5CZ5sjPtXVRcNDNRsJizcNIVZwxcvVPDl_0NaqUaB7Y10ht6GLW9kHHFz00dTLRqrucDuaJ2sbt
	ftW98EbHJBiCroHf5qk9Eo2DHsNMCXetkyKT788wsJ4PrN7y4HQ_kRGuX.HnKZH3FKfVpPtHl.7R
	RdXfUhIrrIFtrb.E7sW0z9iJBKknvTTB29m3OL1nxPzPZpqa3bGfldxq1_Yg_rv2TKmIK0SET0J7
	ofT6LH5vm6hLnBDHvsfJixtnYF5PcGR9hHVmm.d9cYc_SXPSSGEIxYam1IERIBS7oeJbkxVVV5lC
	ehNYzLdX0Xk9hr0D7yVLHUlTR250SL5OQDr2EpmqIqTLrhkRGKVoRZ3FxMpTVWW3_I6ngv7wHkTX
	B8WV2CkhFu4wPW5RivHIJ2_d6ErHf2R2M3bPbc79JenCpEDDyGimnRmnyY6_2MKu4FHAX8_VKKbH
	x8FUaoP8zfX5OV4ffZesZ76Hvj.PPsdiSDeQVOS313v8IIdBKPX2bu5Aa8c5weaT8A4v5V1w3gAh
	6uVWjyFoX31nRRAYJk4ayTDuZqGeGgBz70y_JbmGP
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic314.consmr.mail.sg3.yahoo.com with HTTP;
	Sun, 26 May 2019 07:30:55 +0000
Received: from pl35138.ag1212.nttpc.ne.jp (EHLO localhost.localdomain)
	([133.232.247.66])
	by smtp404.mail.sg3.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
	e0037fd4d9353a4bdc1ee07ef99d6af6; 
	Sun, 26 May 2019 07:28:54 +0000 (UTC)
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 16:28:26 +0900
Message-Id: <20190526072826.32956-1-lucienmp_antispam@yahoo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 106.10.240.172
Subject: [Qemu-devel] [PATCH] Incorrect Stack Pointer shadow register
 support on some m68k CPUs
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
From: Lucien Murray-Pitts via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>,
	"Emilio G . Cota" <cota@braap.org>, lucienmp_antispam@yahoo.com,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On CPU32 and the early 68000 and 68010 the ISP doesnt exist.
These CPUs only have SSP/USP.

The availability of this feature is determined by the
implementation of Master mode bit in the SR register.

Those with the master-mode bit have ISP.

Additional comments added to the features set to claify
exactly what differentiates each class.  (m68k_features)

The movec instruction when accessing these shadow registers
in some configurations should issue a TRAP.  This patch does not
add this funcitonality to the helpers.

Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
---
 target/m68k/cpu.c    |  1 +
 target/m68k/cpu.h    | 12 ++++++++++--
 target/m68k/helper.c |  3 ++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index b16957934a..61368d1a9a 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -121,6 +121,7 @@ static void m68020_cpu_initfn(Object *obj)
     CPUM68KState *env = &cpu->env;
 
     m68k_set_feature(env, M68K_FEATURE_M68000);
+    m68k_set_feature(env, M68K_FEATURE_MSP);
     m68k_set_feature(env, M68K_FEATURE_USP);
     m68k_set_feature(env, M68K_FEATURE_WORD_INDEX);
     m68k_set_feature(env, M68K_FEATURE_QUAD_MULDIV);
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 9deff9e234..8be68e5e4f 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -462,12 +462,19 @@ void m68k_switch_sp(CPUM68KState *env);
 
 void do_m68k_semihosting(CPUM68KState *env, int nr);
 
-/* There are 4 ColdFire core ISA revisions: A, A+, B and C.
+/* The ColdFire core ISA is a RISC-style reduction of the 68000 series
+   Whilst the 68000 flourished by adding extended stack/instructions in
+   five main flavors original 68000, 680010/20/30/40, and a CPU32/CPU32+
+
+   CPU32/32+ are basically 68000/10 compatible, with and 68020.  Mostly
+   Supervisor state differences.
+
+   There are 4 ColdFire core ISA revisions: A, A+, B and C.
    Each feature covers the subset of instructions common to the
    ISA revisions mentioned.  */
 
 enum m68k_features {
-    M68K_FEATURE_M68000,
+    M68K_FEATURE_M68000,   /* Base m68k set, as opposed to ColdFire */
     M68K_FEATURE_CF_ISA_A,
     M68K_FEATURE_CF_ISA_B, /* (ISA B or C).  */
     M68K_FEATURE_CF_ISA_APLUSC, /* BIT/BITREV, FF1, STRLDSR (ISA A+ or C).  */
@@ -477,6 +484,7 @@ enum m68k_features {
     M68K_FEATURE_CF_EMAC,
     M68K_FEATURE_CF_EMAC_B, /* Revision B EMAC (dual accumulate).  */
     M68K_FEATURE_USP, /* User Stack Pointer.  (ISA A+, B or C).  */
+    M68K_FEATURE_MSP, /* Master Stack Pointer. Not 68000/10,Coldfire,CPU32 */
     M68K_FEATURE_EXT_FULL, /* 68020+ full extension word.  */
     M68K_FEATURE_WORD_INDEX, /* word sized address index registers.  */
     M68K_FEATURE_SCALED_INDEX, /* scaled address index registers.  */
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 6db93bdd81..64c8a82a92 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -337,7 +337,8 @@ void m68k_switch_sp(CPUM68KState *env)
     env->sp[env->current_sp] = env->aregs[7];
     if (m68k_feature(env, M68K_FEATURE_M68000)) {
         if (env->sr & SR_S) {
-            if (env->sr & SR_M) {
+            /* SR:Master-Mode bit unimplemented then ISP is not available */
+            if (!m68k_feature(env, M68K_FEATURE_MSP) || env->sr & SR_M) {
                 new_sp = M68K_SSP;
             } else {
                 new_sp = M68K_ISP;
-- 
2.21.0


