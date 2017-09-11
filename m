Received: from eggs.gnu.org ([2001:4830:134:3::10]:32801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1drLyB-0006rW-Oo
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1drLyA-0002F8-RX
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:29:35 -0400
References: <20170905151614.31303-1-cohuck@redhat.com>
	<20170905151614.31303-3-cohuck@redhat.com>
	<20170908110425.GC3283@localhost.localdomain>
	<20170908132439.3ab53d7d.cohuck@redhat.com>
	<20170908115414.GF3283@localhost.localdomain>
	<4374d570-cee8-5f82-7187-dcb7bf57bf55@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <7cb74027-4998-ff80-ae0a-69997df31d8c@redhat.com>
Date: Mon, 11 Sep 2017 12:29:17 +0200
MIME-Version: 1.0
In-Reply-To: <4374d570-cee8-5f82-7187-dcb7bf57bf55@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="03963JhE7eti18mOCwgbNKrb3geIiedh6"
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: use -ccw on s390x for 051
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: haoqf@linux.vnet.ibm.com, qemu-block@nongnu.org, david@redhat.com, agraf@suse.de, qemu-devel@nongnu.org, borntraeger@de.ibm.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--03963JhE7eti18mOCwgbNKrb3geIiedh6
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: haoqf@linux.vnet.ibm.com, qemu-block@nongnu.org, david@redhat.com,
 agraf@suse.de, qemu-devel@nongnu.org, borntraeger@de.ibm.com,
 mreitz@redhat.com
Message-ID: <7cb74027-4998-ff80-ae0a-69997df31d8c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: use -ccw on s390x for 051
References: <20170905151614.31303-1-cohuck@redhat.com>
 <20170905151614.31303-3-cohuck@redhat.com>
 <20170908110425.GC3283@localhost.localdomain>
 <20170908132439.3ab53d7d.cohuck@redhat.com>
 <20170908115414.GF3283@localhost.localdomain>
 <4374d570-cee8-5f82-7187-dcb7bf57bf55@redhat.com>
In-Reply-To: <4374d570-cee8-5f82-7187-dcb7bf57bf55@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 8.9.2017 v 17:55 Thomas Huth napsal(a):
> On 08.09.2017 13:54, Kevin Wolf wrote:
>> Am 08.09.2017 um 13:24 hat Cornelia Huck geschrieben:
>>> On Fri, 8 Sep 2017 13:04:25 +0200
>>> Kevin Wolf <kwolf@redhat.com> wrote:
>>>
>>>> Am 05.09.2017 um 17:16 hat Cornelia Huck geschrieben:
>>>>> The default cpu model on s390x does not provide zPCI, which is
>>>>> not yet wired up on tcg. Moreover, virtio-ccw is the standard
>>>>> on s390x, so use the -ccw instead of the -pci versions of virtio
>>>>> devices on s390x.
>>>>>
>>>>> Provide an output file for s390x.
>>>>>
>>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>> ---
>>>>>  tests/qemu-iotests/051                     |   9 +-
>>>>>  tests/qemu-iotests/051.s390-ccw-virtio.out | 434 +++++++++++++++++=
++++++++++++
>>>>>  2 files changed, 442 insertions(+), 1 deletion(-)
>>>>>  create mode 100644 tests/qemu-iotests/051.s390-ccw-virtio.out =20
>>>>
>>>> It's already a pain to have two separate output files for 051, let's=
 try
>>>> to avoid adding a third one. Even more so since I think that the spl=
it
>>>> between 051.out and 051.pc.out was already made for s390, so I'm not=

>>>> sure if anyone would actually still make use of the plain 051.out
>>>> output if s390 got it's own one.
>>>
>>> Are there no non-pc and non-s390 machines for which this is run?
>>
>> Who knows? But I'm not aware of anyone who is interested in something
>> else and has contributed to the test cases until now.
>=20
> FWIW, as far as I know, Luk=C3=A1=C5=A1 is running this test also on pp=
c64 in our
> weekly regression run. So it would be good to keep that working, please=
 :-)
>=20

Yes, works well on ppc64(le) and would be nice to keep it that way...

Luk=C3=A1=C5=A1

>>> Another approach would be to drop the -pci postfix, but I don't want =
to
>>> introduce more usage of aliases.
>>
>> Maybe that would indeed be the easiest way. As long as we don't intend=

>> to remove the alias from qemu, there's no reason not to use it in test=
s.
>=20
> Maybe we should even use it in a couple of places on purpose - so we ge=
t
> some test coverage for them?
>=20
>  Thomas
>=20



--03963JhE7eti18mOCwgbNKrb3geIiedh6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZtmWBExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsHR
VwgAj1Iv4Cz9pUtR6I36cm1F0rwbLmDreoLjdpxdcs78D2Jy2uxqTeumkv/xVu8s
gAKG0eBe6qYkGN82T2mBqpgUROEU+IQHN5cDK5+kzsVYO32B+dmgIRwbsipcjPsL
b6+fo+Xv/50zEQVWhhDUhYn6mk1PJTV7SGLGjmFpZWHoZf5xNJP30mO7Vla5KOU5
Y8wEkl8GPxg1Gsn3U1hbRCj8pwGAZQZW3Hr3XWlsklgOHA9U2IQS2MRP87QJVNVb
//2c+3r9qFNEFN90tAsFlug1mtba7NkfhYxC5TfBGX927X8BLE9I1E/Yj2Wpg8jq
PG+8cCdy1ct/bIZUljrroSz8ww==
=490u
-----END PGP SIGNATURE-----

--03963JhE7eti18mOCwgbNKrb3geIiedh6--
