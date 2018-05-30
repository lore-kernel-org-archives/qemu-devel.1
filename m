Received: from eggs.gnu.org ([2001:4830:134:3::10]:36181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO3yu-0006rx-82
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO3ys-0006dv-Ie
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:29:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fO3ys-0006cz-DU
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:29:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA7AB40073B1
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:29:45 +0000 (UTC)
Date: Wed, 30 May 2018 17:29:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530162940.GF5973@stefanha-x1.localdomain>
References: <20180529055755.12404-1-peterx@redhat.com>
	<20180529055755.12404-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <20180529055755.12404-5-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 4/7] monitor: fix comment for
 monitor_lock
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


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 01:57:52PM +0800, Peter Xu wrote:
> Fix typo in d622cb5879c.  Meanwhile move these variables close to each
> other.  monitor_qapi_event_state can be declared static, add that.
>=20
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDtF0AAoJEJykq7OBq3PIGhUH/3lH9/2rgjz72KAczSSiraO9
2hw2OJ72uklS9TeauLbBY4KCvEpccP5crQLmhppUUn9Jq67yzeUubzbN7elZzJge
F3gFIKrJbGXZy+kqlRZNhg9BqAYvRVybbhgsInNxpQk0vl+2tm1hbdPQ5IVSFUnx
2qmt5qzw0z9I7bgnFh4rakqT25fSPpGibdb1DSt+s9UHl+mwMgb6ImuqXbO0F3/0
OjyBJvuZbuAHQZk4vbmLpg61QnsW0p1tggE7p1o1cVbq2rhj6nDhVYoHaMoJsypz
pDu/qH+FdMsVYUyas/dmz8L/0omKPI4hW34RPOaSDk3yxafH6X9QKJWe0LvWZt0=
=kHM5
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
