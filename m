Received: from eggs.gnu.org ([209.51.188.92]:54773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gs0lI-0003CI-0m
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gs0lH-00062C-1R
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:39:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gs0l9-0005vJ-Bl
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 02:39:41 -0500
Date: Fri, 8 Feb 2019 15:39:26 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190208073926.GJ16257@stefanha-x1.localdomain>
References: <20190206151425.105871-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
Content-Disposition: inline
In-Reply-To: <20190206151425.105871-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] qemugdb/coroutine: fix arch_prctl has
 unknown return type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 06:14:25PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> qemu coroutine command results in following error output:
>=20
> Python Exception <class 'gdb.error'> 'arch_prctl' has unknown return
> type; cast the call to its declared return type: Error occurred in
> Python command: 'arch_prctl' has unknown return type; cast the call to
> its declared return type
>=20
> Fix it by giving it what it wants: arch_prctl return type.
>=20
> Information on the topic:
>    https://sourceware.org/gdb/onlinedocs/gdb/Calling.html
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/qemugdb/coroutine.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcXTIuAAoJEJykq7OBq3PIdbAH/RcTWhf5rJzLBfinO0K7pHah
pWk97vbgpaOqJLGOLq7ClkV7vk5fqaXIc+Ewwsddf6XXeT+N4xTanv0fMHQBjjIs
t7dGHAz/jYe92PsiarrOWUIP1DXjle5qASAsBv49PN/xeHJd+Nbss1OEigO/dcsN
6ofDjiY2L0CEZzqUFczl5BG/DnqNnqIQbctwZIkKoHAA1Xdswh87TE8R/HWiAZSt
YSXNW7wzaOXlHdlCFc9rSALG3dmdp2JXTJkASYuSCEZX4tmNAgf+21zeW05xiQ1F
44e20iZ6BhnVL3PWuLkZRHrXGXjpZH+r1EeWn2L+lXH6sj7tK1drAK0Djt+XY4w=
=KIQ6
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--
