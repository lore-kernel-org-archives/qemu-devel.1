Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBC0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F23206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F23206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5iB-0001Bt-PC
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kD5fQ-0004co-9g
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:45:40 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:42537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kD5fL-0001PQ-VF
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:45:39 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.188])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id DBA955CC5352;
 Tue,  1 Sep 2020 14:45:30 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 1 Sep 2020
 14:45:27 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003fb0d44fd-0588-48dd-b5ec-99cddadef746,
 38EE1E9FF4E34D4C85F4190D418CEE501B878519) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: <qemu-devel@nongnu.org>
Subject: [PULL 00/20] aspeed queue
Date: Tue, 1 Sep 2020 14:45:05 +0200
Message-ID: <20200901124525.220252-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: b4ee33dc-be57-4289-9c8d-49992d655d21
X-Ovh-Tracer-Id: 4785637554677451741
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepuedtieekkeelgfduvdeijeeujefhheefjedtleegtdehteejteduuddtjeefjeeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 08:45:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20200901

for you to fetch changes up to ddd8ab19749b8639fc08bfe4d0df0204eec049f0:

  hw: add a number of SPI-flash's of m25p80 family (2020-09-01 14:21:51 +0200)

----------------------------------------------------------------
Various fixes of Aspeed machines :

* New Supermicro X11 BMC machine (Erik)
* Fixed valid access size on AST2400 SCU
* Improved robustness of the ftgmac100 model.
* New flash models in m25p80 (Igor)
* Fixed reset sequence of SDHCI/eMMC controllers
* Improved support of the AST2600 SDMC  (Joel)
* Couple of SMC cleanups

----------------------------------------------------------------
Cédric Le Goater (15):
      m25p80: Return the JEDEC ID twice for mx25l25635e
      m25p80: Add support for n25q512ax3
      aspeed/scu: Fix valid access size on AST2400
      aspeed/smc: Fix MemoryRegionOps definition
      aspeed/smc: Fix max_slaves of the legacy SMC device
      aspeed/sdhci: Fix reset sequence
      ftgmac100: Fix registers that can be read
      ftgmac100: Fix interrupt status "Packet transmitted on ethernet"
      ftgmac100: Fix interrupt status "Packet moved to RX FIFO"
      ftgmac100: Change interrupt status when a DMA error occurs
      ftgmac100: Check for invalid len and address before doing a DMA transfer
      ftgmac100: Fix integer overflow in ftgmac100_do_tx()
      ftgmac100: Improve software reset
      aspeed/sdmc: Simplify calculation of RAM bits
      aspeed/smc: Open AHB window of the second chip of the AST2600 FMC controller

Erik Smit (1):
      hw/arm/aspeed: Add board model for Supermicro X11 BMC

Igor Kononenko (2):
      arm: aspeed: add strap define `25HZ` of AST2500
      hw: add a number of SPI-flash's of m25p80 family

Joel Stanley (2):
      aspeed/sdmc: Perform memory training
      aspeed/sdmc: Allow writes to unprotected registers

 include/hw/misc/aspeed_scu.h  |   1 +
 include/hw/misc/aspeed_sdmc.h |  13 ++++-
 hw/arm/aspeed.c               |  35 ++++++++++++
 hw/block/m25p80.c             |   5 +-
 hw/misc/aspeed_scu.c          |   9 +--
 hw/misc/aspeed_sdmc.c         | 125 +++++++++++++++++++++++-------------------
 hw/net/ftgmac100.c            |  95 +++++++++++++++++++++++---------
 hw/sd/aspeed_sdhci.c          |  14 ++++-
 hw/ssi/aspeed_smc.c           |   6 +-
 9 files changed, 208 insertions(+), 95 deletions(-)

