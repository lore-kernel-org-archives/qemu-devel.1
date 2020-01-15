Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4BBC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D9520728
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb5xE+f+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D9520728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irnYh-0004WN-UM
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irnXR-000343-UX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irnXQ-0006WP-Mh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:37:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irnXQ-0006Vz-IV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579113427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ktBjTFU5DdGzj3F48wGGEPQ5sC6+P8g9eFwZ/qRFx9c=;
 b=eb5xE+f+H/0ZNTuDaIrIB9ZkgI3LgtHpAiVVpnFuj2mpu74muyjfTlAjZcHhBzx6haT2dP
 QpEG/HhhpD2YstkVY/DaykeXPTIdjU450OOnpQQgfiucqHVV+HNvS9giXiniqcc+SnGjFI
 gHmhvqO5F29IZAbx/nV7ZF0s0auLV+A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-czKdZdTINLyc5uAk60Ycmw-1; Wed, 15 Jan 2020 13:37:04 -0500
Received: by mail-wr1-f70.google.com with SMTP id j4so8300528wrs.13
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 10:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o5k7mYxCHvyJX1wwWgb9fmQfjKGZq1O5mO/Hegd748I=;
 b=ULzPBJwwmwwffv4TznMHJr6orlgIKiF9h8p4F9XUEUjdMGX2Ns17Q3p0xGAyN/d4w7
 tSkF/cd96dUQ43H/SFYSev6GHxjJEXCUmyJQw6i7thpaJd9peUe8SRpREALl20VfOHPl
 YxkAuTUm7uedMw8zv3QOd2mnlwwDhKZGhBgkFkh0B6JbjS7/mb7EH7hpeUSexCrAy86j
 4gxvqWT4W7Hc/GVTW0ibh7Dswta23Mu7dpZ1AuNsb3awLb5N0aI7p7oSrUQt1wmj871f
 56d3OyZeSdZGxK1tEgOiBgd4YO8y5EhWzPCJVTSmP2fxaawlyUr+WcwS8Z9LxXFdL05P
 TTXA==
X-Gm-Message-State: APjAAAU65PHgRr6+R6jAFoeOTgggqxI0EnqyH//HSwxPxQV/TQubb3TK
 RZ/r37g0ocGYPLx7vmVtrVH979gmYsanVsVao6/eci/5M6quBEVl09C0C6xkVx8+ROMkn1E9gRi
 LVTCQ+rbJE9vZhZY=
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr34250821wro.279.1579113423609; 
 Wed, 15 Jan 2020 10:37:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYP/TfXV83q3XwA+4urMXrq9P17ZJo12OANKmWEsZNkcBs2SGj8ET1x7BbUozk5PFFa4FVSA==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr34250800wro.279.1579113423410; 
 Wed, 15 Jan 2020 10:37:03 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id r5sm25419020wrt.43.2020.01.15.10.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 10:37:02 -0800 (PST)
Subject: Re: [PATCH v2 71/86] ppc:virtex_ml507: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-72-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b11ecc71-4916-0a65-d46c-c3cf85288647@redhat.com>
Date: Wed, 15 Jan 2020 19:37:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-72-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: czKdZdTINLyc5uAk60Ycmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: edgar.iglesias@gmail.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 4:07 PM, Igor Mammedov wrote:
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
> CC: david@gibson.dropbear.id.au
> CC: qemu-ppc@nongnu.org
> CC: edgar.iglesias@gmail.com
> ---
>   hw/ppc/virtex_ml507.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 651d8db..b74a269 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -193,7 +193,6 @@ static int xilinx_load_device_tree(hwaddr addr,
>  =20
>   static void virtex_init(MachineState *machine)
>   {
> -    ram_addr_t ram_size =3D machine->ram_size;
>       const char *kernel_filename =3D machine->kernel_filename;
>       const char *kernel_cmdline =3D machine->kernel_cmdline;
>       hwaddr initrd_base =3D 0;
> @@ -204,7 +203,6 @@ static void virtex_init(MachineState *machine)
>       CPUPPCState *env;
>       hwaddr ram_base =3D 0;
>       DriveInfo *dinfo;
> -    MemoryRegion *phys_ram =3D g_new(MemoryRegion, 1);
>       qemu_irq irq[32], *cpu_irq;
>       int kernel_size;
>       int i;
> @@ -221,8 +219,7 @@ static void virtex_init(MachineState *machine)
>  =20
>       qemu_register_reset(main_cpu_reset, cpu);
>  =20
> -    memory_region_allocate_system_memory(phys_ram, NULL, "ram", ram_size=
);
> -    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
> +    memory_region_add_subregion(address_space_mem, ram_base, machine->ra=
m);
>  =20
>       dinfo =3D drive_get(IF_PFLASH, 0, 0);
>       pflash_cfi01_register(PFLASH_BASEADDR, "virtex.flash", FLASH_SIZE,
> @@ -265,7 +262,7 @@ static void virtex_init(MachineState *machine)
>               /* If we failed loading ELF's try a raw image.  */
>               kernel_size =3D load_image_targphys(kernel_filename,
>                                                 boot_offset,
> -                                              ram_size);
> +                                              machine->ram_size);
>               boot_info.bootstrap_pc =3D boot_offset;
>               high =3D boot_info.bootstrap_pc + kernel_size + 8192;
>           }
> @@ -276,7 +273,7 @@ static void virtex_init(MachineState *machine)
>           if (machine->initrd_filename) {
>               initrd_base =3D high =3D ROUND_UP(high, 4);
>               initrd_size =3D load_image_targphys(machine->initrd_filenam=
e,
> -                                              high, ram_size - high);
> +                                              high, machine->ram_size - =
high);
>  =20
>               if (initrd_size < 0) {
>                   error_report("couldn't load ram disk '%s'",
> @@ -290,7 +287,7 @@ static void virtex_init(MachineState *machine)
>           boot_info.fdt =3D high + (8192 * 2);
>           boot_info.fdt &=3D ~8191;
>  =20
> -        xilinx_load_device_tree(boot_info.fdt, ram_size,
> +        xilinx_load_device_tree(boot_info.fdt, machine->ram_size,
>                                   initrd_base, initrd_size,
>                                   kernel_cmdline);
>       }
> @@ -302,6 +299,7 @@ static void virtex_machine_init(MachineClass *mc)
>       mc->desc =3D "Xilinx Virtex ML507 reference design";
>       mc->init =3D virtex_init;
>       mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("440-xilinx");
> +    mc->default_ram_id =3D "ram";
>   }
>  =20
>   DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


