Received: from eggs.gnu.org ([2001:4830:134:3::10]:39237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6kRT-0006qh-Sw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 17:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6kRT-0001XB-32
	for qemu-devel@nongnu.org; Fri, 05 May 2017 17:07:11 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-7-eblake@redhat.com>
	<f573947e-d97b-ff59-5881-15d1a1b3b8d4@redhat.com>
	<1b3c371b-abc7-d9b1-4fd5-dd1faffb42fe@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c19ba816-f4e4-338d-ed82-c7dbc853a30d@redhat.com>
Date: Fri, 5 May 2017 23:07:03 +0200
MIME-Version: 1.0
In-Reply-To: <1b3c371b-abc7-d9b1-4fd5-dd1faffb42fe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K5f56CQpKtC6GX54Fj6XBKPDccnSVJAIV"
Subject: Re: [Qemu-devel] [PATCH v12 06/10] iotests: Improve
 _filter_qemu_img_map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K5f56CQpKtC6GX54Fj6XBKPDccnSVJAIV
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <c19ba816-f4e4-338d-ed82-c7dbc853a30d@redhat.com>
Subject: Re: [PATCH v12 06/10] iotests: Improve _filter_qemu_img_map
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-7-eblake@redhat.com>
 <f573947e-d97b-ff59-5881-15d1a1b3b8d4@redhat.com>
 <1b3c371b-abc7-d9b1-4fd5-dd1faffb42fe@redhat.com>
In-Reply-To: <1b3c371b-abc7-d9b1-4fd5-dd1faffb42fe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.05.2017 23:06, Eric Blake wrote:
> On 05/05/2017 03:58 PM, Max Reitz wrote:
>> On 04.05.2017 05:07, Eric Blake wrote:
>>> Although _filter_qemu_img_map documents that it scrubs offsets, it
>>> was only doing so for human mode.  Of the existing tests using the
>>> filter (97, 122, 150, 154, 176), two of them are affected, but it
>>> does not hurt the validity of the tests to not require particular
>>> mappings (another test, 66, uses offsets but intentionally does not
>>> pass through _filter_qemu_img_map, because it checks that offsets
>>> are unchanged before and after an operation).
>>>
>=20
>>>  _filter_qemu_img_map()
>>>  {
>>>      sed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
>>> +	-e 's/"offset": [0-9]\+/"offset": OFFSET/g' \>          -e 's/Mappe=
d to *//' | _filter_testdir | _filter_imgfmt
>=20
> Whoa - mail corruption.
>=20
>>
>> This makes my OCD very sad.
>=20
> The real culprit? TAB damage.  I guess this is one of the files that
> emacs thinks should be indented with TAB instead of space, because the

>emacs

Found the issue right there.

O:-)

Max

> file itself looks aligned, only the patch is botched.
>=20
>>
>> With the alignment fixed:
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> (Without this fixed: Will-change-when-applying-and-then-add-the-R-b)
>=20
> Much appreciated, and I await the final verdict on whether I have to
> respin (you've pointed out several cleanups I can make), or whether you=

> take the fixed version of these patches and let me write a few more
> followups.


--K5f56CQpKtC6GX54Fj6XBKPDccnSVJAIV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM6XcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACqEH/jEq+RN+oQZRUG6in3tdYPCeBmWjgC2N
e4uk0CL/vrEptq6ycsJTWHyYPgL4R4o8YCm1p1CKXHc9I6u2YkiXeTYWkOEWKKoQ
vetwj1SS7GpSfMxvoESNekV4rV0PLayHRdtFJbh0A0yhwURUfNYH0GVfHBTh288k
ZvM2FRNNayaVdq2jIFHy5TYBaztU1B9oORBJRdntY11Yyc6ueCGAESIIc6LxCYIH
3aqkznfG8I9CG4mKPkxgKaRcf7RzyqtuWQfzwXYNXuGDbdSyzGIyNgld4XLRP7OK
WXmuU4F2sV9gEPf6cTK0A09cemNMqCP8JoTetgsOqklHMfk+94CRYN4=
=Hswz
-----END PGP SIGNATURE-----

--K5f56CQpKtC6GX54Fj6XBKPDccnSVJAIV--
