Received: from eggs.gnu.org ([2001:4830:134:3::10]:35812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eH7Uv-0001BK-DX
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eH7Us-0005Fv-1S
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:17:53 -0500
References: <20171121095510.29436-1-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <db0b9556-1758-874d-0194-2b77f09173f0@redhat.com>
Date: Tue, 21 Nov 2017 06:17:41 -0600
MIME-Version: 1.0
In-Reply-To: <20171121095510.29436-1-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4m3jWwWQUUJO6jc2hV4WuKIdpA5VQkG97"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] Makefile: use $(MAKE) variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4m3jWwWQUUJO6jc2hV4WuKIdpA5VQkG97
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <db0b9556-1758-874d-0194-2b77f09173f0@redhat.com>
Subject: Re: [PATCH v2 for-2.11] Makefile: use $(MAKE) variable
References: <20171121095510.29436-1-f4bug@amsat.org>
In-Reply-To: <20171121095510.29436-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/21/2017 03:55 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> For some systems (i.e. FreeBSD) the default 'make' is not compatible wi=
th the
> GNU extensions used by QEMU makefiles.
>=20
> Calling the GNU make (gmake) works, however the help displayed refers t=
o the
> host 'make' and copy/paste leads to lot of unobvious errors:
>=20

>=20
> Using the $(MAKE) variable, the help displayed is consistent with the '=
make'
> program used.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v2: dropped inconsistent replace in comment (Fam's review)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4m3jWwWQUUJO6jc2hV4WuKIdpA5VQkG97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloUGWUACgkQp6FrSiUn
Q2pz+Af/a7i/b69T+bHyDAV+ouooJrrSk1FhaVelO8nUxsDDL55V+rgQ3Oo4/FW6
GJLvup0cKNzURev3uurve5FfE/7uEgbcVvw70ZAzjkkqVg6WZFEMMg625QZTyGXI
ilqcjwCIGSPJSv4J+pqAAoYPoR2N+AivHx6afK+PxTJyDcJlQxrK/KbmOKExy8+6
wrXMRgXMLpJsbjLQuZcoRN+bCXBH7+6j6ka1/AZyJ5GMOJ9tg0NjmwXcqP2aH8vp
JamQl8Z2warq5+gOLtnvrD3VkdOFGh+WdN7ViqS8CeqLx2WZAH+ZIDbEiu5QviZM
dV7bVtsYcQbcXBqwNWWHMakKZAj0nw==
=Szwg
-----END PGP SIGNATURE-----

--4m3jWwWQUUJO6jc2hV4WuKIdpA5VQkG97--
