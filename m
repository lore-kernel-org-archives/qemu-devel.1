Received: from eggs.gnu.org ([2001:4830:134:3::10]:55593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dCnZL-0005c2-Ci
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dCnZK-0007gU-IB
	for qemu-devel@nongnu.org; Mon, 22 May 2017 09:40:19 -0400
References: <20170508171302.17805-1-eblake@redhat.com>
	<2f66f2d1-ff51-8b41-8e7d-ef21297de97b@redhat.com>
	<ed7c0d92-94de-820f-bb80-000d8c6c9e6e@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c16a9700-10fb-2ebf-75b2-739528670439@redhat.com>
Date: Mon, 22 May 2017 15:40:06 +0200
MIME-Version: 1.0
In-Reply-To: <ed7c0d92-94de-820f-bb80-000d8c6c9e6e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m74DWT0BU4c6Pqc7kC7rOEQAmGirp1mhr"
Subject: Re: [Qemu-devel] [PATCH] block: Tweak error message related to
 qemu-img convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m74DWT0BU4c6Pqc7kC7rOEQAmGirp1mhr
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <c16a9700-10fb-2ebf-75b2-739528670439@redhat.com>
Subject: Re: [PATCH] block: Tweak error message related to qemu-img convert
References: <20170508171302.17805-1-eblake@redhat.com>
 <2f66f2d1-ff51-8b41-8e7d-ef21297de97b@redhat.com>
 <ed7c0d92-94de-820f-bb80-000d8c6c9e6e@redhat.com>
In-Reply-To: <ed7c0d92-94de-820f-bb80-000d8c6c9e6e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-20 00:07, Eric Blake wrote:
> On 05/19/2017 08:30 AM, Max Reitz wrote:
>> On 2017-05-08 19:13, Eric Blake wrote:
>>> When converting a 1.1 image down to 0.10, qemu-iotests 060 forces
>>> a contrived failure where allocating a cluster used to replace a
>>> zero cluster reads unaligned data.  Since it is a zero cluster
>>> rather than a data cluster being converted, changing the error
>>> message to match our earlier change in 'qcow2: Make distinction
>>> bewteen zero cluster types obvious' is worthwhile.
>=20
> I really had problems with that commit message. If you want to re-stage=
,
> you could s/bewteen/between/

Sure, can do (and done :-)).

Max


--m74DWT0BU4c6Pqc7kC7rOEQAmGirp1mhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZIuo4EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQChK
B/9GqgeUUV+e1ilr/1MngsA/XNBKhvy37O0mSiOwl5qXdZbMwA3/pj5h5tBwQwol
AB100/Fj9hGcSzjsNo/0WCEPXc680lDmJnbbC4zqsF4vldLEmmOxJ/HVkuvQ/OtZ
ih9C3a+/n/AuMnWRkTWmorhYcJdtuvlcDRTD0RQR0Uf0wTmk0DJkbbRvZEtOCBiI
WPjc4kq2qZZjtroQu0CXUGH5axRjnOMl9OsDMfxH1Enan0jzNVLYYvk3AUe80P7c
yPgRvTG/EEHYyp1eNBsTajROg9+gMm2L67eDMouD0zJC0WWHMRbCU2UXlOPJ9JA8
EeZy17TcSWVJj29ozc6bC6aP
=tIE9
-----END PGP SIGNATURE-----

--m74DWT0BU4c6Pqc7kC7rOEQAmGirp1mhr--
