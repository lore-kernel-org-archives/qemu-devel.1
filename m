Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214A6C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0888205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0fpQTji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0888205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imK5R-0001v9-MB
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imK4G-0000Xf-GZ
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imK4F-0007Ws-1U
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:08:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38117
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imK4E-0007VS-To
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577808502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ycavnla7j8+6qiwWMJg6DG8kDreFyo0adLCySXulhkU=;
 b=I0fpQTjikQaA18ycCaopnDxbLka7e+fLxO2nmFemZEodZ2XK0v1OhDtgMwE0sGWL5rJNs/
 xv47LCKbzf187QXejYlIqD2w1CXp12ArDIqeg7tGjZokAFivJxBRnl08Dyl9RncGJIbAI/
 eJAGunJ8A4G/2gl7M85PktMo43o3k5Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-Cvujyw4XOeqkNa9QTWtcgw-1; Tue, 31 Dec 2019 11:08:20 -0500
Received: by mail-wm1-f70.google.com with SMTP id w205so274114wmb.5
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ThuNo76tyievQ15JrShbn2BFt0fsQb4IjIpzNmjAbAI=;
 b=H+wQgYJV9dIHl0C4C14gRuAKG5aMxCSA8t79vaV9DHi9ntvmLuCMgGZw/8ih+z8Kzl
 miQmJPFSHDsZ+fwB+suaHILgsxYQao4L8t8sYPqRa7RDQMvzh2LbV86+x4A8t2wwj4vl
 SdWttC1DUJmADLu7trmEmyvXwUY4XAgoDR4nIgiihP/d6DwTosWUYsXes6Bqs6xvulbc
 OpN9yUkUybZ+hAUz7dBInFWVWlc7oG7ooCixYUf/1+ZV011UOG1i7xbfI/2NhEcnTza5
 z7b5wDxn2fZJD1o9Dewl2LFQisgkTjEbNE367O0VkxgExcGY8Ea4n57GuBiqTFBwDxvB
 Z+1Q==
X-Gm-Message-State: APjAAAUf1PEjXRgWcR7hmQmM/Y+KolFNVXBJ7HTLR0Hyu0V8Dqno2z39
 SfONNQDykemMdICzmryBk4WlKfdMOy/W+A/KyVpuB/4sA/TjEpB16tNiaN59MHRQxD4Eewz89r7
 k8CSuBGK0sw6/eqg=
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr50621300wrm.24.1577808499439; 
 Tue, 31 Dec 2019 08:08:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqyMnl3NWrwiWLoMmOgTPuAK+isSLhRGS7KIKyt6uFqS0f8Xm03zy1bnX5ADywVOG3EcQvuj8g==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr50621283wrm.24.1577808499281; 
 Tue, 31 Dec 2019 08:08:19 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id x10sm49789628wrp.58.2019.12.31.08.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:08:18 -0800 (PST)
Subject: Re: [PATCH 58/86] mips:mips_r4k: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-59-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <532ea6de-541c-c510-029b-e75a8736a509@redhat.com>
Date: Tue, 31 Dec 2019 17:08:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-59-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: Cvujyw4XOeqkNa9QTWtcgw-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/31/19 2:03 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/mips/mips_r4k.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index fd926a3..69b6549 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -171,13 +171,11 @@ static const int sector_len =3D 32 * KiB;
>   static
>   void mips_r4k_init(MachineState *machine)
>   {
> -    ram_addr_t ram_size =3D machine->ram_size;
>       const char *kernel_filename =3D machine->kernel_filename;
>       const char *kernel_cmdline =3D machine->kernel_cmdline;
>       const char *initrd_filename =3D machine->initrd_filename;
>       char *filename;
>       MemoryRegion *address_space_mem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *bios;
>       MemoryRegion *iomem =3D g_new(MemoryRegion, 1);
>       MemoryRegion *isa_io =3D g_new(MemoryRegion, 1);
> @@ -203,14 +201,12 @@ void mips_r4k_init(MachineState *machine)
>       qemu_register_reset(main_cpu_reset, reset_info);
>  =20
>       /* allocate RAM */
> -    if (ram_size > 256 * MiB) {
> +    if (machine->ram_size > 256 * MiB) {
>           error_report("Too much memory for this machine: %" PRId64 "MB,"
>                        " maximum 256MB", ram_size / MiB);
>           exit(1);
>       }
> -    memory_region_allocate_system_memory(ram, NULL, "mips_r4k.ram", ram_=
size);
> -
> -    memory_region_add_subregion(address_space_mem, 0, ram);
> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>  =20
>       memory_region_init_io(iomem, NULL, &mips_qemu_ops,
>                             NULL, "mips-qemu", 0x10000);
> @@ -261,7 +257,7 @@ void mips_r4k_init(MachineState *machine)
>       g_free(filename);
>  =20
>       if (kernel_filename) {
> -        loaderparams.ram_size =3D ram_size;
> +        loaderparams.ram_size =3D machine->ram_size;
>           loaderparams.kernel_filename =3D kernel_filename;
>           loaderparams.kernel_cmdline =3D kernel_cmdline;
>           loaderparams.initrd_filename =3D initrd_filename;
> @@ -316,7 +312,7 @@ static void mips_machine_init(MachineClass *mc)
>   #else
>       mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
>   #endif
> -
> +    mc->default_ram_id =3D "mips_r4k.ram";
>   }
>  =20
>   DEFINE_MACHINE("mips", mips_machine_init)
>=20


