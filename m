Received: from eggs.gnu.org ([2001:4830:134:3::10]:38697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDROs-0002gn-TX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDROo-0007HI-OL
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:48:58 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-2-mreitz@redhat.com>
	<b208ed10-5763-23a1-c576-23aaa4fa22b2@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ed466764-8fdf-0737-5b8d-a469ee04bb06@redhat.com>
Date: Fri, 19 Oct 2018 11:48:45 +0200
MIME-Version: 1.0
In-Reply-To: <b208ed10-5763-23a1-c576-23aaa4fa22b2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C8U86ZH1Ae3oMj8OyhcNeBo14XKvZHguP"
Subject: Re: [Qemu-devel] [PATCH 1/9] iotests: Make nbd-fault-injector flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C8U86ZH1Ae3oMj8OyhcNeBo14XKvZHguP
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ed466764-8fdf-0737-5b8d-a469ee04bb06@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/9] iotests: Make nbd-fault-injector flush
References: <20181015141453.32632-1-mreitz@redhat.com>
 <20181015141453.32632-2-mreitz@redhat.com>
 <b208ed10-5763-23a1-c576-23aaa4fa22b2@redhat.com>
In-Reply-To: <b208ed10-5763-23a1-c576-23aaa4fa22b2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.10.18 20:07, Eric Blake wrote:
> On 10/15/18 9:14 AM, Max Reitz wrote:
>> When closing a connection, make the nbd-fault-injector flush the socke=
t.
>> Without this, the output is a bit unreliable with Python 3.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/083.out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 9 +++++++++
>> =C2=A0 tests/qemu-iotests/nbd-fault-injector.py | 1 +
>> =C2=A0 2 files changed, 10 insertions(+)
>=20
> I already had a complaint that the error message in 083.out should NOT
> be printing a message

You mean the NBD server itself, right?

>                       (whether the server is python 2 and auto-flushes,=

> or python 3 and needs an explicit flush, the message itself is
> pointless, and the test is racy as a result).=C2=A0 We may need to revi=
sit
> this patch when that thread is resolved.
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg01041.html

Well, it's not like the flush hurts either way. :-)

Max

> That said, I'm not opposed to this patch, if it gets iotests to be more=

> useful in the meantime.
>=20
>>
>> diff --git a/tests/qemu-iotests/083.out b/tests/qemu-iotests/083.out
>> index be6079d27e..f9af8bb691 100644
>> --- a/tests/qemu-iotests/083.out
>> +++ b/tests/qemu-iotests/083.out
>> @@ -41,6 +41,7 @@ can't open device nbd+tcp://127.0.0.1:PORT/foo
>> =C2=A0 =C2=A0 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D
>> =C2=A0 +Unable to read from socket: Connection reset by peer
>> =C2=A0 Connection closed
>> =C2=A0 read failed: Input/output error
>> =C2=A0 @@ -54,6 +55,7 @@ can't open device nbd+tcp://127.0.0.1:PORT/fo=
o
>> =C2=A0 =C2=A0 =3D=3D=3D Check disconnect before request =3D=3D=3D
>> =C2=A0 +Unable to read from socket: Connection reset by peer
>> =C2=A0 Connection closed
>> =C2=A0 read failed: Input/output error
>> =C2=A0 @@ -116,6 +118,7 @@ can't open device nbd+tcp://127.0.0.1:PORT/=

>> =C2=A0 =C2=A0 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D
>> =C2=A0 +Unable to read from socket: Connection reset by peer
>> =C2=A0 Connection closed
>> =C2=A0 read failed: Input/output error
>> =C2=A0 @@ -161,6 +164,8 @@ can't open device
>> nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
>> =C2=A0 =C2=A0 =3D=3D=3D Check disconnect after neg2 =3D=3D=3D
>> =C2=A0 +Unable to read from socket: Connection reset by peer
>> +Connection closed
>> =C2=A0 read failed: Input/output error
>> =C2=A0 =C2=A0 =3D=3D=3D Check disconnect 8 neg2 =3D=3D=3D
>> @@ -173,6 +178,8 @@ can't open device
>> nbd+unix:///foo?socket=3DTEST_DIR/nbd.sock
>> =C2=A0 =C2=A0 =3D=3D=3D Check disconnect before request =3D=3D=3D
>> =C2=A0 +Unable to read from socket: Connection reset by peer
>> +Connection closed
>> =C2=A0 read failed: Input/output error
>> =C2=A0 =C2=A0 =3D=3D=3D Check disconnect after request =3D=3D=3D
>> @@ -234,6 +241,8 @@ can't open device
>> nbd+unix:///?socket=3DTEST_DIR/nbd.sock
>> =C2=A0 =C2=A0 =3D=3D=3D Check disconnect after neg-classic =3D=3D=3D
>> =C2=A0 +Unable to read from socket: Connection reset by peer
>> +Connection closed
>> =C2=A0 read failed: Input/output error
>> =C2=A0 =C2=A0 *** done
>> diff --git a/tests/qemu-iotests/nbd-fault-injector.py
>> b/tests/qemu-iotests/nbd-fault-injector.py
>> index f9193c0fae..439a090eb6 100755
>> --- a/tests/qemu-iotests/nbd-fault-injector.py
>> +++ b/tests/qemu-iotests/nbd-fault-injector.py
>> @@ -112,6 +112,7 @@ class FaultInjectionSocket(object):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if rule.match(event, io):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if rule.when =3D=3D 0 or bufsize is None:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print('Closing con=
nection on rule match %s' %
>> rule.name)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.sock.flush()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sys.exit(0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if rule.when !=3D -1:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rule.when
>>
>=20



--C8U86ZH1Ae3oMj8OyhcNeBo14XKvZHguP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJqH0ACgkQ9AfbAGHV
z0Cv9Af+MFc0lCamb8mnmhj6uZvSMh/nSFxfbgUt8tT5+vnANwlQCY9UfGWsISdt
aqmPrQyy6CXNHMqxvTdLdqDTrL0exGzlqrAuzJo9jPvxDFc1t2OiSvG/UnV7CXbg
thj5snsvqRO1kdyfrWjHWMByeVcq4t+K6xTKL+IiqthskK5f/9Xa8i256T6GTRZh
6e5fEj8NlYCTZ3PfR4pAcSkhnXOYA6stR8Ke0JFnfsEpR3nN2QiizcLGXivg7vqh
UTo4qbue2+/xoBzW8v72hvdziSYB1e8jKO17/dj10FBaIKnUkKEPh+RZNJqJiSBj
zuwY9pV3W7XpXWsWpUvrUbQLVdRCYg==
=gUs9
-----END PGP SIGNATURE-----

--C8U86ZH1Ae3oMj8OyhcNeBo14XKvZHguP--
