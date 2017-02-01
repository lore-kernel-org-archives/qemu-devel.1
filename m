Received: from eggs.gnu.org ([2001:4830:134:3::10]:55671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYu4A-00017c-HL
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:31:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYu49-0000GN-3H
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:31:14 -0500
References: <20170126110435.2777-1-berrange@redhat.com>
	<20170126110435.2777-4-berrange@redhat.com>
	<20170126123530.GB23095@lemon.Home> <20170126132708.GB29127@redhat.com>
	<6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
	<8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
	<20170201121658.GF3232@redhat.com>
	<c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
	<20170201122854.GG3232@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
Date: Wed, 1 Feb 2017 13:31:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170201122854.GG3232@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j1u90S40hmL7E7bmEKPdfoJLiq7Xv9KH0"
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
--j1u90S40hmL7E7bmEKPdfoJLiq7Xv9KH0
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <37f445c0-c174-bca4-7073-7aa6c64046b0@redhat.com>
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
In-Reply-To: <20170201122854.GG3232@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 13:28, Daniel P. Berrange wrote:
> On Wed, Feb 01, 2017 at 01:23:54PM +0100, Max Reitz wrote:
>> On 01.02.2017 13:16, Daniel P. Berrange wrote:
>>> On Wed, Feb 01, 2017 at 01:13:39PM +0100, Max Reitz wrote:
>>>> On 30.01.2017 19:37, Eric Blake wrote:
>>>>> On 01/26/2017 07:27 AM, Daniel P. Berrange wrote:
>>>>>> On Thu, Jan 26, 2017 at 08:35:30PM +0800, Fam Zheng wrote:
>>>>>>> On Thu, 01/26 11:04, Daniel P. Berrange wrote:
>>>>>>>> The -n arg to the convert command allows use of a pre-existing i=
mage,
>>>>>>>> rather than creating a new image. This adds a -n arg to the dd c=
ommand
>>>>>>>> to get feature parity.
>>>>>>>
>>>>>>> I remember there was a discussion about changing qemu-img dd's de=
fault to a
>>>>>>> "conv=3Dnocreat" semantic, if so, "-n" might not be that useful. =
But that part
>>>>>>> hasn't made it into the tree, and I'm not sure which direction we=
 should take.
>>>>>>> (Personally I think default to nocreat is a good idea).
>>>>>>
>>>>>> Use nocreat by default would be semantically different from real "=
dd"
>>>>>> binary which feels undesirable if the goal is to make "qemu-img dd=
"
>>>>>> be as consistent with "dd" as possible.
>>>>>>
>>>>>> It would be trivial to rewrite this patch to add support for the "=
conv"
>>>>>> option, allowing the user to explicitly give 'qemu-img dd conv=3Dn=
ocreat'
>>>>>> instead of my 'qemu-img dd -n' syntax, without changing default se=
mantics.
>>>>>
>>>>> Adding 'conv=3Dnocreat' (and not '-n') feels like the right way to =
me.
>>>>
>>>> The original idea was to make conv=3Dnocreat a mandatory option, I t=
hink.
>>>> qemu-img was supposed error out if the user did not specify it.
>>>
>>> I'm not really seeing a benefit in doing that - it would just break
>>> existing usage of qemu-img dd for no obvious benefit.
>>
>> Well... Is there existing usage?
>=20
> It shipped in 2.8.0 though, so imho that means we have to assume there
> are users, and thus additions must to be backwards compatible from now
> on.

Depends. I don't think there are too many users, so we could still
justify a change if there's a very good reason for it.

I do agree that it's probably not a very good reason, though.

>> The benefit would be that one could (should?) expect qemu-img dd to
>> behave on disk images as if they were block devices; and dd to a block=

>> device will not truncate or "recreate" it.
>>
>> If you don't give nocreat, it's thus a bit unclear whether you want to=

>> delete and recreate the target or whether you want to write into it.
>> Some may expect qemu-img dd to behave as if the target is a normal fil=
e
>> (delete and recreate it), others may expect it's treated like a block
>> device (just write into it). If you force the user to specify nocreat,=

>> it would make the behavior clear.
>>
>> (And you can always delete+recreate the target with qemu-img create.)
>>
>> It's all a bit complicated. :-/
>=20
> If the goal is to be compatible with /usr/bin/dd then IIUC, the behavio=
ur
> needs to be
>=20
>  - If target is a block device, then silently assume nocreat|notrunc
>    is set, even if not specified by user
>=20
>  - If target is a file, then silently create & truncate the file
>    unless nocreat or notrunc are set

Yes. But you could easily argue that every image file is a "block device"=
=2E

Max


--j1u90S40hmL7E7bmEKPdfoJLiq7Xv9KH0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliR1QUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ASQgIAKsJFZDquMrqUp33jWtROoPDvTxISnxC
DZkUL16Y4OVeJj5g+znhOUlOia8q12zeHr6pSmYTmTNAVd6MdIlyscNu/a0405V2
ivWUElhjYsyP8asZuqI2ZYTY9L8b92qL0VyFONXqHKJV0USafpeDnu4zlN6uW9QD
NzNJm4Q5qUo6zYr+tSewdsstKeyRgLL7NYZCmEbcevcgjq2tAi/TnRAupXswuM4Y
QGfRY4oWox/3qSnTtc9+yBITIoJGQcuoMge+g4HKb5jBGsYyQIoQK976R/1q67F3
kRp0JbNs05aZx+0APNZa4Dcgb0F0YIOUu4l6LaDHHi14GijFNE/TAVE=
=RiY1
-----END PGP SIGNATURE-----

--j1u90S40hmL7E7bmEKPdfoJLiq7Xv9KH0--
