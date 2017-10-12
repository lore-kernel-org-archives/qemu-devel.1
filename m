Received: from eggs.gnu.org ([2001:4830:134:3::10]:36108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lrq-0003fL-RX
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2lrn-0007oo-MQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 18:22:14 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8f7e0114-825d-be58-46a2-e2122b27576d@redhat.com>
Date: Thu, 12 Oct 2017 17:21:57 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l0FmqtJuPePNtt7oGo6pJelHXp5fiwxQs"
Subject: Re: [Qemu-devel] [PATCH v3 06/13] nbd/server: refactor
 nbd_co_send_simple_reply parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l0FmqtJuPePNtt7oGo6pJelHXp5fiwxQs
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <8f7e0114-825d-be58-46a2-e2122b27576d@redhat.com>
Subject: Re: [PATCH v3 06/13] nbd/server: refactor nbd_co_send_simple_reply
 parameters
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-7-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Pass client and buffer (*data) parameters directly, to make the functio=
n
> consistent with further structured reply sending functions.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--l0FmqtJuPePNtt7oGo6pJelHXp5fiwxQs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnf6wUACgkQp6FrSiUn
Q2rDLwf/dHwAPTFLwfX0K8vHQEqm+YnODOVshuzsIZLJa75V8bfr2pT9k2e/fz1u
uS2gEdZnZ8apY5PAtq4Z5fOA+5It7JnRa6udnCpkhaw7uSxMcyLM5QQs4AJjchc0
dMLcrRxkRB1+ZYBUNymCOUhsFGOtx4tM9/xpBzxqmUWSjKKTPPb3lgwXOX1ovCQ9
GFfeKyk8L0GOU3JqQ0cfo4jcPHWdXFFz2YwbDnzAu6Z2DyHOP542G5+0UGX6WJCJ
cWaMFuaVFrHhyl4rVejHHqMxsgdhFAk/ks3Dtqjjva4N8ySYHiycjj7hOu9th6pl
u3VA4AckX38p9OtL81YcXaxZwKZSlw==
=QXFl
-----END PGP SIGNATURE-----

--l0FmqtJuPePNtt7oGo6pJelHXp5fiwxQs--
