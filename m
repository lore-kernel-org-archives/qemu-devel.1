Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F11C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 21:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F0E206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 21:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F0E206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsuq0-00025y-U0
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 17:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jsupO-0001Tv-Ei
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 17:08:34 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56272
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jsupM-0001Iq-HX
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 17:08:34 -0400
Received: from host86-182-221-233.range86-182.btcentralplus.com
 ([86.182.221.233] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jsupN-0002qX-E5; Tue, 07 Jul 2020 22:08:38 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Tue,  7 Jul 2020 22:07:48 +0100
Message-Id: <20200707210749.18699-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.182.221.233
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 0/1] qemu-openbios queue 20200707
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit eb2c66b10efd2b914b56b20ae90655914310c925:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-07-06' into staging (2020-07-07 19:47:26 +0100)

are available in the Git repository at:

  git://github.com/mcayland/qemu.git tags/qemu-openbios-20200707

for you to fetch changes up to 1e04092feecfc8caaf314df2670bf9c645a0b122:

  Update OpenBIOS images to 75fbb41d built from submodule. (2020-07-07 21:54:37 +0100)

----------------------------------------------------------------
qemu-openbios queue

----------------------------------------------------------------
Mark Cave-Ayland (1):
      Update OpenBIOS images to 75fbb41d built from submodule.

 pc-bios/openbios-ppc     | Bin 696912 -> 696912 bytes
 pc-bios/openbios-sparc32 | Bin 382048 -> 382048 bytes
 pc-bios/openbios-sparc64 | Bin 1593408 -> 1593408 bytes
 roms/openbios            |   2 +-
 4 files changed, 1 insertion(+), 1 deletion(-)

