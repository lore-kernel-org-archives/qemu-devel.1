Received: from eggs.gnu.org ([2001:4830:134:3::10]:48819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDvUk-0006UO-FC
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDvUf-00070n-SE
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:20:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26561)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDvUf-0006zr-Ja
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:20:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D457917AC5A
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 16:20:07 +0000 (UTC)
References: <20170525155300.22743-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a61721d-8554-4d92-50aa-4c34c9dcd397@redhat.com>
Date: Thu, 25 May 2017 11:20:00 -0500
MIME-Version: 1.0
In-Reply-To: <20170525155300.22743-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vMrsFmdroI18MVHeXV9dQpNMObA4AtxBL"
Subject: Re: [Qemu-devel] [PATCH v4] sockets: improve error reporting if
 UNIX socket path is too long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vMrsFmdroI18MVHeXV9dQpNMObA4AtxBL
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <0a61721d-8554-4d92-50aa-4c34c9dcd397@redhat.com>
Subject: Re: [PATCH v4] sockets: improve error reporting if UNIX socket path
 is too long
References: <20170525155300.22743-1-berrange@redhat.com>
In-Reply-To: <20170525155300.22743-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 10:53 AM, Daniel P. Berrange wrote:
> The 'struct sockaddr_un' only allows 108 bytes for the socket
> path.
>=20
> If the user supplies a path, QEMU uses snprintf() to silently
> truncate it when too long. This is undesirable because the user
> will then be unable to connect to the path they asked for.
>=20
> If the user doesn't supply a path, QEMU builds one based on
> TMPDIR, but if that leads to an overlong path, it mistakenly
> uses error_setg_errno() with a stale errno value, because
> snprintf() does not set errno on truncation.
>=20
> In solving this the code needed some refactoring to ensure we
> don't pass 'un.sun_path' directly to any APIs which expect
> NUL-terminated strings, because the path is not required to
> be terminated.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>=20
> Changed in v4:
>=20
>  - Do length check before any mkstemp to avoid leaving long
>    tmpfile on disk on error

Took us a few iterations, but it was worth it.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vMrsFmdroI18MVHeXV9dQpNMObA4AtxBL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJwQwAAoJEKeha0olJ0NquuQH/iJPcbKQejtmnR5QQYNKi24H
GNdQcRr7cSBixG3kXPWqfQnorhPeC7Io3LEuvIBjovUbeQcOtkKd2r9PHYKTksCL
6/7zA5pCbFCllp+NLEj3Vbm/me9MVV69tE5jRwdUSCeS4o9kTXc7dB0k6yRT5P8i
q6/9I/p8IorEa/kB0Kv7/Cyn1+qXheZSMvlsx9dU54JWY7/Gk9/pP6ot4VSj/E77
HBvDuYrC58gB5pnU13kJ+x88iQSK6nbcdJp/dHPlOj8IwVeptM05JhK8H2mX2qf1
5v1h4pCjf05pU8KytsHzblIgcnK6EOgzYAEeBMfVPFgOI4XaWiBRckSXijUr5gA=
=ljmQ
-----END PGP SIGNATURE-----

--vMrsFmdroI18MVHeXV9dQpNMObA4AtxBL--
