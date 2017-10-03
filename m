Received: from eggs.gnu.org ([2001:4830:134:3::10]:46546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzMJi-0000X0-Df
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzMJf-0002dW-5L
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:28:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dzMJe-0002cb-Rw
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 08:28:51 -0400
References: <20140607203050.27669.10321.malonedeb@gac.canonical.com>
	<150702766740.1698.17693165473735413839.malone@chaenomeles.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4f6b65f-9fa9-3cdd-3e9c-182be5ed6436@redhat.com>
Date: Tue, 3 Oct 2017 07:28:48 -0500
MIME-Version: 1.0
In-Reply-To: <150702766740.1698.17693165473735413839.malone@chaenomeles.canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2BORbhLv663Cp8iIwkahpM4qen7TRMfx6"
Subject: Re: [Qemu-devel] [Bug 1327608] Re: monitor socked path is cut a 105
 characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1327608 <1327608@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2BORbhLv663Cp8iIwkahpM4qen7TRMfx6
From: Eric Blake <eblake@redhat.com>
To: Bug 1327608 <1327608@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <f4f6b65f-9fa9-3cdd-3e9c-182be5ed6436@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1327608] Re: monitor socked path is cut a 105
 characters
References: <20140607203050.27669.10321.malonedeb@gac.canonical.com>
 <150702766740.1698.17693165473735413839.malone@chaenomeles.canonical.com>
In-Reply-To: <150702766740.1698.17693165473735413839.malone@chaenomeles.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/03/2017 05:47 AM, Thomas Huth wrote:
> Triaging old bug tickets... can you still reproduce this issue with the=

> latest version of QEMU? Or could we close this ticket nowadays?

This may be fixed by:

commit ad9579aaa16d5b385922d49edac2c96c79bcfb62
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Thu May 25 16:53:00 2017 +0100

    sockets: improve error reporting if UNIX socket path is too long

    The 'struct sockaddr_un' only allows 108 bytes for the socket
    path.

    If the user supplies a path, QEMU uses snprintf() to silently
    truncate it when too long. This is undesirable because the user
    will then be unable to connect to the path they asked for.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2BORbhLv663Cp8iIwkahpM4qen7TRMfx6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnTgoAACgkQp6FrSiUn
Q2rnhAf/f+WxlTkIt2XJEoUEB35Ze1rDpoWe9EqXKOuhBzOU/+ye7BHAaHo7WvJ6
8EhvXwVsYpGDN+KPglnzYrExbEOnL66pM4y8yR3wcKBNQO5pVhae834SBTt1ITLq
YrCub3nLF7IxWFtRO9emYNI+KaSzQa8GKZBYBrNHuoyHylQxJOb8OfWfnb/wizdr
77TnjQtU/0j9MUdiKdK33kKeYSgXJR9WscnshjqcqAoDOujamm+ystKI+NyI9Di2
wzB0TY7cBb5z981pEjivAKAQM1VnMuqO1xGmUfGU5YgLdKzDpZtKBUXLp57w4cxL
7k4xZKlx0zHFlhIQM9/H/xIp2LHy0g==
=U7GZ
-----END PGP SIGNATURE-----

--2BORbhLv663Cp8iIwkahpM4qen7TRMfx6--
