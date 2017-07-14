Received: from eggs.gnu.org ([2001:4830:134:3::10]:41979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzKE-0001cT-0k
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzKC-00068P-Ls
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:04:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dVzKC-000686-Ce
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:04:00 -0400
References: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7da6e78d-5d59-1c75-19fd-b9e54c30a94c@redhat.com>
Date: Fri, 14 Jul 2017 07:03:58 -0500
MIME-Version: 1.0
In-Reply-To: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kipmUIf7vf1VsVXAIXXSHGFDMAAhUfwjr"
Subject: Re: [Qemu-devel] [PATCH] tests: Handle $RANDOM not being supported
 by the shell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Kamil Rytarowski <n54@gmx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kipmUIf7vf1VsVXAIXXSHGFDMAAhUfwjr
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Kamil Rytarowski <n54@gmx.com>
Message-ID: <7da6e78d-5d59-1c75-19fd-b9e54c30a94c@redhat.com>
Subject: Re: [PATCH] tests: Handle $RANDOM not being supported by the shell
References: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2017 05:45 AM, Peter Maydell wrote:
> In various places in our test makefiles and scripts we use the
> shell $RANDOM to create a random number. This is a bash
> specific extension, and doesn't work on other shells.

As mentioned elsewhere, you could reword this to "this is an extension
in bash and some other shells, but not universal".  But I'm also okay
leaving it untouched.

> Switch to using "${RANDOM:-0}" instead of $RANDOM,
> which will portably either give us a random number or zero.
> This means that on non-bash shells we don't get such
> good test coverage via the MALLOC_PERTURB_ setting, but
> we were already in that situation for non-bash shells.
>=20
> Our only other uses of $RANDOM (in tests/qemu-iotests/check
> and tests/qemu-iotests/162) are in shell scripts which use
> a #!/bin/bash line so they are always run under bash.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kipmUIf7vf1VsVXAIXXSHGFDMAAhUfwjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZaLMuAAoJEKeha0olJ0NqmNgH/iN3kpmVZPWsQtwGzicoyRhl
me1o4OjlJm2BmTXyj+bTg5MtV4YHUEv9B0nSpu0XF11R07MhEpBESsdDI7ubVUVZ
RaNG7pWyO+s3Werq9sMQ/OX7zbOHExSOnAF7QVacvQBwmq3rrpukfTw59PSPw671
an/ERd6Vh82GyVS1Hb6eneVK6OszgSEAs4U1FcuASs/0HltNUvM3dnrkkuUABWDT
WkPZLJ/4uni3T/jxUhQXci4W//3+z6DmWnc8Uli3KjfwBLGTZt5RvvZyT+i3qBlQ
SI9+u18XUB5Mn9+0SCWt++byFRTj/6ViM0z/4+DBVB3yg21bfp64yBeBLkEHZgc=
=S+J1
-----END PGP SIGNATURE-----

--kipmUIf7vf1VsVXAIXXSHGFDMAAhUfwjr--
