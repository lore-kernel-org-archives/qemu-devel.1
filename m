Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7661CC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 11:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A10020726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 11:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IjDWFLo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A10020726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0O8r-000305-Ma
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 06:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j0O8C-0002Up-Uq
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 06:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j0O8B-0005cK-LC
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 06:18:36 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56911 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j0O8A-0005Zw-Op; Sat, 08 Feb 2020 06:18:35 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48F8mg5hTQz9sRQ; Sat,  8 Feb 2020 22:18:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581160707;
 bh=ikgABbN60Lf71yU3MmFf1av+jCxW3xyqN0929N16B24=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IjDWFLo8YtrFeluANx4lJKeZbEkE8q+HybVc2x0JHvMhdf38OC1G2DSdKNeJ0Rk68
 08I7YTUeMyokxbnrrpZSJtLjMBcf2GNT82i5Nowlsm8y+JyvTLLydZyHRXDiAtDY0K
 fnWNhNtU+Z2LQIxnKJ56u/1qNYc/BQvvOHk/CjYs=
Date: Sat, 8 Feb 2020 22:12:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] ppc: function to setup latest class options
Message-ID: <20200208111241.GE219689@umbus.fritz.box>
References: <20200207064628.1196095-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline
In-Reply-To: <20200207064628.1196095-1-mst@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 01:46:37AM -0500, Michael S. Tsirkin wrote:
> We are going to add more init for the latest machine, so move the setup
> to a function so we don't have to change the DEFINE_SPAPR_MACHINE macro
> each time.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied to ppc-for-5.0.

> ---
>  hw/ppc/spapr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 02cf53fc5b..4cf2a992a5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4428,6 +4428,12 @@ static const TypeInfo spapr_machine_info =3D {
>      },
>  };
> =20
> +static void spapr_machine_latest_class_options(MachineClass *mc)
> +{
> +    mc->alias =3D "pseries";
> +    mc->is_default =3D 1;
> +}
> +
>  #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)                 \
>      static void spapr_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                      void *data)      \
> @@ -4435,8 +4441,7 @@ static const TypeInfo spapr_machine_info =3D {
>          MachineClass *mc =3D MACHINE_CLASS(oc);                        \
>          spapr_machine_##suffix##_class_options(mc);                  \
>          if (latest) {                                                \
> -            mc->alias =3D "pseries";                                   \
> -            mc->is_default =3D 1;                                      \
> +            spapr_machine_latest_class_options(mc);                  \
>          }                                                            \
>      }                                                                \
>      static const TypeInfo spapr_machine_##suffix##_info =3D {          \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4+l6MACgkQbDjKyiDZ
s5JVqRAAiCXcQgG4stsIrhYIF1UDwYJoCszo12MX/6S6QiPHD3yVim6ElKpJOoBt
HGd8+UnmGD9/Qf0lcOZxdVJZRYFo4nDm0nwgRcSfbHphobdEWov/eZvcuifikvnp
24BcO+4yp497iwvvDeeWuHDTHHNcq1EoCDWLSTBmHJW4sjLPLEniJA3e3LbqBVmG
1LlHKYlIXaMOBtkvJM/W1w3uqEiGIgL1tCYkfYLPIV6hWPpuUDKWl1EZtWdtTPWx
MnJWiv+rXwC0kLdbK9smqcyIHS93gHhHGVVUNKdZw32tIE1AmxX2ybeTO07Ihn6l
cwfjCqxPZEMZQ5WZy6Gyzjt8Vuiz961ee0rzZVAN8rRormipXN9nBoDTwG0HvNAD
doYps6ptSe1RaxOOgb5CfdK3cPhlypGjPpUm+21J3+zlJRDhgt0kToRyXtQVdquf
qcFBA0hy1dIghHX346NKeSPfDAFhqb/LGqSj1P0N4/1wzNav/rbSpPdj1UKmYsBE
yLFuuInjYPcJe/A1JLSaLyggwEKROXsN3MTEB0twBUUXlkcSYln+ZCU8sTzzhI48
7fgqoY9me8Zeq1f5VsAM4XHpfFYmKSPau5V/VWkmUTUE6v7OHcCyWxYc7Hddh7Xh
8loNPZcaGODKb4ppnjczPNo/Oq34vkTz/cSZxxHF6Ws5PeejTpA=
=/Fj/
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--

