Received: from eggs.gnu.org ([2001:4830:134:3::10]:54083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAgoI-0001zY-9L
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAgoF-0004VY-0Y
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:35:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eAgoE-0004UT-NX
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:35:14 -0400
References: <20171103153333.6416-1-berrange@redhat.com>
	<20171103153333.6416-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <10360380-eb0c-104e-da9b-b6d8b5f26718@redhat.com>
Date: Fri, 3 Nov 2017 13:35:11 -0500
MIME-Version: 1.0
In-Reply-To: <20171103153333.6416-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3sO9ldh6NmNh7GB4ccEjRKWGkfdpDOuuJ"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] build: allow automatic git
 submodule updates to be disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3sO9ldh6NmNh7GB4ccEjRKWGkfdpDOuuJ
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <10360380-eb0c-104e-da9b-b6d8b5f26718@redhat.com>
Subject: Re: [PATCH v3 3/5] build: allow automatic git submodule updates to be
 disabled
References: <20171103153333.6416-1-berrange@redhat.com>
 <20171103153333.6416-4-berrange@redhat.com>
In-Reply-To: <20171103153333.6416-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2017 10:33 AM, Daniel P. Berrange wrote:
> Some people building QEMU use VPATH builds where the source directory i=
s on a
> read-only volume. In such a case 'scripts/git-submodules.sh update' wil=
l always
> fail and users are required to run it manually themselves on their orig=
inal
> writable source directory.
>=20
> While this is already supported, it is nice to give users a command lin=
e flag
> to configure to permanently disable automatic submodule updates, as it =
means
> they won't get hard to diagnose failures from git-submodules.sh at an a=
rbitrary
> later date.
>=20
> This patch thus introduces a flag '--disable-git-update' which will pre=
vent
> 'make' from ever running 'scripts/git-submodules.sh update'. It will st=
ill run
> the 'status' command to determine if a submodule update is needed, but =
when it
> does this it'll simply stop and print a message instructing the develop=
er what
> todo. eg
>=20
> $ ./configure  --target-list=3Dx86_64-softmmu --disable-git-update
> ...snip...
>=20
> $ make
>   GEN     config-host.h
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers.c
>   GEN     module_block.h
>=20
> GIT submodule checkout is out of date. Please run
>   scripts/git-submodule.sh update ui/keycodemapdb
> from the source directory checkout /home/berrange/src/virt/qemu
>=20
> make: *** [Makefile:31: git-submodule-update] Error 1
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile                 | 11 +++++++++++
>  configure                |  7 +++++++
>  scripts/git-submodule.sh |  9 +++++++++
>  3 files changed, 27 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3sO9ldh6NmNh7GB4ccEjRKWGkfdpDOuuJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln8tt8ACgkQp6FrSiUn
Q2pSXQf/VngluuFO7gdkVAfV+ic0Q7ao0MRRFukw7OzJatPuisQNVoJrHqD9MlU3
m2GdJPQmvdPldpbtXHQ4Msc13t1bwatTfGc+Bfp6gyp984jA/KxbLRR7YSMHQglW
mIsLsi+qs6/KXWV5FFtVIqaZZEgBbo3bRSt8kzKbThnV9jJgCPC1aedxTfCYL0zj
rdktlU5zeDYjgxIEP6e4PCqbIFxFCG9QX3RvXogFjGe1W0nFoEW7ZCw1BYdG04KP
h3CJQrKMTMHimY9RpkyD29bMaHbK/uW+8j5w8h94otV6YITPzHzYIFZ21MRvQl3/
vVw8WyOnBXdGiqQZFLekZEOWUB22BQ==
=ghdM
-----END PGP SIGNATURE-----

--3sO9ldh6NmNh7GB4ccEjRKWGkfdpDOuuJ--
