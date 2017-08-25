Received: from eggs.gnu.org ([2001:4830:134:3::10]:34148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlMTR-0007Ub-GR
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlMTQ-0005WS-EW
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 17:49:05 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<20170804151440.320927-9-vsementsov@virtuozzo.com>
	<a5cac2fe-5c00-e924-b38d-d34769df6a76@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f0fc671b-ed26-084f-ca4e-8caccfefafd5@redhat.com>
Date: Fri, 25 Aug 2017 16:48:56 -0500
MIME-Version: 1.0
In-Reply-To: <a5cac2fe-5c00-e924-b38d-d34769df6a76@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dPCiOhHwQIO8up3Gus4HuSftvjSoLOTDi"
Subject: Re: [Qemu-devel] [PATCH 08/17] block/nbd-client: rename
 nbd_recv_coroutines_enter_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dPCiOhHwQIO8up3Gus4HuSftvjSoLOTDi
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <f0fc671b-ed26-084f-ca4e-8caccfefafd5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/17] block/nbd-client: rename
 nbd_recv_coroutines_enter_all
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
 <20170804151440.320927-9-vsementsov@virtuozzo.com>
 <a5cac2fe-5c00-e924-b38d-d34769df6a76@redhat.com>
In-Reply-To: <a5cac2fe-5c00-e924-b38d-d34769df6a76@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/25/2017 01:43 PM, Eric Blake wrote:
> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Rename nbd_recv_coroutines_enter_all to nbd_recv_coroutines_wake_all,
>> as it most probably just add all recv coroutines into co_queue_wakeup,=


s/adds/

>> not directly enter them.

s/not/rather than/

>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  block/nbd-client.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dPCiOhHwQIO8up3Gus4HuSftvjSoLOTDi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgm0gACgkQp6FrSiUn
Q2o23Qf/W6dohCZSmZbeTcL1pfawWyUWx2OtRBdArhrzm6RN+wTmDuEYl6rqFFFp
uTtR3NIaEOX45SY8nmg2V3KA/K5Nid5Xef8WpoT1fnV61oMmegOmfohZiI7qzO6O
+GwcFPlQzOAtL7pwq3eKY/2WkzVaR1Y9Du8Z9ArCP0EkWFhBRuvt667IO4FzytyW
hX31aiSu0tj2pXskjMDosfqWZEQscWKC2Hqex8IZO7D2nhRfYjw/Q6VSVuxpd3IG
J4RCLRFkMu5K6uGn9j2MxYO123vWtdYz6Wx0dKiAAnzhlzRU5jaPI8CJSEbZ7wYX
TfG4tt7lVu4aRfBrZ2agfTpyZ5WYjQ==
=pmww
-----END PGP SIGNATURE-----

--dPCiOhHwQIO8up3Gus4HuSftvjSoLOTDi--
