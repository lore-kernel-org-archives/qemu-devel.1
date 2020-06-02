Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0938BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40142068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 15:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40142068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg8li-0006yS-3Z
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 11:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jg8jc-0004Zi-FJ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:21:48 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jg8jb-0008GP-Ax
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:21:48 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVvCn-1jWPS62lyn-00RmiI; Tue, 02 Jun 2020 17:21:45 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] target/m68k: implement opcode fetoxm1
Date: Tue,  2 Jun 2020 17:21:35 +0200
Message-Id: <20200602152135.774894-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602152135.774894-1-laurent@vivier.eu>
References: <20200602152135.774894-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wGgm4wo+FhCfaDRFvdtWI7upNhydgEkGR4/fcVgLHGP5xlH/CL+
 4QEB0My3usX0blwNpL3lAJQaIlt0MOILFhPteiN6mf8rcSAfFpyMS6bfh+GQU9nVX+RZp+o
 xhW9ZqsIoD8sQAG8T97kOAHdCaRulTaXo0uYgSm302BhMRk+RLmU7tueg6YYetUVnENXyT5
 lQzpLSeSJyMgBuLAeOenw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mJEJ9SBE/F4=:b5dsjvjH6A/WzKH3d5WCma
 eHUI1Cwdrn7oS7zJbevFbwO0ViLW5AK210yZHgtYqilM32m8toulVlMbAy/wyBRtO/1sJETGf
 pQ1VYehragzIFE2rcj2P9oRCXKmJNbeRiLnM5v6nk2sIkD9+INyJORQTdjdIHlwFbzDPPqihc
 anvm7YIcgZjwFeTxFTW7KHjlcAdAIQdzASlcWwCO6zTL2re8WcrcNLXAu/htufwqe4dTbOeeB
 XD4S3Ab5glgCE8oDKn0pcCbWxniPJfrUV+aG3ju9KKbHHN00u9FaYlFhKHhg3q0I2lhN04wby
 /lJ2n8pUdFftEJ7XknHOGHbFIdhgOL+lSN6wz2rb1Pot19z9oN422LSpemuaRuco1qLWgkd0+
 IQBwWI4Pg6yYc8lcQmNrvBHP395/zcHGYPCGyiuC7Fc0EtDNBtfpl2nE5vIbSBFvc+r++I1NS
 tHMj4Yvw7OHkS+ZlZZ7UNyUWFs3kYOuNlZ7hbYdEa/21FDtWEOiGjKOnWZ1N/Fx8MCtzspmkz
 3ieJ7VSXaidfniqhnGplo8f+jzNOjYFv3QDKh8Pq4w7M/wpiUoTDUsY0ccuCJkeLL0ctFxbJj
 X6HTbRsMLkdxy/Ol4FFFKsTrvX1rXdXdxeipAapnfrT20ZjGKq77T0zG9hkZHf2zhVEtElTv3
 erLXpMHj15UQQMvHGu+Y6y9bTAhjsE0vZ1gV5rxepJwsuFYvnUIyo3bswnNp1UlakdxnDOV4D
 ZOiqm11jADpUo8d580oqXG7JWNBoPp5DGmL/uy/4c/9zvi9m8xGdNUhUZgsRYu91plFGIHlFg
 QqQVnqZDRIdiReI/UVJ29rZVR5s+AFq3UM8VAwqvbvWGUIh4NIn3DZs81ll+tmqwe56nIA+
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 11:21:45
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200531131951.631902-1-laurent@vivier.eu>
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
index c093f6c683e8..3fc67aa45261 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5160,6 +5160,9 @@ DISAS_INSN(fpu)
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


