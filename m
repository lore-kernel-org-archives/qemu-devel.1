Received: from eggs.gnu.org ([2001:4830:134:3::10]:49718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f3klZ-0003Ou-58
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1f3klU-0006Bz-5v
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:56:05 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:33816
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1f3klT-0006B4-Qa
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:56:00 -0400
References: <mailman.35816.1522678020.27992.qemu-devel@nongnu.org>
	<B4011235-0338-474D-90E4-ABDF3DC8CCB7@gmail.com>
	<eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
	<57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
	<20180404143859.GI3186@redhat.com>
	<e283ef1f-a1cd-c21a-9058-c68c76182486@redhat.com>
	<20180404145803.GJ3186@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <b5f3cb9f-d40a-439a-34a4-58bba9ec0387@weilnetz.de>
Date: Wed, 4 Apr 2018 17:55:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180404145803.GJ3186@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xONVZWKLaBJ04tjZO66gpfGJJSUq9kfex"
Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add instructions for
 MacPorts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>, Rainer M?ller <raimue@macports.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xONVZWKLaBJ04tjZO66gpfGJJSUq9kfex
From: Stefan Weil <sw@weilnetz.de>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>,
 Rainer M?ller <raimue@macports.org>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <b5f3cb9f-d40a-439a-34a4-58bba9ec0387@weilnetz.de>
Subject: Re: [Qemu-devel] [qemu-web PATCH] download: Add instructions for
 MacPorts
References: <mailman.35816.1522678020.27992.qemu-devel@nongnu.org>
 <B4011235-0338-474D-90E4-ABDF3DC8CCB7@gmail.com>
 <eeb9a3c8-e7ee-742b-fd6a-41c364d971c4@redhat.com>
 <57D8CDA1-C9D1-4CD7-99A1-203B570BF4D3@gmail.com>
 <20180404143859.GI3186@redhat.com>
 <e283ef1f-a1cd-c21a-9058-c68c76182486@redhat.com>
 <20180404145803.GJ3186@redhat.com>
In-Reply-To: <20180404145803.GJ3186@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 04.04.2018 um 16:58 schrieb Daniel P. Berrang=C3=A9:
> On Wed, Apr 04, 2018 at 04:45:48PM +0200, Paolo Bonzini wrote:
>> On 04/04/2018 16:38, Daniel P. Berrang=C3=A9 wrote:
>>> The source/quality of those binaries is completely opaque. We've no i=
dea who
>>> built them, nor what build options were used, nor what/where the corr=
esponding
>>> source is (required for GPL compliance), nor any checksum / signature=
 to
>>> validate the binary isn't compromised since build, etc, etc.
>>>
>>> Pointing users to those binaries makes it appear QEMU project is bles=
sing
>>> them, and so any issues with them directly reflect on QEMU's reputati=
on.
>>>
>>> If we're going to link to binaries telling users to download them, we=
 need
>>> to be hosting them on qemu.org and have a clearly documented formal p=
rocess
>>> around building & distributing them.
>>>
>>> Since both Homebrew & Macports are providing formal bulds though, it =
looks
>>> simpler to just entirely delegate the problem to them, as we do for L=
inux
>>> where we delegate to distro vendors to build & distribute binaries.
>>
>> Note that, to some extent, the same issues do apply to Win32 binaries
>> (in particular, they are distributed under http and there are no
>> signatures).  However, the situation is better in that they are hosted=

>> on an identifiable person's website, and of course Windows doesn't hav=
e
>> something akin to Homebrew and Macports so there is no alternative to
>> volunteers building and hosting the binaries.
>=20
> It would be desirable & practical to address that for Win32, by buildin=
g
> the Win32 binaries at time of cutting the release, using the Mingw tool=
chain
> via one of our formal Docker environments. Would need buy-in of our rel=
ease
> manager to accept the extra work for making releases though...
>=20
> Regards,
> Daniel

That would be one possible way. A more automated way could use CI builds
(for example on GitHub) to generate executables for Windows.

By the way: https://qemu.weilnetz.de provides https (maybe I should
enforce it), it includes sha512, and I also sign the binaries with my
key. You still have to trust me, Debian and Cygwin (which provides lots
of libraries used for the build).

Regards,
Stefan


--xONVZWKLaBJ04tjZO66gpfGJJSUq9kfex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESSNv6nXJXWmOwreK4Iwh1Wd0UK0FAlrE9YsACgkQ4Iwh1Wd0
UK35pg/9HLhjrRrn7M3XF5pa6ijxxcPsvJzdb7yySZ2RB9af5fuv4TKeir5dZnkZ
DQQQidD9pXBu174qfZ/YnTkZjw+5FyxzyegFGXUITy8JA6HWMB6Mh3ZrtcvLrn9r
bdjqKJSoRtRQwEBL8pz4X6lcECHepMBPVeNX8Xfta1B42FJrgMHFue3/bJPxzfVI
LopQx81I7r0GvwQhNAHa7tshySv99mjn+e84+z9TS00bFQ4IDJx9yF+0nidjya6i
cYyFkhq6XRZ/AAisvEbT/BJtQQ4KN6BurrUZ61y2Cjg1l6br3FWW/F4MVEX2sgjf
qcnNnydX6SNjXi5wbWQ2TArIWN5N0UcfVqnZxKkSnMtHObgkYnMe2sQ12ty3KN7n
LoE6oRokSZ3tAD9VsYCTi2RUTmL5ccjDG3z8/whNKHGddpoqoTgLb6HUj8dJh02a
GdOHi8N83YkOsWBSsWwsRbebZKsT0+PFpdK0hstW8VdK//ylko/FurJQewZM195G
fBzURyoCQ/kjTUhtxxXhfcMEAS35pVoUTfWkZRvFam6CrpW//9iXde8yvJcqG6Zl
SOz87D7kpoMsug4tu40H+ZGrmHalnhYEg5MDo7893TVU9KB72HoitLFeN4iLyozy
EmN6mHfYuKUfbxT1yvlxw9irG+KLDbAn906kWyS73FZatTQa+Y8=
=omP7
-----END PGP SIGNATURE-----

--xONVZWKLaBJ04tjZO66gpfGJJSUq9kfex--
