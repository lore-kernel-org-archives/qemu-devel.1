Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20A7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99948206B5
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 10:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99948206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8L5U-0007FM-OL
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 06:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8L2t-0001Ea-R6; Wed, 19 Aug 2020 06:10:15 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:52453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8L2p-0006Vu-Le; Wed, 19 Aug 2020 06:10:15 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.21])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 259005892825;
 Wed, 19 Aug 2020 12:10:00 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 19 Aug
 2020 12:09:59 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004f4311396-d5f6-46d7-8dd1-da85e55de9e4,
 56ABA3BD09B5898CED80C8E013D4E39E9C6048D1) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 00/21] aspeed: cleanups and some extensions
Date: Wed, 19 Aug 2020 12:09:35 +0200
Message-ID: <20200819100956.2216690-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 798ef57d-2ef9-4afe-ad54-50bd85416b71
X-Ovh-Tracer-Id: 18047894032872344358
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtkedgvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepuedtieekkeelgfduvdeijeeujefhheefjedtleegtdehteejteduuddtjeefjeeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 06:10:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

This series includes various fixes improving the support of Aspeed
machines. Extra attention was given to the robustness of the ftgmac100
model. A small kernel module tester was created for this purpose :

   https://github.com/legoater/ftgmac100-test/

Changes in v2 :

 - definitions for some new flash models in m25p80 by Igor
 - All Joel's comments should have been addressed
 - A better fix of the integer overflow in ftgmac100_do_tx suggested
   by Peter.


This needs a couple more reviewed-by before I can send a PR.

Thanks,

C.

Cédric Le Goater (16):
  m25p80: Return the JEDEC ID twice for mx25l25635e
  m25p80: Add support for mx25l25635f
  m25p80: Add support for n25q512ax3
  aspeed/scu: Fix valid access size on AST2400
  aspeed/smc: Fix MemoryRegionOps definition
  aspeed/smc: Fix max_slaves of the legacy SMC device
  aspeed/sdhci: Fix reset sequence
  ftgmac100: Fix registers that can be read
  ftgmac100: Fix interrupt status "Packet transmitted on ethernet"
  ftgmac100: Fix interrupt status "Packet moved to RX FIFO"
  ftgmac100: Change interrupt status when a DMA error occurs
  ftgmac100: Check for invalid len and address before doing a DMA
    transfer
  ftgmac100: Fix integer overflow in ftgmac100_do_tx()
  ftgmac100: Improve software reset
  aspeed/sdmc: Simplify calculation of RAM bits
  aspeed/smc: Open AHB window of the second chip of the AST2600 FMC
    controller

Igor Kononenko (2):
  arm: aspeed: add strap define `25HZ` of AST2500
  hw: add a number of SPI-flash's of m25p80 family

Joel Stanley (2):
  aspeed/sdmc: Perform memory training
  aspeed/sdmc: Allow writes to unprotected registers

erik-smit (1):
  hw/arm/aspeed: Add board model for Supermicro X11 BMC

 include/hw/misc/aspeed_scu.h  |   1 +
 include/hw/misc/aspeed_sdmc.h |  13 +++-
 hw/arm/aspeed.c               |  35 ++++++++++
 hw/block/m25p80.c             |   6 +-
 hw/misc/aspeed_scu.c          |   9 +--
 hw/misc/aspeed_sdmc.c         | 125 +++++++++++++++++++---------------
 hw/net/ftgmac100.c            |  95 ++++++++++++++++++--------
 hw/sd/aspeed_sdhci.c          |  14 +++-
 hw/ssi/aspeed_smc.c           |   6 +-
 9 files changed, 209 insertions(+), 95 deletions(-)

-- 
2.25.4


