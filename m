Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECE4C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453AE206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lIbqaXIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453AE206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJXL-0002Tv-Gj
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwJVS-0007kD-03; Fri, 17 Jul 2020 02:06:02 -0400
Received: from ozlabs.org ([203.11.71.1]:55615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jwJVN-0005zS-OD; Fri, 17 Jul 2020 02:06:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B7LG92GyWz9sRk; Fri, 17 Jul 2020 16:05:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594965953;
 bh=uv2K4WfVLFNWRxRu2em8SFafmKAbhkPI0HjrBoZ591M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lIbqaXImsDz7cZ7NIZWAsoriFrPKkRHJjAHi41B2R8yXh3xVpC8PDTUjjB6aW/QtQ
 es2KGPPMLX0MAmJOTSO7iIW9WEvJT9BYvcY3P3npSls9Lx1me6/pPQ19ckkHMxd0r6
 vj65ZxPzi+etUXCdDysL3/05olOdGX+ff4qPlZU0=
Date: Fri, 17 Jul 2020 15:58:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v4 for-5.2 2/2] spapr: Forbid nested KVM-HV in pre-power9
 compat mode
Message-ID: <20200717055818.GI5607@umbus.fritz.box>
References: <159491945918.188975.4358645698778061430.stgit@bahia.lan>
 <159491948127.188975.9621435875869177751.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline
In-Reply-To: <159491948127.188975.9621435875869177751.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 02:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 07:11:21PM +0200, Greg Kurz wrote:
> Nested KVM HV only works if the kernel is using the radix MMU mode, ie.
> the CPU is POWER9 and it is not running in some pre-power9 compat mode.
> Otherwise, the KVM HV module fails to load in the guest with -ENODEV.
> It might be painful for a user to discover this late that nested cannot
> work with their setup. Erroring out at machine init instead seems to be
> the best we can do.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-5.2.

> ---
>  hw/ppc/spapr_caps.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 275f5bd0342c..10a80a8159f4 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -382,6 +382,8 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState=
 *spapr,
>                                      uint8_t val, Error **errp)
>  {
>      ERRP_GUARD();
> +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> +
>      if (!val) {
>          /* capability disabled by default */
>          return;
> @@ -391,6 +393,14 @@ static void cap_nested_kvm_hv_apply(SpaprMachineStat=
e *spapr,
>          error_setg(errp, "No Nested KVM-HV support in TCG");
>          error_append_hint(errp, "Try appending -machine cap-nested-hv=3D=
off\n");
>      } else if (kvm_enabled()) {
> +        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> +                              spapr->max_compat_pvr)) {
> +            error_setg(errp, "Nested KVM-HV only supported on POWER9");
> +            error_append_hint(errp,
> +                              "Try appending -machine max-cpu-compat=3Dp=
ower9\n");
> +            return;
> +        }
> +
>          if (!kvmppc_has_cap_nested_kvm_hv()) {
>              error_setg(errp,
>                         "KVM implementation does not support Nested KVM-H=
V");
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8RPfkACgkQbDjKyiDZ
s5JdchAAqwHe235vhx/s211Dp0oO8EbHBQt7n2TMBR8NP1uOxh8xXvP1mIKaf5mi
qf9A0nOK0z6sZf6MRqUgGWQ2LbYDMXVtBLaFx8OeaHR6+nUFSCxgnSXwTtkWia5i
W9FEUMwqj1lR3JruyUG7Cuocuzm9GXJe5JVnEQndKgPWQDDU/dBmNZe5p4pB6Q6T
N4C6mdUQPeGsdpiBePUeGiiEPMYShd7wbOhj0wvRftYM1O7zTth/Cytcnd4FtyAu
DE5jURud8laMrRkzMyLthyyb7nzSqmrq9yOi6fPPH9JxW/pr8fZPbxuuG7EEe83Z
GUyZdsey2CI1hNUcn/3vC0dgnP5LwjJb7QpUmcsAsebrFlGXidJOSiMfl8exUwXH
EvW74qtwdfef7670WpuDJrq3gr8PN03LYuA8sQfoV88a9jtwXF2v/xlk+F9KVPYP
+R2UIbKp+D+A0WmRksWtoOGvyFfQjj8ZaeLDiGOjhXdPGUtjrrK1t4/sdeAkHElX
S7t0y+SIeBmvtA5jsI5opiBe3HdNGD0iFXX5i6F8UZ86cjL4p9+bnf+7fj5ZQtC2
6qoFTAXX065QCJRZYTRjdLCE9J9mhZIo2Rn8oTaIZnsFAgtv9uBex7AyEfo+Qp8A
YY/j11XKJ0o0WfHF/wZd9TyrkH+PQtbdTqnPEsrOT8QOlZe0PAM=
=xkhM
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--

