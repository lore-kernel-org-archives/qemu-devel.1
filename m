Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7249C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 08:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DFC20663
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 08:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DFC20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iebHb-0004uE-RN
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 03:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iebH0-0004P5-DC
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iebGz-0005r2-ED
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:53:38 -0500
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:44739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iebGz-0005qS-7w
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:53:37 -0500
Received: from player711.ha.ovh.net (unknown [10.108.35.210])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 22EB31B4C69
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 09:53:35 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id 35262CFBD502;
 Tue, 10 Dec 2019 08:53:30 +0000 (UTC)
Subject: Re: [PATCH 0/2] hw/arm: ast2600: Wire up eMMC controller
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <cover.da2612e7c1835c563b20851f0ac26c7b175428fc.1575938234.git-series.andrew@aj.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <378a875a-17c8-3b35-9753-2158e86c5412@kaod.org>
Date: Tue, 10 Dec 2019 09:53:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cover.da2612e7c1835c563b20851f0ac26c7b175428fc.1575938234.git-series.andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6705296898481425216
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelvddguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.48.182
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
Cc: peter.maydell@linaro.org, joel@jms.id.au, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/2019 01:52, Andrew Jeffery wrote:
> Hello,
> 
> The AST2600 has an additional SDHCI intended for use as an eMMC boot source.

Have you also considered booting the QEMU Aspeed AST2600 machine 
from the eMMC device ?

C.

> These two patches rework the existing ASPEED SDHCI model to accommodate the
> single-slot nature of the eMMC controller and wire it into the AST2600 SoC.
> 
> Please review!
> 
> Andrew
> 
> Andrew Jeffery (2):
>   hw/sd: Configure number of slots exposed by the ASPEED SDHCI model
>   hw/arm: ast2600: Wire up the eMMC controller
> 
>  hw/arm/aspeed.c              | 15 ++++++++++++++-
>  hw/arm/aspeed_ast2600.c      | 23 +++++++++++++++++++++++
>  hw/arm/aspeed_soc.c          |  3 +++
>  hw/sd/aspeed_sdhci.c         | 11 +++++++++--
>  include/hw/arm/aspeed_soc.h  |  2 ++
>  include/hw/sd/aspeed_sdhci.h |  1 +
>  6 files changed, 52 insertions(+), 3 deletions(-)
> 
> base-commit: 6a4ef4e5d1084ce41fafa7d470a644b0fd3d9317
> 


