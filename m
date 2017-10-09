Received: from eggs.gnu.org ([2001:4830:134:3::10]:42208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cvc-0005hY-RY
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1cvb-0007Hd-U9
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:37:24 -0400
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
	<20171009172723.190282-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <771ed367-ecac-0785-94cd-087ef85fdd7c@redhat.com>
Date: Mon, 9 Oct 2017 13:37:14 -0500
MIME-Version: 1.0
In-Reply-To: <20171009172723.190282-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aFt1pkvFHfrGVaLNrfU62VBXD7F6K3hd9"
Subject: Re: [Qemu-devel] [PATCH v2 01/10] block/nbd-client: assert qiov len
 once in nbd_co_request
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
--aFt1pkvFHfrGVaLNrfU62VBXD7F6K3hd9
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <771ed367-ecac-0785-94cd-087ef85fdd7c@redhat.com>
Subject: Re: [PATCH v2 01/10] block/nbd-client: assert qiov len once in
 nbd_co_request
References: <20171009172723.190282-1-vsementsov@virtuozzo.com>
 <20171009172723.190282-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171009172723.190282-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/09/2017 12:27 PM, Vladimir Sementsov-Ogievskiy wrote:
> Also improve the assertion: check that qiov is NULL for other commands
> than CMD_READ and CMD_WRITE.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--aFt1pkvFHfrGVaLNrfU62VBXD7F6K3hd9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnbwdoACgkQp6FrSiUn
Q2o8Ggf8ChZ1OALmtnb/1+Kmwi8gdH4IftbjnqOAzctrM2MlLLvEixjarLdAqBH3
O3aBprjEZjUMjLpEGpteOA14JdozkRLinr7WLQ2BgMQemikUtRzlwbzRj0MnfxVU
w45LhPrnMSnO/reD10qxCUilt8todtjU/ewZ3Khwc407ibIKv11Hg62/MgLrECHS
5x54R+2b5oGaX2G8rks3BH+F6onMjW/81ZbixTkD4/lE/5rXTTdAHoNJQI5P3Z/e
ULLIj6uR7t0SYGBs7nBHHOj4pRgO4OzGInELZpi0m8N5hLhrP8QSGVDBATcpltNR
CwjkHwTPAvCFr1wCPUO9NgyhWCD9Zw==
=Mi+X
-----END PGP SIGNATURE-----

--aFt1pkvFHfrGVaLNrfU62VBXD7F6K3hd9--
