Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11113C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2B720795
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2B720795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJAqZ-00046s-Hx
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kJAnd-0007qv-Eo
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:27:17 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:44713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kJAnb-0003lb-7j
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:27:17 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.48])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 703465C5D984;
 Fri, 18 Sep 2020 09:27:05 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 18 Sep
 2020 09:27:04 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001ba540461-4b40-4d2c-855b-05088a1299cd,
 ECEC63DD04C3092DE3B5C7147C06DCFEA73B34A9) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: <qemu-devel@nongnu.org>
Subject: [PULL 0/3] aspeed queue
Date: Fri, 18 Sep 2020 09:27:00 +0200
Message-ID: <20200918072703.331138-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 330cb2b9-564c-4b42-98d9-6fd7a4c8aca5
X-Ovh-Tracer-Id: 7010134297792383965
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdehgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepuedtieekkeelgfduvdeijeeujefhheefjedtleegtdehteejteduuddtjeefjeeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:27:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit de39a045bd8d2b49e4f3d07976622c29d58e0bac:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200915-pull-request' into staging (2020-09-15 14:25:05 +0100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20200918

for you to fetch changes up to 204dab83fe00a3e0781d93ad7899192a9409e987:

  misc: aspeed_scu: Update AST2600 silicon id register (2020-09-18 09:04:36 +0200)

----------------------------------------------------------------
Aspeed patches :

* Couple of cleanups
* New machine properties to define the flash models

----------------------------------------------------------------
Cédric Le Goater (1):
      hw/arm/aspeed: Add machine properties to define the flash models

Joel Stanley (1):
      misc: aspeed_scu: Update AST2600 silicon id register

Philippe Mathieu-Daudé (1):
      hw/arm/aspeed: Map the UART5 device unconditionally

 docs/system/arm/aspeed.rst | 18 ++++++++++++++++++
 hw/arm/aspeed.c            | 45 +++++++++++++++++++++++++++++++++++++++++++--
 hw/arm/aspeed_ast2600.c    |  8 +++-----
 hw/arm/aspeed_soc.c        |  8 +++-----
 hw/misc/aspeed_scu.c       |  7 ++++++-
 5 files changed, 73 insertions(+), 13 deletions(-)

