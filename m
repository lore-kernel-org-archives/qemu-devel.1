Received: from eggs.gnu.org ([2001:4830:134:3::10]:48309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUvJe-0000YF-4s
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUvJa-0002AS-UK
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:35:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dUvJa-0002A2-Nu
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:34:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D736774861
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:34:56 +0000 (UTC)
Date: Tue, 11 Jul 2017 14:34:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170711133452.GS17792@stefanha-x1.localdomain>
References: <20170710072027.7948-1-famz@redhat.com>
	<20170710072027.7948-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6pbY/KU4ayLo+qis"
Content-Disposition: inline
In-Reply-To: <20170710072027.7948-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/5] aio: Wrap poll parameters into
 AioContextPollParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com


--6pbY/KU4ayLo+qis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 03:20:23PM +0800, Fam Zheng wrote:
> The same set of parameters will also be wanted by the coming iothread
> group object, make a structure to slightly reduce the code duplication.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  include/block/aio.h       | 18 ++++++++++++------
>  include/sysemu/iothread.h |  5 +----
>  iothread.c                | 24 +++++++++---------------
>  util/aio-posix.c          | 10 +++++-----
>  util/aio-win32.c          |  4 ++--
>  5 files changed, 29 insertions(+), 32 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6pbY/KU4ayLo+qis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZNP8AAoJEJykq7OBq3PIuaMIAJ0NjoeG+JnX5n5lNhBYyK0L
n6ao3a6jEsoBs/ddy3zsCEe9TuUjA3ofBBgmt/WUMu2EY+dPx+5eUqaKupLJ8BCN
BLQJPpzl1+peNsjgUN3P0TbsTQQHk2xAOkwNB14Oipv/5ed/vxp+iKWdj3VT6XTF
vXVHr240vuT2dOWUR1tpIRCzdBwJ11thRd7afUlqyhEWlIdMe+mdBeycn9bCS0qR
/y1iHX0nsT4CmqceLOi35GtNbpKN6Hr4DPQ9uWGMvi7qN1OLMe9QJ1S14Mcn4qpd
3XJPT9/aAQofg4rKuBMZr0V6ZQ/xB5ryoLwEZaI61yvGZ9t6duOGaKrtFy2fYWs=
=iwrm
-----END PGP SIGNATURE-----

--6pbY/KU4ayLo+qis--
