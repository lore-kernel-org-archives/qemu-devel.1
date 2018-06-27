Received: from eggs.gnu.org ([2001:4830:134:3::10]:53681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYBo9-00083t-97
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYBo6-0000cD-1v
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:52:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYBo5-0000bD-SM
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:52:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3762240704BB
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 14:52:29 +0000 (UTC)
Date: Wed, 27 Jun 2018 15:52:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627145227.GC6623@stefanha-x1.localdomain>
References: <20180619194549.15584-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <20180619194549.15584-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] simpletrace: Convert name from mapping
 record to str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 04:45:49PM -0300, Eduardo Habkost wrote:
> The rest of the code assumes that idtoname is a (int -> str)
> dictionary, so convert the data accordingly.
>=20
> This is necessary to make the script work with Python 3 (where
> reads from a binary file return 'bytes' objects, not 'str').
>=20
> Fixes the following error:
>=20
>   $ python3 ./scripts/simpletrace.py trace-events-all trace-27445
>   b'object_class_dynamic_cast_assert' event is logged but is not \
>   declared in the trace events file, try using trace-events-all instead.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/simpletrace.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can now successfully run simpletrace.py using Python 3.  Thanks!

Thanks, applied to my tracing-next tree:
https://github.com/stefanha/qemu/commits/tracing-next

Stefan

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM6SrAAoJEJykq7OBq3PIozUH/059a/DLeEriwoIBzE/Gnyi9
S4KYQt1PWRTHqYFIAw2ojGKYZQTJVf01DuVlX5w6zWxbaJLRqTyfM0ep1yEW8Q3l
j+jVZ5uk9IkDHLkXjaNgLQxNk/+UWksddG0l0wE32f9VuAI2xRqAAjRx1PnhPFrj
CtuRwo3zbpemytO6ltmCV/Zgw3M51TkFgS7FiaWY+zoIHyw34WDQXNLkSelm9Cc0
M9hZ6a4pd9q41c4tzT4Jj4TiO4pGl4YOECDK85uWqAa+ovMzKt78O4hyOuJRBpq4
FYuy+nxYo/obGg8wIMKLEKb3+K/rodaTHdNzDBW5XTDwsnCRo8AD8Itd70pjIEM=
=VgEh
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
