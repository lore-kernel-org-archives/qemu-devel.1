Received: from eggs.gnu.org ([2001:4830:134:3::10]:51356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsvp8-0004nD-Ci
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsvp7-0004nO-Dy
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:58:46 -0400
References: <20170915101008.16646-1-kwolf@redhat.com>
	<20170915101008.16646-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3b1071f-9cac-af64-982a-baa5c13f75cb@redhat.com>
Date: Fri, 15 Sep 2017 13:58:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170915101008.16646-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n532sskllLXMQIJJnXNW8HUE8OLDnnaGk"
Subject: Re: [Qemu-devel] [PATCH 4/6] block: Base permissions on rw state
 after reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n532sskllLXMQIJJnXNW8HUE8OLDnnaGk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <b3b1071f-9cac-af64-982a-baa5c13f75cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/6] block: Base permissions on rw state
 after reopen
References: <20170915101008.16646-1-kwolf@redhat.com>
 <20170915101008.16646-5-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/15/2017 05:10 AM, Kevin Wolf wrote:
> When new permissions are calculated during bdrv_reopen(), they need to
> be based on the state of the graph as it will be after the reopen has
> completed, not on the current state of the involved nodes.
>=20
> This patch makes bdrv_is_writable() optionally accept a BlockReopenQueu=
e
> from which the new flags are taken. This is then used for determining
> the new bs->file permissions of format drivers as soon as we add the
> code to actually pass a non-NULL reopen queue to the .bdrv_child_perm
> callbacks.
>=20
> While moving bdrv_is_writable(), make it static. It isn't used outside
> block.c.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h |  1 -
>  block.c               | 52 ++++++++++++++++++++++++++++++++++++-------=
--------
>  2 files changed, 37 insertions(+), 16 deletions(-)
>=20

> + * Return the flags that @bs will have after the reopens in @q have
> + * successfully completed. If @q is NULL (or @bs is not contained in @=
q),
> + * return the current flags.
> + */
> +static int bdrv_reopen_get_flags(BlockReopenQueue *q, BlockDriverState=
 *bs)

> +/* Returns whether the image file can be written to after the reopen q=
ueue @q
> + * has been successfully applied, or right now if @q is NULL. */
> +static bool bdrv_is_writable(BlockDriverState *bs, BlockReopenQueue *q=
)

Is it worth having both functions with arguments in the same order?

> +{
> +    int flags =3D bdrv_reopen_get_flags(q, bs);
> +

No real semantic impact to leave it as is, but it would avoid the odd
swap of arguments here.  So either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--n532sskllLXMQIJJnXNW8HUE8OLDnnaGk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm8ItoACgkQp6FrSiUn
Q2qxIAf9E5i+1G1gxditrc1XGqcOSaV9F1TNAydS7xdJdJVupSjxV+hu70D7R+KQ
jeubsgazmNuDDYjNlfnjtCNqlIcqP1Fh0UAn9rYC3fk9lcRva2aiLH3P6a1v5wF2
B/POXdb/bJwuzF+bHB8izvrqLzMySL3tn2g2mwrXvKAHkAjpmnRfZpHHqQZMlzKn
RYB0EDPzeq1mJ6c2EUS8oyjvEZd4zDKRF3PIWgUK/pke7RKpCr9n345JhMhziOH+
9Tllh54WWZVi0cWWMKGJxJDk/Pm3tpsZdRKxnv6oTbSkejm8NJKV8syu4h2nmyp+
T20OtGJZT3WaqIbTzIXiUxoyu0YELA==
=Be8K
-----END PGP SIGNATURE-----

--n532sskllLXMQIJJnXNW8HUE8OLDnnaGk--
