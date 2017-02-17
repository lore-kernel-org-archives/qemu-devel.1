Received: from eggs.gnu.org ([2001:4830:134:3::10]:51554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceqGT-000494-Bt
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceqGS-0007RH-Hp
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:40:29 -0500
References: <cover.1485365834.git.jcody@redhat.com>
	<f0449fb39181c0c4c45d3deba6faaea5282161e0.1485365834.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36a56ad1-9a1a-9542-1b54-389fddc7081e@redhat.com>
Date: Fri, 17 Feb 2017 15:40:21 -0600
MIME-Version: 1.0
In-Reply-To: <f0449fb39181c0c4c45d3deba6faaea5282161e0.1485365834.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IaVsaapdAWfa19QRoAqtaTO44lor2odIc"
Subject: Re: [Qemu-devel] [PATCH v2 6/7] iscsi: Add blockdev-add support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IaVsaapdAWfa19QRoAqtaTO44lor2odIc
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org
Message-ID: <36a56ad1-9a1a-9542-1b54-389fddc7081e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] iscsi: Add blockdev-add support
References: <cover.1485365834.git.jcody@redhat.com>
 <f0449fb39181c0c4c45d3deba6faaea5282161e0.1485365834.git.jcody@redhat.com>
In-Reply-To: <f0449fb39181c0c4c45d3deba6faaea5282161e0.1485365834.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2017 11:42 AM, Jeff Cody wrote:
> From: Kevin Wolf <kwolf@redhat.com>
>=20
> This adds blockdev-add support for iscsi devices.
>=20
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/iscsi.c        | 14 ++++++----
>  qapi/block-core.json | 74 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
>  2 files changed, 78 insertions(+), 10 deletions(-)

> +++ b/qapi/block-core.json
> @@ -2116,10 +2116,10 @@
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

Are we missing a since 2.9 documentation designation here?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IaVsaapdAWfa19QRoAqtaTO44lor2odIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYp23FAAoJEKeha0olJ0NqcvEH/jh7X+ySO2SfELwFCD6vfTeD
K/mLahWdzfccucBA5DsOJYBozBnMnVnjwctosUhdMHCzs/NqZYO/+S3QYyI8uAe7
LLEWjVK5nYj4C01/OanJ2EFT+Rc0fzt0lSpou5BGCBKvVvzN6SLL6EgGCkkSgP3E
zfx8LUPH3sIox/LjC+tNqfOxNycp8JKKhcp9BhR5oD/4CmDj1ZHBPQXdkRiqwbDs
Y4UxntZ4YrrEZBLV1x3+1HfcftBkI0bqz7yMon70KOhmwg0pD1N88P93MackzFbJ
/JwIEpcbt3mWF1NmG4kprF6kVLUV7bG3JpYQtbKe6rrJocNNpFZbpbAHwBcXCSA=
=0NCK
-----END PGP SIGNATURE-----

--IaVsaapdAWfa19QRoAqtaTO44lor2odIc--
