Received: from eggs.gnu.org ([2001:4830:134:3::10]:36091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePw3B-0003Hv-M3
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:53:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePw38-0005VT-JT
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:53:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePw38-0005UA-AQ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 14:53:38 -0500
References: <20171213232025.24503-1-f4bug@amsat.org>
	<20171213232025.24503-2-f4bug@amsat.org>
	<20171214090658.GA3731@dhcp-200-186.str.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f473fa69-c8ea-7f89-0422-2fb1a7337fa8@redhat.com>
Date: Fri, 15 Dec 2017 13:53:24 -0600
MIME-Version: 1.0
In-Reply-To: <20171214090658.GA3731@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="v3VNpwOFoeOWcxeWgF5OVjcl9TrSjjQ2d"
Subject: Re: [Qemu-devel] [PATCH 01/26] sdbus: add a QMP command to access a
 SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v3VNpwOFoeOWcxeWgF5OVjcl9TrSjjQ2d
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Message-ID: <f473fa69-c8ea-7f89-0422-2fb1a7337fa8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/26] sdbus: add a QMP command to access a
 SDBus
References: <20171213232025.24503-1-f4bug@amsat.org>
 <20171213232025.24503-2-f4bug@amsat.org>
 <20171214090658.GA3731@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171214090658.GA3731@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/14/2017 03:06 AM, Kevin Wolf wrote:
> Am 14.12.2017 um 00:20 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>> Use Base64 to serialize the binary blobs in JSON.
>> So far at most 512 bytes will be transfered, which result

s/transfered/transferred/

>> in a 684 bytes payload.
>> Since this command is intented for qtesting, this is acceptable.

s/intented/intended/

>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Doing this kind of thing over QMP doesn't look right to me. qtests
> should access hardware the same way as real guests access the hardware
> (i.e. MMIO and I/O ports).
>=20
> But if for some reason the QMP maintainers were to think that this is
> acceptable in QMP, I'd argue it should at least get an x-debug- prefix
> to avoid making it a stable API that management tools may rely on.

I'm not convinced the command is needed, but agree that if we want it,
it should have an 'x-debug-' prefix.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--v3VNpwOFoeOWcxeWgF5OVjcl9TrSjjQ2d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlo0KDQACgkQp6FrSiUn
Q2oUTQf+P6dyTeVSk3MXre+UNwayKD51ZIEVxNYTvtHAZBJV0lMkRqvxpK3y9sTl
6NKhyYU6HXpw87PAlF4l1pRgL2063sgAXLB9KgQPLRR7UF8BRDtl8RgD/QPwfXAy
MAxSszlgllRA8pv+tM/8YXmo/QW/6cB4DRDbtpzp7z5+U2EJwu6E12ZUcNwoeyKU
2jDL258ea//8rM14Oww7PEz4JO2UUe6Dffh+5xhNsKLVOhqVvju/auLblP9y10CK
5Ik2GESgvm2H+k/H9LFm5v4qWlZRpxw5qhl2PM/1A2pRGp7cEBdP9i8ch124uUbT
cJZp52k/dku8QvexFR0/dgBI6cxxnQ==
=+w/L
-----END PGP SIGNATURE-----

--v3VNpwOFoeOWcxeWgF5OVjcl9TrSjjQ2d--
