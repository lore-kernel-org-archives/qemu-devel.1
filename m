Received: from eggs.gnu.org ([2001:4830:134:3::10]:58056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYXRt-0002Mv-Hb
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYXRo-0001Vh-MZ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:54:29 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dYXRo-0001VK-Eb
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:54:24 -0400
Received: by mail-wm0-x236.google.com with SMTP id w126so12091601wme.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 05:54:24 -0700 (PDT)
Date: Fri, 21 Jul 2017 13:54:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721125420.GE18014@stefanha-x1.localdomain>
References: <CAC0nwATQ-YKmYHyvOQeEmA8u=BvVrC8q20=Ogmr+TFaWRiRUfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <CAC0nwATQ-YKmYHyvOQeEmA8u=BvVrC8q20=Ogmr+TFaWRiRUfw@mail.gmail.com>
Subject: Re: [Qemu-devel] ask a question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?55qu5pm6?= <pizhi0616@gmail.com>
Cc: qemu-devel@nongnu.org


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 03:39:15PM +0800, =E7=9A=AE=E6=99=BA wrote:
> hi qemu-devel=EF=BC=8CI want to know why should add the migration blocker=
s to
> prevent live migration in peer mode=EF=BC=8Cif I drop the patch=EF=BC=8CW=
hat other
> disadvantages will it bring=EF=BC=9F

Peer mode means ivshmem-server is used.  It doesn't support live
migration.  For example, how should peers be migrated and what happens
to peer IDs?

I don't know whether it's possible to add live migration support, but it
would definitely require code changes.  Just removing the migration
blocker will not make migration work correctly in peer mode.

--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZcfl8AAoJEJykq7OBq3PIA4IIAKU+AgtJH7TMz+4hQmEP+BSr
pXDF6DeMG6rNy8fgK4wtWDOCF+mm1oGz6sblA6+eBtTNOl/uhJ+A3zCL+H7prEls
cG1GdhIiagv4lUYQ4QjJZfyLoVMjbXnZJyeFOQqoX9E9fG3uhzlddUhakdUOQxeW
nCGkaSsuu/hPM2UrDDBnm+5oUAY48D6pgfXTSTyJEK40ZKLiHC9SU9pACcy3nqPz
9/j6yqy6YUsxmMlB/cLYjcnJJCZZX3qCuSsdvzZRvVmwbOKVCosl+IorlgvXMv6w
UBDrkq0pHX2EcgYuJ6Oz9LXvXc/PlnEXUQosoeH01v20nXW+O8BleM1nc+VyxxQ=
=G0js
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
