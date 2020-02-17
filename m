Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC14C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5A820836
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tpu8/ESS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5A820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3l4F-0001Jw-OG
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3knB-0003o3-Di
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3kn7-0004a8-DQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:06:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54885
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3kn7-0004Zv-9d
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581962804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3E9XR6lPSQmFLTOuPRjNCXSiWUwgckxgqmP4YLjxFM4=;
 b=Tpu8/ESSQrQSD5yeMY/GdRnj80+u+08lKkIJBGl+aluna5DlisQqiYFH1ksP1A69J1+dl9
 Z22P9nARXlC4oY5abE0eb+riqckfVPFEyp9xFwh1jyqfB1lzr+pWcdtcafdG169B/cPrl5
 Fwr0yk3sSXPnUi1DP8OaE9IWUwtZ0rk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-YGITNztGOsCyf3CtgKnG9Q-1; Mon, 17 Feb 2020 13:06:39 -0500
Received: by mail-wr1-f72.google.com with SMTP id w17so9395844wrr.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+KaQvuw+N85MwcdG1Zov2m//+h1L+wULiqZviO4qUSA=;
 b=Y1usKStfkWwvWnV8VPzP0EEicaxjZa0+RoJbKVqj4Itb6QIdlGrzv0gDLvUeGqq4bS
 2LeRRtZ/Nshp99f2EvXKDx8A1t2So8lZBsyWW2sXnDcpP2fQ7phgo1vjUM3V4vPsLH63
 CHoIzS357LdlzrIsO0jFe53+p9/6aN7VivutAedzGpJ3eqruOeOGlAj/OdFbRWZ8X5l3
 nRpjxqQ95E+I+fK37M3MUItv4sIEdWtp0FF0eTEE8gei4PBCz1SOHno2b/BU11PAvfh/
 Uq7Wo3RZ7QyOJLfCZGsNDGdA/bLofLX1QC9jCKuHi87XOLnHAzz6AM8DLvn3bOA39Orw
 /J6Q==
X-Gm-Message-State: APjAAAVflyC3bf1CcGrY4YGiLJ1bTIqb5VETz/VLc2fRamZbXEh5UPHa
 pktGpqJFVRGAN2ydLqOVOiKw88iPr5M7LRqxB8zItB3DeF4ZjjFJKHXrZu5uDxIq2+R1hRF1T/0
 26qRioFdkaY54/J8=
X-Received: by 2002:a05:600c:292:: with SMTP id
 18mr255462wmk.128.1581962798419; 
 Mon, 17 Feb 2020 10:06:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxD/ORupSBHdFrKT4I5hDg49Avjs/JcfmU7PEvyI0oRAhnNFRlPF/gxAGeGEH2PQZB+svCyQw==
X-Received: by 2002:a05:600c:292:: with SMTP id
 18mr255445wmk.128.1581962798171; 
 Mon, 17 Feb 2020 10:06:38 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x132sm631143wmg.0.2020.02.17.10.06.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:06:37 -0800 (PST)
Subject: Re: [PATCH v5 29/79] arm/raspi: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-30-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d9dbcde-ed08-0534-f9c5-8682b9c4874a@redhat.com>
Date: Mon, 17 Feb 2020 19:06:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-30-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: YGITNztGOsCyf3CtgKnG9Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew.Baumann@microsoft.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 6:34 PM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>      MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
> CC: Andrew.Baumann@microsoft.com
> CC: philmd@redhat.com
>=20
> v5:
>        * fixed rebase conflicts once more
> v4:
>        * fixed rebase conflicts
> ---
>   hw/arm/raspi.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 90ad9b8115..acd2bb794d 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -39,7 +39,6 @@ typedef struct RaspiMachineState {
>       MachineState parent_obj;
>       /*< public >*/
>       BCM283XState soc;
> -    MemoryRegion ram;
>   } RaspiMachineState;
>  =20
>   typedef struct RaspiMachineClass {
> @@ -277,16 +276,14 @@ static void raspi_machine_init(MachineState *machin=
e)
>           exit(1);
>       }
>  =20
> -    /* Allocate and map RAM */
> -    memory_region_allocate_system_memory(&s->ram, OBJECT(machine), "ram"=
,
> -                                         machine->ram_size);
>       /* FIXME: Remove when we have custom CPU address space support */
> -    memory_region_add_subregion_overlap(get_system_memory(), 0, &s->ram,=
 0);
> +    memory_region_add_subregion_overlap(get_system_memory(), 0,
> +                                        machine->ram, 0);
>  =20
>       /* Setup the SOC */
>       object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->=
soc),
>                               board_soc_type(board_rev), &error_abort, NU=
LL);
> -    object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ra=
m),
> +    object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(machin=
e->ram),
>                                      &error_abort);
>       object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
>                               &error_abort);
> @@ -324,6 +321,7 @@ static void raspi_machine_class_init(ObjectClass *oc,=
 void *data)
>       mc->no_cdrom =3D 1;
>       mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D cores_count(=
board_rev);
>       mc->default_ram_size =3D board_ram_size(board_rev);
> +    mc->default_ram_id =3D "ram";
>       if (board_version(board_rev) =3D=3D 2) {
>           mc->ignore_memory_transaction_failures =3D true;
>       }
>=20


