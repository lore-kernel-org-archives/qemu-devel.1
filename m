Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4E1C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F2520874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 13:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BgIdqCbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F2520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Ej6-0003wB-61
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 09:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i2Ehl-0002st-OK
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i2Ehk-0001Qx-4f
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 09:06:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47839 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i2Ehi-0001PB-LJ; Mon, 26 Aug 2019 09:06:40 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46HC225dcXz9sDB; Mon, 26 Aug 2019 23:06:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1566824794;
 bh=4Z2zlYlF3fUNUU59WwLKoo7rZgY5P2WxeBz4KhUV/CM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BgIdqCbXF48uLwIwkRbxlctfjHsctJg363HB6039qpHX9Raso/8izewwdl7OdcN4K
 rm3K51pkeq4ugrMXNbXn9xJ6gOAE2Ex/0AO4Jbp5YNw/0XHI7uW/s860i529kyaCFY
 hT3ZieoZCSO/yhGYeAvH87tBAL1GFAgMnObqENWE=
Date: Mon, 26 Aug 2019 19:28:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190826092847.GE28081@umbus.fritz.box>
References: <20190826090812.19080-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
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


--u5E4XgoOPWr4PD9E
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

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1jpk8ACgkQbDjKyiDZ
s5KV7BAAmBtcPOU35G5kNddYm6iVNLaIrrOvljyMuaVp2ElrvPBHeG47xNw+kGCM
M8Egza8YyKbSDRKBZS9tTBU/ENRLGBFR10ClardpX6MNCp/mNcabdZonIfd5cwHk
RtsMw/NVGsth1mnYd+Arm27dodUWY6Ng/VDSJPWroXSButjsFJCrs9qUZOJjQyqM
ipZoJ07tcgJm+uwIrMY0GOUjJ0EJhxpRD7cmYL+TGKtxaw57VpXGtkFjbJRQQoWc
26X60ctxBr520PT790vOwuHVXTgesuNjJLfmlhWMk+sr3lixuCrmAxAgWgOd+23S
Vb2PkQoF3lyD/31nwnYh0F+//3jbfxHnFjvTWY+2l69cIAhLvGIRtFeXyei4yt/7
0MSMhWDfiPxkbTojnq+abkR144lFTQOOiISFx8cLrSs7kDNCydkkWhl3qFbgENuX
04Z3R/mz/9WP+JuxDYCTH1DrdZVMXIiXIt0GjpmO3VjdzjRNYPP4SCsP3shBqUv/
kQc4olrPhOKw99rA/fw/RmRRBiDKfQp26KFO2ZKrJOD5wUGpszp3oXpstos/PqJc
hbzp8137wMwqjKqLmfKlpmO2JcgWHrL9zR78iU2KBM0XsNuqQRy0N2qM5C+CNhg7
stvpjJZRYdX67Je879pCgbV6he5rkqTdaLJjCMnC4N+EpiDYBxo=
=EocV
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--

