Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF255C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5F520679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReaFdRWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5F520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46yM-0001DB-Hw
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j46wq-0000HR-D8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j46wp-00034V-9J
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:46:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32938
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j46wp-00033Y-5E
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582047974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTsK/LOdshnss0WB9YZKXPTXnhlx6TWMVNIi7xeWhgY=;
 b=ReaFdRWj0xpk6xkZqWHhnaugfc8JeU4Q3LICRvCod1hw7JbolCJ/Oyouf+cwBEzAvo4oS7
 poJ90JTFwa0+p/ipMuurjsMBXLQvKOgR4Cbsmn9OKLJs4pzQH4EJwi3oA7vNFBV2XzE/7W
 YoHwE1Gp1Q9Sp3FIrb+HCXaZXEyqOHU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-gMQXpGm9Pt2VyVeR_EgCsw-1; Tue, 18 Feb 2020 12:46:09 -0500
Received: by mail-wr1-f70.google.com with SMTP id 90so11183527wrq.6
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mFkUEjLlByAbq9F1e99+b+FAaspDxLbhZKg+vJqMhhE=;
 b=Oy9oFpnswg9cBdjW7qfE2WSBb+84+4h3undFNVdyJBe7eNtRHUz75zTO2dXedMDpeX
 sx4wvgjbsu3+R0N+HcXTdoDelfYA/p0F5KAGN7BGnPQfChqn54HkserP/uif3tI0gDkv
 Uov90sQWNqDyJ0O/jWw/aaJf01aNxC9WfXM1EewF0qAUu6cL8AFfpAUHluGzsFg/VOFi
 UKB7uyikp8/Nogg+ZTCtrYKMqUBJ6gI8QPYO00hGn5eEfYzp4x20xCQCSajABcdQkyud
 i+PhF9ZbekbDAUcvW/pur4YhDrlpzs7K5jHSgfVD9UoSgwAIj4bDVy6Y6b0JRLEMp/0k
 iJvg==
X-Gm-Message-State: APjAAAWesEiy+/6EchDveFY5h9F5mLPUZ41U9DgCCIT4Gw7XcQru7Q7Q
 Xw8TirLkwrGqGLnborRHZCA80vbxG35vwC0X8d3Ff/YKLHcGldbmNn4VvpCe8gYmec14rdrCTdf
 P6oHYSxfSxKcs0vQ=
X-Received: by 2002:adf:90cb:: with SMTP id i69mr31005169wri.205.1582047967767; 
 Tue, 18 Feb 2020 09:46:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfVMWm/7MWn+4PoUV9z8mVWeuLs7bx3TQiaRPYpOn4V65yild77ntb8en5LniOWPjSDSeivw==
X-Received: by 2002:adf:90cb:: with SMTP id i69mr31005147wri.205.1582047967569; 
 Tue, 18 Feb 2020 09:46:07 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x7sm6957356wrq.41.2020.02.18.09.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:46:07 -0800 (PST)
Subject: Re: [PATCH v5 60/79] ppc/mac_newworld: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-61-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fabfd332-19eb-3593-c982-bf644f84adaa@redhat.com>
Date: Tue, 18 Feb 2020 18:46:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-61-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: gMQXpGm9Pt2VyVeR_EgCsw-1
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

On 2/17/20 6:34 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>    MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ppc/mac_newworld.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 464d012103..b8189bf7a4 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -118,7 +118,7 @@ static void ppc_core99_init(MachineState *machine)
>       char *filename;
>       IrqLines *openpic_irqs;
>       int linux_boot, i, j, k;
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1), *bios =3D g_new(Memory=
Region, 1);
> +    MemoryRegion *bios =3D g_new(MemoryRegion, 1);
>       hwaddr kernel_base, initrd_base, cmdline_base =3D 0;
>       long kernel_size, initrd_size;
>       UNINHostState *uninorth_pci;
> @@ -152,8 +152,7 @@ static void ppc_core99_init(MachineState *machine)
>       }
>  =20
>       /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "ppc_core99.ram", ra=
m_size);
> -    memory_region_add_subregion(get_system_memory(), 0, ram);
> +    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
>  =20
>       /* allocate and load BIOS */
>       memory_region_init_ram(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
> @@ -586,6 +585,7 @@ static void core99_machine_class_init(ObjectClass *oc=
, void *data)
>   #else
>       mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("7400_v2.9");
>   #endif
> +    mc->default_ram_id =3D "ppc_core99.ram";
>       mc->ignore_boot_device_suffixes =3D true;
>       fwc->get_dev_path =3D core99_fw_dev_path;
>   }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


