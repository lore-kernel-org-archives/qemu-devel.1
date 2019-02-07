Received: from eggs.gnu.org ([209.51.188.92]:45974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlGO-0001K5-6y
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grlGF-0005hd-4F
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 10:06:46 -0500
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190207102445.71998-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f7974507-e373-c883-7ea7-ce4b7500520c@redhat.com>
Date: Thu, 7 Feb 2019 09:06:14 -0600
MIME-Version: 1.0
In-Reply-To: <20190207102445.71998-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IAnXkWQzpDsEE27XBv0J1OgepeP4hFTeb"
Subject: Re: [Qemu-devel] [PATCH v3 04/17] block/backup: use
 qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IAnXkWQzpDsEE27XBv0J1OgepeP4hFTeb
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, quintela@redhat.com, jcody@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com
Message-ID: <f7974507-e373-c883-7ea7-ce4b7500520c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/17] block/backup: use
 qemu_iovec_init_buf
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
 <20190207102445.71998-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/7/19 4:24 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new qemu_iovec_init_buf() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--IAnXkWQzpDsEE27XBv0J1OgepeP4hFTeb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcSWYACgkQp6FrSiUn
Q2oNCAf/RsKcFT1L60nTFej4l/OHpDeNNYw0NL2rneULGgRxVGT5aUSuBvxb6Nkj
6M8VjFbmra9Ace2Epf1faO5Mdo3WyQxzXfFIANtrB3gxVJffLQKdlEBA6VzAdIh7
di4PItiNUE5PjqT8GRR+75G9nGaXE0yTQN5b/S92XFkOQAO7HX/e9wvQ5fzlKL4q
i9Idg7hYhiiiCHZi9WEsrpu8e1bEB1Zkuu8ogHC/7dmE4ZtLFybP152nn0nfxXCt
pRafWkztYrlZMAtswCzZCa9/6+IMcOXWDAtwaODaw1k7LeVFSIBsLFJgxLuOevA5
HrOJsgKEgJ07n6uUWBDbC9vQd54kbg==
=3Nxj
-----END PGP SIGNATURE-----

--IAnXkWQzpDsEE27XBv0J1OgepeP4hFTeb--
