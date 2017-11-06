Received: from eggs.gnu.org ([2001:4830:134:3::10]:53922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eBgdS-0001i6-G6
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eBgdR-0003l2-LP
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:36:14 -0500
References: <cover.1509718618.git.berto@igalia.com>
	<fb53467cf48e95ff3330def1cf1003a5b862b7d9.1509718618.git.berto@igalia.com>
	<ad3990d7-4356-4764-4da2-01cc59a63075@redhat.com>
	<w518tfnglio.fsf@maestria.local.igalia.com>
	<w5160argl1p.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ec0fbf5f-0c42-1787-c6ea-4a64dbc58295@redhat.com>
Date: Mon, 6 Nov 2017 13:36:01 +0100
MIME-Version: 1.0
In-Reply-To: <w5160argl1p.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WgT959NfSKA5fOBUi1JuBf4C3R4ctGl7n"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/7] qcow2: Prevent
 allocating compressed clusters at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WgT959NfSKA5fOBUi1JuBf4C3R4ctGl7n
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry"
 <nasastry@in.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <ec0fbf5f-0c42-1787-c6ea-4a64dbc58295@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 3/7] qcow2: Prevent allocating compressed
 clusters at offset 0
References: <cover.1509718618.git.berto@igalia.com>
 <fb53467cf48e95ff3330def1cf1003a5b862b7d9.1509718618.git.berto@igalia.com>
 <ad3990d7-4356-4764-4da2-01cc59a63075@redhat.com>
 <w518tfnglio.fsf@maestria.local.igalia.com>
 <w5160argl1p.fsf@maestria.local.igalia.com>
In-Reply-To: <w5160argl1p.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-03 21:32, Alberto Garcia wrote:
> On Fri 03 Nov 2017 09:22:39 PM CET, Alberto Garcia wrote:
>>>> -        assert(offset);
>>>
>>> I don't think this assert() was meant as a protection against offset
>>> being 0. :-)
>>
>> After the new check offset is now guaranteed to be 0, so what's the
>> point of keeping the assert() ?
>=20
> I meant "guaranteed _not_ to be 0" :-)

That is the point of an assert.

An assert should not guard against something that can occur.  It should
express that something will always be true (in this case that the offset
is guaranteed not to be 0).  Then, someone who reads the code does not
have to read all code paths to check whether that condition is true.

If an assert checks a condition that can be true, it's wrong.  Then
either the code is buggy (like it was before this patch) or the error
should be handled gracefully instead of aborting the program.

In a perfect world, all assert()s would be checked at compile time.

Max


--WgT959NfSKA5fOBUi1JuBf4C3R4ctGl7n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloAVzESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ArIgH/R59x9iWOqUDyDYm52+8QC9K/9BjaCKL
rUdlvvQHigDEJiXxxwzrJuigYm/D1qOKq9xo86yv5bEFiEGanA8jNzD5wAOJil1y
NcooWLMZe4wtqmOfuyOqgUTqrqCoCTDQccYI+11AzZegCib1jgo/wur1srnlwINO
/9QbmAZxWFHgHmn7BrFgtc4Z1h669GzWYSmqtVciZNoZP9t/XxN4sB5rQ69rBGsA
PibV4nANx2PNSFuiKkI1VW4+aWrEU5BNA6Ix/svjpEB/qrD7ex3RJIB3CoSdAIR/
9VwWrdembGhZideaINsJ6sPLqRpEOmfCgtdIMPj728Q9Wx9r1rZROJ4=
=E6aQ
-----END PGP SIGNATURE-----

--WgT959NfSKA5fOBUi1JuBf4C3R4ctGl7n--
