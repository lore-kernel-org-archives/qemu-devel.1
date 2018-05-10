Received: from eggs.gnu.org ([2001:4830:134:3::10]:52348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGiYe-0005PW-5l
	for qemu-devel@nongnu.org; Thu, 10 May 2018 06:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGiYb-0002E7-0c
	for qemu-devel@nongnu.org; Thu, 10 May 2018 06:12:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fGiYa-0002Dy-ST
	for qemu-devel@nongnu.org; Thu, 10 May 2018 06:12:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 903CD76FB9
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 10:12:16 +0000 (UTC)
Date: Thu, 10 May 2018 11:12:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510101214.GR1296@stefanha-x1.localdomain>
References: <20180509041734.14135-1-peterx@redhat.com>
	<20180509041734.14135-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ivHc2SZskddb40s2"
Content-Disposition: inline
In-Reply-To: <20180509041734.14135-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/4] monitor: more comments on lock-free
 fleids/funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--ivHc2SZskddb40s2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 12:17:33PM +0800, Peter Xu wrote:
> Add some explicit comment for both Readline and cpu_set/cpu_get helpers
> that they do not need the mon_lock protection.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ivHc2SZskddb40s2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9Br+AAoJEJykq7OBq3PIPZIH/iDbRJLWtqYiUWXOvnFSARbT
JM+E47d+lPBqsoTdSAcPHvER3tiQAgScmhAKVeVMsSHObckiHSLzxFZg+RXK47gs
xvyM1ZfvQZSYvL45fMMJ2/gAY4GMMWTgOxiGEPji0dHh1kdCnJ0mYgPwMwJtS44p
wviTax3ddsegLqMNulaoLTgQ5BrNRILpl7QvtV73OXsbEorf9WEHD86VbTSxxXqf
Re/rXaf4nhNaClcz4zN7iXdOEVwokS54vV9mhfoFjDqhGE1q+YQG6xHKaHd9wfsm
TlAtDotnzo9tfOy1xmvdqVj0myFyNAVHOCgDppQ/J0W7hFvS5r3Ri4IpARGdVbk=
=22pS
-----END PGP SIGNATURE-----

--ivHc2SZskddb40s2--
