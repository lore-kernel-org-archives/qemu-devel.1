Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61CDC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8257220801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnkuncOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8257220801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46Z9-00057G-LH
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46YH-0003gL-1w
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46YF-00034R-RN
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:20:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37314
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46YF-00034F-Nf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:20:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khBoOp2Gto0weuKMnqX8oPn3dtrigvOl2jCyPjzlPQM=;
 b=WnkuncODh7pCzJXbB9HLDvUugk8IzpEbiQvUOfPhDAOcXbvWuR4dntDj57fBIaTV6K9oIs
 gPMuDGAcdSn+kYFHebfiUBNi0BEYP8mMj9ZwPHOHsOaJF0Xp1XqKVkHUaFw+i6tCs3yZhB
 COVkg5+Sxyl9soEW66ZtFa18VFdxUlg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-VggHFXXtM-OJHVkWtjIiuA-1; Tue, 18 Feb 2020 12:20:48 -0500
Received: by mail-wr1-f71.google.com with SMTP id d8so11098424wrq.12
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xrmpN2SJXPwU6YW3lXdRmrx/+C5dkKbNFXSK/RKWKP0=;
 b=UBenooWQlyLYVeO7W+vAW6xdaz3IZMyxmOQcrDfQ3cZfKXfg8rjgg1rACgcVEqGw9k
 j52epuaJ3noXzXjBTLAjJ6/8hGE24N307usUOthkvb/MyqrtOmG7q+w3k9EWGMmJAd87
 irpbD17MRjdIwhhDEx3D04ydoYAeqJc1cOOyp41y65PDkhubjlDm7KAIJ2S/lX5n7oEA
 1MT/ZRwMrkyYPa15F4tJMGgeU3+Qn9E4+25rrt1oS6GjcGMPK2QEMGolCRe+plZM3iRO
 +pUKuSHN5+BEJKC99f3hwob9eieOfi+A2kMF7qOArNis5D7dS4NkHwfCH47DqDqW8O/S
 4GOw==
X-Gm-Message-State: APjAAAWFW1g0ndOUiuu/OuPL8vvNVl1CEjQIZZY1uaUpTslc3nj5pV++
 3Vm8dxu6R4eRCQ8GNz3JrA8zgXqD+5xzcHZALzNabvXFNPG63VOcuzjubzo7ucgBt6SmrD5HZNe
 Y0vpOqexqdKtH1sY=
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr4148707wmh.35.1582046447135; 
 Tue, 18 Feb 2020 09:20:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzWJzTUMQnpS2qfizRqyUG1Odt0J1vKSLqJiK3CZyOnKbyReSaZEGN96bP8cSZzzkVIbJTI5w==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr4148688wmh.35.1582046446868; 
 Tue, 18 Feb 2020 09:20:46 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b10sm6791252wrt.90.2020.02.18.09.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:20:46 -0800 (PST)
Subject: Re: [PATCH v5 26/79] arm/omap_sx1: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-27-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fce0c743-34d5-d73d-cfc6-d1976e0fc2bb@redhat.com>
Date: Tue, 18 Feb 2020 18:20:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-27-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: VggHFXXtM-OJHVkWtjIiuA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
>   while at it add check for user supplied RAM size and error
>   out if it mismatches board expected value.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
> v2:
>    * fix format string causing build failure on 32-bit host
>      (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
> ---
>   hw/arm/omap_sx1.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
> index be245714db..2bebab4171 100644
> --- a/hw/arm/omap_sx1.c
> +++ b/hw/arm/omap_sx1.c
> @@ -35,6 +35,7 @@
>   #include "sysemu/qtest.h"
>   #include "exec/address-spaces.h"
>   #include "cpu.h"
> +#include "qemu/cutils.h"
>  =20
>   /**********************************************************************=
*******/
>   /* Siemens SX1 Cellphone V1 */
> @@ -102,8 +103,8 @@ static struct arm_boot_info sx1_binfo =3D {
>   static void sx1_init(MachineState *machine, const int version)
>   {
>       struct omap_mpu_state_s *mpu;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>       MemoryRegion *address_space =3D get_system_memory();
> -    MemoryRegion *dram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *flash =3D g_new(MemoryRegion, 1);
>       MemoryRegion *cs =3D g_new(MemoryRegion, 4);
>       static uint32_t cs0val =3D 0x00213090;
> @@ -115,15 +116,20 @@ static void sx1_init(MachineState *machine, const i=
nt version)
>       uint32_t flash_size =3D flash0_size;
>       int be;
>  =20
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        char *sz =3D size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
>       if (version =3D=3D 2) {
>           flash_size =3D flash2_size;
>       }
>  =20
> -    memory_region_allocate_system_memory(dram, NULL, "omap1.dram",
> -                                         sx1_binfo.ram_size);
> -    memory_region_add_subregion(address_space, OMAP_EMIFF_BASE, dram);
> +    memory_region_add_subregion(address_space, OMAP_EMIFF_BASE, machine-=
>ram);
>  =20
> -    mpu =3D omap310_mpu_init(dram, machine->cpu_type);
> +    mpu =3D omap310_mpu_init(machine->ram, machine->cpu_type);
>  =20
>       /* External Flash (EMIFS) */
>       memory_region_init_ram(flash, NULL, "omap_sx1.flash0-0", flash_size=
,
> @@ -223,6 +229,8 @@ static void sx1_machine_v2_class_init(ObjectClass *oc=
, void *data)
>       mc->init =3D sx1_init_v2;
>       mc->ignore_memory_transaction_failures =3D true;
>       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("ti925t");
> +    mc->default_ram_size =3D sdram_size;
> +    mc->default_ram_id =3D "omap1.dram";
>   }
>  =20
>   static const TypeInfo sx1_machine_v2_type =3D {
> @@ -239,6 +247,8 @@ static void sx1_machine_v1_class_init(ObjectClass *oc=
, void *data)
>       mc->init =3D sx1_init_v1;
>       mc->ignore_memory_transaction_failures =3D true;
>       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("ti925t");
> +    mc->default_ram_size =3D sdram_size;
> +    mc->default_ram_id =3D "omap1.dram";
>   }
>  =20
>   static const TypeInfo sx1_machine_v1_type =3D {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


