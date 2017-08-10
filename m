Received: from eggs.gnu.org ([2001:4830:134:3::10]:41095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsBk-0006xj-VQ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsBj-0007qt-LQ
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 14:28:09 -0400
References: <20170810160451.32723-1-berrange@redhat.com>
	<20170810160451.32723-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9091d4cc-3375-a65d-e629-9ee3554d78ea@redhat.com>
Date: Thu, 10 Aug 2017 13:27:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170810160451.32723-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QmJHoafXV4aUbupdJTBpAmtwKbOiEq6gb"
Subject: Re: [Qemu-devel] [PATCH 4/8] blockdev: convert qemu-nbd server to
 QIONetListener
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QmJHoafXV4aUbupdJTBpAmtwKbOiEq6gb
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org
Message-ID: <9091d4cc-3375-a65d-e629-9ee3554d78ea@redhat.com>
Subject: Re: [PATCH 4/8] blockdev: convert qemu-nbd server to QIONetListener
References: <20170810160451.32723-1-berrange@redhat.com>
 <20170810160451.32723-5-berrange@redhat.com>
In-Reply-To: <20170810160451.32723-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 11:04 AM, Daniel P. Berrange wrote:
> Instead of creating a QIOChannelSocket directly for the NBD
> server socket, use a QIONetListener. This provides the ability
> to listen on multiple sockets at the same time, so enables
> full support for IPv4/IPv6 dual stack.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-nbd.c | 50 +++++++++++++++++---------------------------------
>  1 file changed, 17 insertions(+), 33 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QmJHoafXV4aUbupdJTBpAmtwKbOiEq6gb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMpasACgkQp6FrSiUn
Q2o41wf/YtI4t4FnWctEBYpQLEmifCMonEFSv6s90zqYoLY2NFXc1ZxMCgo4kF/9
drBykEYQCeyBefoApJToPI7q3g5tHZm0C7elnVieegFGqTnTrH/NGxX8RHsfvi4E
+CFYWWhkao6cb9f45N+tsBknbOxfGpdS+m3OIp0lgZFnjleMo1271EYG+DKy05Q/
xWDxqexQGi0rstuExbEydtlNo3b5oHoKl8AL+L1RISOX0sWOoejD9WL3HMtfKaQ5
oPTDofhFIBgCoZICtkYgmy2YsIEl38BKj830bdxMqMe7/aHFh/yfS+aF37Zj7yV0
xNXBO02uyyEnrx/ELXhxTdsN10+d2Q==
=TCqH
-----END PGP SIGNATURE-----

--QmJHoafXV4aUbupdJTBpAmtwKbOiEq6gb--
