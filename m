Received: from eggs.gnu.org ([2001:4830:134:3::10]:50547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfT7Z-0001eM-0X
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfT7X-0005Dq-Ke
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:42:09 -0400
References: <20170809151757.15743-1-vsementsov@virtuozzo.com>
	<565de2a2-316a-1b2e-95e3-6b2b2086484f@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <93a7eaf1-3387-0772-b779-b1ff3d3b9443@redhat.com>
Date: Wed, 9 Aug 2017 10:41:54 -0500
MIME-Version: 1.0
In-Reply-To: <565de2a2-316a-1b2e-95e3-6b2b2086484f@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kw2HDw68M7TWVwj6vGdoClnsJdCajXHK9"
Subject: Re: [Qemu-devel] [PATCH v2 for 2.10] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kw2HDw68M7TWVwj6vGdoClnsJdCajXHK9
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com
Message-ID: <93a7eaf1-3387-0772-b779-b1ff3d3b9443@redhat.com>
Subject: Re: [PATCH v2 for 2.10] iotests: fix 185
References: <20170809151757.15743-1-vsementsov@virtuozzo.com>
 <565de2a2-316a-1b2e-95e3-6b2b2086484f@virtuozzo.com>
In-Reply-To: <565de2a2-316a-1b2e-95e3-6b2b2086484f@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 10:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> 09.08.2017 18:17, Vladimir Sementsov-Ogievskiy wrote:
>> 185 can sometimes produce wrong output like this:
>>

>>
>> This is because quite happens before first mirror request is done
>=20
> s/quite/quit/
>=20
>> (and, in specified case, even before block-job len field is set).
>> To prevent it let's just add a sleep for 0.3 seconds before quite.

Here, as well.

Maybe:

This is because, under heavy load, the quit can happen before the first
iteration of the mirror request has occurred.  To make sure we've had
time to iterate, let's just add a sleep for 0.3 seconds before quitting.


>>       "return"
>>   +# If we don't sleep here 'quit' command may be handled before
>> +# the first mirror iteration is done
>> +sleep 0.5

The commit message disagrees with the code (.3 vs. .5) - which one is
correct?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kw2HDw68M7TWVwj6vGdoClnsJdCajXHK9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLLUIACgkQp6FrSiUn
Q2rlnwgAkZdQI6igfom3FkGI3NObHyy4iWFdPlO7qzmakTw6tVyW1neUdwdFjTIS
fj+PREjsdffvpf4TxwkhPxFHt2JatxPqNoq63iHC3wVnPDVDUvEsCVFjnE15Oi52
p9qFUOeHPJFz/TSsBiCmEGhxdVMfQIQ7MaG8zv5pKti6c76TESJ7U1vla4HjAxTY
rRzwOSwcamkOGG+WjblT1F3V/bXY7fhZoRjFciHhFJUJRyFpKEcBk8Yr1ndx5j+K
ltfqEHqav042VSC4/tX1bQPwJUes+sDH82+73eJaJR33rGc3VtkBy8Si8Bd0my6O
+a4KFBJstAuXbLM+6YHisj7iVwtveg==
=1tR9
-----END PGP SIGNATURE-----

--kw2HDw68M7TWVwj6vGdoClnsJdCajXHK9--
