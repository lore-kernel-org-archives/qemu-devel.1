Received: from eggs.gnu.org ([2001:4830:134:3::10]:40124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJOa-0004Yq-3s
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJOY-0001LA-Pz
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:12:56 -0500
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-25-mreitz@redhat.com>
	<w51k1y2307y.fsf@maestria.local.igalia.com>
	<bcbf0021-4fcd-26d0-e05c-cd3e35608988@redhat.com>
	<w51h8t531ql.fsf@maestria.local.igalia.com>
	<032b64ec-a161-ff2a-5505-06b91deb2682@redhat.com>
	<20171208135329.GG11767@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6ae47d40-8934-99e5-7bc3-dc4d1585ca8f@redhat.com>
Date: Fri, 8 Dec 2017 15:12:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171208135329.GG11767@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ROEKXpra3kX3bEDmswIBtVv7s6Mc8wfxD"
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ROEKXpra3kX3bEDmswIBtVv7s6Mc8wfxD
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <6ae47d40-8934-99e5-7bc3-dc4d1585ca8f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 24/25] block/curl: Implement
 bdrv_refresh_filename()
References: <20171120201004.14999-1-mreitz@redhat.com>
 <20171120201004.14999-25-mreitz@redhat.com>
 <w51k1y2307y.fsf@maestria.local.igalia.com>
 <bcbf0021-4fcd-26d0-e05c-cd3e35608988@redhat.com>
 <w51h8t531ql.fsf@maestria.local.igalia.com>
 <032b64ec-a161-ff2a-5505-06b91deb2682@redhat.com>
 <20171208135329.GG11767@redhat.com>
In-Reply-To: <20171208135329.GG11767@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-08 14:53, Daniel P. Berrange wrote:
> On Fri, Dec 08, 2017 at 02:47:52PM +0100, Max Reitz wrote:
>> On 2017-12-05 11:31, Alberto Garcia wrote:
>>> On Mon 04 Dec 2017 07:26:02 PM CET, Max Reitz wrote:
>>>>>> +static void curl_refresh_filename(BlockDriverState *bs)
>>>>>> +{
>>>>>> +    BDRVCURLState *s =3D bs->opaque;
>>>>>> +
>>>>>> +    if (!s->sslverify || s->cookie ||
>>>>>> +        s->username || s->password || s->proxyusername || s->prox=
ypassword)
>>>>>> +    {
>>>>>
>>>>> Is !s->sslverify negative because that setting is true by default?
>>>>
>>>> Yes, exactly.  If it's false, you'd need to override it (and you can=
't
>>>> do that through a plain filename).
>>>
>>> I think this is not the only case in this series, but I'm not very
>>> comfortable with the idea that this condition and the default value o=
f
>>> the setting are implicity dependent on each other. If you change one =
and
>>> forget to change the other things will break.
>>
>> Well, yes, but...
>>
>>> I understand that the default value is never supposed to change so in=

>>> practice I don't see this breaking,
>>
>> Yes.
>>
>>>                                     but is it perhaps worth adding te=
sts
>>> for all these cases?
>>
>> In theory, sure.  In practice, adding a curl test case seems hard.
>>
>> Well, I could connect to, I don't know, qemu.org or something and then=

>> just test things there (with the index used as a raw image), but if I
>> add one test for the curl protocol, nobody is ever going to run them..=
=2E
>> And in theory, that's not how a curl test should work.  In theory, you=
'd
>> expect the user to set up a localhost server with some known root
>> directory and then _make_test_img etc. would set up images there.  But=

>> that way, really nobody is ever going to run them.
>=20
> For qemu I/O tests I would suggest just having the iotest spin up a sim=
ple
> http server in Python - there's standard APIs in python that make this
> pretty trivial
>=20
>   http://www.pythonforbeginners.com/modules-in-python/how-to-use-simple=
httpserver/
>=20
> That way curl could be reliably tested without any special setup by the=

> developer

Good idea, thanks.  It might be an issue if we ever want to test HTTPS
(putting a self-signed certificate into the iotests directory seems a
bit over the top), but since the sslverify option works just fine with
HTTP itself, that's not an issue for this case.

Now I just have to discuss with myself whether I want to add curl
testing infrastructure for testing whether the defaults are still the
defaults or whether adding default value macros is enough...

Max


--ROEKXpra3kX3bEDmswIBtVv7s6Mc8wfxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloqndoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ar2QH/1wputAofhzklN0a7OwcR3eLhEgo+xIa
JyY7sZ8AW+gK9fNeYc5yXmpvOWoKs6q/h5WlIpSPEDidiqGM5jpWhfJAXU+Xz4Sv
RWfPeiHvNdbCaq9EJat0awAxlHgT5Pae/jkgJz7Y2+LoZAOof616AsgnbYV0+Fvx
JjX6eJCT0dOUn0nIciRyjvExy45AF8FBp2VrcN54JNSUmxo8taS0APsS4lwQQaUq
9lq4kcLvnXp36Re+oenayL5lh3v2AI0BK5RtxfBsaNr9drwa1fiWnPJp6m29INJz
8KA5fLir9L6ZrEk+fmkcmsYU1mvVF4JhDmr+WwXsIxMoRDs/hhEnOao=
=u4rR
-----END PGP SIGNATURE-----

--ROEKXpra3kX3bEDmswIBtVv7s6Mc8wfxD--
