Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50718C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D31E2081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDgOvu4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D31E2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iroMk-0007gU-Sb
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iroBk-0000QM-MN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iroBh-0008Ic-6a
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:18:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45433
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iroBh-0008IH-3R
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579115924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a1G9F6OaC6r8VcMdrUFe/BQIWU0G0oM1nX4/KoUtdok=;
 b=dDgOvu4ZoYGgtAG35Gzbz3AdZRFRmr6H55zqFp44YcMtOr+/i++QXNZ9baKaU++ISQlJjU
 T0IIPGFUY/n7aYXXqYpGDeK+rP9yJ3vEeN+mkbveSxylqflPl2L9KwnVrOCkp8fK1LVYEE
 jQPL991pdC4/+Bz42QBq41bMssnbNfE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-jP5SoIAZOT6kXoWO_Hn9GA-1; Wed, 15 Jan 2020 14:18:43 -0500
Received: by mail-wr1-f69.google.com with SMTP id u18so8317422wrn.11
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vXDQhNlLeoCnvPYVearnv8QPy7p0K1LW31op/Zn5Eyo=;
 b=FqX/gWfV6Q5PyIgQFIOelyL3iDG226J0mwKORzfgaOA0V2UZCtL5Mlcm8fi5p5bXjY
 KbKciTNZf0lh340xScTQ+JFLor7BEtsMziGEkd9oIq+J/PDEkmy4e7CjW/oMC5P9F5Vd
 K22u5UWJNp7pWNzZVoL2uKlMzX38EcxFahu6owk7Lcm9q8Jghy5+eonyEfsxykVmmgSY
 DGhD1SJTB3KNECMEqX0YvyeaewXrB+m4b6RjlnbB5WA70kVS4MyIn1jO7HnAPw5E1WNn
 P7gfY8gmV4fCxfhuWUwAjVIJCC9BcSG3oaVRcdi/TBUJ91xmf6F3AnK59t7DSdgUijw/
 O/EA==
X-Gm-Message-State: APjAAAXmCWHKrNyS8CvokK2Y9/rhTLOZ4MqP8kHGrmfRGdEbC5AdkpmT
 zGXzCttW8N/8c5Jua+Z0cKXpv3BNx9Mj66yTEmH9C/APVc5FrWgJJLEhkAlv0d+fZo+lF84T61F
 D889a1R34aQBxBkM=
X-Received: by 2002:a1c:e108:: with SMTP id y8mr1489392wmg.147.1579115922617; 
 Wed, 15 Jan 2020 11:18:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCmucc/THfWzTPwAIXEjBqNdRYZXnuoomubPDS2D/ADKMZsSQ+Bg6uYuzePn/QqFrFloWwRw==
X-Received: by 2002:a1c:e108:: with SMTP id y8mr1489375wmg.147.1579115922441; 
 Wed, 15 Jan 2020 11:18:42 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id a1sm1095094wmj.40.2020.01.15.11.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 11:18:41 -0800 (PST)
Subject: Re: [PATCH v2 14/86] arm:highbank: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-15-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1177e3ef-6c18-b6e7-d96f-bfb7a906250f@redhat.com>
Date: Wed, 15 Jan 2020 20:18:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-15-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: jP5SoIAZOT6kXoWO_Hn9GA-1
X-Mimecast-Spam-Score: 0
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
Cc: robh@kernel.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 4:06 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: robh@kernel.org
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>   hw/arm/highbank.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
> index 518d935..ac9de94 100644
> --- a/hw/arm/highbank.c
> +++ b/hw/arm/highbank.c
> @@ -236,7 +236,6 @@ enum cxmachines {
>    */
>   static void calxeda_init(MachineState *machine, enum cxmachines machine=
_id)
>   {
> -    ram_addr_t ram_size =3D machine->ram_size;
>       DeviceState *dev =3D NULL;
>       SysBusDevice *busdev;
>       qemu_irq pic[128];
> @@ -247,7 +246,6 @@ static void calxeda_init(MachineState *machine, enum =
cxmachines machine_id)
>       qemu_irq cpu_virq[4];
>       qemu_irq cpu_vfiq[4];
>       MemoryRegion *sysram;
> -    MemoryRegion *dram;
>       MemoryRegion *sysmem;
>       char *sysboot_filename;
>  =20
> @@ -290,10 +288,8 @@ static void calxeda_init(MachineState *machine, enum=
 cxmachines machine_id)
>       }
>  =20
>       sysmem =3D get_system_memory();
> -    dram =3D g_new(MemoryRegion, 1);
> -    memory_region_allocate_system_memory(dram, NULL, "highbank.dram", ra=
m_size);
>       /* SDRAM at address zero.  */
> -    memory_region_add_subregion(sysmem, 0, dram);
> +    memory_region_add_subregion(sysmem, 0, machine->ram);
>  =20
>       sysram =3D g_new(MemoryRegion, 1);
>       memory_region_init_ram(sysram, NULL, "highbank.sysram", 0x8000,
> @@ -387,7 +383,7 @@ static void calxeda_init(MachineState *machine, enum =
cxmachines machine_id)
>  =20
>       /* TODO create and connect IDE devices for ide_drive_get() */
>  =20
> -    highbank_binfo.ram_size =3D ram_size;
> +    highbank_binfo.ram_size =3D machine->ram_size;
>       /* highbank requires a dtb in order to boot, and the dtb will overr=
ide
>        * the board ID. The following value is ignored, so set it to -1 to=
 be
>        * clear that the value is meaningless.
> @@ -430,6 +426,7 @@ static void highbank_class_init(ObjectClass *oc, void=
 *data)
>       mc->units_per_default_bus =3D 1;
>       mc->max_cpus =3D 4;
>       mc->ignore_memory_transaction_failures =3D true;
> +    mc->default_ram_id =3D "highbank.dram";
>   }
>  =20
>   static const TypeInfo highbank_type =3D {
> @@ -448,6 +445,7 @@ static void midway_class_init(ObjectClass *oc, void *=
data)
>       mc->units_per_default_bus =3D 1;
>       mc->max_cpus =3D 4;
>       mc->ignore_memory_transaction_failures =3D true;
> +    mc->default_ram_id =3D "highbank.dram";
>   }
>  =20
>   static const TypeInfo midway_type =3D {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


