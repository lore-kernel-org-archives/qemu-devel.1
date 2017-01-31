Received: from eggs.gnu.org ([2001:4830:134:3::10]:39844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYYxq-0002qO-H7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYYxn-0002Se-Gt
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:59:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cYYxn-0002SU-7a
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 08:59:15 -0500
References: <20170131100945.8189-1-kwolf@redhat.com>
	<w51mve7o4n1.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4864049-0a56-bd97-4cd4-c71878a8477f@redhat.com>
Date: Tue, 31 Jan 2017 07:59:07 -0600
MIME-Version: 1.0
In-Reply-To: <w51mve7o4n1.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hTJekGRiouIos2rHATCx34tcNOGiFNaXL"
Subject: Re: [Qemu-devel] [PATCH] gtk: Hardcode LC_CTYPE as C.utf-8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: mfabian@redhat.com, armbru@redhat.com, kraxel@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hTJekGRiouIos2rHATCx34tcNOGiFNaXL
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Cc: mfabian@redhat.com, armbru@redhat.com, kraxel@redhat.com
Message-ID: <e4864049-0a56-bd97-4cd4-c71878a8477f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] gtk: Hardcode LC_CTYPE as C.utf-8
References: <20170131100945.8189-1-kwolf@redhat.com>
 <w51mve7o4n1.fsf@maestria.local.igalia.com>
In-Reply-To: <w51mve7o4n1.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 05:22 AM, Alberto Garcia wrote:
> On Tue 31 Jan 2017 11:09:45 AM CET, Kevin Wolf <kwolf@redhat.com> wrote=
:
>=20
>> Recently, however, glibc introduced a new locale "C.utf-8" that just
>> uses UTF-8 as its charset, but otherwise leaves the semantics alone.
>> Just setting the right character set is enough for our use case, so we=

>> can just hardcode this one without having to be afraid of nasty side
>> effects.
>=20
>>     setlocale(LC_MESSAGES, "");
>> +   setlocale(LC_CTYPE, "C.utf-8");
>>     bindtextdomain("qemu", CONFIG_QEMU_LOCALEDIR);
>=20
> A couple of quick questions:
>=20
> - Is it C.utf-8 or C.UTF-8 ? 'locale -a' shows only the latter in my
>   system.

At least Cygwin has C.UTF-8, but not C.utf-8.  Furthermore, since my
system defaults to en_US.UTF-8, I would expect the upper-case variant
for the character set name across all locales.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--hTJekGRiouIos2rHATCx34tcNOGiFNaXL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkJgrAAoJEKeha0olJ0Nqz40IAJo1mwl2vKETIQ0Qc+0Y+7Tc
klp03pUe+MCPmH4GEP7M4AHaxivmEZhGPR8tw2i0vti7ePPMf2AxAY4i6hIGIcSQ
sEpz46c9vABBn0teKCdzGbEwvuz+w/wzvOMADq8x05JmhniNzmCGWNnadA7nZ+vm
om4pcnjBV1Stuwg57hbIDPr952IxRoyCJpeG8rvY5RGUJfmDiDuvTEZmSVviJxe0
ERTLqgZAVH1BLjB3grDoF5ka3qbn1HXvbGybURIMznFf9+QsQTkAja1F3nNxdJeR
EOg/j8PuGIhzkkfv5e4CxX/XED1oNBjklhKmOL+jJnCjZXLm0OEXz2D81RtHeAk=
=Qtot
-----END PGP SIGNATURE-----

--hTJekGRiouIos2rHATCx34tcNOGiFNaXL--
