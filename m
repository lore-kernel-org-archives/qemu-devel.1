Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F2FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A3922527
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 07:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A3922527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iffU7-0008IM-KY
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 02:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iffSV-0006TK-5r
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iffSU-00030e-1X
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:33:55 -0500
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:57492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iffST-0002vQ-7M
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 02:33:53 -0500
Received: from player692.ha.ovh.net (unknown [10.109.146.86])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id F40AE21B21B
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 08:33:50 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 426B9D1E3521;
 Fri, 13 Dec 2019 07:33:46 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] hw/arm: ast2600: Wire up eMMC controller
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <cover.fc3e5e495d85ebd919c1f06a1a2c7c7730518f9c.1576211124.git-series.andrew@aj.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <16c90bb0-a3a9-06ec-e79a-bd98471d9e11@kaod.org>
Date: Fri, 13 Dec 2019 08:33:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cover.fc3e5e495d85ebd919c1f06a1a2c7c7730518f9c.1576211124.git-series.andrew@aj.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4530058279157861184
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelkedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.98.131
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

On 13/12/2019 05:28, Andrew Jeffery wrote:
> Hello,
> 
> The AST2600 has an additional SDHCI intended for use as an eMMC boot source.
> These two patches rework the existing ASPEED SDHCI model to accommodate the
> single-slot nature of the eMMC controller and wire it into the AST2600 SoC.
> 
> v2 contains some minor refactorings in response to issues pointed out by
> Cedric.
 

I think these patches are based on mainline. I fixed them locally on 
my aspeed 5.0 branch and I plan to send them along with other aspeed 
changes in the 5.0 timeframe.  

Thanks,

C. 

> 
> v1 can be found here:
> 
> https://patchwork.ozlabs.org/cover/1206845/
> 
> Please review!
> 
> Andrew
> 
> Andrew Jeffery (2):
>   hw/sd: Configure number of slots exposed by the ASPEED SDHCI model
>   hw/arm: ast2600: Wire up the eMMC controller
> 
>  hw/arm/aspeed.c              | 27 +++++++++++++++++----------
>  hw/arm/aspeed_ast2600.c      | 23 +++++++++++++++++++++++
>  hw/arm/aspeed_soc.c          |  2 ++
>  hw/sd/aspeed_sdhci.c         | 11 +++++++++--
>  include/hw/arm/aspeed_soc.h  |  2 ++
>  include/hw/sd/aspeed_sdhci.h |  1 +
>  6 files changed, 54 insertions(+), 12 deletions(-)
> 
> base-commit: 6a4ef4e5d1084ce41fafa7d470a644b0fd3d9317
> 


