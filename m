Received: from eggs.gnu.org ([209.51.188.92]:45592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj4Nr-0000F4-VK
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj4Nr-0003eg-2q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:42:39 -0500
References: <20190111194720.15671-1-eblake@redhat.com>
	<20190111194720.15671-2-eblake@redhat.com>
	<e96bdd9f-a470-8b12-0c27-275a608c4244@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd330ccb-c57c-b7e4-16d7-4cc9783aaaa3@redhat.com>
Date: Mon, 14 Jan 2019 09:42:34 -0600
MIME-Version: 1.0
In-Reply-To: <e96bdd9f-a470-8b12-0c27-275a608c4244@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OOlcCWh5ZPzmPQl8W9dCtQdUsRFiVoSe4"
Subject: Re: [Qemu-devel] [PATCH v3 1/8] nbd: Add some error case testing to
 iotests 223
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
--OOlcCWh5ZPzmPQl8W9dCtQdUsRFiVoSe4
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <fd330ccb-c57c-b7e4-16d7-4cc9783aaaa3@redhat.com>
Subject: Re: [PATCH v3 1/8] nbd: Add some error case testing to iotests 223
References: <20190111194720.15671-1-eblake@redhat.com>
 <20190111194720.15671-2-eblake@redhat.com>
 <e96bdd9f-a470-8b12-0c27-275a608c4244@virtuozzo.com>
In-Reply-To: <e96bdd9f-a470-8b12-0c27-275a608c4244@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/14/19 2:25 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.01.2019 22:47, Eric Blake wrote:
>> Testing success paths is important, but it's also nice to highlight
>> expected failure handling, to show that we don't crash, and so that
>> upcoming tests that change behavior can demonstrate the resulting
>> effects on error paths.
>>
>> Add the following errors:
>> Attempting to export without a running server
>> Attempting to start a second server
>> Attempting to export a bad node name
>> Attempting to export a name that is already exported
>> Attempting to export an enabled bitmap
>> Attempting to clean an already cleaned export
>=20
> For me "clean" sounds not the same as "remove" (I used to the thought t=
hat
> remove means to remove object from larger object, and clean is clean th=
e
> object internally (remove its content?), but it continues to exist and =
all
> its relations with parents are not touched), but I'm really far from be=
ing
> an expert in English.

Sure, I'll s/clean/remove/ in that text.

>=20
>> Attempting to quit server a second time
>>
>> All of these properly complain except for a second server-stop,
>> which will be fixed next.
>=20
> hm, looks a bit strange to add test first and then fix bug, but on the
> other hand it's more demonstrative, OK for me.
>=20
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--OOlcCWh5ZPzmPQl8W9dCtQdUsRFiVoSe4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw8reoACgkQp6FrSiUn
Q2o1Sgf/dsSggR9QetVW3EKOfNoi6LOCNAUX8f3T196jrLIPW9AC66DRp9wvCvFU
MKiAGUdfu1+uaiinVToByG0JE36eYBQjVZN2kYoFvLSX6y6xqFbHG+/kfrArAF7n
RRFhR/ShuFQs3GPqucRReQKu8GJKD8nmh8DczUShhXolm9SR2O5utwjvtpAjUo2o
hIug2ICLK5cZznB8WWwZRktdr7EgTfqKzge8a7tYodnRMPXBhSq7qhHDq3HmjoWf
58gJMQZfhIEemoVMMKWyyH6Ran6RpFg5YOgLIzvTzAX0AaKJtW4eNMiuemrH6ljg
IGMNTdWKCcGTPfse8hZemTR2wETJVw==
=w0v0
-----END PGP SIGNATURE-----

--OOlcCWh5ZPzmPQl8W9dCtQdUsRFiVoSe4--
