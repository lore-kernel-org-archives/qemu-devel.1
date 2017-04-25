Received: from eggs.gnu.org ([2001:4830:134:3::10]:47289)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1d30oe-00089e-6d
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1d30oY-0003J6-J9
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:47:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:51966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1d30oY-0003Io-6W
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 09:47:34 -0400
References: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
	<CAFEAcA-ycgLSU9aX1Ywd1Pky2bquqefJbsRpNvo4DuaXOyL3SQ@mail.gmail.com>
	<3c22d799-1f28-a220-59d7-4218307748e5@gmx.com>
	<CAFEAcA_isLjtq0oZgKTY5J_MStbcENDaWow3kV1bJWpeEBxAzw@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <7eea43e9-08d1-256c-a15b-d5b135a0725f@gmx.com>
Date: Tue, 25 Apr 2017 15:49:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_isLjtq0oZgKTY5J_MStbcENDaWow3kV1bJWpeEBxAzw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cu1VkD4Si9xi1BoXbsoU3ABKLFiJ9srsH"
Subject: Re: [Qemu-devel] NetBSD maintenance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cu1VkD4Si9xi1BoXbsoU3ABKLFiJ9srsH
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <7eea43e9-08d1-256c-a15b-d5b135a0725f@gmx.com>
Subject: Re: [Qemu-devel] NetBSD maintenance
References: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
 <CAFEAcA-ycgLSU9aX1Ywd1Pky2bquqefJbsRpNvo4DuaXOyL3SQ@mail.gmail.com>
 <3c22d799-1f28-a220-59d7-4218307748e5@gmx.com>
 <CAFEAcA_isLjtq0oZgKTY5J_MStbcENDaWow3kV1bJWpeEBxAzw@mail.gmail.com>
In-Reply-To: <CAFEAcA_isLjtq0oZgKTY5J_MStbcENDaWow3kV1bJWpeEBxAzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.04.2017 12:12, Peter Maydell wrote:
> Upstream we're definitely going to drop SunOS/Solaris support unless
> somebody provides us with a machine we can do build/test on.
> DragonFly BSD is in my "let's see if anybody complains" list.
> OpenBSD is also in this "let's see" list but it seems more plausible
> that somebody will complain (and I have a VM setup for it; it
> doesn't pass 'make check' at the moment so the first step there
> will be for somebody to investigate and send fixes.)
>=20
> The motivation here is that we would rather like to get rid of
> things like #ifdef __NetBSD__ in our sources (in favour of doing
> checks in configure for presence/absence of particular functions
> and acting accordingly), and also avoid using "uname" to figure
> out our compile target. That's very likely to break platforms
> we can't test on, so the idea is to identify which platforms
> people do care about, and make sure we are testing them, and
> then not worry about breaking anything that we aren't testing.
>=20
> Also I think it doesn't do our users any favours to claim to
> support platform Foo if in fact it doesn't even compile.
>=20

I can only speak for pkgsrc, qemu/Illumos (SmartOS) is actively maintaine=
d.

I have got an access to an Illumos machine for pkgsrc developers. Once I
will sort out NetBSD issues I will test qemu over there. I cannot speak
for Oracle Solaris and other proprietary Operating Systems.

I should get shell account for myself for DragonFly and Minix within 2
months.

I cannot maintain non-NetBSD targets beyond occasional and trivial
patches thought.

I will keep upstreaming small chunks of patches for NetBSD and let's see
how it will go. Thanks for help!


--Cu1VkD4Si9xi1BoXbsoU3ABKLFiJ9srsH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY/1PsAAoJEEuzCOmwLnZss/EQAMa7N75lEtF76D5HKBhZ2ZWF
gzlimqWRXTkrv9avv7rmxgwE3LNofPwzoQQcem/uEPMUlU2TnyPJjIrXtGkJ1pGr
YUG8I5mEe2iVD1RSgZXkjgb5S5581laKLZpzyPkYqwi99iKiCQwPtA/XC/40bdzP
TAWBXDVlJogD7zbJzF3jjXkyrW2W8wxAj4jlhH8qON5ps2Pz2AjVK1IdWDvj+ntY
cMfVRyRpN5fdDeoLRQCtYmsBX9DFQHQv7A4+kiYhP0+LipDO6TBQZi5pIm8+SB2j
aFnMFtwq3GwKqjJV6ti37zgMXj26WdOFUjO8tTWIFSqJmNbEyf/GeRY347a1Bl/t
jdgX349Fh6r79UgT+8ZYsT/wZKqiA1QVFD3ETAsAXvRXtXW9FgqZzr1XC+8aLY8r
1N5saIu8mUu6fxaVKMFywQHaoUY5YXfHZcdcI8O1Foss8uXn6b1DfARhSpeqWTAo
Xs5olv0LFANsh2utyKa/wErxaQzRwD3m81FdYiV2nxdGgjrBPxnvbpeN8Hxa/4Ps
78uMAaS3RpM8QrUuA8Xi91YAXbAb6HIq/33sJxu2yN7J/Li2E1plVD+hFL62ptBz
Rc868kDX1QXxqkSYMSIh2o4HLYOjvvnZWwTc4REbClq2rjE5M4jbDw7DY/Vnil6k
0n9nVcZRCFKUZjytRJUE
=xKD7
-----END PGP SIGNATURE-----

--Cu1VkD4Si9xi1BoXbsoU3ABKLFiJ9srsH--
