Received: from eggs.gnu.org ([2001:4830:134:3::10]:40924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB6I7-00083Z-Js
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dB6I6-00031T-D9
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:15:31 -0400
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
	<684185116.2952708.1495044580181@mail.yahoo.com>
	<3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
	<107015620.2969780.1495046091978@mail.yahoo.com>
	<5a2b9e50-1444-af4a-dc89-021a4beca0f4@redhat.com>
	<1832071588.99743.1495054408073@mail.yahoo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bcff9cd4-3ec2-0757-02e0-96f0e0a7747e@redhat.com>
Date: Wed, 17 May 2017 16:15:20 -0500
MIME-Version: 1.0
In-Reply-To: <1832071588.99743.1495054408073@mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g2p7tSP9KIq00pA8heec073LSiF2DgKp8"
Subject: Re: [Qemu-devel] Add Markus Armbrusters code for Broadcom
 Perhiperals for ARM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Bradley <flypie1@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Geert Martin Ijewski <gm.ijewski@web.de>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g2p7tSP9KIq00pA8heec073LSiF2DgKp8
From: Eric Blake <eblake@redhat.com>
To: John Bradley <flypie1@yahoo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: John Bradley <flypie@rocketmail.com>, Laurent Vivier
 <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Geert Martin Ijewski <gm.ijewski@web.de>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bcff9cd4-3ec2-0757-02e0-96f0e0a7747e@redhat.com>
Subject: Re: [Qemu-devel] Add Markus Armbrusters code for Broadcom Perhiperals
 for ARM.
References: <684185116.2952708.1495044580181.ref@mail.yahoo.com>
 <684185116.2952708.1495044580181@mail.yahoo.com>
 <3293e70a-71ac-2e6d-433f-06346ad253c9@redhat.com>
 <107015620.2969780.1495046091978@mail.yahoo.com>
 <5a2b9e50-1444-af4a-dc89-021a4beca0f4@redhat.com>
 <1832071588.99743.1495054408073@mail.yahoo.com>
In-Reply-To: <1832071588.99743.1495054408073@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/17/2017 03:53 PM, John Bradley wrote:
> Andrew Baumann has and others have release the code under GNU General P=
ublic License version 2 (GPLv2), the same as QEMU that allows me to added=
 it to QEMU as it is under the same license, by signing it off this is wh=
at I am certifying.=20

See this document linked from the SubmitAPatch link (it describes the
kernel meaning of S-o-b tags, although the qemu meaning is the same):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/SubmittingPatches?id=3Df6f94e2ab1b33f0082ac22d71f66385a60d81=
57f#n297

Yes, your Signed-off-by: asserts that you are okay releasing your
portions of the patch (bullets a, d) and that you chased down that
portions that you did not write are properly licensed (bullet b), but
what you are missing is that when you modify someone else's patch, we
also need that someone's assertion of intent that their work (whether or
not modified by you) meets the same standards (bullet c).  In other
words, when modifying a patch, S-o-b lines should be additive in nature,
rather than replacing his by yours (or, if his is missing in the source
you originally copied from, then we really need to Andrew to chime in
and add one); this is so that there is a full chain of custody on who
wrote portions of the commit.


>  John BradleyTel: 07896 839635Skype: flypie125 125B Grove StreetEdge Hi=
ll Liverpool L7 7AF=20

Your mailer is sending very poor formatting when rendered as plain text
(and we frown on html mail on this list).

>=20
>     On Wednesday, 17 May 2017, 20:11, Eric Blake <eblake@redhat.com> wr=
ote:
> =20
>=20
>  On 05/17/2017 01:34 PM, John Bradley wrote:
>> This is especial true as I meant Andrew Baumann 0xabu (Andrew Baumann)=

>=20
> Top-posting is not nice on technical lists.

And yet, in spite of me mentioning it, you still top-posted. :(

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--g2p7tSP9KIq00pA8heec073LSiF2DgKp8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHL1oAAoJEKeha0olJ0NqPJwH/RVEkX33BLb2V2yrHcYzT7fw
2dcUHFKsllClAAxli/b+zesgraH08zxGRYcLEmgBtqmR1ptvx+EIhEm824n8kRXa
BWvJ+KABJRTZ1mMWSt6o2vcexKL6GMKlDmU5iocyjb7TDkLIcvqf7JA0S22T6C20
qnt69lO4u8DsWvRCOGZ8QlVh4z8Nc9+Q38CbOJItifjq0k8Fs2oafg6x+0jtVUIW
O0WBqeC3GOTBEMzPIF8IRs68cFkzkP7cRL0hRgm4XO+hF6UVEXd8fYKUl9IZuc7e
1PiKLNn188yxQuWddFEMoM6jAr22rnDPyh2OEnRcq+P3GBJ0Whzy8FrnPsGBtVM=
=4uUx
-----END PGP SIGNATURE-----

--g2p7tSP9KIq00pA8heec073LSiF2DgKp8--
