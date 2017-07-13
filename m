Received: from eggs.gnu.org ([2001:4830:134:3::10]:51986)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dVizv-0002Gq-Jv
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 14:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dVizr-00045T-Lb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 14:37:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:60407)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dVizr-00044k-A0
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 14:37:55 -0400
References: <1499965423-13517-1-git-send-email-peter.maydell@linaro.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <b8786d81-4a28-952d-deba-d808ebf42656@gmx.com>
Date: Thu, 13 Jul 2017 20:40:01 +0200
MIME-Version: 1.0
In-Reply-To: <1499965423-13517-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rdluCuE20am2NTrNS1SkihWUkJEX6tITT"
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix NetBSD build (don't build ivshmem
 tools)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rdluCuE20am2NTrNS1SkihWUkJEX6tITT
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, patches@linaro.org
Message-ID: <b8786d81-4a28-952d-deba-d808ebf42656@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix NetBSD build (don't build ivshmem
 tools)
References: <1499965423-13517-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499965423-13517-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.07.2017 19:03, Peter Maydell wrote:
> This patchset fixes the build on NetBSD by making sure we only
> build the ivshmem-client and ivshmem-server tools if the host OS
> actually supports ivshmem. (Previously we were only gating building
> of the within-QEMU ivshmem PCI device.)
>=20
> Most of this patchset is the work of Kamil Rytarowski; I just
> split it up into easily-reviewable patches and fixed a few bugs.
>=20

Thank you for improving the patches!

> Tested on Linux, on NetBSD, and on Linux with a '--disable-linux-user
> --disable-system' config (which was the one that was failing with
> our previous attempt to fix this bug).
>=20
> NB: we still have some things we need to fix to be able to put
> NetBSD into the build-test set. The next issue is that 'make check'
> fails with
>=20
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$((RANDOM % 255 + 1))} gtester -k =
--verbose -m=3Dquick tests/check-qdict
> sh: arith: syntax error: "RANDOM % 255 + 1"
>=20
> likely because we're using a bashism there.
>=20

This is an extension to a POSIX shell. We were lately adding it as an
extension to our sh(1) in the distribution. Were also thinking about
prompting POSIX to standarize it.

$ echo $((RANDOM % 255))
52

As of now, one portable solution is to parse /dev/urandom, or use a 3rd
party tool like awk(1).

To make the life easier we can try to request bash to run tests. A
portable shebang is "/usr/bin/env bash".

=46rom the NetBSD point of view I see nothing wrong with using bash for t=
ests.

We can also request NetBSD 8.0 for running tests, busy wait till getting
this compatibility issue gone. As of now NetBSD 8.0 is in beta.
Personally I don't intend to invest to much time into pre-8.0 releases.

> thanks
> -- PMM
>=20
> Kamil Rytarowski (2):
>   configure: Use an explicit CONFIG_IVSHMEM rather than CONFIG_EVENTFD
>   configure: Don't build ivshmem tools unless CONFIG_IVSHMEM is set
>=20
> Peter Maydell (1):
>   configure: Rename CONFIG_IVSHMEM to CONFIG_IVSHMEM_DEVICE
>=20
>  configure               | 11 +++++++++++
>  Makefile                |  2 ++
>  Makefile.objs           |  4 ++--
>  hw/misc/Makefile.objs   |  2 +-
>  tests/Makefile.include  |  4 ++--
>  default-configs/pci.mak |  2 +-
>  6 files changed, 19 insertions(+), 6 deletions(-)
>=20



--rdluCuE20am2NTrNS1SkihWUkJEX6tITT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZ76HAAoJEEuzCOmwLnZs+iAP/0zL78toB/DgkbzHqRuqU+Kr
NG/hKkFjqsiOvQHJRrVsUEhWv6M0Be5dCW4iHvyCItfGuj3InLWyfIPr4hvSK6BO
bP7xrTP5TwbHHED4dVtkvHvVUzULOchc3OouPa7OS8OktMjc7mZ1d7/M4m9cIuCw
eX73AZp9X5kTrB/JygWA2v7/24HUY1AO1NugBNiGIHIGr5/eDq8doreQMTUlqEoJ
/p0C/JUyTKhkQ8QnsgNhCqpPZv1DnMRsqWAosVbkfspUlJJfw5Pditj54tzbW4Pv
pbLdE4++8fkba3L1aKk+SoiRlQ1fLQR9Xbtj201ECreEZ61NPRu9EqIaNAV5HnG9
fxvX5PTInkimV7IKowsvIYQPy/feHFfDKSPbJrjzPZMl4rU+RRKxLXmQ+RR3A0J1
xI1WpkOH229bPUnS5qNajKTWqxWdW1wBl6xDqnYjhHR99Wv35zhikr4KmMdWnVlK
Mg1rbvXDdcoMEndRcjl43euvCQVILe5/vCbaUHZKuQIxmbR69V/OvEAe5nFZxvtp
DMvj1CF+/JAI/QDXyaN3X9Ibe0xGz66EL0uktJiq1tBqGhazU3jfhorGga7ioszA
Ywko2xGXFonaZaPh0eUIv2qa7PIzk7FD0NzeSnFbJa1hbYMUYV15x0p5wSWT6Cxn
v/tDPmr9E8tbcsX9GrVQ
=J2YT
-----END PGP SIGNATURE-----

--rdluCuE20am2NTrNS1SkihWUkJEX6tITT--
