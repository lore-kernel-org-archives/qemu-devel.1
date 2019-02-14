Received: from eggs.gnu.org ([209.51.188.92]:48678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu6wu-0005LT-Og
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu6ws-00051t-Of
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:40:27 -0500
References: <20181203175211.8230-1-mreitz@redhat.com>
	<20181203175211.8230-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1abab9a3-331c-5e37-7eea-64078680011d@redhat.com>
Date: Wed, 13 Feb 2019 20:35:09 -0600
MIME-Version: 1.0
In-Reply-To: <20181203175211.8230-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wnkYBaQmpSIMz89YPU5V6q5KNbXjKBh3f"
Subject: Re: [Qemu-devel] [PATCH for-next 3/6] blkdebug: Add @iotype error
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wnkYBaQmpSIMz89YPU5V6q5KNbXjKBh3f
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <1abab9a3-331c-5e37-7eea-64078680011d@redhat.com>
Subject: Re: [PATCH for-next 3/6] blkdebug: Add @iotype error option
References: <20181203175211.8230-1-mreitz@redhat.com>
 <20181203175211.8230-4-mreitz@redhat.com>
In-Reply-To: <20181203175211.8230-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/3/18 11:52 AM, Max Reitz wrote:
> This new error option allows users of blkdebug to inject errors only on=

> certain kinds of I/O operations.  Users usually want to make a very
> specific operation fail, not just any; but right now they simply hope
> that the event that triggers the error injection is followed up with
> that very operation.  That may not be true, however, because the block
> layer is changing (including blkdebug, which may increase the number of=

> types of I/O operations on which to inject errors).
>=20
> The new option's default has been chosen to keep backwards
> compatibility.
>=20
> Note that similar to the internal representation, we could choose to
> expose this option as a list of I/O types.  But there is no practical
> use for this, because as described above, users usually know exactly
> which kind of operation they want to make fail, so there is no need to
> specify multiple I/O types at once.  In addition, exposing this option
> as a list would require non-trivial changes to qemu_opts_absorb_qdict()=
=2E
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> If you want @iotype be a list, I have patches.

Might be interesting to see, whether or not we take them.

> ---
>  qapi/block-core.json | 26 +++++++++++++++++++++++
>  block/blkdebug.c     | 50 ++++++++++++++++++++++++++++++++++++--------=

>  2 files changed, 67 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--wnkYBaQmpSIMz89YPU5V6q5KNbXjKBh3f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxk090ACgkQp6FrSiUn
Q2owYgf6AzzbavAYo4raDvi3qJLjzBYje3pN/XWSbZyneaJycMXQ8nlgRDmwO+1s
b8Eo8uWTTHHf/myCc7QNQOZo0FrLVS5e1EFkGmCfAUY4caCTnFhP7/LDQtkN/7Rc
jMD6KVuLASp5G59OIg+lvqJ9RzJssaixQb0W85zWIFAEqFpuNGHYQmwKO8UH5abT
8wdQKhdL568zD1lgag7tKBzbNEBn/lNdcuglAmmgcOs76NisQEf+tfjHafLywcGH
dREcDlNCvSitX5DR5hOhHDvFo4Absf8VwaxEa35wq9YB7IwAW1p//D099dQOlF+V
NWLj8y1UM59zwutQ4mFi7EbevrHDPg==
=JJpK
-----END PGP SIGNATURE-----

--wnkYBaQmpSIMz89YPU5V6q5KNbXjKBh3f--
