Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B9AC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AD822BED
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AD822BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGuB-00078z-Ho
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39527)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hvGte-0006ip-Tq
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hvGtd-0001Q4-Pl
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:02:10 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:51594)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hvGtd-0001Jh-Ic
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:02:09 -0400
Received: from player793.ha.ovh.net (unknown [10.108.35.197])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 5BAAF7494A
 for <qemu-devel@nongnu.org>; Wed,  7 Aug 2019 10:02:07 +0200 (CEST)
Received: from kaod.org (bad36-1-78-202-132-1.fbx.proxad.net [78.202.132.1])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 936028BF84D8;
 Wed,  7 Aug 2019 08:01:58 +0000 (UTC)
To: Balamuruhan S <bala24@linux.ibm.com>, qemu-devel@nongnu.org
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-6-bala24@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a2f067c4-d1a7-e729-baa6-dc4f31a8b882@kaod.org>
Date: Wed, 7 Aug 2019 10:01:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807071445.4109-6-bala24@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 9619407330965162982
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudduuddguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.51.53
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] hw/ppc/pnv_xscom: retrieve
 homer/occ base address from PBA BARs
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
Cc: pbonzini@redhat.com, maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au, hari@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/2019 09:14, Balamuruhan S wrote:
> During PowerNV boot skiboot populates the device tree by retrieving
> base address of homer/occ common area from PBA BARs and prd ipoll
> mask by accessing xscom read/write accesses.

This looks good. If you could add defines it would be better.

Our common XSCOM ops is starting to be a bit messy. May we should think
about introducing one for P9 and one for P8.

Thanks,

C. 

> Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
> ---
>  hw/ppc/pnv_xscom.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
> index 5d5b5e9884..18a780bcdf 100644
> --- a/hw/ppc/pnv_xscom.c
> +++ b/hw/ppc/pnv_xscom.c
> @@ -77,6 +77,29 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
>      case 0x18002:       /* ECID2 */
>          return 0;
>  
> +    /* PBA BAR0 */
> +    case 0x5012b00: /* P9 homer base address */
> +        return PNV9_HOMER_BASE(chip);
> +    case 0x2013f00: /* P8 homer base address */
> +        return PNV_HOMER_BASE(chip);
> +
> +    /* PBA BARMASK0 */
> +    case 0x5012b04: /* P9 homer region size */
> +    case 0x2013f04: /* P8 homer region size */
> +        return PNV_HOMER_SIZE;
> +
> +    /* PBA BAR2 */
> +    case 0x5012b02: /* P9 occ common area */
> +        return PNV9_OCC_COMMON_AREA(chip);
> +    case 0x2013f02: /* P8 occ common area */
> +        return PNV_OCC_COMMON_AREA(chip);
> +
> +    /* PBA BARMASK2 */
> +    case 0x5012b06: /* P9 occ common area size */
> +    case 0x2013f06: /* P8 occ common area size */
> +        return PNV_OCC_COMMON_AREA_SIZE;
> +
> +
>      case 0x1010c00:     /* PIBAM FIR */
>      case 0x1010c03:     /* PIBAM FIR MASK */
>  
> @@ -96,13 +119,9 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
>      case 0x2020009:     /* ADU stuff, error register */
>      case 0x202000f:     /* ADU stuff, receive status register*/
>          return 0;
> -    case 0x2013f00:     /* PBA stuff */
>      case 0x2013f01:     /* PBA stuff */
> -    case 0x2013f02:     /* PBA stuff */
>      case 0x2013f03:     /* PBA stuff */
> -    case 0x2013f04:     /* PBA stuff */
>      case 0x2013f05:     /* PBA stuff */
> -    case 0x2013f06:     /* PBA stuff */
>      case 0x2013f07:     /* PBA stuff */
>          return 0;
>      case 0x2013028:     /* CAPP stuff */
> 


