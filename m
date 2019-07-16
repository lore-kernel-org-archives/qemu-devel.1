Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1EBC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 06:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92CB206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 06:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nHpHwf5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92CB206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnH7f-0004cI-2x
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 02:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60665)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnH7S-000479-Bl
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 02:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnH7P-0003RD-V9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 02:39:22 -0400
Received: from ozlabs.org ([203.11.71.1]:58339)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnH7N-0003Kx-MV; Tue, 16 Jul 2019 02:39:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45nrMv18xZz9sNC; Tue, 16 Jul 2019 16:39:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563259147;
 bh=YE4vbUav9e71hcb1ZI/pEkOKYliaKPnBx9Jo3PHjUYI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nHpHwf5p6KBs00ZnY3Tam+MaUISSevcUU8fIJJ+MWWba5X8nsxfKHH74IHb8Evzol
 5miQ03muma2YzH8pUlW+gvgQikJ54iibCZokJpDlwIAHr2eW81ycwlEv8ce2AzqkEH
 zCq9yibMn+u7JHSoSIa3UG/mha8iru8Jjyl8ETSQ=
Date: Tue, 16 Jul 2019 14:48:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jose Ricardo Ziviani <joserz@linux.ibm.com>
Message-ID: <20190716044833.GB7525@umbus.fritz.box>
References: <20190716040253.23490-1-joserz@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20190716040253.23490-1-joserz@linux.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] ppc: Improve SMT experience with TCG accel
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


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2019 at 01:02:53AM -0300, Jose Ricardo Ziviani wrote:
> It's not possible to specify the number of threads of a guest when
> running QEMU/TCG. Today, users can have setups like:
>=20
> ... -accel tcg,thread=3Dmulti -smp 8,threads=3D1,cores=3D8 ...
> or
> ... -accel tcg,thread=3Dmulti -smp 8,sockets=3D2,cores=3D4,threads=3D1 ...
>=20
> However, the following is not possible:
>=20
> ... -accel tcg,thread=3Dmulti -smp 16,threads=3D4,cores=3D2,sockets=3D2 .=
=2E.
> qemu-system-ppc64: TCG cannot support more than 1 thread/core on a pserie=
s machine
>=20
> The reason is due to how SMT is implemented since Power8. This patch
> implements a very basic simulation of the msgsndp instruction, using ext
> interrupt instead of doorbells. The result is a better user experience,
> allowing them to play with SMT modes. However, it doesn't relate with
> MTTCG threads in any way.

This really isn't enough.

POWER also has a number of SPRs which are per-core rather than
per-thread, but currently TCG treats everything as per-thread.  You'd
need to properly implement per-core registers before you can advertise
support for multiple threads in TCG.

>=20
> Results:
> ... -accel tcg,thread=3Dmulti -smp 16,threads=3D4,cores=3D2,sockets=3D2 .=
=2E.
>=20
> root@ubuntu:~# ppc64_cpu --smt
> SMT=3D4
> root@ubuntu:~# ppc64_cpu --info
> Core   0:    0*    1*    2*    3*
> Core   1:    4*    5*    6*    7*
> Core   2:    8*    9*   10*   11*
> Core   3:   12*   13*   14*   15*
> root@ubuntu:~# ppc64_cpu --smt=3D2
> root@ubuntu:~# ppc64_cpu --info
> Core   0:    0*    1*    2     3
> Core   1:    4*    5*    6     7
> Core   2:    8*    9*   10    11
> Core   3:   12*   13*   14    15
> root@ubuntu:~# ppc64_cpu --smt=3Doff
> root@ubuntu:~# ppc64_cpu --info
> Core   0:    0*    1     2     3
> Core   1:    4*    5     6     7
> Core   2:    8*    9    10    11
> Core   3:   12*   13    14    15
>=20
> root@ubuntu:~# ppc64_cpu --smt
> SMT is off
> root@ubuntu:~# lscpu
> Architecture:         ppc64le
> Byte Order:           Little Endian
> CPU(s):               16
> On-line CPU(s) list:  0,4,8,12
> Off-line CPU(s) list: 1-3,5-7,9-11,13-15
> Thread(s) per core:   1
> Core(s) per socket:   2
> Socket(s):            2
> NUMA node(s):         1
> Model:                2.0 (pvr 004e 1200)
> Model name:           POWER9 (architected), altivec supported
> Hypervisor vendor:    KVM
> Virtualization type:  para
> L1d cache:            32K
> L1i cache:            32K
> NUMA node0 CPU(s):    0,4,8,12
>=20
> root@ubuntu:~# ppc64_cpu --smt=3D4
> root@ubuntu:~# lscpu
> Architecture:        ppc64le
> Byte Order:          Little Endian
> CPU(s):              16
> On-line CPU(s) list: 0-15
> Thread(s) per core:  4
> Core(s) per socket:  2
> Socket(s):           2
> NUMA node(s):        1
> Model:               2.0 (pvr 004e 1200)
> Model name:          POWER9 (architected), altivec supported
> Hypervisor vendor:   KVM
> Virtualization type: para
> L1d cache:           32K
> L1i cache:           32K
> NUMA node0 CPU(s):   0-15
>=20
> Note: it's also possible to simulate SMT in TCG single threaded mode.
>=20
> Signed-off-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
> ---
>  hw/ppc/spapr.c           |  5 -----
>  target/ppc/excp_helper.c | 24 ++++++++++++++++++++++++
>  target/ppc/helper.h      |  1 +
>  target/ppc/translate.c   | 11 +++++++++++
>  4 files changed, 36 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8783b43396..3a864dfc7d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2572,11 +2572,6 @@ static void spapr_set_vsmt_mode(SpaprMachineState =
*spapr, Error **errp)
>      int ret;
>      unsigned int smp_threads =3D ms->smp.threads;
> =20
> -    if (!kvm_enabled() && (smp_threads > 1)) {
> -        error_setg(&local_err, "TCG cannot support more than 1 thread/co=
re "
> -                     "on a pseries machine");
> -        goto out;
> -    }
>      if (!is_power_of_2(smp_threads)) {
>          error_setg(&local_err, "Cannot support %d threads/core on a pser=
ies "
>                       "machine because it must be a power of 2", smp_thre=
ads);
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 50b004d00d..ac5d196641 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1231,6 +1231,30 @@ static int book3s_dbell2irq(target_ulong rb)
>      return msg =3D=3D DBELL_TYPE_DBELL_SERVER ? PPC_INTERRUPT_HDOORBELL =
: -1;
>  }
> =20
> +void helper_msgsndp(target_ulong rb)
> +{
> +    CPUState *cs;
> +    int irq =3D rb & DBELL_TYPE_MASK;
> +    int thread_id =3D rb & 0x3f;
> +
> +    if (irq !=3D DBELL_TYPE_DBELL_SERVER) {
> +        return;
> +    }
> +
> +    qemu_mutex_lock_iothread();
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +
> +        if (cpu->vcpu_id =3D=3D thread_id) {
> +            continue;
> +        }
> +
> +        cpu->env.pending_interrupts |=3D 1 << PPC_INTERRUPT_EXT;
> +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +    }
> +    qemu_mutex_unlock_iothread();
> +}
> +
>  void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
>  {
>      int irq =3D book3s_dbell2irq(rb);
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 380c9b1e2a..eadd08324b 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -630,6 +630,7 @@ DEF_HELPER_FLAGS_3(store_sr, TCG_CALL_NO_RWG, void, e=
nv, tl, tl)
> =20
>  DEF_HELPER_FLAGS_1(602_mfrom, TCG_CALL_NO_RWG_SE, tl, tl)
>  DEF_HELPER_1(msgsnd, void, tl)
> +DEF_HELPER_1(msgsndp, void, tl)
>  DEF_HELPER_2(msgclr, void, env, tl)
>  DEF_HELPER_1(book3s_msgsnd, void, tl)
>  DEF_HELPER_2(book3s_msgclr, void, env, tl)
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 4a5de28036..083731292b 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6657,6 +6657,15 @@ static void gen_msgsnd(DisasContext *ctx)
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
> =20
> +static void gen_msgsndp(DisasContext *ctx)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    GEN_PRIV;
> +#else
> +    gen_helper_msgsndp(cpu_gpr[rB(ctx->opcode)]);
> +#endif /* defined(CONFIG_USER_ONLY) */
> +}
> +
>  static void gen_msgsync(DisasContext *ctx)
>  {
>  #if defined(CONFIG_USER_ONLY)
> @@ -7176,6 +7185,8 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x1=
2, 0x00, 0x03800001,
>                 PPC_NONE, PPC2_BOOKE206),
>  GEN_HANDLER2_E(msgsnd, "msgsnd", 0x1F, 0x0E, 0x06, 0x03ff0001,
>                 PPC_NONE, PPC2_PRCNTL),
> +GEN_HANDLER2_E(msgsndp, "msgsndp", 0x1F, 0x0E, 0x04, 0x03ff0001,
> +               PPC_NONE, PPC_POWER),
>  GEN_HANDLER2_E(msgclr, "msgclr", 0x1F, 0x0E, 0x07, 0x03ff0001,
>                 PPC_NONE, PPC2_PRCNTL),
>  GEN_HANDLER2_E(msgsync, "msgsync", 0x1F, 0x16, 0x1B, 0x00000000,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0tVx8ACgkQbDjKyiDZ
s5I8gQ/+I1fN+fkYYckaruJiRP1g6IeAwFiV1HOgLz0uVzXrR6khqiJMrVcdMoE0
4qEMEjqCdxhcZz9+Fd2C2Lp0vo8J+h5p3tBUxn+4w1MkC3V1Egl0DINiXZBdIKb/
WVootOJQlGHNOpl5E46Q6LDii/+XQr4I/tSuaevsj0xlasEzsZJYx/78SFsXHBf8
Xrlaa/lMtQARgx4uytgfX1MegRcdcj9uzrJwRs2JpWhOxQZzpJYaHANtqNOme22w
FhXbhknhA8WX7pkqXStB9MKNjcqxKdcVD4PBLZfoU0SC8mS+0nvIW50MFdeOjKtd
FTspSl6TJjlSyEfTHAURNCWc2PVn0lCqkOXIl2NvbW7pGC610e+K8+zroOKIzYqB
Tnic74kWs6YMRh/BF5o1y0m3gi0aVGYMrUJdSnyGPxTAFJgqokx72czzLjsI2Hnu
yKkojz5XB0XllRQ6voYSEsoHPpf2BTMiHcwLI4aO6FKtF3ytXERbXw8pAKUG1iYW
RKcECZtjOFUIqOfUkpVLS57sWE1ggG81pn2ZW3dyOI9RGNaCREWYEYkFK39MU7Ye
Rw4QVykN9wQp55apQO07jHcYLgzf9jKO7CsaslX0jBk9649A0E8ggDVBQGxFM5sZ
wrG4YRbb6pPZIduu+sum4Mefor8EricRTyDJUDfT2yqs9OAs85w=
=2z3q
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--

