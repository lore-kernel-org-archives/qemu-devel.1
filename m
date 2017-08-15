Received: from eggs.gnu.org ([2001:4830:134:3::10]:51926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhcjL-0007eG-VZ
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhcjL-0007oK-5n
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:22:03 -0400
References: <20170815130740.31229-1-famz@redhat.com>
	<20170815130740.31229-4-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <62ce5bf4-492f-8026-62a0-0ce42226dbfe@redhat.com>
Date: Tue, 15 Aug 2017 09:21:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170815130740.31229-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bP5QpGvmF4Lw989GnPQTO1OUmkudFpeho"
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 3/4] block-backend: Defer
 shared_perm tightening migration completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bP5QpGvmF4Lw989GnPQTO1OUmkudFpeho
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 stefanha@redhat.com
Message-ID: <62ce5bf4-492f-8026-62a0-0ce42226dbfe@redhat.com>
Subject: Re: [PATCH for-2.10 v2 3/4] block-backend: Defer shared_perm
 tightening migration completion
References: <20170815130740.31229-1-famz@redhat.com>
 <20170815130740.31229-4-famz@redhat.com>
In-Reply-To: <20170815130740.31229-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/15/2017 08:07 AM, Fam Zheng wrote:
> As in the case of nbd_export_new(), bdrv_invalidate_cache() can be
> called when migration is still in progress. In this case we are not
> ready to tighten the shared permissions fenced by blk->disable_perm.
>=20
> Defer to a VM state change handler.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bP5QpGvmF4Lw989GnPQTO1OUmkudFpeho
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmTA30ACgkQp6FrSiUn
Q2rVCAgAo3rNjBW7+MmiRSWJVezt4dbI4Z7FByxT1WJxXGvchXQV8w9RgrwtPkue
5vGC0FxlGxIeJ+EWm8C/0Zxb62WlEq5uYkiXjF95E1CGox/SoIuNfPykwX3lpAq6
aE/+k5QyEoA5JOa7ZfyVta4QL8hdZvs/C4gR7whrjJpGYqV8JIikIc9TTkd7rY5Z
vLbeXnii+wrwVAdvfAdZjAs0+0WWlNHjnd0Z2hUijga7xV475qI2H8hmVlPjWqhB
hPVUF1aGunCS8UVfoH4g7pSfAB6Zb2YQCm1hhU9jd4GQPPUMJVA+UAyb9129xBij
1LNw7a7ilK+if9v/MCPrcBEV2PT4vw==
=hTga
-----END PGP SIGNATURE-----

--bP5QpGvmF4Lw989GnPQTO1OUmkudFpeho--
