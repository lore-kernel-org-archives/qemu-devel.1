Received: from eggs.gnu.org ([2001:4830:134:3::10]:48117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIELA-0000A8-EI
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIEL5-00060W-Ly
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:20:40 -0400
Date: Mon, 14 May 2018 15:20:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514142032.GH5182@stefanha-x1.localdomain>
References: <20180511222052.8734-1-ehabkost@redhat.com>
	<20180511222052.8734-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Content-Disposition: inline
In-Reply-To: <20180511222052.8734-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC 01/10] python: futurize -f
 libfuturize.fixes.fix_print_with_import
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 07:20:43PM -0300, Eduardo Habkost wrote:
> Change all Python code to use print as a function.
>=20
> This is necessary for Python 3 compatibility.
>=20
> Done using:
>=20
>   $ py=3D$( (g grep -l -E '^#!.*python';find -name '*.py' -printf '%P\n';=
) | \
>     sort -u | grep -v README.sh4)
>   $ futurize -w -f libfuturize.fixes.fix_print_with_import $py
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  scripts/analyse-9p-simpletrace.py        | 89 ++++++++++++++++----------=
------
>  scripts/analyse-locks-simpletrace.py     |  1 +
>  scripts/analyze-migration.py             | 11 ++--
>  scripts/dump-guest-memory.py             |  1 +
>  scripts/replay-dump.py                   | 21 ++++----
>  scripts/signrom.py                       |  1 +
>  scripts/simpletrace.py                   |  3 +-
>  scripts/vmstate-static-checker.py        | 85 +++++++++++++++-----------=
----
>  scripts/device-crash-test                |  3 +-
>  scripts/kvm/kvm_flightrecorder           | 21 ++++----
>  scripts/kvm/vmxcap                       |  1 +
>  scripts/qmp/qemu-ga-client               |  1 +
>  scripts/qmp/qmp                          | 17 +++---
>  scripts/qmp/qmp-shell                    | 35 +++++++------
>  scripts/qmp/qom-get                      |  7 +--
>  scripts/qmp/qom-list                     | 11 ++--
>  scripts/qmp/qom-set                      |  5 +-
>  scripts/qmp/qom-tree                     | 11 ++--
>  tests/docker/docker.py                   | 11 ++--
>  tests/docker/travis.py                   | 15 +++---
>  tests/guest-debug/test-gdbstub.py        |  1 +
>  tests/image-fuzzer/runner.py             | 38 ++++++--------
>  tests/migration/guestperf/engine.py      | 29 ++++++-----
>  tests/migration/guestperf/plot.py        | 17 +++---
>  tests/migration/guestperf/shell.py       | 19 +++----
>  tests/qemu-iotests/149                   |  3 +-
>  tests/qemu-iotests/165                   |  3 +-
>  tests/qemu-iotests/iotests.py            |  5 +-
>  tests/qemu-iotests/nbd-fault-injector.py |  7 +--
>  tests/qemu-iotests/qcow2.py              | 39 +++++++-------
>  tests/qemu-iotests/qed.py                | 17 +++---
>  tests/vm/basevm.py                       |  3 +-
>  32 files changed, 278 insertions(+), 253 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+ZswAAoJEJykq7OBq3PI4dAIALj5NgxjsSLWCO6TUc3mA+02
5wSsv6PhukekC+cyz5stMuYMJE1bm55yX6fwLwnYE9i+qpZwGMd4jE++tQOWX5xK
tsxC/MSApuFYQImTS3xSPvWb1Z52NMkdsjCzw6+4EWJC2M0CN7uPTLlFw69nk4Zr
Qk36ta/ywPQ47hjgknb83Rz6xEGKtkOw02DVfYm5Q5G0HaMaPTiqiB3bg8DQIiEB
JYgDoiJfMquKs5vL1zSka3P7SSi66SYjfcJawnljViVjQ2T35HbSJ9lAzDLa1Re7
qb4F8O9f0Uod5ABiefPlwQWoPzYkIha0AwVSMZFLSqS9GkRswjgX1biG8BCYsmI=
=ImKV
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
