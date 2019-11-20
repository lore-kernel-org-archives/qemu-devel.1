Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D4EC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A41122365
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A41122365
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXKSg-0005IC-39
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 02:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXKRL-0004e6-7S
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXKRJ-0008Ar-Ty
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:30:14 -0500
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:48064)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXKRJ-00085Q-MD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:30:13 -0500
Received: from player737.ha.ovh.net (unknown [10.109.160.62])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 36FBF11451B
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:30:10 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id F1BCF2DEFEAA;
 Wed, 20 Nov 2019 07:30:04 +0000 (UTC)
Subject: Re: [PATCH 4/5] hw/ppc/pnv_xscom: occ common area to be mapped only
 once
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <20191119175056.32518-5-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b180f87b-f713-3843-bfc4-fff316b3510d@kaod.org>
Date: Wed, 20 Nov 2019 08:30:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119175056.32518-5-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 16970126346097363942
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegledguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.39.154
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
Cc: qemu-ppc@nongnu.org, groug@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/11/2019 18:50, Balamuruhan S wrote:
> occ common area should be mapped once=20

It's the same address on each chip.=20

the question is how the HW knows from which chip the OCC access is=20
being done ? How does it target the correct OCC if the address is=20
the same ?=20

> and disable it for every other chip.

On P8 OpenPOWER systems, the PBA3 registers are still set, not on
tuletas though (different hostboot I suppose). On OpenPOWER systems,
they are still set also.
=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

nah. I didn't write any of this :)=20

> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/pnv_xscom.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index cb6d6bbcfc..f797a5ec7d 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -98,13 +98,22 @@ static uint64_t xscom_read_default(PnvChip *chip, u=
int32_t pcba)
>          return HOMER_SIZE_MASK;
> =20
>      case P9_PBA_BAR2: /* P9 occ common area */
> -        return PNV9_OCC_COMMON_AREA(chip);
> +        if (!PNV_CHIP_INDEX(chip)) {

Yes that it is the idea. XIVE uses directly 'chip->chip_id'.=20


> +            return PNV9_OCC_COMMON_AREA(chip);
> +        }
> +        return 0;
>      case P8_PBA_BAR3: /* P8 occ common area */
> -        return PNV_OCC_COMMON_AREA(chip);
> +        if (!PNV_CHIP_INDEX(chip)) {
> +            return PNV_OCC_COMMON_AREA(chip);
> +        }
> +        return 0;
> =20
>      case P9_PBA_BARMASK2: /* P9 occ common area size */
>      case P8_PBA_BARMASK3: /* P8 occ common area size */
> -        return OCC_SIZE_MASK;
> +        if (!PNV_CHIP_INDEX(chip)) {
> +            return OCC_SIZE_MASK;
> +        }
> +        return 0;
> =20
>      case 0x1010c00:     /* PIBAM FIR */
>      case 0x1010c03:     /* PIBAM FIR MASK */
>=20


