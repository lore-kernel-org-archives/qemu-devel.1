Received: from eggs.gnu.org ([2001:4830:134:3::10]:60159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4CsX-0000uP-7Z
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4CsW-0008QS-3F
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:52:37 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-8-eblake@redhat.com>
	<99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
	<03c4ac54-99fd-4316-1867-8d16e0703605@redhat.com>
	<ed4433d0-debc-5df1-0b88-d3cafac6056e@redhat.com>
	<a5fdea31-c4ef-81e2-b3b3-baccef969143@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <14b4d2d8-ec55-853c-6d54-10829531dfa5@redhat.com>
Date: Fri, 28 Apr 2017 22:52:26 +0200
MIME-Version: 1.0
In-Reply-To: <a5fdea31-c4ef-81e2-b3b3-baccef969143@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rRFvppnP3N6vlj3bRLCfaG5SAhNisTbHP"
Subject: Re: [Qemu-devel] [PATCH v10 07/17] qemu-io: Switch 'alloc' command
 to byte-based length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rRFvppnP3N6vlj3bRLCfaG5SAhNisTbHP
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <14b4d2d8-ec55-853c-6d54-10829531dfa5@redhat.com>
Subject: Re: [PATCH v10 07/17] qemu-io: Switch 'alloc' command to byte-based
 length
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-8-eblake@redhat.com>
 <99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
 <03c4ac54-99fd-4316-1867-8d16e0703605@redhat.com>
 <ed4433d0-debc-5df1-0b88-d3cafac6056e@redhat.com>
 <a5fdea31-c4ef-81e2-b3b3-baccef969143@redhat.com>
In-Reply-To: <a5fdea31-c4ef-81e2-b3b3-baccef969143@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.04.2017 22:36, Eric Blake wrote:
> On 04/28/2017 03:09 PM, Max Reitz wrote:
>> On 28.04.2017 21:59, Eric Blake wrote:
>>> On 04/28/2017 02:46 PM, Max Reitz wrote:
>>>> On 27.04.2017 03:46, Eric Blake wrote:
>>>>> For the 'alloc' command, accepting an offset in bytes but a length
>>>>> in sectors, and reporting output in sectors, is confusing.  Do
>>>>> everything in bytes, and adjust the expected output accordingly.
>>>>>
>>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>>
>>>
>>>>>      }
>>>>> +    if (!QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE)) {
>>>>> +        printf("bytes %" PRId64 " is not sector aligned\n",
>>>>
>>>> This isn't real English. :-)
>>>
>>> But, it's just copy-and-paste from the other instances you just revie=
wed
>>> in 6/17!  [Translation - if I change this one, I also get to redo tha=
t one]
>>
>> No, those are "offset" and "count" -- all singular. "bytes" is plural.=
 ;-)
>=20
> Then an obvious solution: s/bytes/count/ in the parameter name :)
>=20
> But I still get to redo those, to add the '-' in 'sector-aligned'.

Oh, right! Didn't even notice. Well, in real languages stuff like that
would have to be joined into a single word anyway.

>>> Which of these various alternatives (if any) looks better:
>>>
>>> bytes=3D511 is not sector-aligned
>>> 511 is not a sector-aligned value for 'bytes'
>>> requested 'bytes' of 511 is not sector-aligned
>>> alignment error: 511 bytes is not sector-aligned
>>> 'bytes' must be sector-aligned: 511
>>> your clever entry here...
>>
>> How about "byte count" instead of "bytes" or "bytes value", if really
>> want to have the exact spelling in there?
>>
>> For your entries above: (1) and (2) work for me (I like (2) a bit
>> better), (3) doesn't sound like real English either, and it should be
>> s/is/are/ in (4) (but it still sounds off with that change). (5) I
>> mostly dislike because I dislike error message of the form "This shoul=
d
>> be X: $foo", I like "$foo is not X" better.
>=20
> Maybe this variation of (3) solves the singular/plural disconnect:
>=20
> request of 511 for 'bytes' is not sector-aligned
>=20
> which makes it obvious that the "request of 511" (singular) and not the=

> parameter name (whether singular 'count' or plural 'bytes') is the
> subject.  But it's a bit wordier than (2).  So it looks like (2) may be=

> a winner in all the situations.  But I also think you convinced me to
> rename the command parameter; in my next spin, the help text will read:=

>=20
> alloc offset [count] -- checks if offset is allocated in the file
>=20
> which starts to be non-trivial enough to drop R-b that you were willing=

> to give for just an error message wording change.

Well, reviewing the change will be simple enough, so it doesn't really
matter to me. :-)

(I'm still a bit upset why you think that the average qemu-io user
cannot make the connection between "byte count" and a parameter named
"bytes". Because I am the average qemu-io user. Huff!)

Max


--rRFvppnP3N6vlj3bRLCfaG5SAhNisTbHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDq4sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADo4IAISCA4Ragq15py/gGUC/j/UXqR30lEl5
ccwaoi5cuqf8Qd1aGKj8irHqfX9quX4AL7rSp++9ws5nI7vay6NpCRWvtl7/AArV
SWgFxXUgHIp+qH7M5BExRqVAig1sQ5gk5DiSIUCvdhxCyYK8F2PIyVT0qI2ysFYT
DBFh7yTaN3qAh3QABjEInSgv1sp0/r8t3CPiHnZAZnTNC3luzxmumkNzn86dbMmi
atKoeLSGEdxxfnj2zNtzRtr9WLrqD3cdoky0XFELNFWdZ+DbavCoQe0qkrb4xi17
BMzyLRgK6L37XwcLg080XetSb4ZS3lgGBQ/sQG7u8BncJw4VxbghCHE=
=7T2Q
-----END PGP SIGNATURE-----

--rRFvppnP3N6vlj3bRLCfaG5SAhNisTbHP--
