Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FE7C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD0F208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD0F208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48396 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfJ90-0008MS-8e
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 03:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50271)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.brenken@efs-auto.org>) id 1hfJ6G-0006zl-T0
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.brenken@efs-auto.org>) id 1hfJ6F-0007eo-SM
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:09:12 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
 id 1hfJ6F-0007dt-Fn
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:09:11 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MV6G6-1i7FSR14Du-00SAuw; Mon, 24 Jun 2019 09:04:01 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 09:03:37 +0200
Message-Id: <20190624070339.4408-4-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190624070339.4408-1-david.brenken@efs-auto.org>
References: <20190624070339.4408-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:hSuO67HW8iwhV6aEdETuyui9FX5mpE0aQpS4aTqIp5AFIJNc7PO
 7+lSMeMLpNkzBTDiRAE6smeYkoZ3IVcq3hKTuTeQ54G88Z8dwnPRpQ9xwGbSqz41ig8LICY
 kU05WggdY4RA7uouga9ENllaq547XirB3qUODfJkAhjgBn/8K/n0hhVtaCkBU8E1nF/es1N
 GzuXA2B2N+zIWMiL3cFlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7xnED3zjbIw=:dUFhgc+ft7gZ+T9Ra8hcD+
 ECbNbt8YfhRp9oj+Pv9hGOnKbxhDF2PpOYOn3PMx2dWAF5O6AK//Q3II74lIlqzhYf7wecDic
 jv3om6pD0oIbl/MGEccT1vkOR+EvXOWl7zcxgamM/iA9SmmYorCIN3jjlPDoOFNjCoFX934hK
 DYlIadH84o0rUzf6LfbAswLNzo7fpSqFe0Zr2DJ3dUdkaXez597mEfU3RhnIMwa+aADxbgXvt
 I//uTXMReKKL7NVKps+brUDMH2ob2O+JVOoVvkzN7v/NQoFTXn6TXzoBrDTieenuIyQqdktun
 3c6prFbbjkWvioM4ovhYI7FzgQNmNRfEbqin9C3+Et+vCx7IcapMiwYPth6a4OhkeXk5QzZbV
 fT4uC52YnBUhi37l/PXnvC5GZXOal27hRKwURtyfSs6nFE8JBbrowuK/5X+eOUxAhc8bT9smj
 5vc46sGinRPB/Hs5EcrUQuyCtgq265zZNY51EWKWzk9+vMV3Jtq8tpSXFT0c8FUJltnk3cfk1
 BptWiv2w7FVbEB14+GNyCd+/bNLu0a/0KQMDUDiDSPtELVE6JdyJmwlrgO9ZnH69IoUHTOFkV
 7gDEF6jwsi8mU6E+Uc/HeBnEuznFSPWMs+jH7SFnxgCJBoyc3IsOP9XW+H0zOvmRA49p41LI4
 AgBEIeDnaVp2h4ZBsgyV83gmPg15nS9QCv0s393IpIWcR0cj4LVyKomxpcClEMsJe0bkh49Yl
 K9kOC7qVizBf7Tyl0lutYmuGQfCexvAT6uDyQvG8iQyZA155SyDQV8XtrOY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PATCH v3 3/5] tricore: fix RRPW_INSERT instruction
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
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
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


