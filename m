Received: from eggs.gnu.org ([2001:4830:134:3::10]:59061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZC4-0003Yp-5I
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYZC0-0006m9-2R
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:18:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eYZBz-0006ll-P1
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:18:27 -0500
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
	<CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
	<4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b5453cda-5ae3-cbb3-a158-846f83bb027a@redhat.com>
Date: Mon, 8 Jan 2018 09:18:24 -0600
MIME-Version: 1.0
In-Reply-To: <4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2d6GFlKOKI7WAjXpfDomkyBgIvLLTVRrJ"
Subject: Re: [Qemu-devel] [PULL 00/18] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2d6GFlKOKI7WAjXpfDomkyBgIvLLTVRrJ
From: Eric Blake <eblake@redhat.com>
To: Ed Swierk <eswierk@skyportsystems.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b5453cda-5ae3-cbb3-a158-846f83bb027a@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/18] Net patches
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
 <CAFEAcA_4ZBLNcJXqJ78TmEZz1FqGVqvFuL1NdR2WaWNWxhVLVg@mail.gmail.com>
 <CAO_EM_nzdoQPPtvcf4tEU1=WoNtDpoAHFUBXBGa=EU7skG+40w@mail.gmail.com>
 <4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
In-Reply-To: <4a83359d-408a-35a9-1a81-d201783c3465@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 09:10 AM, Eric Blake wrote:
> On 01/08/2018 07:30 AM, Ed Swierk via Qemu-devel wrote:
>=20
>> Applied, thanks.
>>
>> PS: just noticed, but "Ed Swierk via Qemu-devel <qemu-devel@nongnu.org=
>"
>> is a bit of an odd Author string to end up in git commit logs, so you
>> and/or Ed might like to fix that up for any future patches.
>>
>>
>> Thanks for pointing that out. I wonder if it's happening because I let=

>> git-send-email automatically fill in the From: line.
>=20
> It's also a factor of how strict your ISP is about DMARC handling; the
> list automatically rewrites the 'From:' header to insert the 'via
> Qemu-devel' tag if it detects DMARC settings at your ISP that won't
> allow your email through as originally written.  Sadly, mailman doesn't=

> know to insert a manual 'From:' line in the body when it rewrites the
> original From: header; but if you know that DMARC settings are going to=

> munge your original header, you can probably convince git to always
> insert an explicit From: line in the message body to override whatever
> munging the list does.
>=20

Hmm - we probably ought to enhance checkpatch.pl to insist that patches
attributed to qemu-devel@nongnu.org as the author should be flagged as
invalid, since the list munging is a 1:M mapping rather than 1:1, and
therefore not easily invertable.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2d6GFlKOKI7WAjXpfDomkyBgIvLLTVRrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpTi8AACgkQp6FrSiUn
Q2qM+Af/YXjU1Sz/sB3NkUbQHLUkwSNLNJAhDCf38JXnrA4gPnM7z+1tcZzq49qt
LsnWdSR9sMfpDZmpwrsOjA9HRoum4Z6LTDK8a3KoisXe7iIMmp1JttPsaetobIlo
yxtj9weTMQuln3fGcT5dNhlnYuOj+3z3uypkbQtbtUUgg6iBrCdpNvaAPv0DZpS0
KsEJ71RM2FLuJkLub0XEI4cHVDHui1JlB4Cnc0D9jVTHreOepsyR5yf2T9I1QoW2
cHP91dKgyWqImDXz7EA9Ol+8LGnEfkmIEQjT4t50eXw0O+nQ1/Hjp72QTUdD5xsC
1G4hXpRxrwul+u0EesiZI8phsZpIrA==
=t5T0
-----END PGP SIGNATURE-----

--2d6GFlKOKI7WAjXpfDomkyBgIvLLTVRrJ--
