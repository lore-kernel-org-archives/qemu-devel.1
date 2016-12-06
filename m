Received: from eggs.gnu.org ([2001:4830:134:3::10]:52981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEIXb-0002UI-AY
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEIXa-0001ad-4N
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:24:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cEIXZ-0001aK-RY
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:24:26 -0500
References: <2011630530.2430235.1481039230635.JavaMail.zimbra@redhat.com>
	<e8c1ed6f-fc4b-2093-60d8-5a2fb4f22e5e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efd2e5b9-ec59-f747-6cec-0a8ceaaffa5d@redhat.com>
Date: Tue, 6 Dec 2016 10:24:20 -0600
MIME-Version: 1.0
In-Reply-To: <e8c1ed6f-fc4b-2093-60d8-5a2fb4f22e5e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gf4UXJW4DXMimX9dMBgCeir5ruReVKfNf"
Subject: Re: [Qemu-devel] ui/egl-helpers.c license and reuse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Frediano Ziglio <fziglio@redhat.com>, Qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gf4UXJW4DXMimX9dMBgCeir5ruReVKfNf
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Frediano Ziglio <fziglio@redhat.com>,
 Qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Cole Robinson <crobinso@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <efd2e5b9-ec59-f747-6cec-0a8ceaaffa5d@redhat.com>
Subject: Re: [Qemu-devel] ui/egl-helpers.c license and reuse
References: <2011630530.2430235.1481039230635.JavaMail.zimbra@redhat.com>
 <e8c1ed6f-fc4b-2093-60d8-5a2fb4f22e5e@redhat.com>
In-Reply-To: <e8c1ed6f-fc4b-2093-60d8-5a2fb4f22e5e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 10:18 AM, John Snow wrote:
>=20
>=20
> On 12/06/2016 10:47 AM, Frediano Ziglio wrote:
>> Hi,
>>   I work in the SPICE team (www.spice-space.org). I'd like to reuse so=
me code from
>> this file for some test for our project. The license of the 2 projects=
 are a bit
>> different (GPL2 against LGPL2) so in theory I couldn't do it.
>> The code is mainly doing EGL initialization.
>> Could I obtain a dispensation to reuse to code as LGPL2 ?
>> Alternatively where can I get similar code with compatible LGPL2 licen=
se ?
>>
>> Regards,
>>   Frediano
>>
>=20
> "IANAL,"

Ditto

>=20
> Looks like the file was authored by four people with no explicit
> license, so it defaulted to GPL2.
>=20
> Cole Robinson, Gerd Hoffman, Gonglei, and Peter Maydell.
>=20
> Maybe you can get explicit permission from these four.

Markus Armbruster also has a one-line deletion (although how can a line
no longer present in the file be holding up a copyright question?). It
depends on whether you use 'git blame' to track all contributors to the
current state of the file, or 'git log' to track all authors to any
changes to the file.  'git blame' may also come in handy if you only
need to copy a subset of the file.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gf4UXJW4DXMimX9dMBgCeir5ruReVKfNf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRuY0AAoJEKeha0olJ0NqRHoH/ii9J4vE2IHbjjDZDxvS+M1M
HKw/PYRJNeWLltUTienVV99PSyNQhApg521/TV57mCiUJhDTSiE3xZnz+Xym6n+U
ozrgUKDt61TfUwPxFY+NgWGhnkGZAtAKVySLj6KnOgcFc6oqDJcSqgjYEQvdX+vw
S29CARHI9s3ZxmxF2xn/w/9G8dxTpJ4fQmMUdQR4eB+XdcJ/xqg+VFNdqrozdi9R
5jRd/6iBxNCe7VSkKy6Nl82417GN6ClCIGFKNTXCYhuhx/Sez0+vW936RGE7gq1Q
IyBFQT4kfGcviGkSkKB08GGgFKSbmN1KeXk93s0RhXh80xjdj37utdrSDuJMaWE=
=OTRE
-----END PGP SIGNATURE-----

--gf4UXJW4DXMimX9dMBgCeir5ruReVKfNf--
