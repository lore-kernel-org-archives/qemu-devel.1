Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC40C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E533B2081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeHUk40a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E533B2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iroLF-0005Lj-SI
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iroDn-0002Ij-8G
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iroDh-0001Oy-DP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:20:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24070
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iroDh-0001OX-AC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579116048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lr+NKYaXofPcR7RhfeN0IXT7lsyX1EfsRocFjD8LXa4=;
 b=WeHUk40anFSZiCM0gyhJ7/Kf2tZMECp27ZthWi+t7z6wfs1C3PJu5DfPQTJXp1/9TXEhfK
 NW0cGX0O0x1xC5huvtr8iUXa27/QqLEtkhNVTRw/8laW+7iUQFlUu0U11vrBkb/Vz24zUb
 2JNtYeBcxjCKd0vai+bFkKXxoT0F8cg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-frMzcgTaN4ac0HEAuX1THw-1; Wed, 15 Jan 2020 14:20:47 -0500
Received: by mail-wm1-f72.google.com with SMTP id t4so300840wmf.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CoCbto6KEXlFgRfezNSysfUhqWHr1+YzcWoymJRp9Ls=;
 b=loyXC2HFYuV/cZBaNisvjHIAF+TeDmDyxBvRphW+EzCwzHV62a2rOxs5JZ9+Wy/4x3
 TyvZjDjaP8YU/ShruWbVXJqJYH2BJDVnEdANj8fB/4xrvn/lGzZBdm9JvM01g93xl66P
 QeBHYE69SSuN2IBV5p2Oqt8rFNBgzU9EWE89ngvKcEbVZqrJ3ZAb7mE/iTb/uo3rlouy
 3KSvh7crQmdn5/t16hpJ9CNMi7TZPMFKi1XOBTASC6VcaVRnWUU6YG52OV5fBUrAL2F9
 ZrTbB1d6tNLKdkGGek/CpXyDyuL1lxoyK/XNFG1VTudycTugpON6GVdmnTjhvnYrqNaG
 CCvg==
X-Gm-Message-State: APjAAAXyMl5E8IWPHZg67g5OgzCc6BPTgEcM/Jta8UeTHGrbQm89hmtp
 R1iAASWFbfG8+1smq2eh619dsf1mwyAtVuHxjp2QMxOAOsUSc7SZXMq2xfhZQUAhuerc/getHKV
 o/TiKEotpz1OdLZg=
X-Received: by 2002:a5d:6441:: with SMTP id d1mr32728630wrw.93.1579116046016; 
 Wed, 15 Jan 2020 11:20:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhG/rlnDTNqTEPH0H0OHHwQz3ZxLG+zcQ2P1vhRzhW8ws4Amf35Evj7eFgGjEuz5LoyH4wfg==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr32728612wrw.93.1579116045806; 
 Wed, 15 Jan 2020 11:20:45 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id z4sm1100765wma.2.2020.01.15.11.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 11:20:45 -0800 (PST)
Subject: Re: [PATCH v2 31/86] arm:versatilepb: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-32-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5043dca5-2b49-9f9f-fe56-db286643fe0a@redhat.com>
Date: Wed, 15 Jan 2020 20:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-32-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: frMzcgTaN4ac0HEAuX1THw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
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
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>   hw/arm/versatilepb.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index e86af01..f3c4a50 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -184,7 +184,6 @@ static void versatile_init(MachineState *machine, int=
 board_id)
>       Object *cpuobj;
>       ARMCPU *cpu;
>       MemoryRegion *sysmem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       qemu_irq pic[32];
>       qemu_irq sic[32];
>       DeviceState *dev, *sysctl;
> @@ -220,11 +219,9 @@ static void versatile_init(MachineState *machine, in=
t board_id)
>  =20
>       cpu =3D ARM_CPU(cpuobj);
>  =20
> -    memory_region_allocate_system_memory(ram, NULL, "versatile.ram",
> -                                         machine->ram_size);
>       /* ??? RAM should repeat to fill physical memory space.  */
>       /* SDRAM at address zero.  */
> -    memory_region_add_subregion(sysmem, 0, ram);
> +    memory_region_add_subregion(sysmem, 0, machine->ram);
>  =20
>       sysctl =3D qdev_create(NULL, "realview_sysctl");
>       qdev_prop_set_uint32(sysctl, "sys_id", 0x41007004);
> @@ -398,6 +395,7 @@ static void versatilepb_class_init(ObjectClass *oc, v=
oid *data)
>       mc->block_default_type =3D IF_SCSI;
>       mc->ignore_memory_transaction_failures =3D true;
>       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
> +    mc->default_ram_id =3D "versatile.ram";
>   }
>  =20
>   static const TypeInfo versatilepb_type =3D {
> @@ -415,6 +413,7 @@ static void versatileab_class_init(ObjectClass *oc, v=
oid *data)
>       mc->block_default_type =3D IF_SCSI;
>       mc->ignore_memory_transaction_failures =3D true;
>       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("arm926");
> +    mc->default_ram_id =3D "versatile.ram";
>   }
>  =20
>   static const TypeInfo versatileab_type =3D {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


