Received: from eggs.gnu.org ([2001:4830:134:3::10]:46504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF0Uf-0002DF-1x
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF0Ua-0004VT-Ps
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:20:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cF0Ua-0004Uw-Gq
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:20:16 -0500
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
	<6c9a32a1-9984-6ae6-bbdc-6843938ee2fd@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA156AAE@DGGEMA505-MBX.china.huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <54e4918c-f686-d7d1-2c70-31ed344cd8a9@redhat.com>
Date: Thu, 8 Dec 2016 09:20:07 -0600
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA156AAE@DGGEMA505-MBX.china.huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2q8u1FddtgbmWCHAroWgk39TAePDe4sIa"
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2q8u1FddtgbmWCHAroWgk39TAePDe4sIa
From: Eric Blake <eblake@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Message-ID: <54e4918c-f686-d7d1-2c70-31ed344cd8a9@redhat.com>
Subject: Re: [PATCH for-2.9 v2] virtio-crypto: zeroize the key material before
 free
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
 <6c9a32a1-9984-6ae6-bbdc-6843938ee2fd@redhat.com>
 <33183CC9F5247A488A2544077AF19020DA156AAE@DGGEMA505-MBX.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA156AAE@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2016 08:33 PM, Gonglei (Arei) wrote:

>> Sensitive information is sometimes also held in mlocked pages to preve=
nt
>> it being swapped to disk, but qemu in general is not currently taking
>> that level of precaution (see also commit 8813800b).
>>
>>>
>>> Let's zeroize the memory of CryptoDevBackendSymOpInfo structure point=
ed
>>> for key material security.
>>>
>>> [v2: Stefan perfects the commit message, thanks]
>>
>> The v2 blurb should appear after the --- line, as it is nice for
>> reviewers but a year from now when reading 'git log' we won't care how=

>> many versions were on the list, only about the one version in git.
>>
> Yes, you are right. I just wanted to keep the Stefan's work because
> the most of commit message comes from him. :)

Then I might have written:

[Thanks to Stefan for help with crafting the commit message]

>=20
>>> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  hw/virtio/virtio-crypto.c | 13 ++++++++++++-
>>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>>
>>
>> The commit message may still need improvement, but the maintainer migh=
t
>> be willing to do that without needing a v3.  At any rate,
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
> Thanks.

We'll see what the maintainer thinks :)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2q8u1FddtgbmWCHAroWgk39TAePDe4sIa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSXonAAoJEKeha0olJ0Nqu9MH/0BBQhHWB+mtA9pTQqxL6khe
p4qP5aL5JcE4T+zi3XUCB8ATnRiO4+bcBOYGoDm3ln0xaWV82NBfiFbeHhq1cRtR
XkfvA8/dpCNtQU/OzrzwMMLONepEwLC/UjMfTVCqE0xbFOe8FKjw4nazNOjoHmLd
ivArp8trd/+WIte7M81tBFCGZGGGlDXD9erv07HtrzrxfSfouwByN9GCUvgoma4V
zVpCUgadmrTeLfITF8h7ZncR9Ec3MMt5iSHG2SXIbfo75T76vHJrsmWGz7Dvv60J
8X44dApcs9/l3doAGr2qwRT8EOga2W83gQAUX9CvQNkiE6nryQ1MZM5o+WkA5iU=
=XnMn
-----END PGP SIGNATURE-----

--2q8u1FddtgbmWCHAroWgk39TAePDe4sIa--
