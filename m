Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8570C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD882084D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmeOmCbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD882084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irnw2-0001B2-Qy
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irnut-0008R8-8e
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irnup-00050c-75
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:01:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56955
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irnup-0004yy-2Y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579114876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UuQLGzgmKwdYQbCUGfTuunVa5Cdppnywdo26qugUDpk=;
 b=bmeOmCbVA13St6MGEXlB+dnFVwlsCBENj4unnfzU4GVq/Ox1FUl+S4FxumhV/vDSWeag/j
 ksVAe4nn//AIU5VeFtPg9EQ0zQOr1/1WVv51FKyLGb4zCHBpXbzF29onUYH9fbjXdkCF4Z
 OApcGPeDYbhYyEBNGdkWXZw0qxIb76Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-MvdwmylJM9eYl2pFecFotw-1; Wed, 15 Jan 2020 14:01:15 -0500
Received: by mail-wr1-f70.google.com with SMTP id k18so8368617wrw.9
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2gUAuuy9ejenWLB4RsCZ6mGR1t6R2WZ7s/fAGzHi2Pk=;
 b=spRxMYbMG6/939TN9AuTRXPipoCfdUIl+mShm3FzGzVgJ67p1b4uzkmeKSeRwKLy9n
 tXdudx/zP1JoPfz8BJAGEzhNe16PnQRA/W7C2QhXTEYY2h+FNMeglLnKvM548NQloNQu
 UmCZTAoHe4UdVSHG8CsTk7TSmy/uZ3sd0jFTuYJ3zAPugwCr/t5BM90QOUqRs9/r7P1w
 UNEFbncYEmhQevDKwZ3gR3FhB5pvAQbEYwVxAvf+eu66Zs4R0e8+UW8C3hO3s22BsM54
 ygYVasvnxCl8QRUoo8a6BVBOqUMUgyTsE2qQY+Qfj3gqbJ4hvgPHRQMLryEzAm+UNqqD
 u4jA==
X-Gm-Message-State: APjAAAXAFg7so70xEbiSYUZiLTAy4qmPZpyo07IMKopSu8c42Lwv1dQF
 zzTjWEbGmAAECvwK3AuLsBNobQYxFHJTx1bLV+M+EkTW9CIQta1pfBY14C/ZY7Y/yqKcuJWmzAr
 Tj/6ER/LZIjFHIZY=
X-Received: by 2002:a5d:6211:: with SMTP id y17mr32674666wru.344.1579114874512; 
 Wed, 15 Jan 2020 11:01:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqz1n45aoNSTyxsb41ILwQ0uG+L5pYQmqk7+bjjG4Hj+7nyS6brJ2awmtj0u/N/X9PwA+cFBRg==
X-Received: by 2002:a5d:6211:: with SMTP id y17mr32674638wru.344.1579114874227; 
 Wed, 15 Jan 2020 11:01:14 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id z123sm1132669wme.18.2020.01.15.11.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 11:01:13 -0800 (PST)
Subject: Re: [PATCH v2 35/86] arm:xilinx_zynq: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-36-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2131c7ec-943e-1806-03c4-fe49371caa08@redhat.com>
Date: Wed, 15 Jan 2020 20:01:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-36-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: MvdwmylJM9eYl2pFecFotw-1
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alistair@alistair23.me,
 edgar.iglesias@gmail.com
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
> CC: edgar.iglesias@gmail.com
> CC: alistair@alistair23.me
> ---
>   hw/arm/xilinx_zynq.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index df950fc..0ef9688 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -160,7 +160,6 @@ static void zynq_init(MachineState *machine)
>   {
>       ARMCPU *cpu;
>       MemoryRegion *address_space_mem =3D get_system_memory();
> -    MemoryRegion *ext_ram =3D g_new(MemoryRegion, 1);
>       MemoryRegion *ocm_ram =3D g_new(MemoryRegion, 1);
>       DeviceState *dev;
>       SysBusDevice *busdev;
> @@ -190,9 +189,7 @@ static void zynq_init(MachineState *machine)
>       object_property_set_bool(OBJECT(cpu), true, "realized", &error_fata=
l);
>  =20
>       /* DDR remapped to address zero.  */
> -    memory_region_allocate_system_memory(ext_ram, NULL, "zynq.ext_ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(address_space_mem, 0, ext_ram);
> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>  =20
>       /* 256K of on-chip memory */
>       memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 * KiB,
> @@ -318,6 +315,7 @@ static void zynq_machine_init(MachineClass *mc)
>       mc->no_sdcard =3D 1;
>       mc->ignore_memory_transaction_failures =3D true;
>       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a9");
> +    mc->default_ram_id =3D "zynq.ext_ram";
>   }
>  =20
>   DEFINE_MACHINE("xilinx-zynq-a9", zynq_machine_init)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


