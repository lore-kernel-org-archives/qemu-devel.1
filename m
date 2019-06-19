Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A7C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 07:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279D220823
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 07:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279D220823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdVUC-0006Ih-5I
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 03:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36887)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.brenken@efs-auto.org>) id 1hdVSv-0005U1-L8
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 03:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.brenken@efs-auto.org>) id 1hdVSu-0008PP-OX
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 03:57:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37495)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
 id 1hdVSu-0008NI-FM
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 03:57:08 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWR6x-1i6HfJ03h5-00Xr3V; Wed, 19 Jun 2019 09:57:02 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 09:56:43 +0200
Message-Id: <20190619075643.10048-6-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190619075643.10048-1-david.brenken@efs-auto.org>
References: <20190619075643.10048-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:PMFTec9NeBKgCgCz6Vc23UuJa7y917vhJp6wGTFXYhxV8r3djs3
 Avo/xf0kJzMmClJq0rouVraCucfUFb3kr1uvmFZkMH/RNayMU2qzw9leQDv/HDO331BDO5L
 63dv+B93Kz4myUMJtTt78XtyG8HjUJwAL0HEKJGX0vfOEfrrLStkjReAerme40O57VChitm
 rxYhwCJp6XOcF8lnY5jPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:94Rzijg9NAY=:pLskoi0Wcj3+KRw3fV6pmo
 gzB3N8F4VOzxIj+2Ymx1cBC5BdQF4Bw4GGAaWgMFCc2boZQsVHhNlKozGxd/X1J6VN3rDRW4S
 unEWPQ80vcm4CGajTcO8eUa8SGNxjGO2gAcUZuyOqCYMZ7C7MFWyLHwecJvQmgFZ8qrIojYos
 dTbLjebff2Ss1rsoIwMuUXKCQskyzOcW3r7D8wppn5A7W6v706+MwpN/+U4nBKQYRl6q7JD7b
 FfbjUIV5/olHL5wqYJshJ9TebmbaHTp/7OZ43c6k4FXFRnrgaVyRc+IXtxDrqfQWHfwNKV2zQ
 mFXWDS+u7aNX1rkkVQNvzzTxFQEAy5gWE8AaVPcq5mi+ZXv41+2XylIGufnCj4djuYKzqVVTd
 ctFn+G0qZf/YBOp7Tx1l0gHzEmLmEVVZflvXrMFGyRgFLm+BkmT2/SjjhY89F8gW87THrvS9L
 z/9Fn7x1UOOyJ962o2L00CHxbK0d3FyzlzgQHrdmWPpY2T8yuRim5Ypz3LXChgl2/muvoB2N0
 A38n0ha4UWQhO4C//v6JCJ5GNCKfYIGG5F8XP9etQk4TnnHZC4WkUtWxg8sA5+f6D08AQR6B1
 P9cSKlKieh6hBQEm4qM+92GmBwjbB8iMmp4YkI3nU+U8poddnSb0r6ut0XSqByAt5q854drLa
 m2XyFDujPnIrbSQFQTTVzKy50WeMF5R9Yclql4quV0GAx1ri7y8PLbFx4Icw7Q0rUplfAtguw
 fiFreiqVe32XkUPWh2SeJpCoB9bgD8mB4j6SW/LRlk+FlRJrm4R57XHvwU8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PATCH v2 5/5] tricore: reset DisasContext before
 generating code
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

From: Georg Hofstetter <georg.hofstetter@efs-auto.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
---
 target/tricore/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index b3bfb3ca51..8f90c76d35 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8806,6 +8806,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     target_ulong pc_start;
     int num_insns = 0;
 
+    memset(&ctx, 0x00, sizeof(DisasContext));
     pc_start = tb->pc;
     ctx.pc = pc_start;
     ctx.saved_pc = -1;
-- 
2.22.0.windows.1


