Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4A5C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBA0207FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 07:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBA0207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iojaa-0004FG-5A
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 02:47:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iojO0-00021Q-GA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iojNy-0006i7-P4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:34:44 -0500
Received: from 15.mo7.mail-out.ovh.net ([87.98.180.21]:60259)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iojNy-0006cl-J0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:34:42 -0500
Received: from player755.ha.ovh.net (unknown [10.109.143.24])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 138F3149D84
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 08:34:32 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id DDAC6DFE0B61;
 Tue,  7 Jan 2020 07:34:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/5] aspeed: extensions and fixes
Date: Tue,  7 Jan 2020 08:34:18 +0100
Message-Id: <20200107073423.30043-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3785275489691798289
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehuddguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.180.21
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

Hi,

Here is a short series adding :

 - a new eMMC controller model for the AST2600 SoC (Andrew)
 - accessors to control the led state of the pca9552 device (Joel)
 - a 'execute-in-place' property to boot directly from CE0

Thanks,

C.

Andrew Jeffery (2):
  hw/sd: Configure number of slots exposed by the ASPEED SDHCI model
  hw/arm: ast2600: Wire up the eMMC controller

C=C3=A9dric Le Goater (2):
  ftgmac100: check RX and TX buffer alignment
  hw/arm/aspeed: add a 'execute-in-place' property to boot directly from
    CE0

Joel Stanley (1):
  misc/pca9552: Add qom set and get

 include/hw/arm/aspeed.h      |  2 +
 include/hw/arm/aspeed_soc.h  |  2 +
 include/hw/sd/aspeed_sdhci.h |  1 +
 hw/arm/aspeed.c              | 71 ++++++++++++++++++++++------
 hw/arm/aspeed_ast2600.c      | 23 +++++++++
 hw/arm/aspeed_soc.c          |  2 +
 hw/misc/pca9552.c            | 90 ++++++++++++++++++++++++++++++++++++
 hw/net/ftgmac100.c           | 13 ++++++
 hw/sd/aspeed_sdhci.c         | 11 ++++-
 9 files changed, 198 insertions(+), 17 deletions(-)

--=20
2.21.1


