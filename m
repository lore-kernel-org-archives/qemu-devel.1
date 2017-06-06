Received: from eggs.gnu.org ([2001:4830:134:3::10]:58633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIFJ0-0006Gr-Ve
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIFIx-0003iZ-PS
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:17:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIFIx-0003hO-GL
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:17:55 -0400
References: <20170605085254.16485-1-sf@sfritsch.de>
	<e27e8fb4-64fa-9ba9-26a2-aa2af758462b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39506179-0abd-5bba-89a2-fe89e6f3a167@redhat.com>
Date: Tue, 6 Jun 2017 16:17:42 +0200
MIME-Version: 1.0
In-Reply-To: <e27e8fb4-64fa-9ba9-26a2-aa2af758462b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XLgVmO8SG9sIj3i7eBS8cjHBCsNpjq1OU"
Subject: Re: [Qemu-devel] [PATCH] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XLgVmO8SG9sIj3i7eBS8cjHBCsNpjq1OU
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, Stefan Fritsch <sf@sfritsch.de>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <39506179-0abd-5bba-89a2-fe89e6f3a167@redhat.com>
Subject: Re: [PATCH] Add chardev-send-break monitor command
References: <20170605085254.16485-1-sf@sfritsch.de>
 <e27e8fb4-64fa-9ba9-26a2-aa2af758462b@redhat.com>
In-Reply-To: <e27e8fb4-64fa-9ba9-26a2-aa2af758462b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/06/2017 14:24, Eric Blake wrote:
> On 06/05/2017 03:52 AM, Stefan Fritsch wrote:
>> Sending a break on a serial console can be useful for debugging the
>> guest. But not all chardev backends support sending breaks (only telne=
t
>> and mux do). The chardev-send-break command allows to send a break eve=
n
>> if using other backends.
>>
>> Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
>> ---
>>  chardev/char.c   | 12 ++++++++++++
>>  hmp-commands.hx  | 16 ++++++++++++++++
>>  hmp.c            |  8 ++++++++
>>  hmp.h            |  1 +
>>  qapi-schema.json | 20 ++++++++++++++++++++
>>  5 files changed, 57 insertions(+)
>=20
> Is there an obvious test that we can enhance to add coverage of the new=

> QMP command?

You could have a new test covering hw/char/serial.c, but I wouldn't let
that hold the patch.

Paolo


--XLgVmO8SG9sIj3i7eBS8cjHBCsNpjq1OU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlk2uYYACgkQv/vSX3jH
roMD5gf8Cw8c91h3FPnyiPY/2w8bBCB27GtXyrdkJb5sFug3UiPgLUNBQ0in+HlV
0NYc6yVM7eepIKrd35IgOwmdBuXmcf+j2W2ZlWj+bzztVg3JSSUUPdQLn9f8d3cM
U4xqz34NIaWWpNByX2wx2+/x/KQtyaMSCl3zq42CMTbHhcMkelG35dkygKYQsuP/
5IJZjpuowNicXzhbyWi85WQIn5ioWp/1MJWpLVBThgBXHQy7Gyref7bHPY5SEm07
S1ggyVQJMDLmswtwv5WvTIoz2LOnT3i1Zs+ewpE92TuLQNp3H6ts0n4Cs/Zi9/K1
nGmUes1HOnc7302OKcGMoIyEVQqwIw==
=83yd
-----END PGP SIGNATURE-----

--XLgVmO8SG9sIj3i7eBS8cjHBCsNpjq1OU--
