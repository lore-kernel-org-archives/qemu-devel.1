Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9680C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C9B206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C9B206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgDN-00042b-SZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1izgCo-0003Tw-CM
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1izgCn-0000lb-9z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:24:26 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:15551)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1izgCk-00007R-Sa; Thu, 06 Feb 2020 07:24:23 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 08B4D746383;
 Thu,  6 Feb 2020 13:24:20 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D9C9074637F; Thu,  6 Feb 2020 13:24:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D859274569F;
 Thu,  6 Feb 2020 13:24:19 +0100 (CET)
Date: Thu, 6 Feb 2020 13:24:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 04/30] hw/arm/raspi: Extract the RAM size from the
 board revision
In-Reply-To: <20200206011756.2413-5-f4bug@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2002061321480.71431@zero.eik.bme.hu>
References: <20200206011756.2413-1-f4bug@amsat.org>
 <20200206011756.2413-5-f4bug@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-125707739-1580991859=:71431"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-arm@nongnu.org,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-125707739-1580991859=:71431
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Feb 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> The board revision encode the amount of RAM. Add a helper
> to extract the RAM size, and use it.
> Since the amount of RAM is fixed (it is impossible to physically
> modify to have more or less RAM), do not allow sizes different
> than the one anounced by the manufacturer.
>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Cc: Alistair Francis <alistair@alistair23.me>
>
> hw/arm/raspi.c | 15 ++++++++++++---
> 1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 13d41dfce6..2f5cd32c5e 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -13,6 +13,7 @@
>
> #include "qemu/osdep.h"
> #include "qemu/units.h"
> +#include "qemu/cutils.h"
> #include "qapi/error.h"
> #include "cpu.h"
> #include "hw/arm/bcm2836.h"
> @@ -48,6 +49,12 @@ FIELD(REV_CODE, MANUFACTURER,      16, 4);
> FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
> FIELD(REV_CODE, STYLE,             23, 1);
>
> +static uint64_t board_ram_size(uint32_t board_rev)
> +{
> +    assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style =
*/
> +    return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
> +}
> +
> static int board_processor_id(uint32_t board_rev)
> {
>     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style *=
/
> @@ -190,15 +197,17 @@ static void raspi_init(MachineState *machine, uin=
t32_t board_rev)
> {
>     RasPiState *s =3D g_new0(RasPiState, 1);
>     int version =3D board_version(board_rev);
> +    uint64_t ram_size =3D board_ram_size(board_rev);
>     uint32_t vcram_size;
>     DriveInfo *di;
>     BlockBackend *blk;
>     BusState *bus;
>     DeviceState *carddev;
>
> -    if (machine->ram_size > 1 * GiB) {
> -        error_report("Requested ram size is too large for this machine=
: "
> -                     "maximum is 1GB");
> +    if (machine->ram_size !=3D ram_size) {
> +        char *size_str =3D size_to_str(ram_size);
> +        error_report("This machine can only be used with %s", size_str=
);

Reword error message so it says it has problem with memory as this is not=
=20
clear from the above and user getting it after a command line does not=20
have context to tell what the printed number means.

Regards,
BALATON Zoltan


> +        g_free(size_str);
>         exit(1);
>     }
>
>
--3866299591-125707739-1580991859=:71431--

