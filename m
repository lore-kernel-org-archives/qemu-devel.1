Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C160C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D927F20659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 16:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D927F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgAhW-0006eO-3T
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 12:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55808)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgAfs-0005ad-4P
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgAfq-0006nb-2I
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:21:32 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48575)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hgAfp-0006gG-Ok
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 12:21:29 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MG9c2-1hnspF0n1w-00GYQ5; Wed, 26 Jun 2019 18:21:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 18:20:58 +0200
Message-Id: <20190626162100.24774-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626162100.24774-1-laurent@vivier.eu>
References: <20190626162100.24774-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tHpE2TGhZyegXH1arIg25W/5J/pvplOjvArWH8Il02t/6e6EnoG
 KMEA7Ny6UhXiBvHUBs1q9x5ourmI2abrTdoDUcpZAtBoNQKMJktPc2wZ956iHC7YKwHHCuZ
 neaXDayAlF18bDTwYejzqi4Ki/ZziWL2EixCNA5/FLYU6EBod1AapSvYL5gqMKaHd+7C8YP
 53V3DFN/CZZYMpuBV2S0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pPNZbaz7G7E=:nxDDdc5PnLO5TLaNQPatFT
 z105sJ1lVbg2tz6vLBTl5CAUccn/YVHnNbLv9B/ZuA136pcbYSbSbxJlIbeqx27HXP7V4md5S
 E2HC6Ar+FKnxAKMyqW0mtGesNNxsPHk0wanLMJC8lmAhYRRQZWICgQ2LrTD4UdQiHFHGqwiPw
 EPyx3eTwtAPmBIZfXkU/uwGCzzhgIfkcZ83XRFVOOuwdD/HMlV4mO2fxDKsRB1VibrTUcSlSN
 DiD6WizC49d1yTq9UncRhRK4Mq3AE3UiJg7FBJ5Quy1wFVCDzDDRGWcR13+lAIi+wnhCuFmQB
 yAM+bNxaaUTeMM4Ug7Krk2PzJzti1SsR6yEQzqAR5YRLw/43M5+5auIOTxiDKgCW4DWeHmwt8
 FdaVTYXBEqPdghpqogIlJDne8BhXYfdN+3QAFr9jLuU9Zy4LtFDI1zn74Xuz3hmAVeHfcWIFC
 uDoiUbnbG20uvT6c/oPHRsLpIrgApECGn+IKHNyDJvNcYoc3mBnE+1XFYYZnW/dSfHl5fiFeZ
 anaYUUyinUaEO/nQfajkHCr2uxANOwnauoJGhNukIuZUOmLMBXGNy2JAKxI8hljKl0ZS9IPs/
 EomYJynvqoj5pfmlnJL1eRHoExcMIov5besvIIcdPjAWPLsZnwHQCuQMb5NLNYBuCoaqPwIJ0
 nbtjmyZuhcsgXQLVWFS814iFdFdboQ7jEBS6DNNEzbjjJgH5TNzxoV6XQ/LMe9Ijs4s+X2pOh
 QuTduK0V3WNOCyvsnbKI7mwOkaaLDnKpDAOLFg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 1/3] The m68k gdbstub SR reg request doesnt
 include Condition-Codes
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>

The register request via gdbstub would return the SR part
which contains the Trace/Master/IRQ state flags, but
would be missing the CR (Condition Register) state bits.

This fix adds this support by merging them in the m68k
specific gdbstub handler m68k_cpu_gdb_read_register for SR register.

Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190609105154.GA16755@localhost.localdomain>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/gdbstub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index e6baf0601e..5cad2b658f 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -35,7 +35,8 @@ int m68k_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else {
         switch (n) {
         case 16:
-            return gdb_get_reg32(mem_buf, env->sr);
+            /* SR is made of SR+CCR, CCR is many 1bit flags so uses helper */
+            return gdb_get_reg32(mem_buf, env->sr | cpu_m68k_get_ccr(env));
         case 17:
             return gdb_get_reg32(mem_buf, env->pc);
         }
-- 
2.21.0


