Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55728C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 10:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CD0208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 10:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CD0208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIVHY-0001ys-6L
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 06:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIVGj-0001Yc-Ng
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 06:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIVGh-0003hQ-Ma
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 06:02:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIVGh-0003gt-DX
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 06:01:59 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 60CC83CA03
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 10:01:58 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id z12so5252149qtn.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 03:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qf7aaQtTTvnrWPTNTpWsrjeBF+rB88Wps3yYTBqeYFQ=;
 b=tOQbYxDAufBcPUnAY8u00wZk4Z5nlM5rvoWHDE/R3vX+1P8rkerQ7chu2jggFoOb2d
 EK18P2lm48mDjS7TBzBExRV4B9syNfYF4V5ljWrBKYp9IDA0NWanStCVY1jaDsCW/xyg
 NvSxmZPZBCTofOuXvZgUSQ1CTILS6nvF4tpEC0GCzTYy4jT3h/6JqpJSJHFTl9PJ96Yl
 48MDlOncnBxu/hPNxYRsQf6l+W9FEr03uhD9OROh60iN2BfXMR0dQMxGwHKpAaEegsJ5
 5gdIar77gugczCHb1Ix2ZGKQK1oaMuTcAHxjgUae+eOnwgMO2PkwIRnvIJo1hwvPx8ER
 H6wQ==
X-Gm-Message-State: APjAAAXnpedUkw6n7VZxtcuQ23knJU3Cy5SuFfhnapjk2NY17SrMMBZg
 wUbBQBLN6uu7gUzcq3+SxgvbQK67fwCfWmWIFSdqKt5tQt2mvjo7XoS0ehpuSBjwrTyXdAiI9gj
 w3Gzzu7jiKykvaJg=
X-Received: by 2002:a37:a089:: with SMTP id j131mr8589565qke.446.1570701716911; 
 Thu, 10 Oct 2019 03:01:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz6Ylywi/FqewzTZM0wgBPtLKaDolIUKmNl5/9Mcjt3hTFLMd6zUGWGfT9jqqfxwEZlCtu8qQ==
X-Received: by 2002:a37:a089:: with SMTP id j131mr8589537qke.446.1570701716559; 
 Thu, 10 Oct 2019 03:01:56 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 g8sm2854965qta.67.2019.10.10.03.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 03:01:55 -0700 (PDT)
Date: Thu, 10 Oct 2019 06:01:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 3/4] hw/i386: add facility to expose CPU topology over
 fw-cfg
Message-ID: <20191010055733-mutt-send-email-mst@kernel.org>
References: <20191008105259.5378-1-lersek@redhat.com>
 <20191008105259.5378-4-lersek@redhat.com>
 <20191008175931.483af366@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191008175931.483af366@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 08, 2019 at 05:59:31PM +0200, Igor Mammedov wrote:
> On Tue,  8 Oct 2019 12:52:58 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> > FW_CFG_MAX_CPUS exposes the (exclusive) maximum APIC ID to guest firm=
ware,
> > due to historical reasons. That value is not useful to edk2, however.=
 For
> > supporting VCPU hotplug, edk2 needs:
> >=20
> > - the boot CPU count (already exposed in FW_CFG_NB_CPUS),
> >=20
> > - and the maximum foreseen CPU count (tracked in
> >   "MachineState.smp.max_cpus", but not currently exposed).
> one can get it with current QEMU without adding new fgcfg
> (albeit in a bit awkward way)
>=20
> max_cpu count can be derived indirectly as result of cpu hotplug
> enumeration (IO interface at 0x0cd8-0xcf7) by writing/reading
> to/from selector register (see ACPI_CPU_SELECTOR_OFFSET_WR)
> until read value stops changing values (i.e. max cpu count
> is reached). One also can figure out present/non-present
> cpu status by reading flags register.

Right but so far ACPI was the only driver of CPU hotplug, right?
I don't think firmware should poke it directly, it is
not really clean or especially scalable.
Fine for ACPI but not great as a HV/guest interface.

> > Add a new fw-cfg file to expose "max_cpus".
> >=20
> > While at it, expose the rest of the topology too (die / core / thread
> > counts), because I expect that the VCPU hotplug feature for OVMF will
> > ultimately need those too, and the data size is not large. This is
> > slightly complicated by the fact that the die count is specific to
> > PCMachineState, but fw_cfg_arch_create() intends to be PC-independent=
 (see
> > commit 149c50cabcc4).
> Could you clarify why topology info is necessary?
>=20
> Potentially it's possible to extend cpu hotplug ABI to report
> arch specific apic-id (x86) or mpidr (arm) if firmware really
> needs to know topology and let guest to decode it according
> to CPU's spec.
>=20
> So far there were no need for it as all possible cpus are
> described in ACPI tables passed to guest, but I'm not going
> to suggest to parse them on firmware side as it's too complicated :)

We can always add a QEMU specific data table by the way.
Format would be up to us and would be easy to parse.
I don't see a big advantage as compared to fw cfg though.

> PS:
> The reason we started building ACPI tables in QEMU, was never
> ending story of adding more ABI and supporting it afterwards.
> So I'd try to avoid doing it if it can be helped.

Absolutely. We should try to keep all ACPI generation in QEMU.
But this value is not for ACPI, is it?



> > For now, the feature is temporarily disabled.
> >=20
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Ref: https://bugzilla.tianocore.org/show_bug.cgi?id=3D1515
> > Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> > ---
> >  hw/i386/fw_cfg.h | 30 +++++++++++++++++++++++++++++-
> >  hw/i386/fw_cfg.c | 26 ++++++++++++++++++++++++--
> >  hw/i386/pc.c     |  4 ++--
> >  3 files changed, 55 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
> > index e0856a376996..d742435b9793 100644
> > --- a/hw/i386/fw_cfg.h
> > +++ b/hw/i386/fw_cfg.h
> > @@ -18,9 +18,37 @@
> >  #define FW_CFG_E820_TABLE       (FW_CFG_ARCH_LOCAL + 3)
> >  #define FW_CFG_HPET             (FW_CFG_ARCH_LOCAL + 4)
> > =20
> > +/**
> > + * FWCfgX86Topology: expose the X86 CPU topology to guest firmware o=
ver fw-cfg.
> > + *
> > + * All fields have little-endian encoding.
> > + *
> > + * @dies:     Number of dies per package (aka socket). Set it to 1 u=
nless the
> > + *            concrete MachineState subclass defines it differently.
> > + * @cores:    Corresponds to @CpuTopology.@cores.
> > + * @threads:  Corresponds to @CpuTopology.@threads.
> > + * @max_cpus: Corresponds to @CpuTopology.@max_cpus.
> > + *
> > + * Firmware can derive the package (aka socket) count with the follo=
wing
> > + * formula:
> > + *
> > + *   DIV_ROUND_UP(@max_cpus, @dies * @cores * @threads)
> > + *
> > + * Firmware can derive APIC ID field widths and offsets per the stan=
dard
> > + * calculations in "include/hw/i386/topology.h".
> > + */
> > +typedef struct FWCfgX86Topology {
> > +  uint32_t dies;
> > +  uint32_t cores;
> > +  uint32_t threads;
> > +  uint32_t max_cpus;
> > +} QEMU_PACKED FWCfgX86Topology;
> > +
> >  FWCfgState *fw_cfg_arch_create(MachineState *ms,
> >                                 uint16_t boot_cpus,
> > -                               uint16_t apic_id_limit);
> > +                               uint16_t apic_id_limit,
> > +                               unsigned smp_dies,
> > +                               bool expose_topology);
> >  void fw_cfg_build_smbios(MachineState *ms, FWCfgState *fw_cfg);
> >  void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_c=
fg);
> > =20
> > diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> > index 39b6bc60520c..33d09875014f 100644
> > --- a/hw/i386/fw_cfg.c
> > +++ b/hw/i386/fw_cfg.c
> > @@ -85,9 +85,26 @@ void fw_cfg_build_smbios(MachineState *ms, FWCfgSt=
ate *fw_cfg)
> >      }
> >  }
> > =20
> > +static void fw_cfg_expose_topology(FWCfgState *fw_cfg,
> > +                                   unsigned dies,
> > +                                   unsigned cores,
> > +                                   unsigned threads,
> > +                                   unsigned max_cpus)
> > +{
> > +    FWCfgX86Topology *topo =3D g_new(FWCfgX86Topology, 1);
> > +
> > +    topo->dies     =3D cpu_to_le32(dies);
> > +    topo->cores    =3D cpu_to_le32(cores);
> > +    topo->threads  =3D cpu_to_le32(threads);
> > +    topo->max_cpus =3D cpu_to_le32(max_cpus);
> > +    fw_cfg_add_file(fw_cfg, "etc/x86-smp-topology", topo, sizeof *to=
po);
> > +}
> > +
> >  FWCfgState *fw_cfg_arch_create(MachineState *ms,
> > -                                      uint16_t boot_cpus,
> > -                                      uint16_t apic_id_limit)
> > +                               uint16_t boot_cpus,
> > +                               uint16_t apic_id_limit,
> > +                               unsigned smp_dies,
> > +                               bool expose_topology)
> >  {
> >      FWCfgState *fw_cfg;
> >      uint64_t *numa_fw_cfg;
> > @@ -143,6 +160,11 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
> >                       (1 + apic_id_limit + nb_numa_nodes) *
> >                       sizeof(*numa_fw_cfg));
> > =20
> > +    if (expose_topology) {
> > +        fw_cfg_expose_topology(fw_cfg, smp_dies, ms->smp.cores,
> > +                               ms->smp.threads, ms->smp.max_cpus);
> > +    }
> > +
> >      return fw_cfg;
> >  }
> > =20
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index bcda50efcc23..bb72b12edad2 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1738,8 +1738,8 @@ void pc_memory_init(PCMachineState *pcms,
> >                                          option_rom_mr,
> >                                          1);
> > =20
> > -    fw_cfg =3D fw_cfg_arch_create(machine,
> > -                                pcms->boot_cpus, pcms->apic_id_limit=
);
> > +    fw_cfg =3D fw_cfg_arch_create(machine, pcms->boot_cpus, pcms->ap=
ic_id_limit,
> > +                                pcms->smp_dies, false);
> > =20
> >      rom_set_fw(fw_cfg);
> > =20

