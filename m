Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28A0C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1ED72081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axj2rD9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ED72081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iroMh-0007ZU-Nt
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iroEM-00033p-6c
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:21:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iroEI-0001rz-5X
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:21:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20687
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iroEI-0001rg-2Z
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579116085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KOBNebwN5ZJDL+Ty5TBdkn9mPdsi5cY+IjZgOi1aV7I=;
 b=axj2rD9oSJ7yWRnbKX6q+Fct4xjcYA7gxmFZCW1L6IgTmyn2FYV9UojWNZr+Ba1GyupLx1
 5ODFwcgPs1VHPNUeARRHSGO6+7xd2hT5rlBoLVl8bGjkReHsuisDD3j0u8yML0DlGSxdCj
 frju2eClM9EPWnPtbqS1StzF0jKj2As=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-MrRWgJ1TOw-4EHUGKOx_qw-1; Wed, 15 Jan 2020 14:21:23 -0500
Received: by mail-wr1-f70.google.com with SMTP id f15so8432777wrr.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N6ea6BKh76WzXKHFqhF9XNNKVEaJqpc1BGEfICEg894=;
 b=doRdxYU12oNFXldzasdTHC6hnysa/zQDsod0NVnLooqtPalom6RHkRefj9+K+xiISN
 YdxG+7GqXVJbnH6Prjyj3+47lh1DSmqiGHUKckrfJSjnPdxya248rgqHQI/vZ3xOElMD
 qhzcNAdjJXHj8YBU++TwYOTgCur9lfS3rw1kx2eH7PSfeTBPqAIrNViI3H/CKz19Y6h5
 TLgONGoKPPuqr7S5iOBe9fbX3PWY1BaeMVEGWluZ9hOml4ZHsyVxJqYxI8PJ/owehxOb
 lf0dTY762zHR5qIhrirpcD/uqyROFVS+7w9w1TKW/IDQVsreFFKFJgDxEo7bE8iYyURt
 lhMw==
X-Gm-Message-State: APjAAAXL6vgsFUoq2mbf+xf1bc2ZvI3sZp9+pT2IB9wRqRbivIKRExoO
 3bVuDKgbcvL8frXhDHKlBtQ2tZJrQ5flkVHGZWqCgsMR8QT8SB76rtR7XwnoSHCDSsHMs7db/SR
 6k/8TsI2n20SJ7FM=
X-Received: by 2002:a05:600c:141:: with SMTP id
 w1mr1517730wmm.61.1579116082412; 
 Wed, 15 Jan 2020 11:21:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqzn/Sle6dOgolOHoOdRJ0nbyJG4b6Soav6fAv805RQPDhKEuzSzmLgqLw+V8SvsvQ+o0W4KXg==
X-Received: by 2002:a05:600c:141:: with SMTP id
 w1mr1517702wmm.61.1579116082198; 
 Wed, 15 Jan 2020 11:21:22 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id f1sm26023104wru.6.2020.01.15.11.21.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 11:21:21 -0800 (PST)
Subject: Re: [PATCH v2 32/86] arm:vexpress: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-33-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ba46b36b-470c-d08d-2cad-f411718ef9fd@redhat.com>
Date: Wed, 15 Jan 2020 20:21:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-33-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: MrRWgJ1TOw-4EHUGKOx_qw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 4:06 PM, Igor Mammedov wrote:
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>   hw/arm/vexpress.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index 4673a88..ed683ee 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -273,7 +273,6 @@ static void a9_daughterboard_init(const VexpressMachi=
neState *vms,
>   {
>       MachineState *machine =3D MACHINE(vms);
>       MemoryRegion *sysmem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *lowram =3D g_new(MemoryRegion, 1);
>       ram_addr_t low_ram_size;
>  =20
> @@ -283,8 +282,6 @@ static void a9_daughterboard_init(const VexpressMachi=
neState *vms,
>           exit(1);
>       }
>  =20
> -    memory_region_allocate_system_memory(ram, NULL, "vexpress.highmem",
> -                                         ram_size);
>       low_ram_size =3D ram_size;
>       if (low_ram_size > 0x4000000) {
>           low_ram_size =3D 0x4000000;
> @@ -293,9 +290,10 @@ static void a9_daughterboard_init(const VexpressMach=
ineState *vms,
>        * address space should in theory be remappable to various
>        * things including ROM or RAM; we always map the RAM there.
>        */
> -    memory_region_init_alias(lowram, NULL, "vexpress.lowmem", ram, 0, lo=
w_ram_size);
> +    memory_region_init_alias(lowram, NULL, "vexpress.lowmem", machine->r=
am,
> +                             0, low_ram_size);
>       memory_region_add_subregion(sysmem, 0x0, lowram);
> -    memory_region_add_subregion(sysmem, 0x60000000, ram);
> +    memory_region_add_subregion(sysmem, 0x60000000, machine->ram);
>  =20
>       /* 0x1e000000 A9MPCore (SCU) private memory region */
>       init_cpus(machine, cpu_type, TYPE_A9MPCORE_PRIV, 0x1e000000, pic,
> @@ -360,7 +358,6 @@ static void a15_daughterboard_init(const VexpressMach=
ineState *vms,
>   {
>       MachineState *machine =3D MACHINE(vms);
>       MemoryRegion *sysmem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *sram =3D g_new(MemoryRegion, 1);
>  =20
>       {
> @@ -375,10 +372,8 @@ static void a15_daughterboard_init(const VexpressMac=
hineState *vms,
>           }
>       }
>  =20
> -    memory_region_allocate_system_memory(ram, NULL, "vexpress.highmem",
> -                                         ram_size);
>       /* RAM is from 0x80000000 upwards; there is no low-memory alias for=
 it. */
> -    memory_region_add_subregion(sysmem, 0x80000000, ram);
> +    memory_region_add_subregion(sysmem, 0x80000000, machine->ram);
>  =20
>       /* 0x2c000000 A15MPCore private memory region (GIC) */
>       init_cpus(machine, cpu_type, TYPE_A15MPCORE_PRIV,
> @@ -795,6 +790,7 @@ static void vexpress_class_init(ObjectClass *oc, void=
 *data)
>       mc->init =3D vexpress_common_init;
>       mc->max_cpus =3D 4;
>       mc->ignore_memory_transaction_failures =3D true;
> +    mc->default_ram_id =3D "vexpress.highmem";
>   }
>  =20
>   static void vexpress_a9_class_init(ObjectClass *oc, void *data)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


