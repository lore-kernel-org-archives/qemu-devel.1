Received: from eggs.gnu.org ([2001:4830:134:3::10]:53602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiNy-0007ox-73
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiNx-0007JO-8Y
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:47:18 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-8-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92a75f2c-d99c-a4c8-77c4-11898b16fe1b@redhat.com>
Date: Mon, 24 Jul 2017 13:46:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-8-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N5hTuEk3O3TDLQriglvagNv5rlb0R4seu"
Subject: Re: [Qemu-devel] [PATCH for 2.10 07/35] qcow2: fix null pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N5hTuEk3O3TDLQriglvagNv5rlb0R4seu
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org
Message-ID: <92a75f2c-d99c-a4c8-77c4-11898b16fe1b@redhat.com>
Subject: Re: [PATCH for 2.10 07/35] qcow2: fix null pointer dereference
References: <20170724182751.18261-1-f4bug@amsat.org>
 <20170724182751.18261-8-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 01:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> If find_bitmap_by_name() fails we have bm=3DNULL and go to the 'fail' l=
abel, then
> call bitmap_free(bm) which does g_free(bm->name) with bm=3DNULL...
>=20
> Clang's scan-build-5.0 output:
> block/qcow2-bitmap.c:492:12: warning: Access to field 'name' results in=
 a dereference of a null pointer (loaded from variable 'bm')
>     g_free(bm->name);
>            ^~~~~~~~
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  block/qcow2-bitmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Max already has a better patch from Vladimir pending on his block queue:
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04398.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--N5hTuEk3O3TDLQriglvagNv5rlb0R4seu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2QKUACgkQp6FrSiUn
Q2pobgf/ZjnMaYf8PMIUQe20KpUs/lpBu28bPDo4LsIPg02KV3CX9CKLyyBE8+YO
rH+te+ZoodHGM6g+33lKPAXT+DGyAmwi73htv2yGfo285ywu6zF3W0x9RuVr8M4+
W2kXM+16jp52/itLc1+0qeEt39I1lAYa5eb4u5pigdsQStbVTzTv96wmJyzqFJWN
kqnHTc9M1xjYtYrJi/TgtKQFQLlqttWE/JbEKhrqFz3NvjG6d2KnSnXxuKqHo3kJ
mvEMCFpVKxG/10Qh4PX9/2NnX+2Gsa/jiu39G2MxWf6nqycWmceVPRB0+qGSN3rC
AZCJyWy+vDVVqi/fYaPfMXy6q35ghg==
=LjmP
-----END PGP SIGNATURE-----

--N5hTuEk3O3TDLQriglvagNv5rlb0R4seu--
