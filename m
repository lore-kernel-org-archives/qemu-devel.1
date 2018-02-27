Received: from eggs.gnu.org ([2001:4830:134:3::10]:51527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1eqhji-0000Cm-R3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1eqhjc-0001jH-Rp
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:04:14 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:53562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <benjamin.drung@profitbricks.com>)
	id 1eqhjc-0001iu-Kl
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:04:08 -0500
Received: by mail-wm0-x229.google.com with SMTP id t74so25237284wme.3
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:04:08 -0800 (PST)
Message-ID: <1519747444.4922.5.camel@profitbricks.com>
From: Benjamin Drung <benjamin.drung@profitbricks.com>
Date: Tue, 27 Feb 2018 17:04:04 +0100
In-Reply-To: <a23480b8-c914-6274-52ec-29911cb4d2a5@amsat.org>
References: <ff0868d2-98c0-a0ee-8139-0367c29a03b1@redhat.com>
	<20180216175507.17052-1-benjamin.drung@profitbricks.com>
	<a23480b8-c914-6274-52ec-29911cb4d2a5@amsat.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-aJRzrBWe6CkTxm+dGUPT"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] slirp: Add domainname option to slirp's
 DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org


--=-aJRzrBWe6CkTxm+dGUPT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Am Freitag, den 16.02.2018, 16:23 -0300 schrieb Philippe Mathieu-Daud=C3=A9=
:
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> > index 1cb6b07004..4f29753444 100644
> > --- a/slirp/slirp.c
> > +++ b/slirp/slirp.c
> > @@ -286,7 +286,7 @@ Slirp *slirp_init(int restricted, bool
> > in_enabled, struct in_addr vnetwork,
> >                    const char *tftp_path, const char *bootfile,
> >                    struct in_addr vdhcp_start, struct in_addr
> > vnameserver,
> >                    struct in6_addr vnameserver6, const char
> > **vdnssearch,
> > -                  void *opaque)
> > +                  const char *vdomainname, void *opaque)
> >  {
> >      Slirp *slirp =3D g_malloc0(sizeof(Slirp));
> > =20
> > @@ -317,6 +317,7 @@ Slirp *slirp_init(int restricted, bool
> > in_enabled, struct in_addr vnetwork,
> >      }
> >      slirp->tftp_prefix =3D g_strdup(tftp_path);
> >      slirp->bootp_filename =3D g_strdup(bootfile);
>=20
> I'd use this check:
>=20
>    if (vdomainname) {
>        if (!*vdomainname) {
>            error_report("'domainname' parameter cannot be empty");
>            exit(EXIT_FAILURE);
>        }

I implemented that check in patch v3. In patch v4 I moved the check
logic into net_slirp_init() in net/slirp.c where all the other checks
live.

--=20
Benjamin Drung
System Developer
Debian & Ubuntu Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Email: benjamin.drung@profitbricks.com
URL: https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss, Matthias Steinberg
--=-aJRzrBWe6CkTxm+dGUPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJalYF0AAoJEN2M1aXejH567gQP/R2Qi2hr+wqeKc2rdYcZ/TcB
WTHOi7ALoR+C3v1or0e/IWEM957+JpR+f+HbO5zvyOCzJc0xkpgFkikxytdMUnok
YQp5bFsbpoIr4x/TJWP3NNmWUSsavUnCSgVRZxhNdYo/It6xOFVhO8P/6JUKxA/J
nN0bmZAaRuajZraEk2eodNuEuZm6XJziN6sxJfOu10n6zjZgKQJq0Z8x5a0p8Gya
geKPdYS8isfnWfhmaG2O6Xvg7Tei4mfSF/uVLj0orGfm0l6YzuMgqmXYIlBBrEia
Xk8c6GbcJBsrjQkZ3zXGTfs38oqigvciKERzzFISu0QZAsct8Wg5HrVSboARbnul
FVgsNW6AcalQcqO3UZWQOLuDCQJxQ4p3ywJqo0TRt3cx5tyw5Ab6ttz/hdfatVf2
Or6Pp+gzLiWhcPC0Wf+V2h45/uXMrHNgt3aejZfXSMNKH4FRGylYErUEydJahed/
X1p33DbmNcvb6PrJu5yOliTBVMirIdwM1qk8FeGR7xlJYh9VKTQf+7FEeboDjJl9
J0A55t6ZnPIeYmgbWRLUID+gVdMKPj8cYPPtokzaa9NBPsO8kmSFejfbNes8i8fx
pnSUrGcflsbWB1CTmQg/REF3QhFBJ5ARmVCM1ubt9sZeRE+o6CzqNEGq+igR9dH8
el8BCZ77ABHCc6fdVv1c
=nFc2
-----END PGP SIGNATURE-----

--=-aJRzrBWe6CkTxm+dGUPT--
