Received: from eggs.gnu.org ([2001:4830:134:3::10]:33902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJ0W-0002Aa-I3
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJ0V-0007ql-PE
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 08:48:04 -0500
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-25-mreitz@redhat.com>
	<w51k1y2307y.fsf@maestria.local.igalia.com>
	<bcbf0021-4fcd-26d0-e05c-cd3e35608988@redhat.com>
	<w51h8t531ql.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <032b64ec-a161-ff2a-5505-06b91deb2682@redhat.com>
Date: Fri, 8 Dec 2017 14:47:52 +0100
MIME-Version: 1.0
In-Reply-To: <w51h8t531ql.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xhqKR41j88a7E9kHs1F8cKri2P7U6sUej"
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 24/25] block/curl: Implement
 bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xhqKR41j88a7E9kHs1F8cKri2P7U6sUej
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <032b64ec-a161-ff2a-5505-06b91deb2682@redhat.com>
Subject: Re: [PATCH v7 for-2.12 24/25] block/curl: Implement
 bdrv_refresh_filename()
References: <20171120201004.14999-1-mreitz@redhat.com>
 <20171120201004.14999-25-mreitz@redhat.com>
 <w51k1y2307y.fsf@maestria.local.igalia.com>
 <bcbf0021-4fcd-26d0-e05c-cd3e35608988@redhat.com>
 <w51h8t531ql.fsf@maestria.local.igalia.com>
In-Reply-To: <w51h8t531ql.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-05 11:31, Alberto Garcia wrote:
> On Mon 04 Dec 2017 07:26:02 PM CET, Max Reitz wrote:
>>>> +static void curl_refresh_filename(BlockDriverState *bs)
>>>> +{
>>>> +    BDRVCURLState *s =3D bs->opaque;
>>>> +
>>>> +    if (!s->sslverify || s->cookie ||
>>>> +        s->username || s->password || s->proxyusername || s->proxyp=
assword)
>>>> +    {
>>>
>>> Is !s->sslverify negative because that setting is true by default?
>>
>> Yes, exactly.  If it's false, you'd need to override it (and you can't=

>> do that through a plain filename).
>=20
> I think this is not the only case in this series, but I'm not very
> comfortable with the idea that this condition and the default value of
> the setting are implicity dependent on each other. If you change one an=
d
> forget to change the other things will break.

Well, yes, but...

> I understand that the default value is never supposed to change so in
> practice I don't see this breaking,

Yes.

>                                     but is it perhaps worth adding test=
s
> for all these cases?

In theory, sure.  In practice, adding a curl test case seems hard.

Well, I could connect to, I don't know, qemu.org or something and then
just test things there (with the index used as a raw image), but if I
add one test for the curl protocol, nobody is ever going to run them...
And in theory, that's not how a curl test should work.  In theory, you'd
expect the user to set up a localhost server with some known root
directory and then _make_test_img etc. would set up images there.  But
that way, really nobody is ever going to run them.

And just adding a test for all protocols that then accesses qemu.org
feels somehow wrong, too...  Maybe if I add it to a network group, that
wouldn't feel so bad.

Also, adding macros for the default values could help, I think.

Max


--xhqKR41j88a7E9kHs1F8cKri2P7U6sUej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloqmAgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALmAH/iAItItL98aqvfBhqafv+0KaDfPOCRt7
tRtklzHBM3Iopzte9GA5m/7CZSkxRrceAKrHxD2gSH8g3axg/6cFqZn63Tf1UIn2
9P3VK5p0+E2aLUV0oFMhFnIHrzVfIdoKjc8iNwHI4+x+ElHTwEDImslR/NYPtu2+
fhcJD7BAF2Z3sqrefBLE+cS/QLhfuKxZNDGRVkpBqD6ApO2NMIwebU1iR/veVKX0
vDqXiD9c32M5Jifu5vm70Tu9Bfe7e9/n5zCoHo+ZBYF88S/9YTQ1x8qGCDc+TfNo
BxFH2jSAcbfdUZu4xZ8LxgjNPj+xmsFt82JAas/tc8uCPxDnspFaze4=
=AJfw
-----END PGP SIGNATURE-----

--xhqKR41j88a7E9kHs1F8cKri2P7U6sUej--
