Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED92C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E73A2190F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FwmBrqw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E73A2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpW1H-00060a-4E
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40879)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW0C-0001Yz-CI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hpW0A-0007Y6-SM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:57:08 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52383)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hpW0A-0007TY-4P; Mon, 22 Jul 2019 06:57:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45sdpg4D3xz9sMr; Mon, 22 Jul 2019 20:56:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563793019;
 bh=UMwEnAbgMQypAm28tuilIPRkZKJGuIjAUcFyRi+fnFg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FwmBrqw1Vl8kp3Mgxw4JGzGUkKrSgtrlvFadnU/XcN9BFYjjkDRdmfa/l+GGx21gw
 yvTqFxiyX5LYPh9DwIDlC2FzBe5LFB/FIsstMl3wCAIVRKE7BhdOh9ZjDq6y5D1Id+
 Je0fzmgIn1h0IvzF1Eq2ISTmBkGC9rS+4Ps4qq2M=
Date: Mon, 22 Jul 2019 18:44:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <20190722084424.GH25073@umbus.fritz.box>
References: <156352619712.50279.1247507600735238783.stgit@lep8c.aus.stglabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QDd5rp1wjxlDmy9q"
Content-Disposition: inline
In-Reply-To: <156352619712.50279.1247507600735238783.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v4] ppc: make idle_timer a per-cpu variable
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


--QDd5rp1wjxlDmy9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 03:51:26AM -0500, Shivaprasad G Bhat wrote:
> The current code is broken for more than vcpu as
> each thread would overwrite idle_timer and there were
> memory leaks.
>=20
> Make it part of PowerPCCPU so that every thread has a
> separate one. Avoid using the timer_new_ns which is
> not the preferred way to create timers.
>=20
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>

So, this looks correct, but..

=2E.the whole idle_timer logic is used only in the case that we're
running with a KVM that doesn't support KVM_CAP_PPC_IRQ_LEVEL.  That
support appears to have been in since around v2.6.36 some 9 years
ago.  We could probably just drop support for such old kernels in qemu
instead.

> ---
>  v3: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04375.html
>  Changes from v3:
>     - Calling timer_del() before timer_deinit()
>=20
>  target/ppc/cpu.h |    1 +
>  target/ppc/kvm.c |   32 +++++++++++++++++---------------
>  2 files changed, 18 insertions(+), 15 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c9beba2a5c..521086d91a 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1190,6 +1190,7 @@ struct PowerPCCPU {
>      void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
> +    QEMUTimer idle_timer;
> =20
>      /* Fields related to migration compatibility hacks */
>      bool pre_2_8_migration;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8a06d3171e..52d3292f45 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -87,18 +87,6 @@ static int cap_large_decr;
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
>  static void kvm_kick_cpu(void *opaque)
>  {
>      PowerPCCPU *cpu =3D opaque;
> @@ -491,7 +479,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          return ret;
>      }
> =20
> -    idle_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
> +    timer_init_ns(&cpu->idle_timer, QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cp=
u);
> =20
>      switch (cenv->mmu_model) {
>      case POWERPC_MMU_BOOKE206:
> @@ -523,6 +511,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
> =20
>  int kvm_arch_destroy_vcpu(CPUState *cs)
>  {
> +    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +    timer_del(&cpu->idle_timer);
> +    timer_deinit(&cpu->idle_timer);
> +
>      return 0;
>  }
> =20
> @@ -1379,8 +1372,17 @@ void kvm_arch_pre_run(CPUState *cs, struct kvm_run=
 *run)
>              printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
>          }
> =20
> -        /* Always wake up soon in case the interrupt was level based */
> -        timer_mod(idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +        /*
> +         * XXX We have a race condition where we actually have a level
> +         *     triggered interrupt, but the infrastructure can't expose =
that
> +         *     yet, so the guest takes but ignores it, goes to sleep and
> +         *     never gets notified that there's still an interrupt pendi=
ng.
> +         *
> +         *     As a quick workaround, let's just wake up again 20 ms aft=
er
> +         *     we injected an interrupt. That way we can assure that we'=
re
> +         *     always reinjecting interrupts in case the guest swallowed=
 them.
> +         */
> +        timer_mod(&cpu->idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
) +
>                         (NANOSECONDS_PER_SECOND / 50));
>      }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QDd5rp1wjxlDmy9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl01d2gACgkQbDjKyiDZ
s5K4JxAAn/DN9zRQ5I1uDeud4OeGaBXEPLay/Fhx+sSDPw3YOoFnG+rs3hF4cVRD
KLGtegTU2TuKzlbfUJPJrrj/4RyJ667vnpW1KZyY4ZNSJKkCznE0ELg432eacNFZ
5LpUTeszXuArzHb3m7+GyaoUmowfOjh8QLyV9Cnri0QI91B5iRRrXwwCy5Nb+3NF
oif5ckjlOiG5Pb3hLoFICk+zl7ftvpKYShC4rQsZZsChapNjYtaa5ryouAuEH4tC
+DMLGdtRFKCWgd28+wMhS/PnEWXyLRivlJLcSZcGCG2Qq2X8gzRtSkdGaE3aCNj9
4K2GSo3LLwj9yMNy7weeBLbPr8d/9Faqye9jlUP+o/HJqlHQgAe67OQvMZ5xSP9e
7ye/FyExUrUg2yHHnwnq4ixpL3g22ccMFDGiJzA2dZP0pMC6V0MaSUlWUhIBMXCN
38s4Vn0q8V/4wv8LpfifAIWKNjRUPnH2G3l6/KVbqO/aKuhFB6yA5e8y5bFvbIKY
rb8OeR3Pej9SZnaFOH2/IcikTSn4cFnC9iow4mLtLdJszPNDZQQ7CDWSX8L7PWMK
L4l8snUbEpFPhEelZzMHkSiZcLcwqszK3lqt03ESBoq1rDjquX3XVRzDimbs5UD9
PInQvAGEehbY29teAbwXWyDWMb+/l5pzXjFlLPXXhSWVj0WlYl4=
=pZNU
-----END PGP SIGNATURE-----

--QDd5rp1wjxlDmy9q--

