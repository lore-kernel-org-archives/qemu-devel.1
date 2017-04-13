Received: from eggs.gnu.org ([2001:4830:134:3::10]:37575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyjjw-0003zu-Vi
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyjjv-0005oo-RA
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 14:45:09 -0400
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
	<1492104214-29994-4-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d7af73d-2dc1-88ab-0f66-0fa84661dbb0@redhat.com>
Date: Thu, 13 Apr 2017 13:44:56 -0500
MIME-Version: 1.0
In-Reply-To: <1492104214-29994-4-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r50FVFDNhuC33uAuTVpJeLKsKgoPigaJ4"
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test postcopy migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r50FVFDNhuC33uAuTVpJeLKsKgoPigaJ4
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com,
 stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Message-ID: <6d7af73d-2dc1-88ab-0f66-0fa84661dbb0@redhat.com>
Subject: Re: [PATCH 3/3] qemu-iotests: Test postcopy migration
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
 <1492104214-29994-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1492104214-29994-4-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 12:23 PM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/181     | 117 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/181.out |  38 +++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 156 insertions(+)
>  create mode 100755 tests/qemu-iotests/181
>  create mode 100644 tests/qemu-iotests/181.out
>=20

I don't see a 180.out mentioned on-list anywhere (but the choice of test
number is not too serious).

=2E/check -raw 181

 =3D=3D=3D Write something on the source =3D=3D=3D

+WARNING: Image format was not specified for 'TEST_DIR/t.raw' and
probing guessed raw.
+Automatically detecting the format is dangerous for raw images, write
operations on block 0 will be restricted.
+Specify the 'raw' format explicitly to remove the restrictions.


You'll want to fix that.


> +# Slow down migration so much that it definitely won't finish before w=
e can
> +# switch to postcopy
> +silent=3Dyes
> +_send_qemu_cmd $src 'migrate_set_speed 4k' "(qemu)"
> +_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
> +_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
> +_send_qemu_cmd $src 'migrate_start_postcopy' "(qemu)"
> +
> +QEMU_COMM_TIMEOUT=3D1 qemu_cmd_repeat=3D10 silent=3Dyes \
> +    _send_qemu_cmd $src "info migrate" "completed\|failed"
> +silent=3Dyes _send_qemu_cmd $src "" "(qemu)"

Do we want to tell the source to go back to a higher migrate_set_speed
once we know we are in postcopy mode?  But the test passed for me under
-qcow2 in less than 2 seconds, on an unloaded machine, so hopefully even
on a heavily loaded machine we aren't giving up due to timeouts.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--r50FVFDNhuC33uAuTVpJeLKsKgoPigaJ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY78coAAoJEKeha0olJ0NqFV4H/RMQMv9FSQGfYIxPMMdlKAp2
0EIB2uY0V87FrFhFTp024hDPq4+cRkXsfErpbIxjJSdQKS+aSck4xfGbic9BE5Uq
2nCa9xesJwESymi53BIatQt525PPceG4c0flQ258Hf580uBuRK/2HHgWPABQTaS8
2hY/RVh33Jv6sFHVdw1942rRyOc9C4ZZTpgm5Npn506urL18kLq5csZsGeJo9F3E
/5RekaQE0Zj9pUhyVY4Bknaw2F5JgF7BrS/60hczRAfNCxbuRT2RgUUC2ka/AYDd
Jc0lGrCgbV3ObyedVTcpG4wIC8aKnUkmoyP48LSFRnMRIi1+H+0GKoFCEMcyX40=
=7Ngv
-----END PGP SIGNATURE-----

--r50FVFDNhuC33uAuTVpJeLKsKgoPigaJ4--
