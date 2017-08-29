Received: from eggs.gnu.org ([2001:4830:134:3::10]:57352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmo0z-00007P-I0
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmo0y-0005Bd-Ds
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:25:41 -0400
References: <cover.1503580370.git.berto@igalia.com>
	<31aae6645f0d1fbf3860fb2b528b757236f0c0a7.1503580370.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <266d5e41-eb87-1c03-52bf-e383e5d2e3a1@redhat.com>
Date: Tue, 29 Aug 2017 16:25:31 -0500
MIME-Version: 1.0
In-Reply-To: <31aae6645f0d1fbf3860fb2b528b757236f0c0a7.1503580370.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lh4WtjTFa19LbC2LrwpSeSPRlRi9DIRHr"
Subject: Re: [Qemu-devel] [PATCH v2 2/7] throttle: Update the
 throttle_fix_bucket() documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lh4WtjTFa19LbC2LrwpSeSPRlRi9DIRHr
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <266d5e41-eb87-1c03-52bf-e383e5d2e3a1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/7] throttle: Update the
 throttle_fix_bucket() documentation
References: <cover.1503580370.git.berto@igalia.com>
 <31aae6645f0d1fbf3860fb2b528b757236f0c0a7.1503580370.git.berto@igalia.com>
In-Reply-To: <31aae6645f0d1fbf3860fb2b528b757236f0c0a7.1503580370.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 08:24 AM, Alberto Garcia wrote:
> The way the throttling algorithm works is that requests start being
> throttled once the bucket level exceeds the burst limit. When we get
> there the bucket leaks at the level set by the user (bkt->avg), and
> that leak rate is what prevents guest I/O from exceeding the desired
> limit.
>=20
> If we don't allow bursts (i.e. bkt->max =3D=3D 0) then we can start
> throttling requests immediately. The problem with keeping the
> threshold at 0 is that it only allows one request at a time, and as
> soon as there's a bit of I/O from the guest every other request will
> be throttled and performance will suffer considerably. That can even
> make the guest unable to reach the throttle limit if that limit is
> high enough, and that happens regardless of the block scheduler used
> by the guest.
>=20
> Increasing that threshold gives flexibility to the guest, allowing it
> to perform short bursts of I/O before being throttled. Increasing the
> threshold too much does not make a difference in the long run (because
> it's the leak rate what defines the actual throughput) but it does
> allow the guest to perform longer initial bursts and exceed the
> throttle limit for a short while.
>=20
> A burst value of bkt->avg / 10 allows the guest to perform 100ms'
> worth of I/O at the target rate without being throttled.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  util/throttle.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lh4WtjTFa19LbC2LrwpSeSPRlRi9DIRHr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlml28sACgkQp6FrSiUn
Q2ozngf/TcDc3Tl3c5mncw2RI6UR47G3v9fvYliKX0D+VpZlevix1Rcf9cHzrYV4
KAJDukREoRjHRp0DY3xemgojo1IYJlhmlnDx4q7ZBHgFd7xTrt0P67fck80GVBbb
hmNrPiSRxqWek6qBG2J3umYMPLOBowESyuSJ541xsM7Br1CzVzrgP/hTp9r5EqeG
wbP6znGUaXSXQhwfMH0r2+TKx3buhYXu9rUThyaXL44D7IApgMJtEP98WsoZAHAm
SOOfIOxvVEABJauVqJFDM29rYHX4/qsgn8dTNXVHr9rNZxgFcFOydwzm1+f77PaR
aLBf8hHio01V57WJ6NfgOpdJZlwMXQ==
=Oj3Q
-----END PGP SIGNATURE-----

--lh4WtjTFa19LbC2LrwpSeSPRlRi9DIRHr--
