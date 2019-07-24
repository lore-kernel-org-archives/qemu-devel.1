Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D53EC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3B5229FA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 09:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z4p/V18B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3B5229FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqDJg-0007b1-Jv
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 05:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hqDJL-0006SM-9q
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hqDJJ-0005QT-QK
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 05:11:47 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:37639 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hqDJH-0005JL-DJ; Wed, 24 Jul 2019 05:11:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45tqN54stKz9sBZ; Wed, 24 Jul 2019 19:11:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563959493;
 bh=92HWcZORDfbkP27pWiKi5mvpP6gj0X6yUhBb0vrQ904=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z4p/V18BEN25EZ9SzXfQXvk0DrF/322Pa0rXDqzjz7lXzFGEbT7WrfkcurjWxvNSD
 CJ5GK5/BUHCsa3t111nLbtAxkc8Dh1olCN0I54G4GgpJwo2XOfbFpk/d29BJTAK1Ff
 y8h6F7NLULwgkCcD6OEsBlgfFxXez1QYcp06IlC0=
Date: Wed, 24 Jul 2019 18:56:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190724085650.GW25073@umbus.fritz.box>
References: <156395684219.48058.9459603098282979575.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lQcP9vuZCkvmDKre"
Content-Disposition: inline
In-Reply-To: <156395684219.48058.9459603098282979575.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v5] ppc: remove the idle_timer logic
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


--lQcP9vuZCkvmDKre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2019 at 03:28:28AM -0500, Shivaprasad G Bhat wrote:
> The KVM_CAP_PPC_IRQ_LEVEL is part of the kernel now since 2.6.37.
> Drop the redundant logic which is not excercised on new the kernels anymo=
re.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

I don't think we want to support such ancient kernels any more, but it
would be good to print a useful error message just in case someoone
does.  So I'd suggest..

> ---
>  v4: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04456.html
>  Changes from v4:
>    - it was discussed to drop the idle_timer logic instead of fixing the
>      leak and keeping the redundant logic around. So, the patch does that.
>=20
>  target/ppc/kvm.c |   74 +-----------------------------------------------=
------
>  1 file changed, 2 insertions(+), 72 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8a06d3171e..1c8f2319a0 100644
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
> @@ -161,11 +140,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       */
>      cap_ppc_pvr_compat =3D false;
> =20
> -    if (!cap_interrupt_level) {
> -        fprintf(stderr, "KVM: Couldn't find level irq capability. Expect=
 the "
> -                        "VM to stall at times!\n");
> -    }
> -

=2E.changing this to print such an error and exit(1) if the extension
isn't found.

>      kvm_ppc_register_host_cpu_type(ms);
> =20
>      return 0;
> @@ -491,8 +465,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return ret;
>      }
> =20
> -    idle_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
> -
>      switch (cenv->mmu_model) {
>      case POWERPC_MMU_BOOKE206:
>          /* This target supports access to KVM's guest TLB */
> @@ -1332,7 +1304,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, =
int level)
>          return 0;
>      }
> =20
> -    if (!kvm_enabled() || !cap_interrupt_unset || !cap_interrupt_level) {
> +    if (!kvm_enabled() || !cap_interrupt_unset) {
>          return 0;
>      }
> =20
> @@ -1349,49 +1321,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq,=
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

--lQcP9vuZCkvmDKre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl04HVAACgkQbDjKyiDZ
s5K/hw/9HI4sFDJ2P98UwCswL+zgnpl2jQblul4Fc2az5L4JfpOFW6BfMzmSUTqJ
gpVrq5MKs7r/sEAaaZxHG2tDeqiM38MsDusGkAmN16fjL2pmxf7iJquzPouftpIf
TmEzogAQouUAth6tKbLTEbuXifIMX4YOkJd6Yk27kpDbFR6OSRKgi9HY086QJmDi
vRKd0BqTR0cbMPhCdHfdjHYgqytoDytpwVM7M+r36r4e8AbXxMJ7umZ/B5KH4PIo
kLa0M67cWUfxqZdY/JCncTK0hi9ai8K5ziKSf7kbXUv+eunfeGD6iVNmgfMbi23L
8uC2fXcCLYRFIwug5SUN5wBXO+zTogm8kV4MXh03vShdXJY9+I7YOLZf7YqblgMS
QbCRkoOgTy9pUX9JcMCM3y62h+AncWA2hA5SnKZjJu6HTu1j987ZNUiwo7q3SDOZ
DXHVaUuLwgZ4RKhPdm1J0eG0A1d0LpqoOruHcKQ/GmLpo8Ho3mODVqfC9V1x9ZNx
03EHN4fqq0MODgqe9i4IjJ7/C0g7MVzCAHnxyPoHV5H5pBlXP3uwlB3Kp22sUpZI
yx2AmNeonz7Jrb40C354J0rSpi2ElWoFi1VL2S3tq19c1E5vjHgwPziOaR8ctXL2
prkOPRHAvO0KUKnrku4cS3Di9UhnBGfdEXoB9o6cZhn+F2eh0a0=
=khKn
-----END PGP SIGNATURE-----

--lQcP9vuZCkvmDKre--

