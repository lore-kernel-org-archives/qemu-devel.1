Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B24EC31E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 09:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7437F2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 09:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7437F2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55151 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdANz-00082L-Lq
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 05:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51661)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hdAML-0006oH-K2
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hdAMK-0007OP-JE
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:24:57 -0400
Received: from 19.mo7.mail-out.ovh.net ([178.33.251.118]:56583)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hdAMK-0007Kj-Cf
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 05:24:56 -0400
Received: from player763.ha.ovh.net (unknown [10.108.35.12])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id F359C1234E0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 11:24:53 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player763.ha.ovh.net (Postfix) with ESMTPSA id 03A686F662A7;
 Tue, 18 Jun 2019 09:24:48 +0000 (UTC)
To: Rashmica Gupta <rashmica.g@gmail.com>, qemu-arm@nongnu.org
References: <20190618085154.21498-1-rashmica.g@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e64ed8ab-8be5-e607-db2e-1d5b8ec793f8@kaod.org>
Date: Tue, 18 Jun 2019 11:24:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618085154.21498-1-rashmica.g@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12530421540083174355
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeiledgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.118
Subject: Re: [Qemu-devel] [PATCH 0/2] Add Aspeed GPIO controller model
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
Cc: andrew@aj.id.au, qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/06/2019 10:51, Rashmica Gupta wrote:
> Hi,
>=20
> These two patches add a bunch of the functionality of the ast2400 and
> ast2500 gpio controllers.=20
>=20
> This is based off upstream/master with two of C=C3=A9dric's patches:
> - aspeed: add a per SoC mapping for the interrupt space
> - aspeed: add a per SoC mapping for the memory space
>=20
>=20
> Any feedback would be great!


When you resend, could you please use the comment in aspeed_gpio.c=20
as a commit log ? and add Peter in cc:

Thanks,

C.=20


> Rashmica Gupta (2):
>   hw/gpio: Add basic Aspeed GPIO model
>   aspeed: add a GPIO controller to the SoC
>=20
>  hw/arm/aspeed_soc.c           |  17 +
>  hw/gpio/Makefile.objs         |   1 +
>  hw/gpio/aspeed_gpio.c         | 869 ++++++++++++++++++++++++++++++++++
>  include/hw/arm/aspeed_soc.h   |   3 +
>  include/hw/gpio/aspeed_gpio.h |  76 +++
>  5 files changed, 966 insertions(+)
>  create mode 100644 hw/gpio/aspeed_gpio.c
>  create mode 100644 include/hw/gpio/aspeed_gpio.h
>=20


