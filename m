Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE722C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BFA42081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JV0Kk8UV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFA42081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iroQy-0003ly-KH
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iroEm-0003ls-Ez
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iroEj-0002DX-0R
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:21:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34380
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iroEi-0002CW-Tw
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579116112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UkBLISk3oh0poTz7Y/TmFshjgUQCaI9yfJABFuKUAOo=;
 b=JV0Kk8UVnMX06/s8Hyds+vDOQWJiyNcmadRqzwy9i5zpSearocMb/pEw9NPjl+hd/MMhUE
 hv1SMwwfAWxRN3Dsy+9DGIDYJK9END6YTqeJS6EtozqDqItvrAHHe0tDZjKXRio7RFojSX
 qyW4obDuK7mkWVI1htSXhw+e2BWj21U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-AUdYzrOuP7KeEezSAgFo1A-1; Wed, 15 Jan 2020 14:21:50 -0500
Received: by mail-wm1-f70.google.com with SMTP id t16so296444wmt.4
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 11:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yMhSesZBUDFIkOgoBd1DJGg56X/JlXNd5L2CPlOPFa4=;
 b=JrrbKgPLlnE31t1r/ZuZx4Jge5JnE349zk+W6PeOYP2mgRD17remSr5mFJrAjvr2Wt
 Q8WHeep76D+eXD7xJxmhBglisUiHS08ZOS29U0sifkZINpCm5b0vqiMja4ZKdi2z5Tll
 eCZFQUrjeEefa64DMJrZNLGnJmcKSk3QSVyo6XLHSvjW+Aq3cb9KCAGbW+oXrpoXYQvc
 B+8NynAINAR/Lb64HopR4hamMiatC7TWvxTECNo7ojkkjJhZuqRiiKOuFBJ2Jeuyxbqq
 ZlvtcFLaHdCswUD6r3qMLMuIGlZEa1FKwxQ8CAPs8GVuXl//GgM5WyTfEP2opdkgDww6
 bN/A==
X-Gm-Message-State: APjAAAXQi+JIRFY+sGl7HDfYeRPITRJT0RCCR6jsN3bYvV77vaX1o+id
 J3kHvjPqn442gpo1JDhIUgm40xknm0y0SOp3B8BZlFb0Z9h2pBp5gPk1ZUcDIvLz8ADqgH70TFR
 9JDLPkrVOiBJvJ/w=
X-Received: by 2002:a7b:c151:: with SMTP id z17mr1546118wmi.137.1579116109802; 
 Wed, 15 Jan 2020 11:21:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjhg5Fe1gmMsgrQVjv4g0GwvOYzja/zjq8hZLvxdqZwgl9BVlhNg2xMJC0pa2S1WHlkmeVaA==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr1546092wmi.137.1579116109619; 
 Wed, 15 Jan 2020 11:21:49 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id x18sm25975069wrr.75.2020.01.15.11.21.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 11:21:49 -0800 (PST)
Subject: Re: [PATCH v2 37/86] arm:xlnx-zcu102: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-38-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <67822ed4-e957-b005-cd4d-477d539fd82b@redhat.com>
Date: Wed, 15 Jan 2020 20:21:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-38-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: AUdYzrOuP7KeEezSAgFo1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: edgar.iglesias@gmail.com, alistair@alistair23.me, qemu-arm@nongnu.org,
 peter.maydell@linaro.org
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
> CC: alistair@alistair23.me
> CC: edgar.iglesias@gmail.com
> CC: peter.maydell@linaro.org
> CC: qemu-arm@nongnu.org
> ---
>   hw/arm/xlnx-zcu102.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 53cfe7c..bd645ad 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -28,7 +28,6 @@ typedef struct XlnxZCU102 {
>       MachineState parent_obj;
>  =20
>       XlnxZynqMPState soc;
> -    MemoryRegion ddr_ram;
>  =20
>       bool secure;
>       bool virt;
> @@ -87,13 +86,10 @@ static void xlnx_zcu102_init(MachineState *machine)
>                    ram_size);
>       }
>  =20
> -    memory_region_allocate_system_memory(&s->ddr_ram, NULL, "ddr-ram",
> -                                         ram_size);
> -
>       object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->=
soc),
>                               TYPE_XLNX_ZYNQMP, &error_abort, NULL);
>  =20
> -    object_property_set_link(OBJECT(&s->soc), OBJECT(&s->ddr_ram),
> +    object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
>                            "ddr-ram", &error_abort);
>       object_property_set_bool(OBJECT(&s->soc), s->secure, "secure",
>                                &error_fatal);
> @@ -211,6 +207,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClas=
s *oc, void *data)
>       mc->ignore_memory_transaction_failures =3D true;
>       mc->max_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPU=
S;
>       mc->default_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS;
> +    mc->default_ram_id =3D "ddr-ram";
>   }
>  =20
>   static const TypeInfo xlnx_zcu102_machine_init_typeinfo =3D {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


