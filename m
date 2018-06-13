Received: from eggs.gnu.org ([2001:4830:134:3::10]:33428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5zI-0008UH-PJ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5zE-0005xL-GU
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:39:00 -0400
Date: Wed, 13 Jun 2018 14:38:47 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613133847.GL24528@stefanha-x1.localdomain>
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
	<1528866321-23886-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L/Qt9NZ8t00Dhfad"
Content-Disposition: inline
In-Reply-To: <1528866321-23886-2-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] Replace '-machine accel=xyz' with
 '-accel xyz'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, zhang.zhanghailiang@huawei.com, Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org


--L/Qt9NZ8t00Dhfad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 07:05:18AM +0200, Thomas Huth wrote:
> We've got a separate option to configure the accelerator nowadays.
> Use it in the source and examples to demonstrate that this is the
> preferred way of setting this option now.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi                       | 3 +--
>  qemu-options.hx                     | 2 +-
>  scripts/qtest.py                    | 2 +-
>  tests/bios-tables-test.c            | 2 +-
>  tests/boot-serial-test.c            | 2 +-
>  tests/libqtest.c                    | 2 +-
>  tests/migration-test.c              | 8 ++++----
>  tests/migration/guestperf/engine.py | 2 +-
>  tests/pnv-xscom-test.c              | 2 +-
>  tests/prom-env-test.c               | 2 +-
>  tests/pxe-test.c                    | 2 +-
>  tests/qemu-iotests/172              | 2 +-
>  tests/qemu-iotests/check            | 2 +-
>  tests/vmgenid-test.c                | 2 +-
>  14 files changed, 17 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--L/Qt9NZ8t00Dhfad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbIR5nAAoJEJykq7OBq3PInR0H/iJIPy0ic80YAqyRpW9uzgor
LebJlACCgr8DRirs74++bgOQjPdGjpCDtFcyNePeHgK6owcnzf+vkgXLBOfGYoV+
02NMC1vkF7yk4NSgEpCH0QPzpJFIyS/F43Us7KBD6xG/Abkni+R6cP+lFNvPtQQA
qy92icuRmRKwCeJNh+71IcOmLkY0dYfJDWVemlEIN8FGrIZgz9gXbiFWaIc8YCfg
pCG12B5XKdzGQ0TmtngEf2bp4v2rfvmGAHsidbYJPBdiv+BXmtzcbOART62y/rgb
1uvCGG1WgXLCqydcfAI4E5Gzj/YEpnFGJFmo4Qe0qpLQOQT6XJePvyYbkk0qA/k=
=uWkU
-----END PGP SIGNATURE-----

--L/Qt9NZ8t00Dhfad--
