Received: from eggs.gnu.org ([209.51.188.92]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEK5o-0003v4-FW
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEK5n-0001Ht-5O
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:45:12 -0400
References: <20190403030526.12258-1-eblake@redhat.com>
	<20190403030526.12258-5-eblake@redhat.com>
	<7f20c0df-5ff3-cd2f-391f-3dae1a4cb51c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77387fd3-3265-b48a-c2f6-a8a0613dfbb1@redhat.com>
Date: Wed, 10 Apr 2019 15:44:58 -0500
MIME-Version: 1.0
In-Reply-To: <7f20c0df-5ff3-cd2f-391f-3dae1a4cb51c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lXN7o32Pb9Z2M95NEAcAeW39pdi9YvpYS"
Subject: Re: [Qemu-devel] [PATCH 4/7] iotests: Update 241 to expose backing
 layer fragmentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lXN7o32Pb9Z2M95NEAcAeW39pdi9YvpYS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <77387fd3-3265-b48a-c2f6-a8a0613dfbb1@redhat.com>
Subject: Re: [PATCH 4/7] iotests: Update 241 to expose backing layer
 fragmentation
References: <20190403030526.12258-1-eblake@redhat.com>
 <20190403030526.12258-5-eblake@redhat.com>
 <7f20c0df-5ff3-cd2f-391f-3dae1a4cb51c@virtuozzo.com>
In-Reply-To: <7f20c0df-5ff3-cd2f-391f-3dae1a4cb51c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/8/19 8:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> 03.04.2019 6:05, Eric Blake wrote:
>> Previous commits have mentioned that our NBD server still sends
>> unaligned fragments when an active layer with large advertised minimum=

>> block size is backed by another layer with a smaller block
>> size. Expand the test to actually cover this scenario, by using qcow2
>> encryption (which forces 512-byte alignment) with an unaligned raw
>> backing file.
>>
>> The test passes, but only because the client side works around the
>> server's non-compliance; if you repeat the test manually with tracing
>> turned on, you will see the server sending a status for 1000 bytes
>> data then 1048 bytes hole, which is not aligned. But reverting commit
>> 737d3f5244 shows that it is indeed the client working around the bug
>> in the server.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Oops, 241 fails for me:
>=20
> -WARNING: Image format was not specified for '/home/eblake/qemu/tests/q=
emu-iotests/scratch/t.raw' and probing guessed raw.
> +WARNING: Image format was not specified for '/work/src/qemu/eric/tests=
/qemu-iotests/scratch/t.raw' and probing guessed raw.
>=20
> We forget to filter output :(

The filter bug is pre-existing; separate patch for that is now posted.

>=20
> Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

I saw this email before -rc3, but thought I had only introduced the
problem in this patch which I omitted from my rc3 pull request. Oh well,
the actual break in iotests came earlier; if there's an -rc4 for other
reasons, we'll get the test fixed then.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--lXN7o32Pb9Z2M95NEAcAeW39pdi9YvpYS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyuVcoACgkQp6FrSiUn
Q2o0cQf+IAtnrEi0vQYdC1KCx134jRTfmA4IXXmcSuxbYlDoA7/0Mt00SbwzMl/L
6dZMWkNjS79YpvzmjgwV7BSGuaygwIoDNqc4tWb3d624zgCXKEq5WOiN7Rq9k3hA
9kO/u8ES8WmoQ6Zb7lU0rDe3TXXc5+4eAk6p+lG8BUxx9P2GXUBbjy7E7eaClj0t
Urk1PLLpDFmeBSylGI3g1RJKNYh00OlVhE468drOBH1t5ey34s3J9MCQpEI5cIIB
H+sI515YLBYYNGzjdhRUqn1yeskWTRz1VRch3TEFjpk9m1Rxp2SRr/m+/mdepxlx
oMwrkJP9COPZQHgNW3DxUD46ANKPWg==
=ecaD
-----END PGP SIGNATURE-----

--lXN7o32Pb9Z2M95NEAcAeW39pdi9YvpYS--
