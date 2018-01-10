Received: from eggs.gnu.org ([2001:4830:134:3::10]:32852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZHZN-0004be-6y
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:41:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZHZM-0004LN-4x
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:41:33 -0500
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-10-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d425ded3-cfe0-1ae3-7d91-eb9913194f18@redhat.com>
Date: Wed, 10 Jan 2018 08:41:10 -0600
MIME-Version: 1.0
In-Reply-To: <20180110091846.10699-10-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PQJ8HpQWsK1FVPfGgTk4j87IY6ZJBUhkS"
Subject: Re: [Qemu-devel] [PATCH v4 9/9] qapi: Add NVMe driver options to
 the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PQJ8HpQWsK1FVPfGgTk4j87IY6ZJBUhkS
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>
Message-ID: <d425ded3-cfe0-1ae3-7d91-eb9913194f18@redhat.com>
Subject: Re: [PATCH v4 9/9] qapi: Add NVMe driver options to the schema
References: <20180110091846.10699-1-famz@redhat.com>
 <20180110091846.10699-10-famz@redhat.com>
In-Reply-To: <20180110091846.10699-10-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/10/2018 03:18 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qapi/block-core.json | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index e94a6881b2..fd6c94454d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2237,7 +2237,7 @@
>    'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop',
>              'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
>              'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'n=
fs',
> -            'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed'=
,
> +            'null-aio', 'null-co', 'nvme', 'parallels', 'qcow', 'qcow2=
', 'qed',
>              'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
>              'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' =
] }

Missing a doc line:
@nvme: Since 2.12

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PQJ8HpQWsK1FVPfGgTk4j87IY6ZJBUhkS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpWJgYACgkQp6FrSiUn
Q2po6gf/eIeRMHMnel7nZPpcDjTP8XxE/S1EfWIdXFoNBtVNCbvKtrsrBeMM8Klp
zuM0iBT22aJZ9AuquP+7LQPk47zbPdXy8i94sOq5cJFrptLBz7UuOAJH46yWdOri
njnJOwSopR3yFS7gGtxsSBEnH3Fh6YzePFXXt3X8sKj23Fp+tI3jHLHBS0DI1Q9J
PR4rvDvD94pFB4rnfFz/7xMMwXIif2T2MnbH1OlgpWiBE2NAqMvh9C9UPE4jkd8t
xsra2N3SQ5Cb8taJ+98a1EcSwP/z1jcM0aL+eFIv+vAg+ExPd43WMQzD+O2MfaDU
iZFP96Ujq+osxGZw4BZvEWH87om4Sg==
=UBXe
-----END PGP SIGNATURE-----

--PQJ8HpQWsK1FVPfGgTk4j87IY6ZJBUhkS--
