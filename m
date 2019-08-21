Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D57C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD192339E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD192339E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0LxM-0001io-IR
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0LwH-0000P5-CD
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0LwG-0007YL-CI
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:25:53 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38389)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i0LwG-0007X3-3T
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:25:52 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MxVbb-1iBJLe3p8r-00xq1f; Wed, 21 Aug 2019 10:25:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 10:25:45 +0200
Message-Id: <20190821082546.5252-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DqyqwVI5qOo+jQZNGMmTGuO8lmLg4hapIVy4+QsjC/y8ALGTmOy
 ZTH6jNmGPkxhmnNFpkHKbcpqmPY0gE+5ApV/LebyUXGnoUt39h91UmZBhcb5E+im/fiaUT9
 PKrKGYxmRbNd8/EWsP4g0AK9VZnZpU31T0iWwelKDE6Rmlfwv7Eo0szJx06uoktG/pX3Dh/
 Dj5fGtfV7xqD6IU7vH9hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qhYbd+MD3AI=:9VCabLQEifLH5OFJuZnlnH
 siT3s59I1Umkuyl9g780vO4d2QHPPpcEoLiquzVw3E96IrriyP/LMIFvQeVt6NA2oBcWSN+SI
 ofcioxycEUPCFpI/f8D28IyupaZ4DHuAaqO/E2WChb4rdTDhXs0ZnI/YwRMbI9UWiBUNz9jRc
 SmaKgIt3AonLHB1Ft1f4AT+qC3y+lvXdZb0fQqITgXVWyzxrHfHcTz29canxvAfXRgybnsdTx
 /tiC9/mh73gMvrxAMbXVJN5rtP3Voc/A+lfzr1Yyqu6LOk05kF9olRQXnBb1eAfThuq5evbj/
 uafBGWQwo7FRmTJbNsUtsHnZObDSzT9SizwUGsFit53nu8AU/J1TnfRnjmMt31ai+66d3EN4H
 RJmIwKDVpm4sW6t+z3p6tJfIsL2y40bciacQs5KasE3xJoBkIjeMGh0aqj69z36w6/cyWmPDM
 sS0/8NjoLdBJ/rkE8MSsH06rbaKQ4/0L0IqTZm1biDMq1zjauHhu9qZv1wwpMhtlEDcAtcV0o
 yVT7Z/3s/bAz0oidMAAFJ7MGlDYjvfLlgdY5RKnBBYkkHbntg2LF/6Rr2xAFIWsIEUriBGobK
 8xEMoRXVh6/Y0D/bomGMNm8kfcSyAHt9yZ2CCk1vmQjVhlnyIHtJm3OoPNY3kl4cwSeHtYIWS
 q5674gwbI8WVCRPodUNz6/oPtZRKcneBGkRkkcKzI8FUrluJ+ppk5XlK31VgBoeP/E6W9Fb+x
 +qMylolsJGrXWoTTHH7GTMBUr/aCkh97/w8E8Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PATCH 0/1] Fix cacheline detection on FreeBSD/powerpc
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Justin Hibbits <chmeeedalf@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the patch originally sent by Justin, modified
to change the parameter size on FreeBSD only.

Justin, could you review and test on FreeBSD?
Peter, could you run "make check" on your MacOS X host?

Thanks,
Laurent

Justin Hibbits (1):
  Fix cacheline detection on FreeBSD/powerpc.

 util/cacheinfo.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.21.0


