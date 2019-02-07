Received: from eggs.gnu.org ([209.51.188.92]:55799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grpWb-0005Q2-Ss
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:39:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grpWa-0001OV-LE
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:39:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1grpWa-0001Dz-Br
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:39:52 -0500
References: <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <90a28737-c1ea-3d1b-9bc4-584364c1017d@redhat.com>
Date: Thu, 7 Feb 2019 13:39:30 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Nr8xBZvNReo2fqtgA4QNHErrO15aGOGP0"
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
--Nr8xBZvNReo2fqtgA4QNHErrO15aGOGP0
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <90a28737-c1ea-3d1b-9bc4-584364c1017d@redhat.com>
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
> Now that doesn't necessarily apply to us as a userspace program,

But systemd-journal is a userspace program bit by VLA:
https://www.openwall.com/lists/oss-security/2019/01/09/3

So the gnulib project recently switched to making it easier to disable VL=
A:
https://lists.gnu.org/archive/html/bug-gnulib/2019-01/msg00110.html

> but on the other hand if any of these were allowing the guest to
> determine the size of an on-stack array that would not be great.
> (The linux-user one is bogus in that way, though not a security issue
> as the guest code there has full control anyway.)
>=20
> Opinions? I admit that to some extent this is just my sense of
> tidiness thinking that if we only have a handful of uses of
> something we should squash that down to zero :-)

I'm all for removing it. (Hmm, I should update BiteSizedTasks to call
out general compiler-driven cleanups, calling out both -Wshadow and
-Wvla as separate subtasks in that category)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Nr8xBZvNReo2fqtgA4QNHErrO15aGOGP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxciXIACgkQp6FrSiUn
Q2pJXggAljnOAl9NrGBemm+KhrdgfMsmNY5/R8AQ2iUg4MJ60xg2Klq10Wf6vK7C
eN7lMSpvUE3Nj8MZgiTwYoqaVANry7SbevdaNOYx0rK3Qy/9eM+szj4YGe6sFQ9Z
98RD+eMZBW+n7xDOu0TDEGjdC/2lp6TrAoAKBm0MB/Y5hYf/H6FfoCLfj+LL7u4O
VuASNuUEP363wPyu53GLjCTp2VJBBzrKxT4OgpNiTtU6/AWwDdsWqQqBXR23K/tU
zcfXaC52M5Xb/99cm7m78IZJVSjOTUOJBKgIt+HS2dwns7sfD2sPWFikXtm0JBKv
UyuJKaLBDubHaRUaPni8mmwFwJ0PYA==
=EPcu
-----END PGP SIGNATURE-----

--Nr8xBZvNReo2fqtgA4QNHErrO15aGOGP0--
