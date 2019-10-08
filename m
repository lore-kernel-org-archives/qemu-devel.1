Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7D2C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5AB206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5AB206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpZ9-0002vT-0z
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iHpY9-0002A4-Bf
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iHpY7-0005iM-Pu
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:29:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iHpY7-0005hT-HR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:29:11 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 750018665A
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 13:29:10 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id c17so8854421wro.18
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 06:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iwbF2vZJO+3P5xmjgj+lktJWVD8y1JtbE3wMEF3MVl8=;
 b=BGDjPiYqS/QB1ya8LIrJ9P2WLW5viOv8LYA7Wp2HJMCcloLiFp1dgr2IjGiCFFKNQy
 pWZrnH2+znKCiFDGX2DY8RlY+v8tG1jTzyK4tt1xESitx7wcoc/8qGVUOJPlBvjHAQuw
 enm6nQ+FXHfD+orULcaRwyfhMY2HGmDKYNzelfMfLeg+nZPFcC9RxIF6v34UyCk9nRMq
 W6e9TKlLXK7dgsZr5yUbQjeRkYUNK3ZqCCVnFZHG0gC1zm5vBzMnzVw7Uo1O/ZZVwSGn
 fAP5hlHR6Tce76xJ+3SEYpukoczFloq75tyY9pzQ7bmzU6m1dJ8rhdOHbCf86WTyELnm
 rLZQ==
X-Gm-Message-State: APjAAAWwgdnqdIIXQe0/V9Z95UZ+M3JRqOf/M745SjJ7Lw2o7EJicGGL
 9mxdo1lW1uuhueGD7uuPL/jeirK+Ul/JbKiUimyuaT9ZYa48/e7FoT8C9TPPjdn77nmqKJej9/7
 eeJnuKXjGwrsLCm4=
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr3604264wmj.119.1570541347762; 
 Tue, 08 Oct 2019 06:29:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxTY/bulPF79gg9qI2B9eWy0pIKP9b64J5uTFGEhYx/g+FEZS9eGrLVL1CeukWFrgx6ReMg/Q==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr3604248wmj.119.1570541347541; 
 Tue, 08 Oct 2019 06:29:07 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id g4sm24872284wrw.9.2019.10.08.06.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2019 06:29:06 -0700 (PDT)
Subject: Re: [PATCH 3/4] hw/i386: add facility to expose CPU topology over
 fw-cfg
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
References: <20191008105259.5378-1-lersek@redhat.com>
 <20191008105259.5378-4-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f3792fe-9cf6-725a-3fbc-475fda5c22e3@redhat.com>
Date: Tue, 8 Oct 2019 15:29:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008105259.5378-4-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laszlo,

On 10/8/19 12:52 PM, Laszlo Ersek wrote:
> FW_CFG_MAX_CPUS exposes the (exclusive) maximum APIC ID to guest firmwa=
re,
> due to historical reasons. That value is not useful to edk2, however. F=
or
> supporting VCPU hotplug, edk2 needs:
>=20
> - the boot CPU count (already exposed in FW_CFG_NB_CPUS),
>=20
> - and the maximum foreseen CPU count (tracked in
>    "MachineState.smp.max_cpus", but not currently exposed).
>=20
> Add a new fw-cfg file to expose "max_cpus".
>=20
> While at it, expose the rest of the topology too (die / core / thread
> counts), because I expect that the VCPU hotplug feature for OVMF will
> ultimately need those too, and the data size is not large. This is
> slightly complicated by the fact that the die count is specific to
> PCMachineState, but fw_cfg_arch_create() intends to be PC-independent (=
see
> commit 149c50cabcc4).

The X86 topology is generic to the architecture (not machine specific)=20
so it is well placed in fw_cfg_arch_create().

>=20
> For now, the feature is temporarily disabled.

I see you enable it in the PC machine in the next patch.
Do you plan to remove the 'expose_topology' argument and expose the key=20
later, or is this comment simply related to this patch?

Ah, now I see you disable it previous to pc-4.2, OK.

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Ref: https://bugzilla.tianocore.org/show_bug.cgi?id=3D1515
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   hw/i386/fw_cfg.h | 30 +++++++++++++++++++++++++++++-
>   hw/i386/fw_cfg.c | 26 ++++++++++++++++++++++++--
>   hw/i386/pc.c     |  4 ++--
>   3 files changed, 55 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
> index e0856a376996..d742435b9793 100644
> --- a/hw/i386/fw_cfg.h
> +++ b/hw/i386/fw_cfg.h
> @@ -18,9 +18,37 @@
>   #define FW_CFG_E820_TABLE       (FW_CFG_ARCH_LOCAL + 3)
>   #define FW_CFG_HPET             (FW_CFG_ARCH_LOCAL + 4)
>  =20
> +/**
> + * FWCfgX86Topology: expose the X86 CPU topology to guest firmware ove=
r fw-cfg.
> + *
> + * All fields have little-endian encoding.
> + *
> + * @dies:     Number of dies per package (aka socket). Set it to 1 unl=
ess the
> + *            concrete MachineState subclass defines it differently.
> + * @cores:    Corresponds to @CpuTopology.@cores.
> + * @threads:  Corresponds to @CpuTopology.@threads.
> + * @max_cpus: Corresponds to @CpuTopology.@max_cpus.
> + *
> + * Firmware can derive the package (aka socket) count with the followi=
ng
> + * formula:
> + *
> + *   DIV_ROUND_UP(@max_cpus, @dies * @cores * @threads)
> + *
> + * Firmware can derive APIC ID field widths and offsets per the standa=
rd
> + * calculations in "include/hw/i386/topology.h".
> + */
> +typedef struct FWCfgX86Topology {
> +  uint32_t dies;
> +  uint32_t cores;
> +  uint32_t threads;
> +  uint32_t max_cpus;
> +} QEMU_PACKED FWCfgX86Topology;
> +
>   FWCfgState *fw_cfg_arch_create(MachineState *ms,
>                                  uint16_t boot_cpus,
> -                               uint16_t apic_id_limit);
> +                               uint16_t apic_id_limit,
> +                               unsigned smp_dies,
> +                               bool expose_topology);
>   void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
>   void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cf=
g);
>  =20
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index 39b6bc60520c..33d09875014f 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -85,9 +85,26 @@ void fw_cfg_build_smbios(MachineState *ms, FWCfgStat=
e *fw_cfg)
>       }
>   }
>  =20
> +static void fw_cfg_expose_topology(FWCfgState *fw_cfg,
> +                                   unsigned dies,
> +                                   unsigned cores,
> +                                   unsigned threads,
> +                                   unsigned max_cpus)
> +{
> +    FWCfgX86Topology *topo =3D g_new(FWCfgX86Topology, 1);
> +
> +    topo->dies     =3D cpu_to_le32(dies);
> +    topo->cores    =3D cpu_to_le32(cores);
> +    topo->threads  =3D cpu_to_le32(threads);
> +    topo->max_cpus =3D cpu_to_le32(max_cpus);
> +    fw_cfg_add_file(fw_cfg, "etc/x86-smp-topology", topo, sizeof *topo=
);
> +}
> +
>   FWCfgState *fw_cfg_arch_create(MachineState *ms,
> -                                      uint16_t boot_cpus,
> -                                      uint16_t apic_id_limit)
> +                               uint16_t boot_cpus,
> +                               uint16_t apic_id_limit,
> +                               unsigned smp_dies,
> +                               bool expose_topology)
>   {
>       FWCfgState *fw_cfg;
>       uint64_t *numa_fw_cfg;
> @@ -143,6 +160,11 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
>                        (1 + apic_id_limit + nb_numa_nodes) *
>                        sizeof(*numa_fw_cfg));
>  =20
> +    if (expose_topology) {
> +        fw_cfg_expose_topology(fw_cfg, smp_dies, ms->smp.cores,
> +                               ms->smp.threads, ms->smp.max_cpus);
> +    }
> +
>       return fw_cfg;
>   }
>  =20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bcda50efcc23..bb72b12edad2 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1738,8 +1738,8 @@ void pc_memory_init(PCMachineState *pcms,
>                                           option_rom_mr,
>                                           1);
>  =20
> -    fw_cfg =3D fw_cfg_arch_create(machine,
> -                                pcms->boot_cpus, pcms->apic_id_limit);
> +    fw_cfg =3D fw_cfg_arch_create(machine, pcms->boot_cpus, pcms->apic=
_id_limit,
> +                                pcms->smp_dies, false);
>  =20
>       rom_set_fw(fw_cfg);
>  =20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

