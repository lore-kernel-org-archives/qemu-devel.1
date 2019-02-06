Received: from eggs.gnu.org ([209.51.188.92]:50350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grS19-0001EW-Vp
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grS19-00025E-9S
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:33:51 -0500
References: <20190206165342.219192-1-vsementsov@virtuozzo.com>
	<20190206165342.219192-3-vsementsov@virtuozzo.com>
	<abf6dafa-da7d-4bf5-5a21-225c2809a038@redhat.com>
	<aced9235-a3d7-e201-ce13-ff2094ac974f@virtuozzo.com>
	<608f7ff7-7b3c-939a-7bdb-852f63f4828e@redhat.com>
	<6cf6c085-3a28-0a7c-75b2-79f181e3ca6e@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09e2ef0f-7bda-4ad1-c583-b25e5d75a738@redhat.com>
Date: Wed, 6 Feb 2019 12:33:39 -0600
MIME-Version: 1.0
In-Reply-To: <6cf6c085-3a28-0a7c-75b2-79f181e3ca6e@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vW30fqJdEo9rq5mwDgDLKqUeVEoi79K7c"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] block/io: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vW30fqJdEo9rq5mwDgDLKqUeVEoi79K7c
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Message-ID: <09e2ef0f-7bda-4ad1-c583-b25e5d75a738@redhat.com>
Subject: Re: [PATCH v2 2/2] block/io: use qemu_iovec_init_buf
References: <20190206165342.219192-1-vsementsov@virtuozzo.com>
 <20190206165342.219192-3-vsementsov@virtuozzo.com>
 <abf6dafa-da7d-4bf5-5a21-225c2809a038@redhat.com>
 <aced9235-a3d7-e201-ce13-ff2094ac974f@virtuozzo.com>
 <608f7ff7-7b3c-939a-7bdb-852f63f4828e@redhat.com>
 <6cf6c085-3a28-0a7c-75b2-79f181e3ca6e@virtuozzo.com>
In-Reply-To: <6cf6c085-3a28-0a7c-75b2-79f181e3ca6e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 12:26 PM, Vladimir Sementsov-Ogievskiy wrote:

>>> shows a lot of, exactly 34 after io.c already updated.
>>> They are in different subsystems, so I think it should be simpler to =
push this
>>> one as a precedent and example, and then send separate patches (or se=
ries)
>>> per-maintainer.
>>
>> Most are block related, so getting it in through the block maintainers=

>> is probably the easiest - but you ARE right that one patch per one or
>> two files or two is going to be smartest (otherwise, it gets too big).=

>>

>> I'd group qed-table.c and qed.c; and the two hw/ide/ files; resulting =
in
>> 14 more patches to go.
>>
>=20
> So, you, think better is to make one common patch set? Ok, I'll do (hmm=
 or start doing)
> it tomorrow as v3 if no other opinions.

Yes, a v3 series of 16 patches for the entire conversion, and cc:
qemu-block, should be sufficient.  Looking forward to seeing v3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vW30fqJdEo9rq5mwDgDLKqUeVEoi79K7c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxbKIMACgkQp6FrSiUn
Q2qhxAf+Jc+bkXYkq5f+ql2MjjBumNRnFc8w9dMPiFWmFoPCjItlvXlV1WkMCjxd
uK5CS0KZ8xOplJ8eLR4mHgqn8Kls2xiQw0PGFL2tNHQR4h8ALjqukz5OF8sp7GFu
VD/Xbfi/rnKOViHOzafR+srmxrAuGNTBbh9DkUKfrGK7OzCmYObh4AePSt/NfSpH
wUAQSrjJPLVmRKwQvCFEovS84TNR73eala1QQvciSz62PEIb3GqZLWsYQUTrF2Vq
6+xD+34SwuOf8vRBoWUbmnW85nps0NMLcB+GCR/LovcGyejdoNvuKvMyfXbRwwVu
DEPhR6PLpcrQdJUs28aa7emZpLBbBw==
=lus5
-----END PGP SIGNATURE-----

--vW30fqJdEo9rq5mwDgDLKqUeVEoi79K7c--
