Received: from eggs.gnu.org ([2001:4830:134:3::10]:60934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVK20-00085b-Hk
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVK1z-00053p-NA
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:58:28 -0400
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
	<1499864249-26305-8-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7db41d6e-7b5d-6d1b-9bc0-7c4badcd1077@redhat.com>
Date: Wed, 12 Jul 2017 10:58:16 -0500
MIME-Version: 1.0
In-Reply-To: <1499864249-26305-8-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VcTi4HaJSIjRDdiVfX4x2h85hD5Bw4Igw"
Subject: Re: [Qemu-devel] [PATCH 7/9] scsi-disk: bdrv_attach_dev() for empty
 CD-ROM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VcTi4HaJSIjRDdiVfX4x2h85hD5Bw4Igw
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Message-ID: <7db41d6e-7b5d-6d1b-9bc0-7c4badcd1077@redhat.com>
Subject: Re: [PATCH 7/9] scsi-disk: bdrv_attach_dev() for empty CD-ROM
References: <1499864249-26305-1-git-send-email-kwolf@redhat.com>
 <1499864249-26305-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499864249-26305-8-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2017 07:57 AM, Kevin Wolf wrote:
> If no drive=3D... option is passed (for an empty drive), we don't only
> lack the BlockBackend normally created by parse_drive(), but we also
> need to manually call blk_attach_dev().
>=20
> This fixes at least a segfault when unplugging such devices, the bug
> that they didn't show up in query-block, and probably some more
> problems.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VcTi4HaJSIjRDdiVfX4x2h85hD5Bw4Igw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZkcYAAoJEKeha0olJ0NqkdAH/jAAz+qZ/BirVEbvkyB/V+nK
xXGfRHDGfTCXkASR5Bc/fL/4Kk3bfsh+xkBHwez0bxZ3LiZ4MaYz70/VgABe9H8y
STv9mOhzh2jT9SlqBttmRg8eE+YMKjEAqXelzCorkTGh7CvV/x2jjlYFBYrDBbrg
sqY3LwB2doMxFvr9fijuoumJ8XasCpJiuR/lpAP3nfLC7uQhfxejkzj/itu0/q1M
aLb1J4pQhmQzZxYvB8yy6268wj10DNuTXZBvstisBI8BYUAMnqs9jQ9UdGsMweXc
n4hPu8KF8HJUirCv7mAy9jJCRy2mhgkhjef1bhYCVMDstIFMPKq2dQLD5a/7Svk=
=CNdj
-----END PGP SIGNATURE-----

--VcTi4HaJSIjRDdiVfX4x2h85hD5Bw4Igw--
