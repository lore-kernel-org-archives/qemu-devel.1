Received: from eggs.gnu.org ([2001:4830:134:3::10]:34977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCVTI-00067T-7e
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCVTH-0005D3-DM
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 13:53:08 -0500
References: <20170929165347.29658-1-mreitz@redhat.com>
	<20170929165347.29658-19-mreitz@redhat.com>
	<w51o9okwtgx.fsf@maestria.local.igalia.com>
	<15538193-cfa0-822e-04c4-4aedbfd0724a@redhat.com>
	<20171108171441.GH30890@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f93d184c-fbc4-5895-8794-2c48f2b8c52c@redhat.com>
Date: Wed, 8 Nov 2017 19:52:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171108171441.GH30890@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iMRVT7QuajqRgJapdpS4tOMIiRQDK04TA"
Subject: Re: [Qemu-devel] [PATCH v6 18/25] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iMRVT7QuajqRgJapdpS4tOMIiRQDK04TA
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <f93d184c-fbc4-5895-8794-2c48f2b8c52c@redhat.com>
Subject: Re: [PATCH v6 18/25] block: Add sgfnt_runtime_opts to BlockDriver
References: <20170929165347.29658-1-mreitz@redhat.com>
 <20170929165347.29658-19-mreitz@redhat.com>
 <w51o9okwtgx.fsf@maestria.local.igalia.com>
 <15538193-cfa0-822e-04c4-4aedbfd0724a@redhat.com>
 <20171108171441.GH30890@localhost.localdomain>
In-Reply-To: <20171108171441.GH30890@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-11-08 18:14, Kevin Wolf wrote:
> Am 02.11.2017 um 17:18 hat Max Reitz geschrieben:
>> On 2017-11-02 17:11, Alberto Garcia wrote:
>>> On Fri 29 Sep 2017 06:53:40 PM CEST, Max Reitz wrote:
>>>>      QLIST_ENTRY(BlockDriver) list;
>>>> +
>>>> +    /* Pointer to a NULL-terminated array of names of significant o=
ptions that
>>>> +     * can be specified for bdrv_open(). A significant option is on=
e that
>>>> +     * changes the data of a BDS.
>>>> +     * If this pointer is NULL, the array is considered empty.
>>>> +     * "filename" and "driver" are always considered significant. *=
/
>>>> +    const char *const *sgfnt_runtime_opts;
>>>>  };
>>>
>>> Is sgfnt a common acronym? I actually had to look it up...
>>
>> I'm open for other suggestions to shorten "significant". :-)
>>
>> (Actually, I can't remember where I got it from.  I think I just made =
it
>> up, but then I don't know why I didn't use sgfcnt -- maybe because cnt=

>> looks either like count (or like something else, but that's a differen=
t
>> matter)...?)
>=20
> Because in reality you were abbreviating "signifant"? ;-)

I actually thought the very same, yes. ;-)

> Anyway, I found the inline initialisation as part of BlockDriver rather=

> ugly. The places where you used a separate static const array look
> much nicer. Maybe use that consistently in all places?

Sure.

Max


--iMRVT7QuajqRgJapdpS4tOMIiRQDK04TA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloDUoUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAukH/0LhehHgmPdLuZ/Q6j5EakG1OJ2yBDWd
zaXsf0rdHws4bgCFuzdaRjkMMSp61MXuJKzgenVrnopPSR8Kj5kq3q3Csq+tZ+sE
+0tdwr+C5vuMlJ0kSkXv5vlhHbYx9a36AOQUAGhuS9TVOdlvFN2cOMQ6vb4cyUVE
HaoCyIk5vy0vo5yoY3ltzIVxv1yVAUq6flriqtSGOGPsjQtoFWY6o5a/mMMhCokg
UYcf1P6aBkkGC6adCRDt2/h++Jvs/Vpf3x4W7ksEtrge+nk1Q446OFXKs56I5L/t
rijuWVkuoyCYx9+uID5Xq3ChHXoFFe5r1lfUDRwpaoH/7RDpnUVxrMM=
=4EHT
-----END PGP SIGNATURE-----

--iMRVT7QuajqRgJapdpS4tOMIiRQDK04TA--
