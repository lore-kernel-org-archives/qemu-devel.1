Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBE0C43457
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4813D207BB
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 20:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4813D207BB
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTszx-0007Ha-EY
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 16:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTsvj-0000ib-8B; Sat, 17 Oct 2020 16:35:55 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:13753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kTsvf-0004ZL-Kq; Sat, 17 Oct 2020 16:35:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7E468747634;
 Sat, 17 Oct 2020 22:35:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 560D8745953; Sat, 17 Oct 2020 22:35:46 +0200 (CEST)
Message-Id: <cover.1602965621.git.balaton@eik.bme.hu>
Subject: [PATCH 0/6] m48t59: remove legacy init functions
Date: Sat, 17 Oct 2020 22:13:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Herve Poussineau <hpoussin@reactos.org>,
 Philippe Mathieu-Daude <f4bug@amsat.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

This is inspired by Mark's series:

https://lists.nongnu.org/archive/html/qemu-ppc/2020-10/msg00251.html

and implements what I've suggested in review of that series to
simplify it and avoid code churn if implementing my suggestion later.

Regards,
BALATON Zoltan

BALATON Zoltan (4):
  mt48t59: Set default value of base-year property to 1968
  sun4m: use qdev instead of legacy m48t59_init() function
  sun4u: use qdev instead of legacy m48t59_init() function
  ppc405_boards: use qdev instead of legacy m48t59_init() function

Mark Cave-Ayland (2):
  m48t59-isa: remove legacy m48t59_init_isa() function
  m48t59: remove legacy m48t59_init() function

 hw/ppc/ppc405_boards.c  |  3 ++-
 hw/rtc/m48t59-isa.c     | 25 -------------------------
 hw/rtc/m48t59.c         | 37 +------------------------------------
 hw/sparc/sun4m.c        |  5 +++--
 hw/sparc64/sun4u.c      |  6 ++++--
 include/hw/rtc/m48t59.h |  6 ------
 6 files changed, 10 insertions(+), 72 deletions(-)

-- 
2.21.3


