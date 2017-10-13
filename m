Received: from eggs.gnu.org ([2001:4830:134:3::10]:47032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2zow-0006Nt-RP
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2zor-0006Qd-0w
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:16:10 -0400
References: <150781866372.288.18433466623199909715@b58463cdfd5f>
	<accd9d19-e2f8-6476-c31d-f382055a44b0@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b93ec59a-bcaa-2e21-702f-9d0111d9da98@redhat.com>
Date: Fri, 13 Oct 2017 08:15:45 -0500
MIME-Version: 1.0
In-Reply-To: <accd9d19-e2f8-6476-c31d-f382055a44b0@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qpWMVLe61hlvFLWiItXv02cfSux5ajqOc"
Subject: [Qemu-devel] iotest 77 failure [was: [PATCH v2 0/5] backup
 improvements part 1]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.comqemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qpWMVLe61hlvFLWiItXv02cfSux5ajqOc
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 jsnow@redhat.com, qemu block <qemu-block@nongnu.org>
Message-ID: <b93ec59a-bcaa-2e21-702f-9d0111d9da98@redhat.com>
Subject: iotest 77 failure [was: [Qemu-devel] [PATCH v2 0/5] backup
 improvements part 1]
References: <150781866372.288.18433466623199909715@b58463cdfd5f>
 <accd9d19-e2f8-6476-c31d-f382055a44b0@virtuozzo.com>
In-Reply-To: <accd9d19-e2f8-6476-c31d-f382055a44b0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding qemu-block]

On 10/13/2017 02:37 AM, Vladimir Sementsov-Ogievskiy wrote:
> 077 is unrelated to backup, it's already broken test:
>=20
> i=3D1; while check -nbd 077; do echo $((i++)) - OK; done; echo $i - FAI=
L
>=20
> failed on 3rd try for me on master
>=20

>> 077=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch =
(see 077.out.bad)
>> --- /tmp/qemu-test/src/tests/qemu-iotests/077.out=C2=A0=C2=A0=C2=A0 20=
17-10-12
>> 14:02:13.000000000 +0000
>> +++ /tmp/qemu-test/build/tests/qemu-iotests/077.out.bad=C2=A0=C2=A0=C2=
=A0 2017-10-12
>> 14:29:25.909887675 +0000
>> @@ -40,9 +40,9 @@
>> =C2=A0 wrote XXX/XXX bytes at offset XXX
>> =C2=A0 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 blkdebug: Resuming request 'B'
>> +blkdebug: Resuming request 'A'
>> =C2=A0 wrote XXX/XXX bytes at offset XXX
>> =C2=A0 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -blkdebug: Resuming request 'A'
>> =C2=A0 wrote XXX/XXX bytes at offset XXX
>> =C2=A0 XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> =C2=A0 wrote XXX/XXX bytes at offset XXX

Looks like we have a data race. Kevin, you wrote this test, any ideas on
how we can make it more robust?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qpWMVLe61hlvFLWiItXv02cfSux5ajqOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlngvIIACgkQp6FrSiUn
Q2qWOQf/aoVBVrMBCzhlK5Ns8xJHCMdlHNThxJiteYDsKXQGQFAi2WD3gbpn/Bo9
lElQ81mmXVt2FbfAxRhys98KEit3CLlcpM6NDP30G52XG4nQaf6p/pasCTqrPB1T
XSswrKrS3qPj8RGdoRflNicAWw8Z5FryQVW2kZNrv6talN5Xzf7sCTbkqp6d4tfQ
Wl8asn5lPvjgcey0VhWYGM6VSBLcyKNsoo4viY2XkHLfwz/SKAvqpnbJqVt5IX/2
n9tK5M5/6Qy9lxdnTfRD8wUvzmucyZDkCh/xwyGGERcOgQbU2RsWVtRywwOSkxOn
O97vxvF2DA4YsNfwmLMlvXgWaDLqNw==
=VAy2
-----END PGP SIGNATURE-----

--qpWMVLe61hlvFLWiItXv02cfSux5ajqOc--
