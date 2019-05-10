Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81105C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D922175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WXDjZ9zi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D922175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37933 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOzRE-0006sk-HG
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:55:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOzNz-0004GP-JB
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hOzNw-0005ac-EM
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:52:02 -0400
Received: from ozlabs.org ([203.11.71.1]:35707)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hOzNu-0005Zd-Dv; Fri, 10 May 2019 02:51:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 450gqY47Pwz9sD4; Fri, 10 May 2019 16:51:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557471113;
	bh=eTULiAW7dBRFQ8uvr73mEn08R5/i7kshZAQc7apclbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXDjZ9ziU1GFX80iigk5JZ2mXm+dOKRN8ZzXC6wpM8nTR8hQ4NN0HFB1PWw+eKH6o
	F0R2ALH1e9bA246GIn/ReWZf50HkXfkgExBJ7AOMNhJ0Eu11CmIdWFCxkmprTcX4DJ
	WLVBss1kdW/DEG+BgIbkiskJciAOXwfbco09CMmw=
Date: Fri, 10 May 2019 16:37:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190510063705.GJ20559@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591659639.20338.6078212293519133016.stgit@aravinda>
	<20190423065359.GF31496@umbus.fritz.box>
	<3f8435a4-0435-fb3c-6f67-446e9a090ae0@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
Content-Disposition: inline
In-Reply-To: <3f8435a4-0435-fb3c-6f67-446e9a090ae0@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 3/6] target/ppc: Handle NMI
 guest exit
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
Cc: paulus@ozlabs.org, aik@au1.ibm.com, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 10:20:42AM +0530, Aravinda Prasad wrote:
65;5601;1c>=20
>=20
> On Tuesday 23 April 2019 12:23 PM, David Gibson wrote:
> > On Mon, Apr 22, 2019 at 12:33:16PM +0530, Aravinda Prasad wrote:
> >> Memory error such as bit flips that cannot be corrected
> >> by hardware are passed on to the kernel for handling.
> >> If the memory address in error belongs to guest then
> >> the guest kernel is responsible for taking suitable action.
> >> Patch [1] enhances KVM to exit guest with exit reason
> >> set to KVM_EXIT_NMI in such cases. This patch handles
> >> KVM_EXIT_NMI exit.
> >>
> >> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
> >>     (e20bbd3d and related commits)
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >=20
> > LGTM, apart from one detail noted below.
> >=20
> >> ---
> >>  hw/ppc/spapr.c          |    3 +++
> >>  hw/ppc/spapr_events.c   |   22 ++++++++++++++++++++++
> >>  hw/ppc/spapr_rtas.c     |    5 +++++
> >>  include/hw/ppc/spapr.h  |    6 ++++++
> >>  target/ppc/kvm.c        |   16 ++++++++++++++++
> >>  target/ppc/kvm_ppc.h    |    2 ++
> >>  target/ppc/trace-events |    2 ++
> >>  7 files changed, 56 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 6642cb5..2779efe 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1806,6 +1806,7 @@ static void spapr_machine_reset(void)
> >> =20
> >>      spapr->cas_reboot =3D false;
> >> =20
> >> +    spapr->mc_status =3D -1;
> >>      spapr->guest_machine_check_addr =3D -1;
> >> =20
> >>      /* Signal all vCPUs waiting on this condition */
> >> @@ -2106,6 +2107,7 @@ static const VMStateDescription vmstate_spapr_ma=
chine_check =3D {
> >>      .minimum_version_id =3D 1,
> >>      .fields =3D (VMStateField[]) {
> >>          VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
> >> +        VMSTATE_INT32(mc_status, SpaprMachineState),
> >=20
> > So, technically this is a breaking change to the migration stream.  If
> > this is applied immediately after the earlier patch introducing the
> > subsection it would be ok in practice, but it would still be
> > preferable to make all the migration stream changes together.
>=20
> Do you mean that all .fields entries to vmstate_spapr_machine_check
> should be in a single patch?

Yes, that's preferable.  If necessary you can move the migration
support out into its own patch which goes after the implementation of
the underlying state.

>=20
> Because this patch introduced the variable mc_status, I added it to
> vmstate_spapr_machine_check.
>=20
> Regards,
> Aravinda
>=20
> >=20
> >>          VMSTATE_END_OF_LIST()
> >>      },
> >>  };
> >> @@ -3085,6 +3087,7 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >>          kvmppc_spapr_enable_inkernel_multitce();
> >>      }
> >> =20
> >> +    spapr->mc_status =3D -1;
> >>      qemu_cond_init(&spapr->mc_delivery_cond);
> >>  }
> >> =20
> >> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> >> index ae0f093..9922a23 100644
> >> --- a/hw/ppc/spapr_events.c
> >> +++ b/hw/ppc/spapr_events.c
> >> @@ -620,6 +620,28 @@ void spapr_hotplug_req_remove_by_count_indexed(Sp=
aprDrcType drc_type,
> >>                              RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &=
drc_id);
> >>  }
> >> =20
> >> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
> >> +{
> >> +    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >> +
> >> +    while (spapr->mc_status !=3D -1) {
> >> +        /*
> >> +         * Check whether the same CPU got machine check error
> >> +         * while still handling the mc error (i.e., before
> >> +         * that CPU called "ibm,nmi-interlock"
> >> +         */
> >> +        if (spapr->mc_status =3D=3D cpu->vcpu_id) {
> >> +            qemu_system_guest_panicked(NULL);
> >> +        }
> >> +        qemu_cond_wait_iothread(&spapr->mc_delivery_cond);
> >> +        /* Meanwhile if the system is reset, then just return */
> >> +        if (spapr->guest_machine_check_addr =3D=3D -1) {
> >> +            return;
> >> +        }
> >> +    }
> >> +    spapr->mc_status =3D cpu->vcpu_id;
> >> +}
> >> +
> >>  static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
> >>                              uint32_t token, uint32_t nargs,
> >>                              target_ulong args,
> >> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >> index c2f3991..d3499f9 100644
> >> --- a/hw/ppc/spapr_rtas.c
> >> +++ b/hw/ppc/spapr_rtas.c
> >> @@ -375,6 +375,11 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cp=
u,
> >>          /* NMI register not called */
> >>          rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> >>      } else {
> >> +        /*
> >> +         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
> >> +         * hence unset mc_status.
> >> +         */
> >> +        spapr->mc_status =3D -1;
> >>          qemu_cond_signal(&spapr->mc_delivery_cond);
> >>          rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >>      }
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index ec6f33e..f7204d0 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -189,6 +189,11 @@ struct SpaprMachineState {
> >> =20
> >>      /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" ca=
lls */
> >>      target_ulong guest_machine_check_addr;
> >> +    /*
> >> +     * mc_status is set to -1 if mc is not in progress, else is set t=
o the CPU
> >> +     * handling the mc.
> >> +     */
> >> +    int mc_status;
> >>      QemuCond mc_delivery_cond;
> >> =20
> >>      /*< public >*/
> >> @@ -792,6 +797,7 @@ void spapr_clear_pending_events(SpaprMachineState =
*spapr);
> >>  int spapr_max_server_number(SpaprMachineState *spapr);
> >>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
> >>                        uint64_t pte0, uint64_t pte1);
> >> +void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
> >> =20
> >>  /* DRC callbacks. */
> >>  void spapr_core_release(DeviceState *dev);
> >> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >> index 9e86db0..5eedce8 100644
> >> --- a/target/ppc/kvm.c
> >> +++ b/target/ppc/kvm.c
> >> @@ -1759,6 +1759,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct k=
vm_run *run)
> >>          ret =3D 0;
> >>          break;
> >> =20
> >> +    case KVM_EXIT_NMI:
> >> +        trace_kvm_handle_nmi_exception();
> >> +        ret =3D kvm_handle_nmi(cpu, run);
> >> +        break;
> >> +
> >>      default:
> >>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_re=
ason);
> >>          ret =3D -1;
> >> @@ -2837,6 +2842,17 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
> >>      return data & 0xffff;
> >>  }
> >> =20
> >> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
> >> +{
> >> +    bool recovered =3D run->flags & KVM_RUN_PPC_NMI_DISP_FULLY_RECOV;
> >> +
> >> +    cpu_synchronize_state(CPU(cpu));
> >> +
> >> +    spapr_mce_req_event(cpu, recovered);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>  int kvmppc_enable_hwrng(void)
> >>  {
> >>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC=
_HWRNG)) {
> >> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> >> index 2238513..6edc42f 100644
> >> --- a/target/ppc/kvm_ppc.h
> >> +++ b/target/ppc/kvm_ppc.h
> >> @@ -80,6 +80,8 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void);
> >>  void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
> >>  void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
> >> =20
> >> +int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
> >> +
> >>  #else
> >> =20
> >>  static inline uint32_t kvmppc_get_tbfreq(void)
> >> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
> >> index 7b3cfe1..d5691d2 100644
> >> --- a/target/ppc/trace-events
> >> +++ b/target/ppc/trace-events
> >> @@ -28,3 +28,5 @@ kvm_handle_papr_hcall(void) "handle PAPR hypercall"
> >>  kvm_handle_epr(void) "handle epr"
> >>  kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
> >>  kvm_handle_debug_exception(void) "handle debug exception"
> >> +kvm_handle_nmi_exception(void) "handle NMI exception"
> >> +
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzVHBEACgkQbDjKyiDZ
s5KQVxAA04z/BklbQfJRcOy32GbX8lQZt/gOdSy/eKkdEk2B9mCIX0YqWRBrkcQB
pgzM+NiKwJUaFAqkTp5cVmzcjBeSKXNnDsgXEzPKEwg9eieUwo5kwQUR4TSy3+xt
XAo3McgFrryhOLr2+sRtz0C52+swYdhe+tON+9c64JiRz02YNCn7IR3ID7I/Mhd6
pj6z2uBoihWd3YgJRhGHp+U3Up3yJmaOWFMJwXRCJ5k/XrrThLHmhUOnFIVUEG4E
wj0pBNKKuox72vQXBfd+Z6znVA/kCFhcbpmcbqupL2l1RjV6TSJ4UIxaySHwIyOR
mFVDhMxOkYFFW5VVJfrfXCzfSL2fyUSgfEZ+8dJHSgXHN9MWYBenO0v72Fig9xtU
InCRvdwTkGXJ2KIMmzdCghOmLkYwHAoOjYZfsrZoVyon6wrcQgxFNSgVyj8hBezf
EvFJ3tKrUn9c4C5kidDfQBgu6QnUZhOUoJBzzPwHVxI88x8I6fVNY8gb6XMwjnXB
INqnibsT0kJQB+KM8P8zBWcy5rQnQXX+tFzg0BQ8gbTXc0RcwMenw5fMYTRLWZ4U
sN+ozT8VeB/w94O12PUgIQQMmxxVuhjoecStiWJStGn6qGS5BhMPjaVJn9VWynr1
WF/r62KVtx9e/09kxxD4DQMKVOM7KglfSLnCjxr63zWYwwIOqsU=
=7yHs
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--

