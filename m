Received: from eggs.gnu.org ([2001:4830:134:3::10]:38291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHr3W-0003h3-Fr
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHr3S-0002KM-7h
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:24:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHr3R-0002Jj-VC
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:24:18 -0400
References: <20170605085254.16485-1-sf@sfritsch.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e27e8fb4-64fa-9ba9-26a2-aa2af758462b@redhat.com>
Date: Mon, 5 Jun 2017 07:24:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170605085254.16485-1-sf@sfritsch.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HOujfIVc3OSn4TWSQ5QAGjxxcNEB1hxR3"
Subject: Re: [Qemu-devel] [PATCH] Add chardev-send-break monitor command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HOujfIVc3OSn4TWSQ5QAGjxxcNEB1hxR3
From: Eric Blake <eblake@redhat.com>
To: Stefan Fritsch <sf@sfritsch.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <e27e8fb4-64fa-9ba9-26a2-aa2af758462b@redhat.com>
Subject: Re: [PATCH] Add chardev-send-break monitor command
References: <20170605085254.16485-1-sf@sfritsch.de>
In-Reply-To: <20170605085254.16485-1-sf@sfritsch.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/05/2017 03:52 AM, Stefan Fritsch wrote:
> Sending a break on a serial console can be useful for debugging the
> guest. But not all chardev backends support sending breaks (only telnet=

> and mux do). The chardev-send-break command allows to send a break even=

> if using other backends.
>=20
> Signed-off-by: Stefan Fritsch <sf@sfritsch.de>
> ---
>  chardev/char.c   | 12 ++++++++++++
>  hmp-commands.hx  | 16 ++++++++++++++++
>  hmp.c            |  8 ++++++++
>  hmp.h            |  1 +
>  qapi-schema.json | 20 ++++++++++++++++++++
>  5 files changed, 57 insertions(+)

Is there an obvious test that we can enhance to add coverage of the new
QMP command?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HOujfIVc3OSn4TWSQ5QAGjxxcNEB1hxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNU1sAAoJEKeha0olJ0NqEvcH/3Gi+YqRn/QU+fN50zuXetp9
796+B7noRdIX7Zh4j4YHu3wR79j0HGIaPZuGpOTpp99tqS54Qx80MnQuuIGC2BLh
QAQ8fEwCA+zCQjREgn9CCBTGZY5CCbOUfncKG+qJ8MezA9vUYRYbIhbsuaR3cyx9
hQSVB1e3xLHDKgkgZmX4+V9dFXLjt1RmJiDlYQPSW6aceL59DdLjMqmDSUyRVRs/
yG4LZjTTk+G+/JifPvhjhTQlAcjiVq47zxfRhaeJsiJjAGPwMwZvke8DqZRkCSMf
Gx4O4ehMgPSfkHQIyE1WxjyrUj/wpAGgVOc9JWId4DQpXE6MaDsXfNT5RsQGALs=
=El+W
-----END PGP SIGNATURE-----

--HOujfIVc3OSn4TWSQ5QAGjxxcNEB1hxR3--
