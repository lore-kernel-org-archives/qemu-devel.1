Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7FDC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9AF207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxGuK/16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9AF207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wov-0006Sv-Rv
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3woH-0005cF-4o
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3woG-0006tW-3u
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:56:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3woG-0006su-0C
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582009003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUGaDMLr4dvVL/+BMyf8eAgSLpuuWOgGcYbWlf5hmfA=;
 b=GxGuK/16gnRLlzYg0WnhoLjjjuso8To+kOov+lTaP52g9PevLJJCLqAC1QvXAw4zhompLN
 8ACd0BBMxmEDG21+lWA6diGr3BOyup2CaDAn9w5rTD7Ywj4FEQtFhpPgOZ/En0a8+VH+t2
 6ViRwua6W7Zyq0dbygTz0C/la84cnxU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-KzlhH7zmNQGG43-9uZRUOQ-1; Tue, 18 Feb 2020 01:56:39 -0500
Received: by mail-wr1-f70.google.com with SMTP id p8so10293353wrw.5
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:56:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l9rK6ZnwuZRehrgwyYK15Y1gV8n9RIcrL2Owfz/2eUE=;
 b=XtD5fgYdzpj6Om9LksvIwIWCUBSODsi0gnkcTh1+NIiyjs9ccqFm29pOIeCKUO9zuR
 /4QtfklIb73EYBHJAC/788+/dxrbCSNfoFII0cC5yaZjAR1xxJiK7Nj5Kmn3C58mNRH+
 I562ogyXF2EpzonpHi2dWZq3bmpvRxgF6oE2CVsT7zaI5t26ADLck+xEMGAW6ohoqb0N
 4ne08O/vQjNl14Ml++vF2BNsqp1vYeR9On7vQj3t4d3YW5GGPKls24/cOn1dxMxD0Gmh
 5Gbgt/0Mz5OxpxRuA/AI4QTWM9lcnUsd1OJvcBsfqFk+FJt4T6ALkdSHv4gf2lcBE3B8
 wAAA==
X-Gm-Message-State: APjAAAWUVrQNngCrYW5PNTDKorvmCDquOzZU1J5Ba6ke9/fmXTl5j7ec
 6tzb6gxNVGvcbnPqgLUBZdNNBghJfphoNadA/EtqcDqrGnPFrEl2JfFzyuHzLiQ7ilf+lI3cj+k
 +eJsQYJ10gu7sMK8=
X-Received: by 2002:a1c:9646:: with SMTP id y67mr1232581wmd.42.1582008998404; 
 Mon, 17 Feb 2020 22:56:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8RhkDcDsJkIqUeF2d4XGFsk50dmVJ352ywc68IfiMuC1LuIsqlBzgvaiq6Mghb1kz1ULeCg==
X-Received: by 2002:a1c:9646:: with SMTP id y67mr1232561wmd.42.1582008998200; 
 Mon, 17 Feb 2020 22:56:38 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id 4sm2201571wmg.22.2020.02.17.22.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 22:56:37 -0800 (PST)
Subject: Re: [PATCH v5 22/79] arm/mps2-tz: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-23-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d0663ec7-47ec-ba71-3cc2-a8fc66509215@redhat.com>
Date: Tue, 18 Feb 2020 07:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-23-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: KzlhH7zmNQGG43-9uZRUOQ-1
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
> v4:
>    * move default_ram_size to mps2tz_class_init()
>      (Andrew Jones <drjones@redhat.com>)
> ---
>   hw/arm/mps2-tz.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
> index f8b620bcc6..a8dea7dde1 100644
> --- a/hw/arm/mps2-tz.c
> +++ b/hw/arm/mps2-tz.c
> @@ -39,6 +39,7 @@
>  =20
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
> +#include "qemu/cutils.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "hw/arm/boot.h"
> @@ -79,7 +80,6 @@ typedef struct {
>       MachineState parent;
>  =20
>       ARMSSE iotkit;
> -    MemoryRegion psram;
>       MemoryRegion ssram[3];
>       MemoryRegion ssram1_m;
>       MPS2SCC scc;
> @@ -388,6 +388,13 @@ static void mps2tz_common_init(MachineState *machine=
)
>           exit(1);
>       }
>  =20
> +    if (machine->ram_size !=3D mc->default_ram_size) {
> +        char *sz =3D size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
> +        exit(EXIT_FAILURE);
> +    }
> +
>       sysbus_init_child_obj(OBJECT(machine), "iotkit", &mms->iotkit,
>                             sizeof(mms->iotkit), mmc->armsse_type);
>       iotkitdev =3D DEVICE(&mms->iotkit);
> @@ -458,9 +465,7 @@ static void mps2tz_common_init(MachineState *machine)
>        * tradeoffs. For QEMU they're all just RAM, though. We arbitrarily
>        * call the 16MB our "system memory", as it's the largest lump.
>        */
> -    memory_region_allocate_system_memory(&mms->psram,
> -                                         NULL, "mps.ram", 16 * MiB);
> -    memory_region_add_subregion(system_memory, 0x80000000, &mms->psram);
> +    memory_region_add_subregion(system_memory, 0x80000000, machine->ram)=
;
>  =20
>       /* The overflow IRQs for all UARTs are ORed together.
>        * Tx, Rx and "combined" IRQs are sent to the NVIC separately.
> @@ -642,6 +647,8 @@ static void mps2tz_class_init(ObjectClass *oc, void *=
data)
>  =20
>       mc->init =3D mps2tz_common_init;
>       iic->check =3D mps2_tz_idau_check;
> +    mc->default_ram_size =3D 16 * MiB;
> +    mc->default_ram_id =3D "mps.ram";
>   }
>  =20
>   static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


