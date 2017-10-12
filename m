Received: from eggs.gnu.org ([2001:4830:134:3::10]:48796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2kqZ-0001o6-TT
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2kqY-0001Wx-Ug
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:16:51 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9792ab45-82bd-d2ba-3786-ccfc0cc91de9@redhat.com>
Date: Thu, 12 Oct 2017 16:16:41 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U42OiuAiTUXMmUwmJU3QVwIvVlnHJWuIr"
Subject: Re: [Qemu-devel] [PATCH v3 01/13] block/nbd-client: assert qiov len
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
--U42OiuAiTUXMmUwmJU3QVwIvVlnHJWuIr
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <9792ab45-82bd-d2ba-3786-ccfc0cc91de9@redhat.com>
Subject: Re: [PATCH v3 01/13] block/nbd-client: assert qiov len once in
 nbd_co_request
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Also improve the assertion: check that qiov is NULL for other commands
> than CMD_READ and CMD_WRITE.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/nbd-client.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Looks identical to v2, where I gave R-b:
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg01903.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--U42OiuAiTUXMmUwmJU3QVwIvVlnHJWuIr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnf27oACgkQp6FrSiUn
Q2osMQgAmuvn1ckMHvmUeB8pihXLhZN0AB8uqI6dVgOeajNgyPqePeFczqB6ywGj
oIrRNk6GraAxQP+gKfveE6LmpV6dgGIn24Skn+1IpDNaVqCn8liG+84twrhTttj4
pltXwxdZNBBGJxUV7+iECBVkdv4u2fqGIzA9bqY6cGwfZ0Srbx6wrSDOFzsJCo6o
S8MiGmFW/k3EJVbYlHwQ0pOJ8W9bcDDlpUwqsQ1uV55ocTWyPZ3qp8POABnGPm1f
yluKYt6FfPjA04JkJYifnfzzkJTKYOf53zJRsY5tiaam4gc/KP3IE1PXTpkgiAis
/WKGJsfQ4Ho6uQWBXjmYn9++L/yvgQ==
=UxpE
-----END PGP SIGNATURE-----

--U42OiuAiTUXMmUwmJU3QVwIvVlnHJWuIr--
