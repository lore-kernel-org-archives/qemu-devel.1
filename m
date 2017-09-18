Received: from eggs.gnu.org ([2001:4830:134:3::10]:51844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du1Wm-0001dN-9c
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1du1Wl-0005zu-66
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 15:16:20 -0400
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
	<20170918135935.255591-6-vsementsov@virtuozzo.com>
	<cd7f10e4-2e78-5108-f744-eab2babb5965@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be18253e-86a1-3478-f5c0-73061f88423a@redhat.com>
Date: Mon, 18 Sep 2017 14:16:11 -0500
MIME-Version: 1.0
In-Reply-To: <cd7f10e4-2e78-5108-f744-eab2babb5965@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GU12DKOSV2qOuk9aXvLaboaTccoSbTiLI"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] block/nbd-client:
 nbd_co_send_request: return -EIO if s->quit was set in parallel
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
--GU12DKOSV2qOuk9aXvLaboaTccoSbTiLI
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com
Message-ID: <be18253e-86a1-3478-f5c0-73061f88423a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/7] block/nbd-client:
 nbd_co_send_request: return -EIO if s->quit was set in parallel
References: <20170918135935.255591-1-vsementsov@virtuozzo.com>
 <20170918135935.255591-6-vsementsov@virtuozzo.com>
 <cd7f10e4-2e78-5108-f744-eab2babb5965@redhat.com>
In-Reply-To: <cd7f10e4-2e78-5108-f744-eab2babb5965@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 11:01 AM, Eric Blake wrote:
> On 09/18/2017 08:59 AM, Vladimir Sementsov-Ogievskiy wrote:
>> It's incorrect to return success rc >=3D 0 if we skip qio_channel_writ=
ev_all()
>> call due to s->quit.
>=20
> Does this need to cc: qemu-stable for 2.10.1 (or put another way, can w=
e
> come up with some scenario of EAGAIN or other handling that would
> actually set s->quit in a parallel coroutine when a client sends out
> multiple requests at once)?

Also, long subject line (longer than 80 columns!).  I'd suggest
something like:

nbd-client: fail with -EIO on early exit of nbd_co_send_request

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GU12DKOSV2qOuk9aXvLaboaTccoSbTiLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnAG3sACgkQp6FrSiUn
Q2pqMwf/WMk7onShi5KqAR1y1S83i65iEouBgxZF2W2ezGQVjWIq/F9ymyMNEe83
Hx1N3tpxMSdlpBeFRL9SUY+SoyNWtF6txiwip+SSve1YHE9P3bEf9z+NDcqH82t1
+JBXI6E49OXVH36IsWJCdY+HMeET8QeWqGJsqNXwm2jXa+0u/2vYiOjQik4QxKau
hOnhETG6uf3M/tWOjjqglMbyac3bIDD3TQKcsygLUDGaZxnYejn2fHHkHEoi6hdV
SZ+JPQQ5WkcVtrO63RFONNCY18bFO2z/7vmyfKeuaNh5eTTDQcvdZJ0I3HdtWBxF
KtvcDv64vVXAkSmI3s+rGN+6AqyfcQ==
=THrH
-----END PGP SIGNATURE-----

--GU12DKOSV2qOuk9aXvLaboaTccoSbTiLI--
