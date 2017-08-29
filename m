Received: from eggs.gnu.org ([2001:4830:134:3::10]:59279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmo4s-0002OF-CH
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:29:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmo4r-0007kX-Gy
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:29:42 -0400
References: <cover.1503580370.git.berto@igalia.com>
	<f29b840422767b5be2c41c2dfdbbbf6c5f8fedf8.1503580370.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a9806493-1ca3-7744-036c-844417040170@redhat.com>
Date: Tue, 29 Aug 2017 16:29:33 -0500
MIME-Version: 1.0
In-Reply-To: <f29b840422767b5be2c41c2dfdbbbf6c5f8fedf8.1503580370.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="88w4Gt8ntTsbLP8OpGdFCsrNHsvEpw0VV"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] throttle: Make LeakyBucket.avg and
 LeakyBucket.max integer types
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
--88w4Gt8ntTsbLP8OpGdFCsrNHsvEpw0VV
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <a9806493-1ca3-7744-036c-844417040170@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/7] throttle: Make LeakyBucket.avg and
 LeakyBucket.max integer types
References: <cover.1503580370.git.berto@igalia.com>
 <f29b840422767b5be2c41c2dfdbbbf6c5f8fedf8.1503580370.git.berto@igalia.com>
In-Reply-To: <f29b840422767b5be2c41c2dfdbbbf6c5f8fedf8.1503580370.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 08:24 AM, Alberto Garcia wrote:
> Both the throttling limits set with the throttling.iops-* and
> throttling.bps-* options and their QMP equivalents defined in the
> BlockIOThrottle struct are integer values.
>=20
> Those limits are also reported in the BlockDeviceInfo struct and they
> are integers there as well.
>=20
> Therefore there's no reason to store them internally as double and do
> the conversion everytime we're setting or querying them, so this patch
> uses uint64_t for those types. Let's also use an unsigned type because
> we don't allow negative values anyway.
>=20
> LeakyBucket.level and LeakyBucket.burst_level do however remain double
> because their value changes depending on the fraction of time elapsed
> since the previous I/O operation.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  include/qemu/throttle.h | 4 ++--
>  tests/test-throttle.c   | 3 ++-
>  util/throttle.c         | 7 +++----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--88w4Gt8ntTsbLP8OpGdFCsrNHsvEpw0VV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlml3L0ACgkQp6FrSiUn
Q2rwvgf/eZzVzwyFFbtSOEyAXHIQ6M6bZZSZ9KEHiaN6OU1wfYURckRtl+iDTd9h
DbU5NUi4t6Ew8XejHTX1/pcpeGf2XHeuerr7toNkdxFZe/6gq7R2CCibRzaBI5jA
3V0Y+6w3Dere4RxMtWqUpBTGUreIxUVM1wi/l+iOhTKOqQwggiTJj4iYSNC6/jDH
4x35Yg+DgblppQbrrxHFtBPGeUGcm7Q6BaioKQ5kr7wXrno8HecaXQ59xjWtVvag
J25avjKbAM6YIjkZmgDsHC4b8G/3fiN3a+jtzF+V5Ncc4OHhZnfxwqobBkbxnpSM
biGBPmTj2Aw7odzB25mY3xktbru5MQ==
=udLG
-----END PGP SIGNATURE-----

--88w4Gt8ntTsbLP8OpGdFCsrNHsvEpw0VV--
