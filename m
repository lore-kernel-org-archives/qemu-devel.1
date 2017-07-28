Received: from eggs.gnu.org ([2001:4830:134:3::10]:48625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db4Z2-00017X-1F
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db4Yy-0006zY-BX
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:40:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db4Yy-0006yi-2N
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:40:16 -0400
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
	<CAFEAcA_9_YVyDC5jbLT=YXT64MFkxOrpxV7eydCEK_Lc4oSY5g@mail.gmail.com>
	<06a9ae13-4279-1210-0664-0faf5f55f830@redhat.com>
	<CAFEAcA-oowaaK9Amn2Achj4a7X-HGOYgNF_7M=rmdOzbick3JA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ffae613e-92cf-6702-39c3-13b05f378687@redhat.com>
Date: Fri, 28 Jul 2017 07:40:01 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-oowaaK9Amn2Achj4a7X-HGOYgNF_7M=rmdOzbick3JA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2FGPq5UIKBXfu9vN00m6e7e5HN44a6Fuk"
Subject: Re: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2FGPq5UIKBXfu9vN00m6e7e5HN44a6Fuk
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <ffae613e-92cf-6702-39c3-13b05f378687@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
 <CAFEAcA_9_YVyDC5jbLT=YXT64MFkxOrpxV7eydCEK_Lc4oSY5g@mail.gmail.com>
 <06a9ae13-4279-1210-0664-0faf5f55f830@redhat.com>
 <CAFEAcA-oowaaK9Amn2Achj4a7X-HGOYgNF_7M=rmdOzbick3JA@mail.gmail.com>
In-Reply-To: <CAFEAcA-oowaaK9Amn2Achj4a7X-HGOYgNF_7M=rmdOzbick3JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 07:19 AM, Peter Maydell wrote:
> On 28 July 2017 at 13:08, Eric Blake <eblake@redhat.com> wrote:
>> On 07/28/2017 04:04 AM, Peter Maydell wrote:
>>> On 28 July 2017 at 09:55, Vladimir Sementsov-Ogievskiy
>>> <vsementsov@virtuozzo.com> wrote:
>>>> To make logs more readable prefix all hex values with '0x' mark.
>>>> This is needed for consistency too, as a lot of hex values are alrea=
dy
>>>> prefixed with '0x'. Also, bring all hex outputs to the common form -=

>>>> use '%#', not '0x%'.
>>>>
>>>> This patch is done by two commands:
>>>> find . -name trace-events | \
>>>>  xargs sed -i 's/%\([-+ *.0-9]*\([hljztL]\|ll\|hh\)\?\(x\|X\|"\s*PRI=
x\)\)/%#\1/g'
>>
>> Why PRIx32 but not PRIX32?
>=20
> As it happens none of our trace-events files use PRIX...

True for now, but if we're going to add a checkpatch.pl rule to enforce
things, then the regex should cover it for future additions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2FGPq5UIKBXfu9vN00m6e7e5HN44a6Fuk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7MKEACgkQp6FrSiUn
Q2oP8gf/fdbSB7wMuTWLnB7a1yeZOwMv0WlbyHbZ8XUy8Tv3fM96U7g7jK9uB9yF
QjRmbiS5uZkjTZbs/BvHsTwUsj/ncaOhSIePBQ9K9817fkqh/n2Y1iQSuo/kNIqz
ePeoO3GWgoBA8oSKID3mL5YQ00EhL+LVx0IOFSA3aFJoCm6wnO0D5y3O5LWasaK/
wtirucFp9tX86aKdGTmt6lCkUgtrtMpSOwxzIYOJ0JShrrSozgay/bntx9/rKtqq
c05ALEI8Ingl7V5JcHBMFFHkNhkkoELWtQpSmg+qoSUUoPXfPpamGvwAgX2W9FjC
wdtK0JfAlVHx5S6jSNPEfuYsHlIUzQ==
=orhE
-----END PGP SIGNATURE-----

--2FGPq5UIKBXfu9vN00m6e7e5HN44a6Fuk--
