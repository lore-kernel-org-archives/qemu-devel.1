Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0349EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51222081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsmV2lnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51222081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iroOu-0001VN-Rs
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iroCl-0001bg-V1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iroCi-0000gv-MV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:19:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20122
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iroCi-0000gY-Ii
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579115988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icvhrBW1PVxpIIX+PKFYZC6iPa3UKQeyZdq9YW+nQjM=;
 b=OsmV2lnlB3tcQ7XpyhnbcA1FqogZbjCO4uNt0QRhiqVRwPq1WO3ALBiQUG9pkObdwcXyfX
 1JDwSTJAqGrX3PiLC5MVrwNOmeJSzwDnrb+NHaVTzScT1P8Ge0/wwOnxyHmti+ROHR8oUZ
 Xky3ImMYIPhXoAeIz+pW/mJ0UWEmRdQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-0Lc5rmIEMQ2TK6J-sfaxrQ-1; Wed, 15 Jan 2020 14:19:46 -0500
Received: by mail-wr1-f69.google.com with SMTP id d8so8303419wrq.12
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E3IfmtLSaR04KvkBZVsKCcUXay0mUZAhGTTj4Sxtw+s=;
 b=GRjjygRyPRj2dwxZUEHl0YxhRFc2l7zAFbIu4wqO6n+0tPrXgbv6BwAAyvZi0sRigK
 F50XFW2fvSWKAP9JXg81KuaENeqJ2xXwQAIRCyoKQZu/N7oCo5Rus1UT1ThtMAF8N4/F
 q7/I6ea79g1QHe3NRlTE4nOH4+uHYeVD8cl3Y+NrDVGnDauQc5G8d2jC0oOaxwnlosmh
 9mTUHBurxVPGU4UA37wtkewZycWWNZyMK/L3BLl1iI//hevScM7tuGzD8eUgc6/UPEPr
 glNsb4QDRhwUTIkvVie2kcp6uKX1XcOZhL6eePhImNZk/HT0LSG+2kS7RXffjNDYREpE
 ksVQ==
X-Gm-Message-State: APjAAAUHqOwzTh+W9NZzuU3e61ENgUyGNpyfLPIgSHwaif2JuqprjUQ6
 lbJ1x9F2vqwX7iWyx1unc4s8HggNlLHnpyQmXwru1X6Valne0/PIXC1WsAYcl/mALtqQ5w2AYGg
 unc+UqDw55DvGF/M=
X-Received: by 2002:adf:e290:: with SMTP id v16mr33958811wri.16.1579115985559; 
 Wed, 15 Jan 2020 11:19:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBIqfdlL8N4Ef+AGgSLD17H7js6DH/K1dlcXWdq6LaHs/rjqXNGfz4qkyyqPq2LcjY3Coc+g==
X-Received: by 2002:adf:e290:: with SMTP id v16mr33958798wri.16.1579115985385; 
 Wed, 15 Jan 2020 11:19:45 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id o16sm569027wmc.18.2020.01.15.11.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 11:19:44 -0800 (PST)
Subject: Re: [PATCH v2 10/86] arm:aspeed: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-11-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db0a48be-4c18-664b-42f4-d415bedc72e6@redhat.com>
Date: Wed, 15 Jan 2020 20:19:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-11-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 0Lc5rmIEMQ2TK6J-sfaxrQ-1
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 clg@kaod.org, joel@jms.id.au
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
> CC: clg@kaod.org
> CC: peter.maydell@linaro.org
> CC: andrew@aj.id.au
> CC: joel@jms.id.au
> CC: qemu-arm@nongnu.org
> ---
>   hw/arm/aspeed.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 525c547..330254b 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -35,7 +35,6 @@ static struct arm_boot_info aspeed_board_binfo =3D {
>   struct AspeedBoardState {
>       AspeedSoCState soc;
>       MemoryRegion ram_container;
> -    MemoryRegion ram;
>       MemoryRegion max_ram;
>   };
>  =20
> @@ -184,6 +183,7 @@ static void aspeed_machine_init(MachineState *machine=
)
>  =20
>       memory_region_init(&bmc->ram_container, NULL, "aspeed-ram-container=
",
>                          UINT32_MAX);
> +    memory_region_add_subregion(&bmc->ram_container, 0, machine->ram);
>  =20
>       object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
>                               (sizeof(bmc->soc)), amc->soc_name, &error_a=
bort,
> @@ -215,8 +215,6 @@ static void aspeed_machine_init(MachineState *machine=
)
>       object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
>                                &error_fatal);
>  =20
> -    memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_siz=
e);
> -    memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
>       memory_region_add_subregion(get_system_memory(),
>                                   sc->memmap[ASPEED_SDRAM],
>                                   &bmc->ram_container);
> @@ -393,6 +391,7 @@ static void aspeed_machine_class_init(ObjectClass *oc=
, void *data)
>       mc->no_floppy =3D 1;
>       mc->no_cdrom =3D 1;
>       mc->no_parallel =3D 1;
> +    mc->default_ram_id =3D "ram";
>   }
>  =20
>   static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *d=
ata)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


