Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4078DC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162572078B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162572078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJb7C-0007PD-5v
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 07:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jJb5Y-0006In-Jb
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1jJb5X-00005D-Bi
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:59:16 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:46094
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1jJb5X-0008Vh-1P
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:59:15 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 46EFF81385;
 Wed,  1 Apr 2020 12:59:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RFF9QOzObMRa; Wed,  1 Apr 2020 12:59:14 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 086A381387;
 Wed,  1 Apr 2020 12:59:14 +0200 (CEST)
Subject: Re: [PATCH-for-5.1 4/7] hw/misc/grlib_ahb_apb_pnp: Add trace events
 on read accesses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-5-f4bug@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <557a8f96-5dd1-99f7-ee6a-67876a5ff3e8@adacore.com>
Date: Wed, 1 Apr 2020 12:59:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331105048.27989-5-f4bug@amsat.org>
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   hw/misc/grlib_ahb_apb_pnp.c | 13 +++++++++++--
>   hw/misc/trace-events        |  4 ++++
>   2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
> index d22ed00206..43e001c3c7 100644
> --- a/hw/misc/grlib_ahb_apb_pnp.c
> +++ b/hw/misc/grlib_ahb_apb_pnp.c
> @@ -25,6 +25,7 @@
>   #include "qemu/log.h"
>   #include "hw/sysbus.h"
>   #include "hw/misc/grlib_ahb_apb_pnp.h"
> +#include "trace.h"
>  =20
>   #define GRLIB_PNP_VENDOR_SHIFT (24)
>   #define GRLIB_PNP_VENDOR_SIZE   (8)
> @@ -132,8 +133,12 @@ void grlib_ahb_pnp_add_entry(AHBPnp *dev, uint32_t=
 address, uint32_t mask,
>   static uint64_t grlib_ahb_pnp_read(void *opaque, hwaddr offset, unsig=
ned size)
>   {
>       AHBPnp *ahb_pnp =3D GRLIB_AHB_PNP(opaque);
> +    uint32_t val;
>  =20
> -    return ahb_pnp->regs[offset >> 2];
> +    val =3D ahb_pnp->regs[offset >> 2];
> +    trace_grlib_ahb_pnp_read(offset, val);
> +
> +    return val;
>   }
>  =20
>   static void grlib_ahb_pnp_write(void *opaque, hwaddr addr,
> @@ -239,8 +244,12 @@ void grlib_apb_pnp_add_entry(APBPnp *dev, uint32_t=
 address, uint32_t mask,
>   static uint64_t grlib_apb_pnp_read(void *opaque, hwaddr offset, unsig=
ned size)
>   {
>       APBPnp *apb_pnp =3D GRLIB_APB_PNP(opaque);
> +    uint32_t val;
>  =20
> -    return apb_pnp->regs[offset >> 2];
> +    val =3D apb_pnp->regs[offset >> 2];
> +    trace_grlib_apb_pnp_read(offset, val);
> +
> +    return val;
>   }
>  =20
>   static void grlib_apb_pnp_write(void *opaque, hwaddr addr,
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index a5862b2bed..9387664823 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -198,3 +198,7 @@ via1_rtc_cmd_pram_read(int addr, int value) "addr=3D=
%u value=3D0x%02x"
>   via1_rtc_cmd_pram_write(int addr, int value) "addr=3D%u value=3D0x%02=
x"
>   via1_rtc_cmd_pram_sect_read(int sector, int offset, int addr, int val=
ue) "sector=3D%u offset=3D%u addr=3D%d value=3D0x%02x"
>   via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int va=
lue) "sector=3D%u offset=3D%u addr=3D%d value=3D0x%02x"
> +
> +# grlib_ahb_apb_pnp.c
> +grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0=
x%03"PRIx64" data:0x%08x"
> +grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0=
x%03"PRIx64" data:0x%08x"
>=20

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

