Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F53C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4515920801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJ6/jZqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4515920801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46V5-0006fp-FD
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46Tw-0005gO-7m
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46Tv-0000Ve-2e
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:16:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43821
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46Tu-0000VU-VE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SYK6mBPmYHOXy7bu+xLnvBCdrwzix2ozAxFrSKioYKA=;
 b=ZJ6/jZqf1IqbfAtl6m+DaxLhLCl9fBqu/AU+I7UGHfI9Iqxsz0unTTg0U/pfU6XNlXwIbq
 80R/LLbARnKwM/MUxDYHfDCyuPnKdGC+GM7OMmvHJkP9xGCVN9hrE1xrX/op07wOcFi93T
 2ucuAEPdUeB2BC+0Y0oA6vl/SslOxLs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-GeAZ5-bOPIO9jfYwx-UTgg-1; Tue, 18 Feb 2020 12:16:20 -0500
Received: by mail-wr1-f70.google.com with SMTP id a12so11154003wrn.19
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=okJmUtVsn/nFOJXDKToCrbi+I7ltUyqWJrUJ+X6ouiQ=;
 b=mjzH1thtialfAufqnh6iE3FiqE1AOM3APEdYIE+innZ/rZWSRl1b9MrSNcUDQMHMg3
 SLsX8JPpCFW7qQC1xKRnr6/x3dczRKKosnEIl3/X32TdFYfN+a9Ml1AvcsEZyXoOMrf3
 ZYB+HM9/wfx886TMjIy0Qjq4bT3PktR0TZGnZsZzJPT+z0lOvSaGhPo306JkHvVI5Dfe
 8TEgD4y3D6XT7abpzPoErwda8FIcwn8xA7NgdWijpR62rrXZtLnteMoUY0sigeVKhkQr
 h6rs5a5v+UH3OB62IjivDjDKY44GBpO/a1gZII/q/gRj6UnrGOjq9rLON7rV2UAEFgw+
 RaAQ==
X-Gm-Message-State: APjAAAWyHW3+JeXuKSFVIkK5aktr3DEinra0MnSkS0CAqawIcsO/H8Eq
 ybrnsi54DR+TBmS6leMlWPEfzZHzrucNZ/uLL2lRczS5v/eTbFnOJCusaLgOdZzBX349RS3aXLZ
 OyUenRbJ8BOHkNSw=
X-Received: by 2002:a05:6000:8c:: with SMTP id
 m12mr30257523wrx.142.1582046176195; 
 Tue, 18 Feb 2020 09:16:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTOaosFYIjsaXRLNH9HVI0sSE/yCemHUFYH6TPDJ0RoPk86CZlH7hlwYB6XOoiZLBxBPx9Sw==
X-Received: by 2002:a05:6000:8c:: with SMTP id
 m12mr30257500wrx.142.1582046175925; 
 Tue, 18 Feb 2020 09:16:15 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z25sm3990624wmf.14.2020.02.18.09.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:16:15 -0800 (PST)
Subject: Re: [PATCH v5 11/79] arm/collie: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-12-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6ab7280b-cc57-e714-6908-163bab7c898c@redhat.com>
Date: Tue, 18 Feb 2020 18:16:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-12-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: GeAZ5-bOPIO9jfYwx-UTgg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 2/17/20 6:33 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> PS:
>   - while at it add check for user supplied RAM size and error
>     out if it mismatches board expected value.
>   - introduce RAM_ADDR_UFMT to avoid build errors on 32-bit hosts
>     when specifying format string for ram_addr_t type

Since v3 the 2nd comment is not valid anymore (also in other patches=20
from this series).

>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
> v2:
>    * fix format string causing build failure on 32-bit host
>      (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
> v3:
>    * instead of RAM_ADDR_UFMT adding use size_to_str()
>       Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   hw/arm/collie.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/collie.c b/hw/arm/collie.c
> index 970a4405cc..024893fc9e 100644
> --- a/hw/arm/collie.c
> +++ b/hw/arm/collie.c
> @@ -10,6 +10,7 @@
>    */
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
> +#include "qemu/cutils.h"
>   #include "hw/sysbus.h"
>   #include "hw/boards.h"
>   #include "strongarm.h"
> @@ -20,20 +21,24 @@
>  =20
>   static struct arm_boot_info collie_binfo =3D {
>       .loader_start =3D SA_SDCS0,
> -    .ram_size =3D 0x20000000,

This doesn't seem correct, this field is used do_cpu_reset() ->=20
set_kernel_args() (see hw/arm/boot.c).

>   };
>  =20
>   static void collie_init(MachineState *machine)
>   {
>       StrongARMState *s;
>       DriveInfo *dinfo;
> -    MemoryRegion *sdram =3D g_new(MemoryRegion, 1);
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> +
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        char *sz =3D size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
>  =20
>       s =3D sa1110_init(machine->cpu_type);
>  =20
> -    memory_region_allocate_system_memory(sdram, NULL, "strongarm.sdram",
> -                                         collie_binfo.ram_size);
> -    memory_region_add_subregion(get_system_memory(), SA_SDCS0, sdram);
> +    memory_region_add_subregion(get_system_memory(), SA_SDCS0, machine->=
ram);
>  =20
>       dinfo =3D drive_get(IF_PFLASH, 0, 0);
>       pflash_cfi01_register(SA_CS0, "collie.fl1", 0x02000000,
> @@ -57,6 +62,8 @@ static void collie_machine_init(MachineClass *mc)
>       mc->init =3D collie_init;
>       mc->ignore_memory_transaction_failures =3D true;
>       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("sa1110");
> +    mc->default_ram_size =3D 0x20000000;
> +    mc->default_ram_id =3D "strongarm.sdram";
>   }
>  =20
>   DEFINE_MACHINE("collie", collie_machine_init)
>=20


