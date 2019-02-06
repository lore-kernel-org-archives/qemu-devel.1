Received: from eggs.gnu.org ([209.51.188.92]:56494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grR46-00025B-WA
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grR44-00075I-Uv
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:32:50 -0500
References: <20190206165342.219192-1-vsementsov@virtuozzo.com>
	<20190206165342.219192-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <abf6dafa-da7d-4bf5-5a21-225c2809a038@redhat.com>
Date: Wed, 6 Feb 2019 11:32:31 -0600
MIME-Version: 1.0
In-Reply-To: <20190206165342.219192-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HJkmJYiOOIoSFVBHH477NMBNWS7tL12lO"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] block/io: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HJkmJYiOOIoSFVBHH477NMBNWS7tL12lO
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com
Message-ID: <abf6dafa-da7d-4bf5-5a21-225c2809a038@redhat.com>
Subject: Re: [PATCH v2 2/2] block/io: use qemu_iovec_init_buf
References: <20190206165342.219192-1-vsementsov@virtuozzo.com>
 <20190206165342.219192-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190206165342.219192-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 10:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Use new qemu_iovec_init_buf() instead of
> qemu_iovec_init_external( ... , 1), which simplifies the code.

Did you just do a manual search for candidate callers?

As you said in the cover letter, there are other files that can benefit
as well; are you planning on making v3 of the series longer?

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 90 +++++++++++++-----------------------------------------=

>  1 file changed, 21 insertions(+), 69 deletions(-)

But I'm loving the diffstat - it is definitely a nice change.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HJkmJYiOOIoSFVBHH477NMBNWS7tL12lO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbGi8ACgkQp6FrSiUn
Q2riqAf+NnYhg2z+bTI3nfLi+lPRoEe+NAfaWfaQ9mafGE1WqFENGre3SgcN0pXe
hHc5gnn1sCvPV8GqHJ/QnOPz/X0UQbv7QJTlGHIHKuna+z5dI7CNNYEQ8a6Ol1nt
jXQ6uKU02mtz1YwNY9ZWgZAAto3id9SMqIon7HtIyVpmoGin88Ik+UnYibDPSpne
+IPsb0t7ke+wV0+/Bp4oDjWUIWY6o7N4tkAdKAKYYXn02pr/RtykRdmAhinR5jeB
fPrzbmfqWDNPzj7UcZdTRpID0cT1+zIhDoRtIX6oYR+DfTkXJQaawodnLpGZG+nQ
axhVg1X40gxvWANTnPISvSIxFM+23Q==
=jd5x
-----END PGP SIGNATURE-----

--HJkmJYiOOIoSFVBHH477NMBNWS7tL12lO--
