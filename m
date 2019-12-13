Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BFDC00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847EC21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847EC21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifkYI-0001km-IK
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 08:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ifkXQ-0001DQ-SC
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ifkXP-0004IK-PR
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:59:20 -0500
Received: from 14.mo1.mail-out.ovh.net ([178.32.97.215]:41737)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ifkXP-0004FS-Hx
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:59:19 -0500
Received: from player688.ha.ovh.net (unknown [10.108.54.237])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5756619F65D
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 13:59:17 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 3406FD2E2D5A;
 Fri, 13 Dec 2019 12:59:13 +0000 (UTC)
Subject: Re: [PATCH 06/13] ppc/pnv: Drop pnv_is_power9() and pnv_is_power10()
 helpers
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623840200.360005.1300941274565357363.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8ddb12e7-a49f-b7be-ac62-6e0859ab3850@kaod.org>
Date: Fri, 13 Dec 2019 13:59:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157623840200.360005.1300941274565357363.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10026138672240233299
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudelledggeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.97.215
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/2019 13:00, Greg Kurz wrote:
> They aren't used anymore.

Good !=20

> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>


> ---
>  include/hw/ppc/pnv.h |   10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 8a42c199b65c..c213bdd5ecd3 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -227,11 +227,6 @@ static inline bool pnv_chip_is_power9(const PnvChi=
p *chip)
>      return PNV_CHIP_GET_CLASS(chip)->chip_type =3D=3D PNV_CHIP_POWER9;
>  }
> =20
> -static inline bool pnv_is_power9(PnvMachineState *pnv)
> -{
> -    return pnv_chip_is_power9(pnv->chips[0]);
> -}
> -
>  PnvChip *pnv_get_chip(uint32_t chip_id);
> =20
>  #define PNV_FDT_ADDR          0x01000000
> @@ -242,11 +237,6 @@ static inline bool pnv_chip_is_power10(const PnvCh=
ip *chip)
>      return PNV_CHIP_GET_CLASS(chip)->chip_type =3D=3D PNV_CHIP_POWER10=
;
>  }
> =20
> -static inline bool pnv_is_power10(PnvMachineState *pnv)
> -{
> -    return pnv_chip_is_power10(pnv->chips[0]);
> -}
> -
>  /*
>   * BMC helpers
>   */
>=20


