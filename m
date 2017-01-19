Received: from eggs.gnu.org ([2001:4830:134:3::10]:45339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cUGdL-0001gO-Mq
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cUGdK-0004zQ-Oy
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:36:23 -0500
Date: Thu, 19 Jan 2017 17:36:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170119173611.GE27032@stefanha-x1.localdomain>
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Content-Disposition: inline
In-Reply-To: <20170118161653.19296-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qdict: Add convenience helpers for
 wrapped puts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Chrysostomos Nanakos <chris@include.gr>, Jeff Cody <jcody@redhat.com>, Stefan Weil <sw@weilnetz.de>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, Fam Zheng <famz@redhat.com>, Alberto Garcia <berto@igalia.com>, "Richard W.M. Jones" <rjones@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:X86" <xen-devel@lists.xensource.com>


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 10:16:49AM -0600, Eric Blake wrote:
> Quite a few users of qdict_put() were manually wrapping a
> non-QObject. We can make such call-sites shorter, by providing
> common macros to do the tedious work.  Also shorten nearby
> qdict_put_obj(,,QOBJECT()) sequences.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> ---
>=20
> v2: rebase to current master
>=20
> I'm okay if you want me to break this patch into smaller pieces.
> ---
>  include/qapi/qmp/qdict.h            |   8 +++
>  block.c                             |  59 +++++++---------
>  block/archipelago.c                 |   4 +-
>  block/blkdebug.c                    |   6 +-
>  block/blkverify.c                   |  11 ++-
>  block/curl.c                        |   2 +-
>  block/file-posix.c                  |   8 +--
>  block/file-win32.c                  |   4 +-
>  block/iscsi.c                       |   2 +-
>  block/nbd.c                         |  41 ++++++-----
>  block/nfs.c                         |  43 +++++-------
>  block/null.c                        |   2 +-
>  block/qcow2.c                       |   4 +-
>  block/quorum.c                      |  13 ++--
>  block/ssh.c                         |  16 ++---
>  block/vvfat.c                       |  10 +--
>  blockdev.c                          |  28 ++++----
>  hw/block/xen_disk.c                 |   2 +-
>  hw/usb/xen-usb.c                    |  12 ++--
>  monitor.c                           |  18 ++---
>  qapi/qmp-event.c                    |   2 +-
>  qemu-img.c                          |   6 +-
>  qemu-io.c                           |   2 +-
>  qemu-nbd.c                          |   2 +-
>  qobject/qdict.c                     |   2 +-
>  target/s390x/cpu_models.c           |   4 +-
>  tests/check-qdict.c                 | 132 ++++++++++++++++++------------=
------
>  tests/test-qmp-commands.c           |  30 ++++----
>  tests/test-qmp-event.c              |  30 ++++----
>  tests/test-qobject-output-visitor.c |   6 +-
>  util/qemu-option.c                  |   6 +-
>  31 files changed, 245 insertions(+), 270 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYgPkLAAoJEJykq7OBq3PIopUH/06JeNnJ+ZDPdbVfN2ZbnNXo
jdLk78F0MDGKN9vTcw5ofH7kRc9OhRDsj9hwCQKQm5bE5T5EgTobnEYZ0Hsmi/1A
moiA5gesHSNvTqAhPM9O93dT3UcHMh/ekxgJTcJX4Z4/GOr3UkRUzvythmNJRJ+e
dNH5FuHGX8nrXcCPzmNkq8wxiobu+SpXdz5OpEJW978ppPMxtIZqD9wEvL5VPVvN
/CmcLTEy2Hx7nXHwPCipGyd/0Q02CzRNT8wKfGoQGHh6BYQ+YitWulPDdwAbiVRu
ZtbPeiL0ndLGTzWX4gTpi0URGGtUte1AXhELJ7PjG3sXoTfUSAnzH11/9dTK2yk=
=eHgc
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
