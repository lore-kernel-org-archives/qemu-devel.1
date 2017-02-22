Received: from eggs.gnu.org ([2001:4830:134:3::10]:52608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgYee-0003t0-Q7
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgYed-000421-LB
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:16:32 -0500
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d06e4ca-b10b-0c91-ae12-06f4f3e972c4@redhat.com>
Date: Wed, 22 Feb 2017 09:16:19 -0600
MIME-Version: 1.0
In-Reply-To: <1487710908-26356-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pkh67tcEwAwi80wT17N0QskEEuIUur5nG"
Subject: Re: [Qemu-devel] [PATCH RFC v3 1/5] tests: Fix
 gcov-files-test-qemu-opts-y, gcov-files-test-logging-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pkh67tcEwAwi80wT17N0QskEEuIUur5nG
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org
Message-ID: <4d06e4ca-b10b-0c91-ae12-06f4f3e972c4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 1/5] tests: Fix
 gcov-files-test-qemu-opts-y, gcov-files-test-logging-y
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
 <1487710908-26356-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1487710908-26356-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 03:01 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index e60bb6c..5591f60 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -94,7 +94,7 @@ gcov-files-check-qom-interface-y =3D qom/object.c
>  check-unit-y +=3D tests/check-qom-proplist$(EXESUF)
>  gcov-files-check-qom-proplist-y =3D qom/object.c
>  check-unit-y +=3D tests/test-qemu-opts$(EXESUF)
> -gcov-files-test-qemu-opts-y =3D qom/test-qemu-opts.c
> +gcov-files-test-qemu-opts-y =3D util/qemu-option.c
>  check-unit-y +=3D tests/test-write-threshold$(EXESUF)
>  gcov-files-test-write-threshold-y =3D block/write-threshold.c
>  check-unit-y +=3D tests/test-crypto-hash$(EXESUF)
> @@ -119,8 +119,8 @@ check-unit-y +=3D tests/test-crypto-ivgen$(EXESUF)
>  check-unit-y +=3D tests/test-crypto-afsplit$(EXESUF)
>  check-unit-y +=3D tests/test-crypto-xts$(EXESUF)
>  check-unit-y +=3D tests/test-crypto-block$(EXESUF)
> -gcov-files-test-logging-y =3D tests/test-logging.c
>  check-unit-y +=3D tests/test-logging$(EXESUF)
> +gcov-files-test-logging-y =3D util/log.c
>  check-unit-$(CONFIG_REPLICATION) +=3D tests/test-replication$(EXESUF)
>  check-unit-y +=3D tests/test-bufferiszero$(EXESUF)
>  gcov-files-check-bufferiszero-y =3D util/bufferiszero.c
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--pkh67tcEwAwi80wT17N0QskEEuIUur5nG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYratDAAoJEKeha0olJ0NqAEYH/AuB3xtG5Kh+4LqDTPCYBnXM
b96/5ca/0EccmlM2bjGQt8EGv/XbrRrbTxmsBIWc932NeqMlwrIIjnTxYI9FAj8R
WZqc/KamKjDyee2HmfyOvFcel7Mt8sK+gxCqfIkIoUO4d9WfYCNUpx/HqL9mBgYn
lABd0E4HSa1tUxJb5ZP5zOLzp6084gzwDurni+7Ew7Tz/QzukwaictMTRQtQLmFI
YpXCmUwcm9ZKMzbZrExcXLiSGd9cPYG0YOH1K1RXoFyfHEpX23sCx4arG+PmO6pt
Ysx86Hb9i/kte/rdR/V5zBdMk5E/szdM66JCvxRflPB3QfM4AI2uQCkrkndujE4=
=EJ+o
-----END PGP SIGNATURE-----

--pkh67tcEwAwi80wT17N0QskEEuIUur5nG--
