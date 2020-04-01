Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B60BC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 10:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD9E20678
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 10:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD9E20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJb5Y-00064e-Bz
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 06:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jJb4o-0005At-GH
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1jJb4n-000723-FZ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:58:30 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:46013
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1jJb4n-0006ya-9D
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:58:29 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 4871381382;
 Wed,  1 Apr 2020 12:58:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J--_eWlb6MnX; Wed,  1 Apr 2020 12:58:28 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 0ADAC81380;
 Wed,  1 Apr 2020 12:58:28 +0200 (CEST)
Subject: Re: [PATCH-for-5.0 3/7] hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit
 accesses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-4-f4bug@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <f453bf73-0c17-cd5d-4171-3b13f199f59b@adacore.com>
Date: Wed, 1 Apr 2020 12:58:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331105048.27989-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 194.98.77.210
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
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiri Gaisler <jiri@gaisler.se>, Fabien Chouteau <chouteau@adacore.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 3/31/20 =C3=A0 12:50 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> The Plug & Play region of the AHB/APB bridge can be accessed
> by various word size, however the implementation is clearly
> restricted to 32-bit:
>=20
>    static uint64_t grlib_ahb_pnp_read(void *opaque, hwaddr offset, unsi=
gned size)
>    {
>        AHBPnp *ahb_pnp =3D GRLIB_AHB_PNP(opaque);
>=20
>        return ahb_pnp->regs[offset >> 2];
>    }
>=20
> Similarly to commit 0fbe394a64 with the APB PnP registers,
> set the MemoryRegionOps::impl min/max fields to 32-bit, so
> memory.c::access_with_adjusted_size() can adjust when the
> access is not 32-bit.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/misc/grlib_ahb_apb_pnp.c | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
> index 72a8764776..d22ed00206 100644
> --- a/hw/misc/grlib_ahb_apb_pnp.c
> +++ b/hw/misc/grlib_ahb_apb_pnp.c
> @@ -146,6 +146,10 @@ static const MemoryRegionOps grlib_ahb_pnp_ops =3D=
 {
>       .read       =3D grlib_ahb_pnp_read,
>       .write      =3D grlib_ahb_pnp_write,
>       .endianness =3D DEVICE_BIG_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 4,
> +        .max_access_size =3D 4,
> +    },
>   };
>  =20
>   static void grlib_ahb_pnp_realize(DeviceState *dev, Error **errp)
>=20

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

