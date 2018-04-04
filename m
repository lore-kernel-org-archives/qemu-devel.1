Received: from eggs.gnu.org ([2001:4830:134:3::10]:38477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3kAC-0000D8-W9
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3kA6-0002nb-UQ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:17:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f3kA6-0002nF-OX
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:17:22 -0400
References: <20180404133550.2143237-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4db09c62-543f-4eb7-6415-24d80de6b02e@redhat.com>
Date: Wed, 4 Apr 2018 10:17:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180404133550.2143237-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6OMNb13pD0wtBSfrcD5VeyfiA2ooQE5Fj"
Subject: Re: [Qemu-devel] [PULL v2 0/4] QAPI and misc patches for 2.12-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6OMNb13pD0wtBSfrcD5VeyfiA2ooQE5Fj
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>
Message-ID: <4db09c62-543f-4eb7-6415-24d80de6b02e@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 0/4] QAPI and misc patches for 2.12-rc2
References: <20180404133550.2143237-1-eblake@redhat.com>
In-Reply-To: <20180404133550.2143237-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/04/2018 08:35 AM, Eric Blake wrote:
> The following changes since commit e5efa1f5f2d32cbfbf18ba84300736503985=
b593:
>=20
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' i=
nto staging (2018-04-04 12:33:23 +0100)
>=20
> are available in the Git repository at:
>=20
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-04-03-v2
>=20
> for you to fetch changes up to 908cc9be8811c15abc70e1a5e1c396d9c3414d2e=
:
>=20
>   iothread: workaround glib bug which hangs qmp-test (2018-04-04 08:22:=
37 -0500)
>=20
> In v2: add one more patch (just sending the new patch in this thread)

Self-NACK - these patches are still having conversations on the list. At
this point, since OOB is opt-in for 2.12, we can delay these patches to
-rc3 or drop them entirely, depending on the resolution to the ongoing
comments.

>=20
> ----------------------------------------------------------------
> qapi and misc patches for 2018-04-03
>=20
> - Peter Xu: monitor: bind dispatch bh to iohandler context
> - Eric Blake: maint: Add .mailmap entries for patches claiming list aut=
horship
> - Eric Blake: dump: Fix build with newer gcc
> - Peter Xu: iothread: workaround glib bug which hangs qmp-test
>=20
> ----------------------------------------------------------------
> Eric Blake (2):
>       maint: Add .mailmap entries for patches claiming list authorship
>       dump: Fix build with newer gcc
>=20
> Peter Xu (2):
>       monitor: bind dispatch bh to iohandler context
>       iothread: workaround glib bug which hangs qmp-test
>=20
>  dump.c     |  4 ++--
>  iothread.c | 18 ++++++++++++++----
>  monitor.c  |  2 +-
>  .mailmap   | 18 ++++++++++++++----
>  4 files changed, 31 insertions(+), 11 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6OMNb13pD0wtBSfrcD5VeyfiA2ooQE5Fj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrE7HgACgkQp6FrSiUn
Q2o45Qf9G4qGOWbbDe8wUFtqaLLyvH8rAXAURhn7LsJ5td/L97upDmJTTAmUQ8Dx
0snMUIVFZ79fIkxUUH1M+rgX5TgBkW+3X2B5BGcx7PkyNrJw0Ps7Bvbg7VE4/VAR
dWVvpYBx68gZHnu4tPh/hiFG0za0zMoZgcw4VI3lvZOUSXE6ynQbogjmP8AwEhY/
m+cu4h23MQqdaXGLKb06JAJPS5z5hrIeGsf5uEn2I5ZA/GhwfNZMp3LXsbqVb/xf
lRdMkAaNH4+17IKB2Ym5mUdbUEgxajTG4cWkg6i0bpontf9kPnOCCyOXlk+foird
/mmi/iR2nLmw9aULM09310VP5KUy4A==
=97xr
-----END PGP SIGNATURE-----

--6OMNb13pD0wtBSfrcD5VeyfiA2ooQE5Fj--
