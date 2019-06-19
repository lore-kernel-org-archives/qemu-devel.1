Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B2BC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DAC20823
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DAC20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdVby-0002DH-Eo
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 04:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38443)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.brenken@efs-auto.org>) id 1hdVXu-0000eg-ME
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.brenken@efs-auto.org>) id 1hdVXr-0003f9-Fr
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:02:16 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44127)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
 id 1hdVXq-0003di-9C
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:02:14 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIyiY-1htNLz2opu-00KOmq; Wed, 19 Jun 2019 09:57:01 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 09:56:41 +0200
Message-Id: <20190619075643.10048-4-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190619075643.10048-1-david.brenken@efs-auto.org>
References: <20190619075643.10048-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:TJTQuwrD7GSOQ+/bpbW0bBl5s4PpQBZTLrTop8z0RHYH6+k30u4
 Zi+cNrkJINttxjsWrMOLA5OanQICgR3nn8YLsRDgB4ZLyxB93S8Ocz/fyRNrqCxHe9XO4HT
 r3zpXYFSOvTUvJDdXCgaQpp2+HM04ywmoygQIdL0V0f1uGIK4xGjcgqDmmrS/FScPegOQdy
 2Ijezxs/gFzF2nIx19IJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:inbGUyd3CqI=:QRjoutGvegZP41MhIeXHEv
 PNQlFoUMpk71T6RwyqJzdsE5ze57bAZfQv7G+JZZdBJ2PCUGTBQypIrXkBMVhqotl2ow+PtVe
 AV/ZSXnpdDKln6zDDMIqm0/+/7k/39ePmwtpT+0n+jJbR0PeB1Y74HPZpV+cQSDAy4HRPX+AD
 Mhd18268LnR7hS1sMG/wYXr6jstfoWoWqU8e+Mewjig1xwQGQw3eaCdhSan89gXsJeSoejipR
 /1lKSJYGQwXB0dYboOgG8HHJQak+vnJQebgUrvYMDxE+xg9NSyNjiGH7ujUc/bF4fF5oFK1or
 cRWfF1XgWFLCGz+d1LI4fQMEuPmIoz71cyM3AQflkIQ0xywwO1jhxSkZRURiuqxakWDd8E4yI
 HPmuluYHyHKCIMajbGNMkxhbTd+MQmsRwbMm+mCjVJl4IAaYJj6U2Kw+N3YguYy8kqfxMfVwQ
 CjX3uaY//G7MZcqAcrXext4g6NT+A4QPbULOzVRK8u3z0NTkw+6DgWMEQoB8+5vGTbROsrysG
 D9hg4GO2aAJ4WMT9zW/e1Mfu/U23bGwGRoOQosiAGqZT0iWrh+TYXPSOJV30jD1uMWhlqvMVg
 dkRURbYMiOmTNEIwByzS2DrEeItpPgCCErHtLtaEQG1sIfr+p2V18fUcChHNVNFTpxvfw3STB
 c25y2fBOkPlkNsSUVm9jHuOU/S6VMU+HajDuqxC/AgLwaZCOTxeG82pIjGg/pv1KRQGUz4nK2
 oG71wtKZIvNP9Tq6AypfPJBfIC3XVc2sohUhhv8hIS/L4mf0ncYnCkivbcI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PATCH v2 3/5] tricore: fix RRPW_INSERT instruction
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
Cc: kbastian@mail.uni-paderborn.de,
 Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
---
 target/tricore/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index bd913d71a1..5d4febf1c0 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -7025,9 +7025,9 @@ static void decode_rrpw_extract_insert(CPUTriCoreState *env, DisasContext *ctx)
         }
         break;
     case OPC2_32_RRPW_INSERT:
-        if (pos + width <= 31) {
+        if (pos + width <= 32) {
             tcg_gen_deposit_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
-                               width, pos);
+                               pos, width);
         }
         break;
     default:
-- 
2.22.0.windows.1


