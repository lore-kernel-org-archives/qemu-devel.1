Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9B7C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 13:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292B420707
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 13:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292B420707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfNto-0005pJ-4k
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 09:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jfNsa-0005ES-Rq
 for qemu-devel@nongnu.org; Sun, 31 May 2020 09:19:56 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:57203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jfNsZ-0002v6-QB
 for qemu-devel@nongnu.org; Sun, 31 May 2020 09:19:56 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mz9hF-1ijJF41nGt-00wHqT; Sun, 31 May 2020 15:19:53 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/m68k: implement opcode fetoxm1
Date: Sun, 31 May 2020 15:19:51 +0200
Message-Id: <20200531131951.631902-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5leHTlG1pCom/TOd29aCcdHH4V71+cbHvz6npuDqcPq0xUDOm7d
 IwA1RUXz907inHyQ5ZHwe8DpVacIPqDaEBSRqw6AdNuLsIEHKu4NbP1VXi9TfSWWPGCuFlR
 Sj2HmFaVrDCprzpoLRZbElovWy+n0O9FgwhQUZkNfnPUNEyvr+yiTkDmHP3CLlzA2ynLmmF
 gMmh/VmXpz7zHPC9lnsyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/XYQQfUyNHg=:QitNltI511sdn2YSwxT9wB
 MVe7aVSSvoNl+dXdreix4VRS5OE/AWwV7r5dEnFTTWIiiwJ6tccFL3poozCK5OocE+1xKvJoU
 T7x/rKBPLN2d8v1uFXDXHm3Nky+MwsgN7K2+EGEPkJ0LcQkJrLZYbOw3ip2dYtDoHzjwDHYgZ
 SW/GxmSML8xnn0QxckHQNlmkq4jUVsWmP1aqTWK6MeCgPv+ALFANUZuZFpCfXLW7IC4HY35KO
 aD+06yCBbnppGfWJx3DjunoFq4+HUsrrZSVZ5VLnp7NW6ThSqUj0uwre3r6ZeoRLQUB4vj9F3
 d6ybxEiQhK+2+67VXhpt1zdKFrJyN/IRR9t+rlpmAn9JtTq/RA1wqBOyHCPbYvEV7KMghPFzz
 i2DdZ0Ij8XncJvDgiOdhlW7Xvn4b8+Q9AZRTgM7hvB8Q+8xcoN/e7Q7RD0ft742iBqYbR4Coq
 7aH9NkAkU4XrN6bnSc/YG7YqEVRZR+NmsECo/1/ncOg//w/t+97s0cBWKZb5Qw3XPW6Mti+AK
 GUYDuSb7H3g70zK/fJB+IRX0tqYSn+RorVbbuRT4+cCQuygJnbxy6y6aO77SSueQW+a8M1LKM
 uhJBIB7c7ga/3+Tp/U4ypbE2I1L+PMJJjLSAvw7zpoiZalQsjXcaUYjEdl1PU8Wzpj43Vk8ff
 OKct8+/TpDWZf+FsA7475nmg/roLciWMTXxPLXtvExWV+5NCfoCg3sMFRZoKtMiyq2Yg4dUsW
 RDREYQinf2JRv6ziv/osMQq6hrQpy/uwFtBHxznx4AvVOpJP4fdoDnrNGcIz/PJTgoEBnZMRL
 xRcTMNdQ2aQug2vFrQweCiek1BmekbrDI5rLcIsCsmi+6uNUStu9mSnZDwwVRccgCbxnQko
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 09:19:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Example provided in the launchpad bug fails with:

   qemu: uncaught target signal 4 (Illegal instruction) - core dumped
   Illegal instruction (core dumped)

It appears fetoxm1 is not implemented:

   IN: expm1f
   0x800005cc: fetoxm1x %fp2,%fp0
   Disassembler disagrees with translator over instruction decoding
   Please report this to qemu-devel@nongnu.org

   (gdb) x/2hx 0x800005cc
   0x800005cc: 0xf200 0x0808

This patch adds the instruction.

Bug: https://bugs.launchpad.net/qemu/+bug/1881450
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/helper.h     | 1 +
 target/m68k/fpu_helper.c | 5 +++++
 target/m68k/translate.c  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index feee7be62655..77808497a95c 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -83,6 +83,7 @@ DEF_HELPER_3(fatan, void, env, fp, fp)
 DEF_HELPER_3(fasin, void, env, fp, fp)
 DEF_HELPER_3(facos, void, env, fp, fp)
 DEF_HELPER_3(fatanh, void, env, fp, fp)
+DEF_HELPER_3(fetoxm1, void, env, fp, fp)
 DEF_HELPER_3(ftanh, void, env, fp, fp)
 DEF_HELPER_3(fsinh, void, env, fp, fp)
 DEF_HELPER_3(fcosh, void, env, fp, fp)
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 36e6c704d1d0..9acf60dfd443 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -641,6 +641,11 @@ void HELPER(fatanh)(CPUM68KState *env, FPReg *res, FPReg *val)
     res->d = floatx80_atanh(val->d, &env->fp_status);
 }
 
+void HELPER(fetoxm1)(CPUM68KState *env, FPReg *res, FPReg *val)
+{
+    res->d = floatx80_etoxm1(val->d, &env->fp_status);
+}
+
 void HELPER(ftanh)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_tanh(val->d, &env->fp_status);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0f80888203d3..db4e69bac195 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5146,6 +5146,9 @@ DISAS_INSN(fpu)
     case 0x06: /* flognp1 */
         gen_helper_flognp1(cpu_env, cpu_dest, cpu_src);
         break;
+    case 0x08: /* fetoxm1 */
+        gen_helper_fetoxm1(cpu_env, cpu_dest, cpu_src);
+        break;
     case 0x09: /* ftanh */
         gen_helper_ftanh(cpu_env, cpu_dest, cpu_src);
         break;
-- 
2.26.2


