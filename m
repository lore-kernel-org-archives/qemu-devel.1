Received: from eggs.gnu.org ([2001:4830:134:3::10]:53851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gXkTr-0004eQ-Mk
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gXkTo-0000y6-Ej
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:14:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gXkTm-0000wD-35
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:13:58 -0500
Date: Fri, 14 Dec 2018 10:13:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181214101355.GA31340@stefanha-x1.localdomain>
References: <CAFEAcA_=XAXoFRFUjZsDWb-8puO4b9CbB85DO+iRXiDrO9O7NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_=XAXoFRFUjZsDWb-8puO4b9CbB85DO+iRXiDrO9O7NA@mail.gmail.com>
Subject: Re: [Qemu-devel] patchew.org using expired https certificate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fam@euphon.net
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 09:54:06AM +0000, Peter Maydell wrote:
> Connecting to https://patchew.org/ makes my browser complain:
>=20
> # patchew.org uses an invalid security certificate.
> # The certificate expired on 19 November 2017, 00:27:00 GMT.
> # The current time is 14 December 2018, 09:52.
> # Error code: SEC_ERROR_EXPIRED_CERTIFICATE
>=20
> which is a bit odd, given I don't think this has been
> broken since 2017. Did a cert-renewal script go wrong?

Hi Fam,
Let's Encrypt isn't set up correctly on patchew.org.  Any ideas?

Also, is there a backup admin for the patchew VM at OSUOSL?  I have root
access but I'd prefer for someone with patchew internals knowledge to be
backup admin:
https://wiki.qemu.org/AdminContacts

Stefan

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcE4JjAAoJEJykq7OBq3PIa6cH/iBH8/6VLL9dMGLH0sVTH4w6
by7aTCG4oJURJOGgH+i419r9f0efIYG4V2cnty10rSDyAKDHQr7XonMUgtfmhXnx
PizXIGNVmuwyNyyZYpCbCoGkTuXAqux4D497+Q+b0dyKj1FoQQf5r7WRGhsTlru5
xdPK9uktkK/7NgPLxhjkdUdrr1LR5Y71vk2Uu+ROFUw9zLlJ8zntp44zgua4p77I
YV5ULyYAbZd7P+D95S1JSju0qzzirvoUQT+LbMt3pjj8YObfy9odf9sfYAs6qq67
4Yy3i5pzPjx0Mrp7TyIEVstQg7Ad07H4vTegvwPqujqkO6LkfVaGMh4TFQWAnHE=
=Nh1U
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
