Received: from eggs.gnu.org ([2001:4830:134:3::10]:59352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYuMk-0002yA-Sx
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYuMk-00069z-07
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:50:26 -0500
References: <20170126110435.2777-1-berrange@redhat.com>
	<20170126110435.2777-4-berrange@redhat.com>
	<20170126123530.GB23095@lemon.Home> <20170126132708.GB29127@redhat.com>
	<6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
	<8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
	<20170201121658.GF3232@redhat.com>
	<c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
	<20170201122854.GG3232@redhat.com>
	<37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
	<20170201124014.GH3232@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bfc2e7a9-31c7-bb97-a199-032203f7a614@redhat.com>
Date: Wed, 1 Feb 2017 13:50:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170201124014.GH3232@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IGDvCAUxi4ipRj8xoKbEq3T0H0r7EXtRK"
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IGDvCAUxi4ipRj8xoKbEq3T0H0r7EXtRK
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <bfc2e7a9-31c7-bb97-a199-032203f7a614@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
References: <20170126110435.2777-1-berrange@redhat.com>
 <20170126110435.2777-4-berrange@redhat.com>
 <20170126123530.GB23095@lemon.Home> <20170126132708.GB29127@redhat.com>
 <6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
 <8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
 <20170201121658.GF3232@redhat.com>
 <c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
 <20170201122854.GG3232@redhat.com>
 <37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
 <20170201124014.GH3232@redhat.com>
In-Reply-To: <20170201124014.GH3232@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 13:40, Daniel P. Berrange wrote:
> On Wed, Feb 01, 2017 at 01:31:01PM +0100, Max Reitz wrote:
>> On 01.02.2017 13:28, Daniel P. Berrange wrote:
>>> On Wed, Feb 01, 2017 at 01:23:54PM +0100, Max Reitz wrote:
>>>> On 01.02.2017 13:16, Daniel P. Berrange wrote:

[...]

>>>> The benefit would be that one could (should?) expect qemu-img dd to
>>>> behave on disk images as if they were block devices; and dd to a blo=
ck
>>>> device will not truncate or "recreate" it.
>>>>
>>>> If you don't give nocreat, it's thus a bit unclear whether you want =
to
>>>> delete and recreate the target or whether you want to write into it.=

>>>> Some may expect qemu-img dd to behave as if the target is a normal f=
ile
>>>> (delete and recreate it), others may expect it's treated like a bloc=
k
>>>> device (just write into it). If you force the user to specify nocrea=
t,
>>>> it would make the behavior clear.
>>>>
>>>> (And you can always delete+recreate the target with qemu-img create.=
)
>>>>
>>>> It's all a bit complicated. :-/
>>>
>>> If the goal is to be compatible with /usr/bin/dd then IIUC, the behav=
iour
>>> needs to be
>>>
>>>  - If target is a block device, then silently assume nocreat|notrunc
>>>    is set, even if not specified by user
>>>
>>>  - If target is a file, then silently create & truncate the file
>>>    unless nocreat or notrunc are set
>>
>> Yes. But you could easily argue that every image file is a "block devi=
ce".
>=20
> IMHO that would be a bad idea as it would mean different behaviour
> from dd vs qemu-img dd, when run on raw files.

=46rom the perspective of qemu-img, however, a raw file is not a raw file=

but a disk image in raw format.

> If we assume nocreat|notrunc behaviour by default, then we would  likel=
y
> need to invent new "creat|trunc" flags to let people turn the previous
> behaviour back on, which would diverge from 'dd' command.

Not really, because you could just use qemu-img create.

I understand your standpoint. I'm just saying there is another
standpoint that also makes a lot of sense and that would imply different
default behavior.

In the end, retaining backwards compatibility will probably win the
discussion automatically, though. That is, always overwrite the target
image by default.


By the way, I plan to integrate all of qemu-img dd's functionality into
qemu-img convert eventually and make qemu-img dd just another interface
for qemu-img convert. Therefore, I'm all in favor of not touch
qemu-img dd until that is done so it doesn't get any more weird behavior
that needs to be supported later.

Max


--IGDvCAUxi4ipRj8xoKbEq3T0H0r7EXtRK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliR2YgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AtNUH/RB2CVuw0oPvdetuu1faFJn0mqmJiWk9
iSs8nOcWECpcPDBCMivmewQTlZOeyuac5p7WZqY6Gtsv7OsZrHwZQ2rKJtrbY3BF
trQ1W205l6dde5Ddeu2PDYhvojRlku/S/cz2pOF6D/CQgI1nFqZ+Y5vF7OoNfhKP
HRES0LEZ73BfkGHOcRSzjnFfbKXmt5gOWkyXzYDo6AfSoB04cW6fCKPFuicN4t0q
67K1TJNMSjYKP7v97jQXshCZqPQ2cxzH11lA9VMU6/Qzvs2Po9zzG4Hi9xAsHnuo
g9j4CsYuBY2MV1XyHzPXI3y0uDDXTI/B9DFbfQPLekib7sLP09RZiy0=
=yO8l
-----END PGP SIGNATURE-----

--IGDvCAUxi4ipRj8xoKbEq3T0H0r7EXtRK--
