Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2FBC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 05:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F3520879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 05:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dESDJXHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F3520879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51511 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ3yZ-0006vZ-Nr
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 01:58:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQ3xN-0006EO-83
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hQ3xL-0003Db-K7
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:57:01 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:37803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hQ3xK-0003CR-U5; Mon, 13 May 2019 01:56:59 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 452VSl5TgLz9sN1; Mon, 13 May 2019 15:56:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557727015;
	bh=bsOZNd8EdmLs5YC2oZ+hk7p7yfXR5TjHxD8ZFX0nUTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dESDJXHDSG8MR6yreMsfEN5SKXNjUabdA7n2X81+5/J2Uxv185428upML+6dx4Zu5
	ONmvYguGSGA+Kf4mctnNHutk3xXzN9E3USv1HhivyrWM3GswXuNzOACv3GUHFBN8wW
	lDFxASoZQXTmprWaIhbIbmjZi6wmvcnBjNwDGppA=
Date: Mon, 13 May 2019 15:56:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190513055600.GC12044@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591659639.20338.6078212293519133016.stgit@aravinda>
	<20190510182541.1c2e81ac@bahia.lab.toulouse-stg.fr.ibm.com>
	<2faeefbb-2628-060f-9bd7-996e1f6a1af6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline
In-Reply-To: <2faeefbb-2628-060f-9bd7-996e1f6a1af6@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: aik@au1.ibm.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2019 at 11:10:28AM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Friday 10 May 2019 09:55 PM, Greg Kurz wrote:
> > On Mon, 22 Apr 2019 12:33:16 +0530
> > Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> >=20
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
> >>          VMSTATE_END_OF_LIST()
> >>      },
> >>  };
> >> @@ -3085,6 +3087,7 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >>          kvmppc_spapr_enable_inkernel_multitce();
> >>      }
> >> =20
> >> +    spapr->mc_status =3D -1;
> >=20
> > Since this is done at reset, do we need it here ?
>=20
> Yes, because we need to initialize this on a fresh boot. I need to
> check, but if spapr_machine_reset() is called every time a system boots

It is.

> then we don't need qemu_cond_init() here as well.
>=20
> >=20
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
> >=20
> > Missing )
>=20
> ok.
>=20
> >=20
> >> +         */
> >> +        if (spapr->mc_status =3D=3D cpu->vcpu_id) {
> >> +            qemu_system_guest_panicked(NULL);
> >=20
> > If we don't also return, is there a chance we end up stuck in
> > qemu_cond_wait_iothread() below ?
>=20
> I think I need to return here
>=20
>=20
> >=20
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
> >=20
> > new blank line at EOF.
>=20
> ok
>=20
> >=20
> >>
> >>
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzZBvAACgkQbDjKyiDZ
s5IbbxAAjw+OChZVRrs3ngZuOO+T0V+9ucqlnPAjdQq9hwqUzWkuNk2ERLl4uQiV
us+F+qOI+SgvnNpKr571vt2t73nkscoTR1ijPyHqQPoTbK6EyR7xxtm6Fta/fvhz
wj5vi/z8VK8KqSgYR0dDw1zWDDrRJR0w+7x60pg9nqaa+rMFtsYCOMqn7mizt50F
oGAdaNCDNVx6OaDeG7dZTfuo63WV3FEUqujLhd6ODSx1wn+vgod5/eVBDomxCNno
aYrJjclhEJIeTFvwbLKabX007LEn4YucvLMoZMGTek0RK719ECyze4vqYCcHKRF9
lXaDldUa3O8d+YAoVfz8mase6Fd3AZHcPy+RH2soB6M8eL9ssgO57n27Opy7oPiY
lesjLbuGSbrqW+29P4Q+SeefV1cZsi63asfVx3eU3chbHV54W6Kbspxp3nRC/0hA
38bLb4XqCSErbqkK5MXEi/EGs98rRzBhSCSFO5wVH7ODndyFVOokZ5V1UshatqGG
Ovp8FxRSw9S96RCLWVvE8lxAgWBElBlgByvG5vu6NDbuMi6o9TirIsfeu09uQ6xw
IiJHBsQ+JADJ9WpiGKmz2Aqb6gheLEy8ZekilT48e0nveuNoZjadfcHrXkO4kr/e
DKKR/HNgIr6pl0SNWeMwoF8Jsgohxpn6vv71MArT+r1YsoKSFPk=
=leRw
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--

