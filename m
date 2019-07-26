Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499C0C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFCC216C8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 08:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BffoA7/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFCC216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqvdF-0004BU-2w
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 04:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34146)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hqvcV-0002HD-7a
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hqvcS-0001IU-BB
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 04:30:29 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hqvcM-0000vY-AR; Fri, 26 Jul 2019 04:30:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45w2MT5yDJz9s4Y; Fri, 26 Jul 2019 18:30:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564129813;
 bh=tYS/8sV48OjtUa7/ahOf1Z0vXCj3GYrNGs50+0OE21E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BffoA7/WIR8aRwDlNe/AO5UkupBtaxmEyRnAYvQ8FA9737qP+qw6ye1yrf/hlRy3W
 H256eksU/415BLGwn+EmT9qS1J23V15f9sImGgycAqa5Xn37FkliisxQ33AjU7pGV1
 8GffY9/uBAkw3auaQvRoYZ2QvwRB8w4C2Y8OX/1o=
Date: Fri, 26 Jul 2019 18:01:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190726080107.GH28601@umbus>
References: <156406409479.19996.7606556689856621111.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dMyqICaxQaaUjrCL"
Content-Disposition: inline
In-Reply-To: <156406409479.19996.7606556689856621111.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v7] ppc: remove idle_timer logic
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dMyqICaxQaaUjrCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 09:15:08AM -0500, Shivaprasad G Bhat wrote:
> The logic is broken for multiple vcpu guests, also causing memory leak.
> The logic is in place to handle kvm not having KVM_CAP_PPC_IRQ_LEVEL,
> which is part of the kernel now since 2.6.37. Instead of fixing the
> leak, drop the redundant logic which is not excercised on new kernels
> anymore. Exit with error on older kernels.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Applied to ppc-for-4.2.

> ---
> v6: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg05378.html
> Changes from v6:
>    - switched to error_report instead of fprintf
> ---
>  target/ppc/kvm.c |   75 ++++--------------------------------------------=
------
>  1 file changed, 5 insertions(+), 70 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8a06d3171e..5ab5e6c6a9 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -56,7 +56,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[=
] =3D {
>  };
> =20
>  static int cap_interrupt_unset;
> -static int cap_interrupt_level;
>  static int cap_segstate;
>  static int cap_booke_sregs;
>  static int cap_ppc_smt;
> @@ -87,25 +86,6 @@ static int cap_large_decr;
> =20
>  static uint32_t debug_inst_opcode;
> =20
> -/*
> - * XXX We have a race condition where we actually have a level triggered
> - *     interrupt, but the infrastructure can't expose that yet, so the g=
uest
> - *     takes but ignores it, goes to sleep and never gets notified that =
there's
> - *     still an interrupt pending.
> - *
> - *     As a quick workaround, let's just wake up again 20 ms after we in=
jected
> - *     an interrupt. That way we can assure that we're always reinjecting
> - *     interrupts in case the guest swallowed them.
> - */
> -static QEMUTimer *idle_timer;
> -
> -static void kvm_kick_cpu(void *opaque)
> -{
> -    PowerPCCPU *cpu =3D opaque;
> -
> -    qemu_cpu_kick(CPU(cpu));
> -}
> -
>  /*
>   * Check whether we are running with KVM-PR (instead of KVM-HV).  This
>   * should only be used for fallback tests - generally we should use
> @@ -125,7 +105,6 @@ static int kvmppc_get_dec_bits(void);
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      cap_interrupt_unset =3D kvm_check_extension(s, KVM_CAP_PPC_UNSET_IRQ=
);
> -    cap_interrupt_level =3D kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL=
);
>      cap_segstate =3D kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
>      cap_booke_sregs =3D kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS);
>      cap_ppc_smt_possible =3D kvm_vm_check_extension(s, KVM_CAP_PPC_SMT_P=
OSSIBLE);
> @@ -161,9 +140,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       */
>      cap_ppc_pvr_compat =3D false;
> =20
> -    if (!cap_interrupt_level) {
> -        fprintf(stderr, "KVM: Couldn't find level irq capability. Expect=
 the "
> -                        "VM to stall at times!\n");
> +    if (!kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL)) {
> +        error_report("KVM: Host kernel doesn't have level irq capability=
");
> +        exit(1);
>      }
> =20
>      kvm_ppc_register_host_cpu_type(ms);
> @@ -491,8 +470,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return ret;
>      }
> =20
> -    idle_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
> -
>      switch (cenv->mmu_model) {
>      case POWERPC_MMU_BOOKE206:
>          /* This target supports access to KVM's guest TLB */
> @@ -1332,7 +1309,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, =
int level)
>          return 0;
>      }
> =20
> -    if (!kvm_enabled() || !cap_interrupt_unset || !cap_interrupt_level) {
> +    if (!kvm_enabled() || !cap_interrupt_unset) {
>          return 0;
>      }
> =20
> @@ -1349,49 +1326,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq,=
 int level)
> =20
>  void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
>  {
> -    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -    CPUPPCState *env =3D &cpu->env;
> -    int r;
> -    unsigned irq;
> -
> -    qemu_mutex_lock_iothread();
> -
> -    /*
> -     * PowerPC QEMU tracks the various core input pins (interrupt,
> -     * critical interrupt, reset, etc) in PPC-specific
> -     * env->irq_input_state.
> -     */
> -    if (!cap_interrupt_level &&
> -        run->ready_for_interrupt_injection &&
> -        (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
> -        (env->irq_input_state & (1 << PPC_INPUT_INT)))
> -    {
> -        /*
> -         * For now KVM disregards the 'irq' argument. However, in the
> -         * future KVM could cache it in-kernel to avoid a heavyweight
> -         * exit when reading the UIC.
> -         */
> -        irq =3D KVM_INTERRUPT_SET;
> -
> -        trace_kvm_injected_interrupt(irq);
> -        r =3D kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &irq);
> -        if (r < 0) {
> -            printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
> -        }
> -
> -        /* Always wake up soon in case the interrupt was level based */
> -        timer_mod(idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> -                       (NANOSECONDS_PER_SECOND / 50));
> -    }
> -
> -    /*
> -     * We don't know if there are more interrupts pending after
> -     * this. However, the guest will return to userspace in the course
> -     * of handling this one anyways, so we will get a chance to
> -     * deliver the rest.
> -     */
> -
> -    qemu_mutex_unlock_iothread();
> +    return;
>  }
> =20
>  MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dMyqICaxQaaUjrCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl06s0MACgkQbDjKyiDZ
s5JqRw//T9+PAX6W2pJt5EkJz6gEhTjbW70TmZlOn64Q2uX8916xn7Xjzt+ySaeq
dSvyUuwNMq+bnLaekr7fvrzWE8rdZkVbctTc4jHPx+ggPqtT08PB9Z3xICW4JJa9
x2lKniX6lBWtu9tnqX6BbeDlXAnyOlffQv915B4o1bRa4N84fiYPrTLN33SrxfBh
uq4py4zTFLP8yXIz9nbyXiVK3YsYuLmyG7dAgrtlkVtLNHsXIr/WEVCGVBXNPlIV
tkzYH6JiJlYhVX70kZbb7g5/CVL8i4hxR1ftnKypL8lhgVvJwPl77Uk6eCjFxKlJ
8PgPQCoJW0vzPtjbDc2dRh2oz+VPeZAZkCYC48Wl26evOseBmESjsUHFlx3rnMHO
5yYo7hsqqlpMg5b5edPV6Qikd8xd8u40UKtSK30diVog2OJRRtsJpTJdNJgUt41A
UDUgX+2Px7rysvMykO2xNCYxx1srIwUzPDnXGWSuG847L6VqrvDmGHx4bRW2Hnhb
8nV8bX5TjGZWVJ0/L6qHCMa5UWaD1gkOUwaYAd0aN+vU7ppmTGdHYhkCzIBR0jlu
49+gpqO2ZMiuaShHC7p2r2Idy1sH5hFijegFFtX+4mQFMyYaYiFtxhi0iHk0Dc7f
DlwoNN534pchZ+LVcYPjft+UieOLzuh+l0C5YRl0JpZlyzNXCFM=
=T54B
-----END PGP SIGNATURE-----

--dMyqICaxQaaUjrCL--

