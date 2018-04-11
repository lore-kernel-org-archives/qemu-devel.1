Received: from eggs.gnu.org ([2001:4830:134:3::10]:50213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6KXh-00031i-4p
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6KXg-00007M-Ao
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:32:25 -0400
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <acbc503f-71bd-4eaf-fa7b-8e04c9b8ccf5@redhat.com>
Date: Wed, 11 Apr 2018 13:32:08 -0500
MIME-Version: 1.0
In-Reply-To: <20180411163940.2523-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XcSH5JeFdFp2VkTTALtAfm90X3wmtQDkY"
Subject: Re: [Qemu-devel] [PATCH 04/19] block: Don't manually poll in
 bdrv_drain_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XcSH5JeFdFp2VkTTALtAfm90X3wmtQDkY
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <acbc503f-71bd-4eaf-fa7b-8e04c9b8ccf5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/19] block: Don't manually poll in
 bdrv_drain_all()
References: <20180411163940.2523-1-kwolf@redhat.com>
 <20180411163940.2523-5-kwolf@redhat.com>
In-Reply-To: <20180411163940.2523-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2018 11:39 AM, Kevin Wolf wrote:
> All involved nodes are already idle, we called bdrv_do_draine_begin() o=
n

s/draine/drain/

> them.
>=20
> The comment in the code suggested that this were not correct because th=
e

s/were/was/

> completion of a request on one node could spawn a new request on a
> different node (which might have been drained before, so we wouldn't
> drain the new request). In reality, new requests to different nodes
> aren't spawned out of nothing, but only in the context of a parent
> request, and they aren't submitted to random nodes, but only to child
> nodes. As long as we still poll for the completion of the parent reques=
t
> (which we do), draining each root node separately is good enough.
>=20
> Remove the additional polling code from bdrv_drain_all_begin() and
> replace it with an assertion that all nodes are already idle after we
> drained them separately.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 41 ++++++++++++-----------------------------
>  1 file changed, 12 insertions(+), 29 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XcSH5JeFdFp2VkTTALtAfm90X3wmtQDkY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrOVKgACgkQp6FrSiUn
Q2qaQAf/ROkf1wV/9V+AoNa94xXepYxpnbcGbejqYFTxtn6sczvjJggBxMioyOCx
s45qpNt30mwJoM1wmRB/tMDI5r5CyZq5O/rNRXPs7NxGZvK+SMgy/OfqFshusSy7
M9qB2Gxc/VEUS3QNiTrr+GRUmLEL5I5IVaSbX0PyjBvyeiU+J9QnCcmnoyZMkOFC
zdx9LbGrdjs5ynsWRKahc8qreYY4GkZExFHxnkxOQccVg82+wnZzelzt0Ucm9OiE
qe8o1EbYoQqxMCxa7IpV2Z/stbDgVNTNmKeKPvAM/0nxg0nQsq13JVi+Ei+nq5LG
RnGD66L8YP24c4lDOsK0GXP0Cg8QbA==
=4pcs
-----END PGP SIGNATURE-----

--XcSH5JeFdFp2VkTTALtAfm90X3wmtQDkY--
