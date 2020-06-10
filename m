Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F322C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB9B206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB9B206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj18h-0005EK-7a
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Georg.Hofstetter@efs-auto.de>)
 id 1jj170-0003eC-LY
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:49:50 -0400
Received: from mailin4.audi.de ([143.164.102.18]:33053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Georg.Hofstetter@efs-auto.de>)
 id 1jj16y-0004xR-TV
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:49:50 -0400
From: "Hofstetter, Georg (EFS-GH2)" <Georg.Hofstetter@efs-auto.de>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: AW: [PATCH v2 1/1] tricore: added triboard with tc27x_soc
Thread-Topic: [PATCH v2 1/1] tricore: added triboard with tc27x_soc
Thread-Index: AQHWPnJScHnEYAKYDEWPeFmhEWMOQqjRaVoAgAByBHA=
Date: Wed, 10 Jun 2020 13:49:37 +0000
Message-ID: <69A9BBE82CEA98469F7BA51850C5B89CF2FEA8F8@AUDIINSX0364.audi.vwg>
References: <20200609152553.4376-1-david.brenken@efs-auto.org>
 <20200609152553.4376-2-david.brenken@efs-auto.org>
 <20200610084818.yrzxqm6466w2wpiz@schnipp-desktop>
In-Reply-To: <20200610084818.yrzxqm6466w2wpiz@schnipp-desktop>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.44.80]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Received-SPF: none client-ip=143.164.102.18;
 envelope-from=Georg.Hofstetter@efs-auto.de; helo=mailin4.audi.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:49:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Brenken, David \(EFS-GH5\)" <david.brenken@efs-auto.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Konopik, Andreas
 \(EFS-GH2\)" <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Bastian,

Thanks for your feedback, I like your proposals.

> Also what do the _U and _C suffixes mean? I could not find them in the us=
er manual [1].

See TC27X UM chapter 3.2 "Contents of the Segments"
"CPUx default attributes for these segments: non-cached" vs "cached"
These regions are the same memory, just with address bit 29 set, which will=
 bypass the DMI/PMI cache.
The regions are reflected here with _C (cached) and _U (uncached) suffixes.

> These aliases point to reserved memory in the user manual [1].

See TC27X UM chapter 5.7.2 "Local and Global Addressing"
"The local PSPR memory is always located at C0000000H. The local DSPR is al=
ways located at D0000000H."
Those addresses are not visible on the SRI crossbar, but are core-locally m=
apped onto the current core memories.
As we emulate only one core (yet?), the "local DSPR" is being mapped to "CP=
U0 DSPR", same for PSPR.


Regards,
Georg


-----Urspr=FCngliche Nachricht-----
Von: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>=20
Gesendet: Mittwoch, 10. Juni 2020 10:49
An: David Brenken <david.brenken@efs-auto.org>
Cc: qemu-devel@nongnu.org; Konopik, Andreas (EFS-GH2) <andreas.konopik@efs-=
auto.de>; Brenken, David (EFS-GH5) <david.brenken@efs-auto.de>; Hofstetter,=
 Georg (EFS-GH2) <Georg.Hofstetter@efs-auto.de>; Rasche, Robert (EFS-GH2) <=
robert.rasche@efs-auto.de>; Biermanski, Lars (EFS-GH3) <lars.biermanski@efs=
-auto.de>
Betreff: Re: [PATCH v2 1/1] tricore: added triboard with tc27x_soc

Hi,

thanks for the patch. In general this looks good to me. However, a have a f=
ew nitpicks.

On Tue, Jun 09, 2020 at 05:25:53PM +0200, David Brenken wrote:
> From: Andreas Konopik <andreas.konopik@efs-auto.de>
> +static const int tc27x_soc_irqmap[] =3D { };

Since this is empty, it's best to just remove it.

> +
> +static const hwaddr tc27x_soc_memmap[] =3D {
> +    [TC27XD_DSPR2]     =3D 0x50000000,
> +    [TC27XD_DCACHE2]   =3D 0x5001E000,
> +    [TC27XD_DTAG2]     =3D 0x500C0000,
> +    [TC27XD_PSPR2]     =3D 0x50100000,
> +    [TC27XD_PCACHE2]   =3D 0x50108000,
> +    [TC27XD_PTAG2]     =3D 0x501C0000,
> +    [TC27XD_DSPR1]     =3D 0x60000000,
> +    [TC27XD_DCACHE1]   =3D 0x6001E000,
> +    [TC27XD_DTAG1]     =3D 0x600C0000,
> +    [TC27XD_PSPR1]     =3D 0x60100000,
> +    [TC27XD_PCACHE1]   =3D 0x60108000,
> +    [TC27XD_PTAG1]     =3D 0x601C0000,
> +    [TC27XD_DSPR0]     =3D 0x70000000,
> +    [TC27XD_PSPR0]     =3D 0x70100000,
> +    [TC27XD_PCACHE0]   =3D 0x70106000,
> +    [TC27XD_PTAG0]     =3D 0x701C0000,
> +    [TC27XD_PFLASH0_C] =3D 0x80000000,
> +    [TC27XD_PFLASH1_C] =3D 0x80200000,
> +    [TC27XD_OLDA_C]    =3D 0x8FE70000,
> +    [TC27XD_BROM_C]    =3D 0x8FFF8000,
> +    [TC27XD_LMURAM_C]  =3D 0x90000000,
> +    [TC27XD_EMEM_C]    =3D 0x9F000000,
> +    [TC27XD_PFLASH0_U] =3D 0xA0000000,
> +    [TC27XD_PFLASH1_U] =3D 0xA0200000,
> +    [TC27XD_DFLASH0]   =3D 0xAF000000,
> +    [TC27XD_DFLASH1]   =3D 0xAF110000,
> +    [TC27XD_OLDA_U]    =3D 0xAFE70000,
> +    [TC27XD_BROM_U]    =3D 0xAFFF8000,
> +    [TC27XD_LMURAM_U]  =3D 0xB0000000,
> +    [TC27XD_EMEM_U]    =3D 0xBF000000,
> +    [TC27XD_PSPRX]     =3D 0xC0000000,
> +    [TC27XD_DSPRX]     =3D 0xD0000000,
> +};

Can we add the sizes here as well? That make it much easier to read. See hw=
/riscv/sifive_e.c

Also what do the _U and _C suffixes mean? I could not find them in the user=
 manual [1].

> +
> +/*
> + * Initialize the auxiliary ROM region @mr and map it into
> + * the memory map at @base.
> + */
> +static void make_rom(MemoryRegion *mr, const char *name,
> +                     hwaddr base, hwaddr size) {
> +    memory_region_init_rom(mr, NULL, name, size, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), base, mr); }
> +
> +/*
> + * Initialize the auxiliary RAM region @mr and map it into
> + * the memory map at @base.
> + */
> +static void make_ram(MemoryRegion *mr, const char *name,
> +                     hwaddr base, hwaddr size)
> +{
> +    memory_region_init_ram(mr, NULL, name, size, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), base, mr);
> +}
> +
> +/*
> + * Create an alias of an entire original MemoryRegion @orig
> + * located at @base in the memory map.
> + */
> +static void make_alias(MemoryRegion *mr, const char *name,
> +                           MemoryRegion *orig, hwaddr base)
> +{
> +    memory_region_init_alias(mr, NULL, name, orig, 0,
> +                             memory_region_size(orig));
> +    memory_region_add_subregion(get_system_memory(), base, mr);
> +}

These seem like very common idioms. It might be worth while to make this a
generic QEMU API. However this is out of scope for this patchset.

> +    /*
> +     * TriCore QEMU executes CPU0 only, thus it is sufficient to map
> +     * LOCAL.PSPR/LOCAL.DSPR exclusively onto PSPR0/DSPR0.
> +     */
> +    make_alias(&s->psprX, "LOCAL.PSPR", &s->cpu0mem.pspr,
> +            sc->memmap[TC27XD_PSPRX]);
> +    make_alias(&s->dsprX, "LOCAL.DSPR", &s->cpu0mem.dspr,
> +            sc->memmap[TC27XD_DSPRX]);
 =20
These aliases point to reserved memory in the user manual [1].

> +static void tc27x_soc_init(Object *obj)
> +{
> +    TC27XSoCState *s =3D TC27X_SOC(obj);
> +    TC27XSoCClass *sc =3D TC27X_SOC_GET_CLASS(s);
> +
> +    sysbus_init_child_obj(OBJECT(s), "tc27x", OBJECT(&s->cpu), sizeof(s-=
>cpu),
> +                        sc->cpu_type);

Unnecessary cast. Just use sysbus_init_child_obj(obj,...)

> +static void tricore_load_kernel(const char *kernel_filename)
> +{
> +    uint64_t entry;
> +    long kernel_size;
> +    TriCoreCPU *cpu;
> +    CPUTriCoreState *env;
> +
> +    kernel_size =3D load_elf(kernel_filename, NULL,
> +                           NULL, NULL, &entry, NULL,
> +                           NULL, NULL, 0,
> +                           EM_TRICORE, 1, 0);
> +    if (kernel_size <=3D 0) {
> +        error_report("no kernel file '%s'", kernel_filename);
> +        exit(1);
> +    }
> +    cpu =3D TRICORE_CPU(first_cpu);
> +    env =3D &cpu->env;
> +    env->PC =3D entry;
> +}

Just a note for the future. This seems like a function that ought to be
generalized for all TriCore boards.

Cheers,
Bastian

[1] https://hitex.co.uk/fileadmin/uk-files/downloads/ShieldBuddy/tc27xD_um_=
v2.2.pdf=20

