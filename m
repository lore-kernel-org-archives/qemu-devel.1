Received: from eggs.gnu.org ([2001:4830:134:3::10]:42294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDw9c-0008Q7-EJ
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:30:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDw9W-0000zn-Hg
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:30:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cDw9W-0000zJ-AD
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:30:06 -0500
References: <20161202210152.6880-1-lersek@redhat.com>
	<20161204192953-mutt-send-email-mst@kernel.org>
	<d5a6c326-46b0-b9ab-084f-d45868b76006@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fcd33b5f-0ef5-2566-e39a-0227bb8fcb2a@redhat.com>
Date: Mon, 5 Dec 2016 10:30:00 -0600
MIME-Version: 1.0
In-Reply-To: <d5a6c326-46b0-b9ab-084f-d45868b76006@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rATXWv7QBsA2JRuSj5HsoBIQeOXtiRulH"
Subject: Re: [Qemu-devel] [PATCH v2] scripts: add "git.orderfile" for
 ordering diff hunks by pathname patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rATXWv7QBsA2JRuSj5HsoBIQeOXtiRulH
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <fcd33b5f-0ef5-2566-e39a-0227bb8fcb2a@redhat.com>
Subject: Re: [PATCH v2] scripts: add "git.orderfile" for ordering diff hunks
 by pathname patterns
References: <20161202210152.6880-1-lersek@redhat.com>
 <20161204192953-mutt-send-email-mst@kernel.org>
 <d5a6c326-46b0-b9ab-084f-d45868b76006@redhat.com>
In-Reply-To: <d5a6c326-46b0-b9ab-084f-d45868b76006@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2016 04:24 AM, Laszlo Ersek wrote:

>=20
> I picked the below lines from Eric's feedback.
>=20
>>> +qapi-schema*.json
>>> +qapi/*.json
>>> +include/qapi/visitor.h
>>> +include/qapi/visitor-impl.h
>>> +scripts/qapi.py
>>> +scripts/*.py
>>> +*.h
>>> +qapi/qapi-visit-core.c
>>
>> is the exact order or qapi files that important?
>> I'd rather we stuck to simple wildcards without
>> special casing visitors etc.
>=20
> Eric indicated this specific order was helpful for QAPI work.

In fact, what I would recommend is that we do the minimal file now, and
then subsequent series (such as if I have more QAPI work) can add their
further tweaks as part of the series where those tweaks aid review.  So
I'd be just fine omitting the visitor special-casing if it helps get the
patch in faster.

> I suggest we go ahead with this posting (or v1), then people can submit=

> whatever improvements they deem fit, from their personal experience. I
> think the initial version should be minimal and non-controversial.
>=20
> We've already spent a disproportionate amount of time discussing this i=
tem.

Indeed, especially for something that still requires manual
configuration from each developer to make use of it (it's a shame git
doesn't yet have automatic support for .gitorderfile, like it does for
=2Egitignore or .gitattributes).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rATXWv7QBsA2JRuSj5HsoBIQeOXtiRulH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRZYIAAoJEKeha0olJ0NqV8kIAKZ/5bEtamyzbpqKiBuTysOI
0Kj4jatx5LzGfsVn9Oy8x1guY8uYKD1WmY2VzouarV8NH2HwEvgBJExrEUFfLUIi
9I3CB1XJaqGMkyfgYeJ2dDpqDizn7Ci0CmxhPTbbuqYMHKLNEFVLAPLxs+38iY0o
5Ez9RTIa7Ri+l5viJc7nLXBiL+rg7RmBRRKCh3HY5VQ6lvJTm2+pAygqk07GV84U
4jHHUPoTmq9VIczlWbSdwzykaWM/NXenl+lZ/cAebctwlFNUdo1MXkkApKj6xDLA
oA4NfAOCW2BhO+HNOjqyBAEeHMpHn8fMKTngql+ffjllwLS5PsfqHWbAvPTBSy4=
=PA+m
-----END PGP SIGNATURE-----

--rATXWv7QBsA2JRuSj5HsoBIQeOXtiRulH--
