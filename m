Received: from eggs.gnu.org ([2001:4830:134:3::10]:59609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmo61-0003Cg-49
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmo60-0008Sy-7H
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:30:53 -0400
References: <cover.1503580370.git.berto@igalia.com>
	<1b2e3049803f71cafb2e1fa1be4fb47147a0d398.1503580370.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <365e0acc-9885-2c42-365f-dfe55425747f@redhat.com>
Date: Tue, 29 Aug 2017 16:30:44 -0500
MIME-Version: 1.0
In-Reply-To: <1b2e3049803f71cafb2e1fa1be4fb47147a0d398.1503580370.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sGtogeveIAdAPFsw0pCFgQeMtxaBfpaSo"
Subject: Re: [Qemu-devel] [PATCH v2 6/7] throttle: Make burst_length 64bit
 and add range checks
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
--sGtogeveIAdAPFsw0pCFgQeMtxaBfpaSo
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <365e0acc-9885-2c42-365f-dfe55425747f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] throttle: Make burst_length 64bit and
 add range checks
References: <cover.1503580370.git.berto@igalia.com>
 <1b2e3049803f71cafb2e1fa1be4fb47147a0d398.1503580370.git.berto@igalia.com>
In-Reply-To: <1b2e3049803f71cafb2e1fa1be4fb47147a0d398.1503580370.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 08:24 AM, Alberto Garcia wrote:
> LeakyBucket.burst_length is defined as an unsigned integer but the
> code never checks for overflows and it only makes sure that the value
> is not 0.
>=20
> In practice this means that the user can set something like
> throttling.iops-total-max-length=3D4294967300 despite being larger than=

> UINT_MAX and the final value after casting to unsigned int will be 4.
>=20
> This patch changes the data type to uint64_t. This does not increase
> the storage size of LeakyBucket, and allows us to assign the value
> directly from qemu_opt_get_number() or BlockIOThrottle and then do the
> checks directly in throttle_is_valid().
>=20
> The value of burst_length does not have a specific upper limit,
> but since the bucket size is defined by max * burst_length we have
> to prevent overflows. Instead of going for UINT64_MAX or something
> similar this patch reuses THROTTLE_VALUE_MAX, which allows I/O bursts
> of 1 GiB/s for 10 days in a row.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  include/qemu/throttle.h | 2 +-
>  util/throttle.c         | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sGtogeveIAdAPFsw0pCFgQeMtxaBfpaSo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlml3QQACgkQp6FrSiUn
Q2rSxAf/ZeafLsY3J1J4YYy+w6ka0WU5EtVNou6KYo/u8GnfR3eaILcYGFQXkum5
KOFAT25oTJLDC5odBgo9Jy+HLE3+b5B+hrCSJUaT7i3OBbEiHzyBLA56HP3Cw61Y
nGk1YvyJEeEJjKHTpbRtcCUpHOAv4jc/ugv8cKnp5a0hNaPKjSAx3JCuIK67z8B6
u1UGkLMPGsbdaO6LWAanBoURpV7BX+Ifu/XCdVrLXqziN3U80UJgqklKlOiMVVIB
PuV7vaM5igw50b7QAm8yvns1NFphxw78gMbuWdSh2m4Hpoy7X4UaqIjLQzD7VHpo
k00nj+iWHueswoqugmWifhfQNwM3ZA==
=ZTX5
-----END PGP SIGNATURE-----

--sGtogeveIAdAPFsw0pCFgQeMtxaBfpaSo--
