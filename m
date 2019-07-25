Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32913C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7D4206BF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WLpnDttT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7D4206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hquh2-0005d4-PD
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 03:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37589)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hqufa-0000dI-R4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hqufX-00052T-1Q
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 03:29:36 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:58407)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hqufV-0004YO-ML; Fri, 26 Jul 2019 03:29:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45w11J2VR1z9sLt; Fri, 26 Jul 2019 17:29:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1564126164;
 bh=nfZJi7O1wINOim8jTSMpkpYki+r5BOAXW1ykalUgiN4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WLpnDttT/fRPANG+91uGagM+fha55+g+p6btDQIHVoDjL0X6Ec4/vg2RYwMR9db4J
 5JpnBleaHP7SghqWTwQzIxbSLTixJJz+dv30opi1tUnJVZ28EcWbWQhuwZE1L6ZsL2
 ZGrvvaJXIqWRWE1CbaYE6y0DPRDtluSM2+P21uI8=
Date: Thu, 25 Jul 2019 13:34:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190725033444.GD28601@umbus>
References: <156397239821.79647.2790800099666109879.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
In-Reply-To: <156397239821.79647.2790800099666109879.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v6] ppc: remove idle_timer logic
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2019 at 07:47:45AM -0500, Shivaprasad G Bhat wrote:
> The KVM_CAP_PPC_IRQ_LEVEL is part of the kernel now since 2.6.37.
> Drop the redundant logic which is not excercised on new the kernels anymo=
re.
> Exit with error on older kernels.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Applied, although..

> ---
>  v5: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg05301.html
>  Changes from v5:
>    - exit with error if KVM_CAP_PPC_IRQ_LEVEL is not there.
>=20
>  target/ppc/kvm.c |   75 ++++--------------------------------------------=
------
>  1 file changed, 5 insertions(+), 70 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8a06d3171e..4a3f36f0d5 100644
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
> +        fprintf(stderr, "KVM: Host kernel doesn't have level irq capabil=
ity\n");


=2E. I've changed this to an error_report() instead of a raw fprintf.

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

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl05I1QACgkQbDjKyiDZ
s5Kygg//XtSQpTBDAQm3ZVBzoIvNantn4Q+0zUd81fPIGJo1ILN5cBn1frOg4s91
CA1KtJrmtuwmDsxU+QF1E6cFtULnZu8wPN82IHHm6KjiVsGVW24uuEJalvZtxoKq
kTS5vldbKx6KSpJq3b5G+ORwwx5BHJLcw+y31KD+8W6/ZFAHDCSmRfFQhrP7v6pq
GLxPcHaRzkE1Noz+b1rX76RY45xRhrxGaS+Fw+odNw0C3dtviYmw4OhzEY16uUN4
+H4aNjoUB9De7m8gFn3kFimO5EiqvmKSABpkFlnz7TFKB35/x5ID/BrcfxW6I2gI
jsmOJIIrLK1k6bfzqzbGiBCXxbmnNW6yjaMkrJbllyaiqjYRn8mZRfLTggWUqUMB
fZbHU+Vr/e5WTNfnpMmGPtISM/Zz9iI5U+N2EWvQLEA2lOnhSYSZ74I0WCtn+FYz
MWjgybieEHkG5Cg9MOafBfEXMkQ6TKeodpXj2Noy0GN96vCJRErhAQCIDKwskoIe
KnDQV9dd9kfD98vjXBMf2xcSHK6V6I0HnVr8S3M7K8qXbqvDXOEMQx6wky99UFTb
+mcEIYXleO0u2DBk+3R4+4fSiQC6DOr+Xltt3+fMKR281/LexS8/OACA/HdCBWbo
fBt9IPrUAx8udo/Y6UU12wXTuygQdePu31nKrp5HlIotNL3ZnTU=
=/3/B
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--

