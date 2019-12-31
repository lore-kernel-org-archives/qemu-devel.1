Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D57C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDDE206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hjj0xTpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDDE206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imK0G-0004Q9-Sk
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imJz4-0003Fi-15
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imJz2-0001w4-Qs
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:03:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35787
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imJz2-0001rX-Lj
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577808178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J5CBhbMjVQsC1ay+stQSF6WSLxgSlNBxfCSXedGS3/8=;
 b=Hjj0xTplR57VTCZ08S+1S5KTJ0kRWRkfO/ApPCphH9mmdQ/nn1H8EHrnJAyHffiZcNglRk
 RP4HPer0V9RQQW4ueLJXVeCe6AJjjjyi801AVqAK93PRgfUeBNhITbJJhLGJyZFbNbpmNb
 bYJYTsNIaTaCThxvBaLAQbfJfLkDkpU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-qMpDqMXWNb2c8IDi1FeSrQ-1; Tue, 31 Dec 2019 11:02:55 -0500
Received: by mail-wr1-f69.google.com with SMTP id i9so2918183wru.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eCRuOJrq4KkXXnfso9RqGuA0OtZKnLxpRgZhuMtOYBk=;
 b=BpvieufQd/r9zQYClk9SmxNlGlngqYh26ts0bune86wzdrAmqVznTTzV5JR20wsbGm
 xqwyO2cUCHIPWo/hFTINO356W/MkFOAx/y6oaMy3sOvaDGpZXSEt5Udb2nZRDsKDb8yy
 WOsFCHmu29egvcewyY3/Qnzg4r6xOSRT2uCP7LyHX9H4MU64JS8KyRaAJsJ+VK+2Wbdq
 a1w5k0P5DMC/n6Ndrx0sIYxgtS5KXpbiNJvCKgdQGIiM5/pKgKjHcmmLS7dsvGntbHm4
 MG/tDRa2bTzQwUHSfDMJY0XhXHVr2AYgSNib0HnfA1SGjDpvAanXacX5uGXxFRKrg6Ah
 zduQ==
X-Gm-Message-State: APjAAAXL1jk8P8RwAPvQmmgUHpwB8jOOxAV2qYr87cjkhwJM6RzBojVv
 0ldPrANh5TwAEPQqk32+Q0Frwjmrb2KMSLtr92ZOaiBtYbZD20ygAwgk4QUSsvgKZnODXjARBxy
 lNEyjqQjTZ2Kz7jQ=
X-Received: by 2002:a7b:c851:: with SMTP id c17mr5189095wml.71.1577808173985; 
 Tue, 31 Dec 2019 08:02:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0VQSy8l4238WOQPxcyrvnHqMZkirbJMZrLRsZXBeNbIUXt2Ol4E+QEJMjRYirQYQMsnUmRg==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr5189081wml.71.1577808173817; 
 Tue, 31 Dec 2019 08:02:53 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id l15sm49971362wrv.39.2019.12.31.08.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:02:52 -0800 (PST)
Subject: Re: [PATCH 74/86] sparc:niagara: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-75-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b9a954a9-6416-a6dc-307a-6b6d02dd6885@redhat.com>
Date: Tue, 31 Dec 2019 17:02:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-75-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: qMpDqMXWNb2c8IDi1FeSrQ-1
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
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/sparc64/niagara.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index 5eb2d09..ab5ef8c 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -40,7 +40,6 @@
>  =20
>   typedef struct NiagaraBoardState {
>       MemoryRegion hv_ram;
> -    MemoryRegion partition_ram;
>       MemoryRegion nvram;
>       MemoryRegion md_rom;
>       MemoryRegion hv_rom;
> @@ -111,11 +110,8 @@ static void niagara_init(MachineState *machine)
>                              NIAGARA_HV_RAM_SIZE, &error_fatal);
>       memory_region_add_subregion(sysmem, NIAGARA_HV_RAM_BASE, &s->hv_ram=
);
>  =20
> -    memory_region_allocate_system_memory(&s->partition_ram, NULL,
> -                                         "sun4v-partition.ram",
> -                                         machine->ram_size);
>       memory_region_add_subregion(sysmem, NIAGARA_PARTITION_RAM_BASE,
> -                                &s->partition_ram);
> +                                machine->ram);
>  =20
>       memory_region_init_ram(&s->nvram, NULL, "sun4v.nvram", NIAGARA_NVRA=
M_SIZE,
>                              &error_fatal);
> @@ -173,6 +169,7 @@ static void niagara_class_init(ObjectClass *oc, void =
*data)
>       mc->max_cpus =3D 1; /* XXX for now */
>       mc->default_boot_order =3D "c";
>       mc->default_cpu_type =3D SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
> +    mc->default_ram_id =3D "sun4v-partition.ram";
>   }
>  =20
>   static const TypeInfo niagara_type =3D {
>=20


