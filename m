Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9B7C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0842186A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 04:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ko1as5jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0842186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2SzW-0004Ba-0D
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 00:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i2SyD-00037S-DK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i2SyB-0003q9-Pr
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 00:20:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44991 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i2SyA-0003pJ-IN; Tue, 27 Aug 2019 00:20:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46HbJY3YP3z9sBp; Tue, 27 Aug 2019 14:20:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566879629;
 bh=OYz68tk1JX1UxE1vRSPi6VOjfRxeQr4mWC4mDkVQvFA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ko1as5jj9urdn+8br6Ljo37qUQRo/6GEu3mpbMs8o+3ZCVBx2c2JEVKRhn1T789Mg
 R2rlbTrkTz2bKAoyrYuMCXqD7fWtUJ2XKZmMAQmM5teMpoLv0nhMu1yDtc3glGRf1M
 hxtzj0ucq620is1r6cYFjdbVCMVNRu27F1lrgXpM=
Date: Tue, 27 Aug 2019 13:45:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190827034519.GB10107@umbus.fritz.box>
References: <20190826090812.19080-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20190826090812.19080-1-lvivier@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH] pseries: Fix compat_pvr on reset
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2019 at 11:08:12AM +0200, Laurent Vivier wrote:
> If we a migrate P8 machine to a P9 machine, the migration fails on
> destination with:
>=20
>   error while loading state for instance 0x1 of device 'cpu'
>   load of migration failed: Operation not permitted
>=20
> This is caused because the compat_pvr field is only present for the first
> CPU.
> Originally, spapr_machine_reset() calls ppc_set_compat() to set the value
> max_compat_pvr for the first cpu and this was propagated to all CPUs by
> spapr_cpu_reset().  Now, as spapr_cpu_reset() is called before that, the
> value is not propagated to all CPUs and the migration fails.
>=20
> To fix that, propagate the new value to all CPUs in spapr_machine_reset().
>=20
> Fixes: 25c9780d38d4 ("spapr: Reset CAS & IRQ subsystem after devices")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-4.2, thanks.

> ---
>  hw/ppc/spapr.c          | 8 +++++++-
>  hw/ppc/spapr_cpu_core.c | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index baedadf20b8c..d063312a3b2a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1752,7 +1752,13 @@ static void spapr_machine_reset(MachineState *mach=
ine)
>          spapr_ovec_cleanup(spapr->ov5_cas);
>          spapr->ov5_cas =3D spapr_ovec_new();
> =20
> -        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fata=
l);
> +        /*
> +         * reset compat_pvr for all CPUs
> +         * as qemu_devices_reset() is called before this,
> +         * it can't be propagated by spapr_cpu_reset()
> +         * from the first CPU to all the others
> +         */
> +        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
>      }
> =20
>      /*
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index bf47fbdf6f7f..45e2f2747ffc 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -43,6 +43,8 @@ static void spapr_cpu_reset(void *opaque)
> =20
>      /* Set compatibility mode to match the boot CPU, which was either set
>       * by the machine reset code or by CAS. This should never fail.
> +     * At startup the value is already set for all the CPUs
> +     * but we need this when we hotplug a new CPU
>       */
>      ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort=
);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1kp04ACgkQbDjKyiDZ
s5JjChAAhbYHCU59+LwKTC6bWcsC9VlRLESFIigKB4WyreUA0xiVT+bMWpn2iHSZ
zni9Oicn6yYLyMObVbxjFWTQLRs1YvurNRwYTJ0XiJ+FSFQntESeiq7lV9xcSGhG
ds0gbWlMUPkoFmadBmnLDXGrHMVVLIFFdJbOvlVpvmP/uaS3JSe7nYt4k26sF8d4
dUJVJx8NtpGBau0vCk4wVJO+pM6G7yc81wO633Tip3PcTBCrrTidDxZtpkdErvOk
6XBRNAb1JwBkh7iIkTIkhvMhYBPopK/7tlPfaXvVEblVmZydq0LvFHhYeSMkhbPB
4/U0rIPxM65HnFZpkbPJEqHcEziBOPBZjODaBRnK1wMrm2kRxrngfqa5hmas3k2V
TTNoZBaLYsRPXpNd6LGbw++SvThX8TY/iyw9U0Db9RI+8KQWQsMWiIwbM0SGE8DE
eX9d9J7vg+N+u+2gYzlwXEEbhdTMHyRGCLVCTj9anXgC6LUZ6ufwBzkDD/zf2hEo
WsfxiQafr5TIzRcWKnoM3L4hVvMoIYTSREKs1n676XMyU/A5vsbMLpPq+6ZVfD4d
mTI5OPqlp5XXJKHMC3oGa/MbE3SKflzl7wk03lm6UKz+dvpihNxeHQt/H8OeIyXH
izUfWFlAkvnwhT5NLqbPEp9IbFeKM2/BCYvAdaY5x3MdF6wSI1s=
=SaA0
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

