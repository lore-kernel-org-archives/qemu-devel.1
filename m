Received: from eggs.gnu.org ([2001:4830:134:3::10]:33598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5zg-0000Q6-7k
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fT5zc-00075k-3w
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 09:39:24 -0400
Date: Wed, 13 Jun 2018 14:39:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613133918.GO24528@stefanha-x1.localdomain>
References: <1528866321-23886-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="acOuGx3oQeOcSZJu"
Content-Disposition: inline
In-Reply-To: <1528866321-23886-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] Clean up accelerator options
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


--acOuGx3oQeOcSZJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 07:05:17AM +0200, Thomas Huth wrote:
> The current state of the accelerator options is quite messy: There are
> three ways of enabling an accelerator (-machine accel=3Dxyz, -accel xyz
> and -enable-xyz) and this can be very confusing for the users. This
> patch series now tries to standardize our documentation and examples
> on the preferred -accel option.

Nice, thank you for keeping things tidy.

Stefan

> Thomas Huth (4):
>   Replace '-machine accel=3Dxyz' with '-accel xyz'
>   Replace '-enable-kvm' with '-accel kvm' in docs and help texts
>   qemu-options: Improve the documentation of '-accel' and '-machine
>     accel=3D...'
>   qemu-options: Do not show -enable-kvm and -enable-hax in the docs
>     anymore
>=20
>  docs/COLO-FT.txt                    |  8 +++----
>  docs/can.txt                        |  4 ++--
>  docs/multi-thread-compression.txt   |  2 +-
>  docs/multiseat.txt                  |  2 +-
>  docs/specs/tpm.txt                  |  8 +++----
>  hw/block/dataplane/virtio-blk.c     |  4 ++--
>  hw/scsi/virtio-scsi-dataplane.c     |  4 ++--
>  qemu-doc.texi                       |  3 +--
>  qemu-options.hx                     | 44 ++++++++++++-------------------=
------
>  scripts/qtest.py                    |  2 +-
>  tests/bios-tables-test.c            |  2 +-
>  tests/boot-serial-test.c            |  2 +-
>  tests/libqtest.c                    |  2 +-
>  tests/migration-test.c              |  8 +++----
>  tests/migration/guestperf/engine.py |  2 +-
>  tests/pnv-xscom-test.c              |  2 +-
>  tests/prom-env-test.c               |  2 +-
>  tests/pxe-test.c                    |  2 +-
>  tests/qemu-iotests/172              |  2 +-
>  tests/qemu-iotests/check            |  2 +-
>  tests/vmgenid-test.c                |  2 +-
>  21 files changed, 46 insertions(+), 63 deletions(-)
>=20
> --=20
> 1.8.3.1
>=20

--acOuGx3oQeOcSZJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbIR6GAAoJEJykq7OBq3PIJOsH/iWqLso90sBguyhhVuCKZw2Z
4Urs0pql1Jpfoi5Paug8yBhPuSIuR79NP0vRFxIXfj7J5DjBFk5nVPXHB6mBWSlB
hYvhcU7ZyWtsAnXth7jSXnW0NI84unMdxbIUTHgXjkbufQ3e5F8Nae6edtNmQdnL
XWJUlWTYTtAs9P68UXJ4o643dYJuGqie1KlhSHquNk0GBeHem6mH7JkLvrxZjqWq
x4OtvBnDKaVTxjMsrDow1HA2e2PaL3T9cFok00M58W3fLgyqimTXfnKCJVRjrI91
7lZWkevICzcN+i1DI3Z1eI33c4VsIw6LJXw7/9oSdXlVkXO0MppWlzLrz3kDcFc=
=6n5L
-----END PGP SIGNATURE-----

--acOuGx3oQeOcSZJu--
