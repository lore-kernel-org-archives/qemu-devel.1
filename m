Received: from eggs.gnu.org ([2001:4830:134:3::10]:53558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbA5a-0002SL-Sd
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dbA5X-0007sd-GB
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:34:18 -0400
References: <20170728012542.29975-1-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9bf5ddf1-3b81-ceb3-66a0-1d3267e7cae4@redhat.com>
Date: Fri, 28 Jul 2017 13:34:11 -0500
MIME-Version: 1.0
In-Reply-To: <20170728012542.29975-1-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uUD4CgVF4QPKgQPFAkrRmrGjPnXVRgvcb"
Subject: Re: [Qemu-devel] [PATCH for 2.10 0/8] docs: fix broken paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uUD4CgVF4QPKgQPFAkrRmrGjPnXVRgvcb
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <9bf5ddf1-3b81-ceb3-66a0-1d3267e7cae4@redhat.com>
Subject: Re: [PATCH for 2.10 0/8] docs: fix broken paths
References: <20170728012542.29975-1-f4bug@amsat.org>
In-Reply-To: <20170728012542.29975-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/27/2017 08:25 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi, following Cleber Rosa example I cleaned more invalid references.
>=20
> Eric said this can wait 2.11, however these patches don't change any co=
de
> generated, I think the 2.10 users deserve an up-to-date doc :p

I think what I said was: this doesn't change code and doc updates are
find during freeze, so this is a GOOD candidate for 2.10; but if it
misses 2.10, slipping to 2.11 doesn't hurt.  (If I didn't say that, it's
what I should have done).  But you caught on to my intention, even if in
the process it sounds like I was asking you to wait.

>=20
> I used the following command (and consider include it in some CI test j=
ob):
>=20
> $ git grep docs/ \
>       | sed -ne "s/.* \(docs[^ :)}\"\']*\).*/\1/p" \
>       | sed -e 's/\(.*\)\.$/\1/p' | sort -u | while read p;do
>     ls -ld $p 1>/dev/null

Wait. What? 'ls -ld' with stdout sent to /dev/null?  (I never cease to
be amazed at the random shell constructs that people come up with).  I
guess you are just trying to check for file existence, by going off of
the stderr droppings from ls?  'ls -d' is less effort than 'ls -ld'; and
if all you care about is stderr messages, spawning one ls per filename
is much slower than just doing it wholesale via xargs to minimize ls call=
s:

git grep ... | sort -u | xargs ls -d >/dev/null

But then again, efficiency in generating the list of problems isn't a
bottleneck.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uUD4CgVF4QPKgQPFAkrRmrGjPnXVRgvcb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7g6MACgkQp6FrSiUn
Q2olQwf/ZaX430jnE16HN4gvAjRyQ7CZT1J/yFW7Sro7zs/Y1rCLRh2kS3T3Xpzz
rG3TKNU1/EQ3VMnq108nL1m9icX5cvYOEPw41SiRqjOCHwbJNue9GdMhM2Ti5OUa
G72z/s6DpB4HZnAZHYTctGi0MknQK9Q8JlnZ2BPadr1QZUovkRgEhdxjOgZ0XcYx
N3VbkQtbrGgOgLW0EkBC3xWy3Q7UWnIClYRFgU8D2Q/Uvb0opdAN27qjSgm6DdbH
R5G0ZFOrOd6QR8RGKaC81yyKImMMgMJorMJG7GQHyLdPzCaqvToV2hWoSWZ5fvHL
NsjLmz1WuY5Z3ZW+ogaNzex7zbezhg==
=OupY
-----END PGP SIGNATURE-----

--uUD4CgVF4QPKgQPFAkrRmrGjPnXVRgvcb--
