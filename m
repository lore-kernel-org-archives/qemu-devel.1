Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADD5C04AB3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF68217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF68217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6cd-0007dG-QR
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:35:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hP6bF-0006TH-9N
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hP6bD-0005sC-Nw
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:34:13 -0400
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:57898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hP6bD-0005ob-Ho
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:34:11 -0400
Received: from player797.ha.ovh.net (unknown [10.109.143.225])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 90CB41E83EB
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 16:34:01 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
	(Authenticated sender: groug@kaod.org)
	by player797.ha.ovh.net (Postfix) with ESMTPSA id 6E0CC5BB60E1;
	Fri, 10 May 2019 14:33:52 +0000 (UTC)
Date: Fri, 10 May 2019 16:33:50 +0200
From: Greg Kurz <groug@kaod.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190510163350.58cc85b9@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190510110604.67c0d18d@bahia.lan>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591657807.20338.12115795588476734752.stgit@aravinda>
	<20190510110604.67c0d18d@bahia.lan>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10077085643900492180
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkeekgdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.41.16
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 1/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 11:06:04 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Mon, 22 Apr 2019 12:32:58 +0530
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> 
> > This patch adds support in QEMU to handle "ibm,nmi-register"
> > and "ibm,nmi-interlock" RTAS calls.
> > 
> > The machine check notification address is saved when the
> > OS issues "ibm,nmi-register" RTAS call.
> > 
> > This patch also handles the case when multiple processors
> > experience machine check at or about the same time by
> > handling "ibm,nmi-interlock" call. In such cases, as per
> > PAPR, subsequent processors serialize waiting for the first
> > processor to issue the "ibm,nmi-interlock" call. The second
> > processor that also received a machine check error waits
> > till the first processor is done reading the error log.
> > The first processor issues "ibm,nmi-interlock" call
> > when the error log is consumed. This patch implements the
> > releasing part of the error-log while subsequent patch
> > (which builds error log) handles the locking part.
> > 
> > Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> > ---
> >  hw/ppc/spapr.c         |   18 ++++++++++++++
> >  hw/ppc/spapr_rtas.c    |   61 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/hw/ppc/spapr.h |    9 ++++++-
> >  3 files changed, 87 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index c56939a..6642cb5 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1805,6 +1805,11 @@ static void spapr_machine_reset(void)
> >      first_ppc_cpu->env.gpr[5] = 0;
> >  
> >      spapr->cas_reboot = false;
> > +
> > +    spapr->guest_machine_check_addr = -1;
> > +
> > +    /* Signal all vCPUs waiting on this condition */
> > +    qemu_cond_broadcast(&spapr->mc_delivery_cond);
> >  }
> >  
> >  static void spapr_create_nvram(SpaprMachineState *spapr)
> > @@ -2095,6 +2100,16 @@ static const VMStateDescription vmstate_spapr_dtb = {
> >      },
> >  };
> >  
> > +static const VMStateDescription vmstate_spapr_machine_check = {
> > +    .name = "spapr_machine_check",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),

Also this should use VMSTATE_UINTTL()

> > +        VMSTATE_END_OF_LIST()
> > +    },  
> 
> This VMState descriptor is missing a .needed field because we only want
> to migrate the subsection if the guest has called NMI register, ie.
> spapr->guest_machine_check_addr != (target_ulong) -1.
> 
> > +};
> > +
> >  static const VMStateDescription vmstate_spapr = {765cf442a8afe8e5c8c6896b5072066df5129077
> >      .name = "spapr",
> >      .version_id = 3,
> > @@ -2127,6 +2142,7 @@ static const VMStateDescription vmstate_spapr = {
> >          &vmstate_spapr_dtb,
> >          &vmstate_spapr_cap_large_decr,
> >          &vmstate_spapr_cap_ccf_assist,
> > +        &vmstate_spapr_machine_check,
> >          NULL
> >      }
> >  };
> > @@ -3068,6 +3084,8 @@ static void spapr_machine_init(MachineState *machine)
> >  
> >          kvmppc_spapr_enable_inkernel_multitce();
> >      }
> > +
> > +    qemu_cond_init(&spapr->mc_delivery_cond);
> >  }
> >  
> >  static int spapr_kvm_type(MachineState *machine, const char *vm_type)
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index ee24212..c2f3991 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -348,6 +348,39 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
> >      rtas_st(rets, 1, 100);
> >  }
> >  
> > +static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
> > +                                  SpaprMachineState *spapr,
> > +                                  uint32_t token, uint32_t nargs,
> > +                                  target_ulong args,
> > +                                  uint32_t nret, target_ulong rets)
> > +{
> > +    uint64_t rtas_addr = spapr_get_rtas_addr();
> > +
> > +    if (!rtas_addr) {
> > +        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
> > +        return;
> > +    }
> > +
> > +    spapr->guest_machine_check_addr = rtas_ld(args, 1);
> > +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > +}
> > +
> > +static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
> > +                                   SpaprMachineState *spapr,
> > +                                   uint32_t token, uint32_t nargs,
> > +                                   target_ulong args,
> > +                                   uint32_t nret, target_ulong rets)
> > +{
> > +    if (!spapr->guest_machine_check_addr) {  
> 
> Hmm... the default value is -1. It looks like the check should rather be:
> 
>     if (spapr->guest_machine_check_addr == (target_ulong) -1) {
> 
> 
> > +        /* NMI register not called */
> > +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > +    } else {
> > +        qemu_cond_signal(&spapr->mc_delivery_cond);
> > +        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > +    }
> > +}
> > +
> > +
> >  static struct rtas_call {
> >      const char *name;
> >      spapr_rtas_fn fn;
> > @@ -466,6 +499,30 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr)
> >      }
> >  }
> >  
> > +uint64_t spapr_get_rtas_addr(void)  
> 
> Shouldn't this be hwaddr instead of uint64_t ?
> 
> > +{
> > +    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> > +    int rtas_node;
> > +    const struct fdt_property *rtas_addr_prop;
> > +    void *fdt = spapr->fdt_blob;
> > +    uint32_t rtas_addr;
> > +
> > +    /* fetch rtas addr from fdt */
> > +    rtas_node = fdt_path_offset(fdt, "/rtas");
> > +    if (rtas_node == 0) {
> > +        return 0;
> > +    }
> > +
> > +    rtas_addr_prop = fdt_get_property(fdt, rtas_node, "linux,rtas-base", NULL);
> > +    if (!rtas_addr_prop) {  
> 
> Just for curiosity: this is ok for linux, but what about other OSes (eg. AIX) ?
> 
> > +        return 0;
> > +    }
> > +
> > +    rtas_addr = fdt32_to_cpu(*(uint32_t *)rtas_addr_prop->data);  
> 
> Also this assumes the OS called RTAS instantiate-rtas, but some other
> OS might have called RTAS instantiate-rtas-64 instead. I guess it is
> ok for now because SLOF only provides the 32-bit variant, but a
> comment would certainly help IMHO.
> 
> > +    return (uint64_t)rtas_addr;
> > +}
> > +
> > +
> >  static void core_rtas_register_types(void)
> >  {
> >      spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
> > @@ -489,6 +546,10 @@ static void core_rtas_register_types(void)
> >                          rtas_set_power_level);
> >      spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
> >                          rtas_get_power_level);
> > +    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
> > +                        rtas_ibm_nmi_register);
> > +    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
> > +                        rtas_ibm_nmi_interlock);
> >  }
> >  
> >  type_init(core_rtas_register_types)
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 7e32f30..ec6f33e 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -187,6 +187,10 @@ struct SpaprMachineState {
> >       * occurs during the unplug process. */
> >      QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
> >  
> > +    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
> > +    target_ulong guest_machine_check_addr;
> > +    QemuCond mc_delivery_cond;
> > +
> >      /*< public >*/
> >      char *kvm_type;
> >      char *host_model;
> > @@ -623,8 +627,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
> >  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
> >  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
> >  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
> > +#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
> > +#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
> >  
> > -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
> > +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
> >  
> >  /* RTAS ibm,get-system-parameter token values */
> >  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
> > @@ -874,4 +880,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
> >  #define SPAPR_OV5_XIVE_BOTH     0x80 /* Only to advertise on the platform */
> >  
> >  void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
> > +uint64_t spapr_get_rtas_addr(void);
> >  #endif /* HW_SPAPR_H */
> > 
> >   
> 
> 


