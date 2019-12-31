Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A34C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B47206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 16:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6L9viTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B47206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imK1X-0005U3-MK
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 11:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imK0g-000515-Td
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imK0f-0000Tw-GH
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:04:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imK0f-0000RR-By
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 11:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577808280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Adko0/5F/XH1d7Yu0b1uRfEzABuUMpsdkQJCZfGJwC0=;
 b=S6L9viTkjGGcRvEbvvNVQCMgNhtgYxyBYYc8HtZze04ZrBEEf6U4h2UDLkLroLcUZR4TN3
 v0lIkhMm1nYnAavwz41S05EmugETqPvzGcxNY3Zd66se6XSCsir5Vcoy3F5opOvBIG07rX
 6h1Qy67SIJpSXsV79zOrXwfvMFJo6cM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-KQe0y83WPhKK6bL3V25Y0g-1; Tue, 31 Dec 2019 11:04:36 -0500
Received: by mail-wr1-f71.google.com with SMTP id j13so5058379wrr.20
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 08:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CKo982HTFC7VrK1MCWAE6HYgvpBZaPzDmNamagijyrg=;
 b=JOFVYAnwMtGqtZqeBh2Iw8yzLnFVbzoHRFZ6bEkpkUMmhY/LyfsjAntll7+It020si
 /rt7Ql9PSkDcihg07xv38cZbf6O4tN11EuwFNufV6j1pNeDmae8r2z0E4ALSEGQBAwGb
 7sMhn+J6J+33fvdEhpXn4shwnosJzhYFKiaA+BC/5sGXtIgwk+j3Hp42AAPZ17G7DNyE
 6/RRHAapPDMvjd4hGqfrrHR6rBCHoH157074J0PvYpU/NI/A1lm/7rJKnHOf2NgTAjTy
 SnbChi5LZCb+ybjsN+beIs7p1CU9hrNCwRQ6F1olxT/FUqQWACnKrpykMTCTs2FKsnL/
 vcMA==
X-Gm-Message-State: APjAAAUM1j57Kv60HxyrsUnS9A1N/39AVnK5O1lIND4zwkbIqQSB4N/G
 lCJbA309OkMc1JUCCUKCIMM8vLNwBPkTDiXGc58EDpYFkNcY6iakl7nmM7D5hLMbzmQuEDO7r4Q
 d551FYYKG8AgQqnU=
X-Received: by 2002:a7b:c218:: with SMTP id x24mr5121559wmi.149.1577808275475; 
 Tue, 31 Dec 2019 08:04:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyklsi4N/UhAt/fB1/AGhRu/AnM31eC5InyJ6QHnGsMr+Q1YarWulI7iYVDGuKBUKbIdAklZA==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr5121539wmi.149.1577808275203; 
 Tue, 31 Dec 2019 08:04:35 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id z21sm3029927wml.5.2019.12.31.08.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 08:04:34 -0800 (PST)
Subject: Re: [PATCH 76/86] post conversion default_ram_id cleanup
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-77-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b396c643-ef2e-b6b6-a098-3a5dcb0ed507@redhat.com>
Date: Tue, 31 Dec 2019 17:04:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-77-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: KQe0y83WPhKK6bL3V25Y0g-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/31/19 2:04 PM, Igor Mammedov wrote:
> With default_ram_id is always defined, simplify
> 'if' conditions in vl.c and numa.c
>=20
> while at it set
>    MachineClass::default_ram_id =3D "ram"
> and clean up several boards that use "ram" id
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/alpha/dp264.c       | 1 -
>   hw/arm/aspeed.c        | 1 -
>   hw/arm/digic_boards.c  | 1 -
>   hw/arm/raspi.c         | 2 --
>   hw/core/machine.c      | 1 +
>   hw/core/null-machine.c | 1 -
>   hw/core/numa.c         | 2 +-
>   hw/hppa/machine.c      | 1 -
>   hw/ppc/virtex_ml507.c  | 1 -
>   vl.c                   | 1 -
>   10 files changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
> index 29439c7..f6b9e50 100644
> --- a/hw/alpha/dp264.c
> +++ b/hw/alpha/dp264.c
> @@ -183,7 +183,6 @@ static void clipper_machine_init(MachineClass *mc)
>       mc->max_cpus =3D 4;
>       mc->is_default =3D 1;
>       mc->default_cpu_type =3D ALPHA_CPU_TYPE_NAME("ev67");
> -    mc->default_ram_id =3D "ram";
>   }
>  =20
>   DEFINE_MACHINE("clipper", clipper_machine_init)
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 330254b..188d42f 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -391,7 +391,6 @@ static void aspeed_machine_class_init(ObjectClass *oc=
, void *data)
>       mc->no_floppy =3D 1;
>       mc->no_cdrom =3D 1;
>       mc->no_parallel =3D 1;
> -    mc->default_ram_id =3D "ram";
>   }
>  =20
>   static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *d=
ata)
> diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
> index c3bc5cb..c3cffb3 100644
> --- a/hw/arm/digic_boards.c
> +++ b/hw/arm/digic_boards.c
> @@ -149,7 +149,6 @@ static void canon_a1100_machine_init(MachineClass *mc=
)
>       mc->init =3D &canon_a1100_init;
>       mc->ignore_memory_transaction_failures =3D true;
>       mc->default_ram_size =3D 64 * MiB;
> -    mc->default_ram_id =3D "ram";
>   }
>  =20
>   DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 33ace66..3d49dcc 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -223,7 +223,6 @@ static void raspi2_machine_init(MachineClass *mc)
>       mc->min_cpus =3D BCM283X_NCPUS;
>       mc->default_cpus =3D BCM283X_NCPUS;
>       mc->default_ram_size =3D 1 * GiB;
> -    mc->default_ram_id =3D "ram";
>       mc->ignore_memory_transaction_failures =3D true;
>   };
>   DEFINE_MACHINE("raspi2", raspi2_machine_init)
> @@ -246,7 +245,6 @@ static void raspi3_machine_init(MachineClass *mc)
>       mc->min_cpus =3D BCM283X_NCPUS;
>       mc->default_cpus =3D BCM283X_NCPUS;
>       mc->default_ram_size =3D 1 * GiB;
> -    mc->default_ram_id =3D "ram";
>   }
>   DEFINE_MACHINE("raspi3", raspi3_machine_init)
>   #endif
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 080ce57..a938052 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -711,6 +711,7 @@ static void machine_class_init(ObjectClass *oc, void =
*data)
>  =20
>       /* Default 128 MB as guest ram size */
>       mc->default_ram_size =3D 128 * MiB;
> +    mc->default_ram_id =3D "ram";
>       mc->rom_file_has_mr =3D true;
>       mc->smp_parse =3D smp_parse;
>  =20
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index cb47d9d..08c6109 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -49,7 +49,6 @@ static void machine_none_machine_init(MachineClass *mc)
>       mc->init =3D machine_none_init;
>       mc->max_cpus =3D 1;
>       mc->default_ram_size =3D 0;
> -    mc->default_ram_id =3D "ram";
>   }
>  =20
>   DEFINE_MACHINE("none", machine_none_machine_init)
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 623b307..6a1711d 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -459,7 +459,7 @@ void numa_complete_configuration(MachineState *ms)
>               exit(1);
>           }
>  =20
> -        if (!numa_uses_legacy_mem() && mc->default_ram_id) {
> +        if (!numa_uses_legacy_mem()) {
>               ms->ram =3D g_new(MemoryRegion, 1);
>               memory_region_init(ms->ram, OBJECT(ms), mc->default_ram_id,
>                                  ram_size);
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index b2f7bc5..ebbf44f 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -279,7 +279,6 @@ static void machine_hppa_machine_init(MachineClass *m=
c)
>       mc->is_default =3D 1;
>       mc->default_ram_size =3D 512 * MiB;
>       mc->default_boot_order =3D "cd";
> -    mc->default_ram_id =3D "ram";
>   }
>  =20
>   DEFINE_MACHINE("hppa", machine_hppa_machine_init)
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index b74a269..b31f1cf 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -299,7 +299,6 @@ static void virtex_machine_init(MachineClass *mc)
>       mc->desc =3D "Xilinx Virtex ML507 reference design";
>       mc->init =3D virtex_init;
>       mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("440-xilinx");
> -    mc->default_ram_id =3D "ram";
>   }
>  =20
>   DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
> diff --git a/vl.c b/vl.c
> index b89e76c..60dffb4 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4296,7 +4296,6 @@ int main(int argc, char **argv, char **envp)
>  =20
>       if (numa_uses_legacy_mem() &&
>           machine_class->default_ram_size &&
> -        machine_class->default_ram_id &&
>           !current_machine->ram_memdev) {
>           create_default_memdev(current_machine, mem_path, mem_prealloc);
>       }
>=20


