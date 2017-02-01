Received: from eggs.gnu.org ([2001:4830:134:3::10]:54028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYtxG-0002Cy-H4
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYtxF-0006hi-Ky
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:24:06 -0500
References: <20170126110435.2777-1-berrange@redhat.com>
	<20170126110435.2777-4-berrange@redhat.com>
	<20170126123530.GB23095@lemon.Home> <20170126132708.GB29127@redhat.com>
	<6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
	<8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
	<20170201121658.GF3232@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
Date: Wed, 1 Feb 2017 13:23:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170201121658.GF3232@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NvRJfseOF9ihcDdC2q9hHrrV0hn4G8ai0"
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
--NvRJfseOF9ihcDdC2q9hHrrV0hn4G8ai0
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <c4d38998-b862-90e6-6c4b-4b96a8d17bb4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
References: <20170126110435.2777-1-berrange@redhat.com>
 <20170126110435.2777-4-berrange@redhat.com>
 <20170126123530.GB23095@lemon.Home> <20170126132708.GB29127@redhat.com>
 <6a9aeec8-d4ee-a0aa-7e04-0ee4295fef80@redhat.com>
 <8a13c995-c094-2704-c770-214132b2d6cf@redhat.com>
 <20170201121658.GF3232@redhat.com>
In-Reply-To: <20170201121658.GF3232@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 13:16, Daniel P. Berrange wrote:
> On Wed, Feb 01, 2017 at 01:13:39PM +0100, Max Reitz wrote:
>> On 30.01.2017 19:37, Eric Blake wrote:
>>> On 01/26/2017 07:27 AM, Daniel P. Berrange wrote:
>>>> On Thu, Jan 26, 2017 at 08:35:30PM +0800, Fam Zheng wrote:
>>>>> On Thu, 01/26 11:04, Daniel P. Berrange wrote:
>>>>>> The -n arg to the convert command allows use of a pre-existing ima=
ge,
>>>>>> rather than creating a new image. This adds a -n arg to the dd com=
mand
>>>>>> to get feature parity.
>>>>>
>>>>> I remember there was a discussion about changing qemu-img dd's defa=
ult to a
>>>>> "conv=3Dnocreat" semantic, if so, "-n" might not be that useful. Bu=
t that part
>>>>> hasn't made it into the tree, and I'm not sure which direction we s=
hould take.
>>>>> (Personally I think default to nocreat is a good idea).
>>>>
>>>> Use nocreat by default would be semantically different from real "dd=
"
>>>> binary which feels undesirable if the goal is to make "qemu-img dd"
>>>> be as consistent with "dd" as possible.
>>>>
>>>> It would be trivial to rewrite this patch to add support for the "co=
nv"
>>>> option, allowing the user to explicitly give 'qemu-img dd conv=3Dnoc=
reat'
>>>> instead of my 'qemu-img dd -n' syntax, without changing default sema=
ntics.
>>>
>>> Adding 'conv=3Dnocreat' (and not '-n') feels like the right way to me=
=2E
>>
>> The original idea was to make conv=3Dnocreat a mandatory option, I thi=
nk.
>> qemu-img was supposed error out if the user did not specify it.
>=20
> I'm not really seeing a benefit in doing that - it would just break
> existing usage of qemu-img dd for no obvious benefit.

Well... Is there existing usage?

The benefit would be that one could (should?) expect qemu-img dd to
behave on disk images as if they were block devices; and dd to a block
device will not truncate or "recreate" it.

If you don't give nocreat, it's thus a bit unclear whether you want to
delete and recreate the target or whether you want to write into it.
Some may expect qemu-img dd to behave as if the target is a normal file
(delete and recreate it), others may expect it's treated like a block
device (just write into it). If you force the user to specify nocreat,
it would make the behavior clear.

(And you can always delete+recreate the target with qemu-img create.)

It's all a bit complicated. :-/

Max

> FYI, I've implemented "conv" with "nocreat" and "notrunc" options
> which i'll post once i've tested some more.
>=20
> Regards,
> Daniel
>=20



--NvRJfseOF9ihcDdC2q9hHrrV0hn4G8ai0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliR01oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdEUH/1YJqJqgH88HI6NZ6/85VMD1K7p5Qckh
iLTa8JlfhlPCvppS/QYE8/LqWdC4tTcxzDBLcuGiaiwpl7Vj6eXW6Yw6FOYsRmHo
xvX4bIOH1CxluUQ9fFOD3euogTF1b5MQQuyLOD9Lk0WiJmSN+ciztJyB9DBv2Ek9
WEjRJC6rU8tp/ARX7mcf46N+siLJEoM17lUqarBruyo1GuWIu9PPkCukU3rbzLF2
F8XnMiHzLE9PPhSejKXBG3WtY1qiRE4/rblhOaTJF4I273E7s0m9GqTr1A81Xm5W
5gL7hsdAedJp7ggmL0aslhiTthtVqNOHBkY+qPhTwh7kTV5sWYbSsbA=
=53os
-----END PGP SIGNATURE-----

--NvRJfseOF9ihcDdC2q9hHrrV0hn4G8ai0--
