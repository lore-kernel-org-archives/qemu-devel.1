Received: from eggs.gnu.org ([2001:4830:134:3::10]:39052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF1bG-0005jC-Mi
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 11:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF1bF-0000Va-BK
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 11:31:14 -0500
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
	<1481203391-9523-7-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1df4d95-5c06-3940-5843-efe056cbd0b9@redhat.com>
Date: Thu, 8 Dec 2016 10:31:00 -0600
MIME-Version: 1.0
In-Reply-To: <1481203391-9523-7-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QdJiXaDJ3Hq0gMFvsthivKOOFN9icUeqg"
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] iscsi: Add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, pl@kamp.de, qemu-devel@nongnu.org, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QdJiXaDJ3Hq0gMFvsthivKOOFN9icUeqg
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, pl@kamp.de, qemu-devel@nongnu.org, ptoscano@redhat.com,
 ronniesahlberg@gmail.com, pbonzini@redhat.com
Message-ID: <d1df4d95-5c06-3940-5843-efe056cbd0b9@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] iscsi: Add blockdev-add support
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
 <1481203391-9523-7-git-send-email-kwolf@redhat.com>
In-Reply-To: <1481203391-9523-7-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2016 07:23 AM, Kevin Wolf wrote:
> This adds blockdev-add support for iscsi devices.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/iscsi.c        | 14 ++++++----
>  qapi/block-core.json | 74 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
>  2 files changed, 78 insertions(+), 10 deletions(-)
>=20

> +++ b/qapi/block-core.json
> @@ -1721,10 +1721,10 @@
>  { 'enum': 'BlockdevDriver',
>    'data': [ 'archipelago', 'blkdebug', 'blkverify', 'bochs', 'cloop',
>              'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
> -            'host_device', 'http', 'https', 'luks', 'nbd', 'nfs', 'nul=
l-aio',
> -            'null-co', 'parallels', 'qcow', 'qcow2', 'qed', 'quorum', =
'raw',
> -            'replication', 'ssh', 'vdi', 'vhdx', 'vmdk', 'vpc',
> -            'vvfat' ] }
> +            'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'n=
fs',
> +            'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed'=
,
> +            'quorum', 'raw', 'replication', 'ssh', 'vdi', 'vhdx', 'vmd=
k',
> +            'vpc', 'vvfat' ] }

Missing documentation that calls out 'since 2.9'

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--QdJiXaDJ3Hq0gMFvsthivKOOFN9icUeqg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSYrEAAoJEKeha0olJ0NqI10H/jzmWnDmR/gpMWjM0fvWGKON
ppTT/2NJ/1+kCqY+nbldkxxTn7B3jP8QhwMigfepohGjA0R+eYktNbW1W71n431R
cTQHhBiN8EWCyAgJudKE8Sqj6nvo4XxoNqQan/SAEvatyPeJ7hfVnDRZKCdfJMf2
il1aIBYjhAMiVnNFyLxu5KbMiYIkQPMfRzJrW1/Jn/QaNetN2mQ1+y8ncgBtlkFo
hEdPo3Wr43FpoAYCtVI+GhCmKcRdcoRRBXGlW/U4QkyOCgrrODosdL/tintFC8/l
d93jhWJlXL8KSJ6et0c222u7YbfviPkssP9y6qEb8AZ0iOhjQ1VjCSjhkyMVHaI=
=Ap9O
-----END PGP SIGNATURE-----

--QdJiXaDJ3Hq0gMFvsthivKOOFN9icUeqg--
