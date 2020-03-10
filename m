Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5BFC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4213E24691
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4213E24691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcos-0005RN-Gd
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jBclL-0000fi-5n
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jBclJ-0004DA-Mh
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:09:26 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:42881)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jBclJ-0004AF-Eq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:09:25 -0400
Received: from player734.ha.ovh.net (unknown [10.108.54.203])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id B3CF215D62A
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 12:09:21 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 1E81E101D538E;
 Tue, 10 Mar 2020 11:09:15 +0000 (UTC)
Date: Tue, 10 Mar 2020 12:09:12 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH qemu v8 1/3] ppc/spapr: Move GPRs setup to one place
Message-ID: <20200310120912.4cfb3748@bahia.home>
In-Reply-To: <0365dff7-7135-7118-3e12-e07472e9937d@kaod.org>
References: <20200310050733.29805-1-aik@ozlabs.ru>
 <20200310050733.29805-2-aik@ozlabs.ru>
 <0365dff7-7135-7118-3e12-e07472e9937d@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 8458041578523367819
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvtddgvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.140
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 07:41:47 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 3/10/20 6:07 AM, Alexey Kardashevskiy wrote:
> > At the moment "pseries" starts in SLOF which only expects the FDT blob
> > pointer in r3. As we are going to introduce a OpenFirmware support in
> > QEMU, we will be booting OF clients directly and these expect a stack
> > pointer in r1, Linux looks at r3/r4 for the initramdisk location
> > (although vmlinux can find this from the device tree but zImage from
> > distro kernels cannot).
> >=20
> > This extends spapr_cpu_set_entry_state() to take more registers. This
> > should cause no behavioral change.
>=20
> LGTM, one question below.
>=20
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > Changes:
> > v7:
> > * removed r5 as it points to prom entry which is now provided by
> > a new firmware in later patches
> > ---
> >  include/hw/ppc/spapr_cpu_core.h | 4 +++-
> >  hw/ppc/spapr.c                  | 2 +-
> >  hw/ppc/spapr_cpu_core.c         | 6 +++++-
> >  hw/ppc/spapr_rtas.c             | 2 +-
> >  4 files changed, 10 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu=
_core.h
> > index 1c4cc6559c52..7aed8f555b4f 100644
> > --- a/include/hw/ppc/spapr_cpu_core.h
> > +++ b/include/hw/ppc/spapr_cpu_core.h
> > @@ -40,7 +40,9 @@ typedef struct SpaprCpuCoreClass {
> >  } SpaprCpuCoreClass;
> > =20
> >  const char *spapr_get_cpu_core_type(const char *cpu_type);
> > -void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, targ=
et_ulong r3);
> > +void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
> > +                               target_ulong r1, target_ulong r3,
> > +                               target_ulong r4);
> > =20
> >  typedef struct SpaprCpuState {
> >      uint64_t vpa_addr;
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 2eb0d8f70de6..64bc8b83e91e 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1698,7 +1698,7 @@ static void spapr_machine_reset(MachineState *mac=
hine)
> >      spapr->fdt_blob =3D fdt;
> > =20
> >      /* Set up the entry state */
> > -    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, fdt_ad=
dr);
> > +    spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT, 0, fdt=
_addr, 0);
> >      first_ppc_cpu->env.gpr[5] =3D 0;
>=20
>=20
> Why is this done in the machine reset handler and not in the CPU reset=20
> handler ?=20
>=20

Because spapr_cpu_set_entry_state() starts the CPU. The machine code is
responsible to start the boot CPU (first_ppc_cpu) at system reset, other
CPUs will be started by the guest with the "start-cpu" RTAS call.

> C.=20
>=20
>=20
> >      spapr->cas_reboot =3D false;
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 36ed3a2b665b..ac1c10942771 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -76,13 +76,17 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
> >      spapr_irq_cpu_intc_reset(spapr, cpu);
> >  }
> > =20
> > -void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, targ=
et_ulong r3)
> > +void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip,
> > +                               target_ulong r1, target_ulong r3,
> > +                               target_ulong r4)
> >  {
> >      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> >      CPUPPCState *env =3D &cpu->env;
> > =20
> >      env->nip =3D nip;
> > +    env->gpr[1] =3D r1;
> >      env->gpr[3] =3D r3;
> > +    env->gpr[4] =3D r4;
> >      kvmppc_set_reg_ppc_online(cpu, 1);
> >      CPU(cpu)->halted =3D 0;
> >      /* Enable Power-saving mode Exit Cause exceptions */
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index 656fdd221665..fe83b50c6629 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -190,7 +190,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, Spa=
prMachineState *spapr,
> >       */
> >      newcpu->env.tb_env->tb_offset =3D callcpu->env.tb_env->tb_offset;
> > =20
> > -    spapr_cpu_set_entry_state(newcpu, start, r3);
> > +    spapr_cpu_set_entry_state(newcpu, start, 0, r3, 0);
> > =20
> >      qemu_cpu_kick(CPU(newcpu));
> > =20
> >=20
>=20
>=20


