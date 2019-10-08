Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EA1C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C962206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 12:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C962206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHoJr-0005z0-IG
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 08:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHoJ8-0005TK-1u
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHoJ3-0007G4-1s
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:09:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52204)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHoJ2-0007FY-Pr
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 08:09:32 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9702C9B293
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 12:09:31 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z205so1286969wmb.7
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 05:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+a6Whkvdmk5PObrP5xBYoksAhIsLuSGCplgjOD7bfRg=;
 b=S9l/3uc6ljhvxOqZNoQ3KLsWcPRqNbi2foLtFnQlX4kQMgcagUko6mu9NTaXpxFfvW
 PZFqR9b8UPFWIkCplMczUXA6N5OLS81iuvJ5CMxLh+6K+cYCzHn9vEIc1NuBxg+92ntQ
 +qMYMoS+l2hcNRMsJkddLug2Dx54cq7bYhcQTNKo3GVfbDsXTZiT6ze//gJlOES1VP/V
 osSiRrkx/mbgxqmqSIfsYuMu0WToFe0LAHDPGc0h6GJwNUt12Mg0TBpsXS7+YteqWOmb
 jXQBmZkbW5OHFx4qRPFBW5DmhiJJA5AVXwxBcYWU8yt0nKHixi/w/QarjknxNL+Zf6wp
 zTRA==
X-Gm-Message-State: APjAAAXxpOaE/vsp+mdFrD3RgRhN6goLHcaE2YwJpM580u9Dvt6e+DOj
 a803AxaoduX/HqGgzCf9ujENYvmWKo0MuJnSu1gG8zTjewaX31bh3RU6E+WwrvntemB4f1MvXuE
 mXnaZFTu/3TYHvHU=
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr3464225wms.168.1570536570377; 
 Tue, 08 Oct 2019 05:09:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmba1V+/qFinI16d072zmiDuHK83cYNFT6MIciRYDnYGMAAyzeikFqLfygyHhgZP/PCOx0rA==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr3464205wms.168.1570536570182; 
 Tue, 08 Oct 2019 05:09:30 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id m16sm2475250wml.11.2019.10.08.05.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 05:09:29 -0700 (PDT)
Subject: Re: [PATCH 1/3] sparc64: use memory_region_allocate_system_memory()
 only for '-m' specified RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20191008113318.7012-1-imammedo@redhat.com>
 <20191008113318.7012-2-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d1d15a4c-a8a3-2bd3-3421-088dd8fc8d2d@redhat.com>
Date: Tue, 8 Oct 2019 14:09:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008113318.7012-2-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, deller@gmx.de,
 mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, hpoussin@reactos.org,
 david@gibson.dropbear.id.au, atar4qemu@gmail.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 1:33 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() was designed to be called for
> allocating inital RAM. Using it mutiple times within one board is not
> supported and could fail if -mem-path with non hugepage path is used.
>=20
> Keep using memory_region_allocate_system_memory() only for initial
> RAM and use memory_region_init_ram() for the rest fixed size regions.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/sparc64/niagara.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index 167143bffe..5987693659 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -36,6 +36,7 @@
>   #include "qemu/error-report.h"
>   #include "sysemu/qtest.h"
>   #include "sysemu/sysemu.h"
> +#include "qapi/error.h"
>  =20
>   typedef struct NiagaraBoardState {
>       MemoryRegion hv_ram;
> @@ -106,8 +107,8 @@ static void niagara_init(MachineState *machine)
>       /* init CPUs */
>       sparc64_cpu_devinit(machine->cpu_type, NIAGARA_PROM_BASE);
>       /* set up devices */
> -    memory_region_allocate_system_memory(&s->hv_ram, NULL, "sun4v-hv.r=
am",
> -                                         NIAGARA_HV_RAM_SIZE);
> +    memory_region_init_ram(&s->hv_ram, NULL, "sun4v-hv.ram",
> +                           NIAGARA_HV_RAM_SIZE, &error_fatal);
>       memory_region_add_subregion(sysmem, NIAGARA_HV_RAM_BASE, &s->hv_r=
am);
>  =20
>       memory_region_allocate_system_memory(&s->partition_ram, NULL,

Did we have an issue calling memory_region_allocate_system_memory()=20
*after* memory_region_init_ram() by the past?
Maybe not, or it is fixed, and your patch is fine:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> @@ -116,17 +117,17 @@ static void niagara_init(MachineState *machine)
>       memory_region_add_subregion(sysmem, NIAGARA_PARTITION_RAM_BASE,
>                                   &s->partition_ram);
>  =20
> -    memory_region_allocate_system_memory(&s->nvram, NULL,
> -                                         "sun4v.nvram", NIAGARA_NVRAM_=
SIZE);
> +    memory_region_init_ram(&s->nvram, NULL, "sun4v.nvram", NIAGARA_NVR=
AM_SIZE,
> +                           &error_fatal);
>       memory_region_add_subregion(sysmem, NIAGARA_NVRAM_BASE, &s->nvram=
);
> -    memory_region_allocate_system_memory(&s->md_rom, NULL,
> -                                         "sun4v-md.rom", NIAGARA_MD_RO=
M_SIZE);
> +    memory_region_init_ram(&s->md_rom, NULL, "sun4v-md.rom",
> +                           NIAGARA_MD_ROM_SIZE, &error_fatal);
>       memory_region_add_subregion(sysmem, NIAGARA_MD_ROM_BASE, &s->md_r=
om);
> -    memory_region_allocate_system_memory(&s->hv_rom, NULL,
> -                                         "sun4v-hv.rom", NIAGARA_HV_RO=
M_SIZE);
> +    memory_region_init_ram(&s->hv_rom, NULL, "sun4v-hv.rom",
> +                           NIAGARA_HV_ROM_SIZE, &error_fatal);
>       memory_region_add_subregion(sysmem, NIAGARA_HV_ROM_BASE, &s->hv_r=
om);
> -    memory_region_allocate_system_memory(&s->prom, NULL,
> -                                         "sun4v.prom", PROM_SIZE_MAX);
> +    memory_region_init_ram(&s->prom, NULL, "sun4v.prom", PROM_SIZE_MAX=
,
> +                           &error_fatal);
>       memory_region_add_subregion(sysmem, NIAGARA_PROM_BASE, &s->prom);
>  =20
>       add_rom_or_fail("nvram1", NIAGARA_NVRAM_BASE);
> @@ -143,8 +144,8 @@ static void niagara_init(MachineState *machine)
>           BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
>           int size =3D blk_getlength(blk);
>           if (size > 0) {
> -            memory_region_allocate_system_memory(&s->vdisk_ram, NULL,
> -                                                 "sun4v_vdisk.ram", si=
ze);
> +            memory_region_init_ram(&s->vdisk_ram, NULL, "sun4v_vdisk.r=
am", size,
> +                                   &error_fatal);
>               memory_region_add_subregion(get_system_memory(),
>                                           NIAGARA_VDISK_BASE, &s->vdisk=
_ram);
>               dinfo->is_default =3D 1;
>=20

