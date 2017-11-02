Received: from eggs.gnu.org ([2001:4830:134:3::10]:36591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAJt6-0006QN-W1
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAJt6-00004s-1N
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 14:06:44 -0400
References: <20171101154204.27146-1-vsementsov@virtuozzo.com>
	<20171101154204.27146-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f8feedf-9650-f004-dae0-c658759588d9@redhat.com>
Date: Thu, 2 Nov 2017 13:06:35 -0500
MIME-Version: 1.0
In-Reply-To: <20171101154204.27146-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jThuUeciQOWHakjuIqq8FmXcjeNcaa8jI"
Subject: Re: [Qemu-devel] [PATCH 2/2] nbd/server: add assert to
 nbd_negotiate_handle_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jThuUeciQOWHakjuIqq8FmXcjeNcaa8jI
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: den@openvz.org
Message-ID: <0f8feedf-9650-f004-dae0-c658759588d9@redhat.com>
Subject: Re: [PATCH 2/2] nbd/server: add assert to nbd_negotiate_handle_info
References: <20171101154204.27146-1-vsementsov@virtuozzo.com>
 <20171101154204.27146-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171101154204.27146-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/01/2017 10:42 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add an assert here to make last length assignment meaningful and
> following return without tail dropping obvious.

Not quite sure I followed your explanation, which means it's difficult
for me to propose an alternative wording.  Maybe:

Add an assert here to make it obvious that the prior loop consumed the
rest of the input, and that all further code in the function is focused
on output.

On the other hand, if you are okay with it, I wouldn't mind squashing
the first and second patches into one (as the first patch is then easier
to read when it is obvious that we used the wrong length variable).  But
until I get your feedback (on either squashing the two patches or
tweaking the wording), I'm just placing your patches as-is on my NBD
queue for inclusion prior to rc0.

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jThuUeciQOWHakjuIqq8FmXcjeNcaa8jI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln7XqsACgkQp6FrSiUn
Q2qHsgf7BtBdqkjDHLxSbCl9NCIruaxkV0bfMQ3YfIfGBYt4cXPiSVHHhuQou4Hv
Ux32dDSlhaO9/sUr19njBf+E5l/C9kJw4NQ1BUnOy6WdLXj9E4DUbZxfA7ZL8FvL
RWRrq/M7Z1v7a38vERsPp4ZcOBVjK1o2tn3elnqXV1mc72gTXco2H83jXUMrHOgg
E+hz/0X8B1Av6DHBBl2u2stc5GeSnQuK+6QsoXV6SZwaw7esCkvQHuqlQyKQWpAn
4CAc245+Gt8TfFNfUpdReCQETJXwPS7txBx0/uTcH3LudCYSrifIf+CJkC0Jd+gZ
tKDbXwC51Gebomhs7erIb2svQjOaoQ==
=1CIx
-----END PGP SIGNATURE-----

--jThuUeciQOWHakjuIqq8FmXcjeNcaa8jI--
