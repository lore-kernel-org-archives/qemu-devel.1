Received: from eggs.gnu.org ([209.51.188.92]:37331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grqHP-0002I3-3z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grqHL-0001Tn-Bv
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:28:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1grqHK-0001SH-2U
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:28:11 -0500
References: <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d99cf209-b79f-ae75-af2a-37e87d26af7b@redhat.com>
Date: Thu, 7 Feb 2019 14:28:07 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5lE8vICz1bmpujWYpLnZYTI9zU3aB4XWa"
Subject: Re: [Qemu-devel] should we try to stop using variable length arrays?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5lE8vICz1bmpujWYpLnZYTI9zU3aB4XWa
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <d99cf209-b79f-ae75-af2a-37e87d26af7b@redhat.com>
Subject: Re: should we try to stop using variable length arrays?
References: <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
In-Reply-To: <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 1:30 PM, Peter Maydell wrote:
> Currently QEMU has 9 uses of variable length arrays
> (found using -Wvla):
>=20

>=20
> Should we be looking to get rid of these and turn on the -Wvla
> warning? I know the Linux kernel has recently decided to do this
> (some rationale at the start of https://lwn.net/Articles/749064/).

A big part of that article was a discussion on how hard it is to write
an eval-once macro MAX() that does not trigger a VLA, and that the
kernel settled on a second macro for use in constant contexts.  Do we
want to revist my patch that would add eval-once MAX() and constant-use
MAX_CONST(), to make it easier to avoid accidental VLAs?
 https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00727.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--5lE8vICz1bmpujWYpLnZYTI9zU3aB4XWa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxclNcACgkQp6FrSiUn
Q2oW8Af/SuAbVRjesOfRKwteyyn8TGtOlrFFBXt0q1Rhg7sls3cYo7BIcbphrlLy
Ra9ZMEThbBRlXHC+10aYEWOko+0BEtQDh9SZpIKeO6L95iLkRSxsby88bCfbQ2gg
HJRunddwwBeVlWICogGNhy+WNRpBIoBqlk49NTnrFRWUvbC/c34B2J5im1B+57Sa
ZwubQ8wCwvpuWRrnp3S9Bgyw1gIhccyNCJUgGd3ov4ioTcx2fTzwDLx7bk2geBYI
JXtN+UUG++9odYHw9MW7PfwobOJJEg0elg7hFu8eeOvsXDibjrT7b+2nF2jvn435
M2Pr1hHkQzHHzD0k+ntSlr6VMWapZQ==
=h0qt
-----END PGP SIGNATURE-----

--5lE8vICz1bmpujWYpLnZYTI9zU3aB4XWa--
