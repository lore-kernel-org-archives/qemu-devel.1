Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0123C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 07:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2950206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 07:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2950206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUQtQ-00079I-DO
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 02:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iUQrw-0005n9-4L
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iUQrv-0004LZ-4m
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:45:44 -0500
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:52809)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iUQru-00044o-VQ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 02:45:43 -0500
Received: from player758.ha.ovh.net (unknown [10.108.57.38])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 8DFF319A84E
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:45:33 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player758.ha.ovh.net (Postfix) with ESMTPSA id 74576C03D0FB;
 Tue, 12 Nov 2019 07:45:27 +0000 (UTC)
Subject: Re: [PATCH 1/4] aspeed/sdmc: Make ast2600 default 1G
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>
References: <20191112064058.13275-1-joel@jms.id.au>
 <20191112064058.13275-2-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5c0c7d7e-0580-2bcd-39ac-6314c61dd1d3@kaod.org>
Date: Tue, 12 Nov 2019 08:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112064058.13275-2-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 7141583110517197632
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedruddvkedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.127.22
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/2019 07:40, Joel Stanley wrote:
> Most boards have this much.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  hw/misc/aspeed_sdmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
> index f3a63a2e01db..2df3244b53c8 100644
> --- a/hw/misc/aspeed_sdmc.c
> +++ b/hw/misc/aspeed_sdmc.c
> @@ -208,10 +208,10 @@ static int ast2600_rambits(AspeedSDMCState *s)
>      }
> =20
>      /* use a common default */
> -    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
> +    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 1024M",
>                  s->ram_size);
> -    s->ram_size =3D 512 << 20;
> -    return ASPEED_SDMC_AST2600_512MB;
> +    s->ram_size =3D 1024 << 20;
> +    return ASPEED_SDMC_AST2600_1024MB;
>  }
> =20
>  static void aspeed_sdmc_reset(DeviceState *dev)
>=20


