Received: from eggs.gnu.org ([2001:4830:134:3::10]:50361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d89Ji-0004HX-2K
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d89Jd-0002Vt-Jq
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:52:58 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:34767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d89Jd-0002Vo-E3
	for qemu-devel@nongnu.org; Tue, 09 May 2017 13:52:53 -0400
Received: by mail-qk0-x22a.google.com with SMTP id k74so7828686qke.1
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 10:52:53 -0700 (PDT)
Date: Tue, 9 May 2017 13:52:47 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170509175247.GB26793@stefanha-x1.localdomain>
References: <1494317205-2211-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <1494317205-2211-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PULL v3 00/28] QAPI patches for 2017-05-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 10:06:17AM +0200, Markus Armbruster wrote:
> [v3]: Rebase & resolve semantic conflicts, with help from Eric Blake
> [v2]: Fix trailing space, note tweaks to PATCH 12 properly in the
> commit message=20
>=20
> The following changes since commit dd1559bb267becbb838de41132ef60771d183e=
5d:
>=20
>   Merge remote-tracking branch 'elmarco/tags/chr-tests-pull-request' into=
 staging (2017-05-05 17:07:55 +0100)
>=20
> are available in the git repository at:
>=20
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2017-05-04-v3
>=20
> for you to fetch changes up to dcd3b25d656d346205dc0f2254723fccf0264e45:
>=20
>   qmp-shell: improve help (2017-05-09 09:14:41 +0200)
>=20
> ----------------------------------------------------------------
> QAPI patches for 2017-05-04
>=20
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (1):
>       tests/check-qdict: Fix missing brackets
>=20
> Eric Blake (10):
>       pci: Use struct instead of QDict to pass back parameters
>       pci: Reduce scope of error injection
>       coccinelle: Add script to remove useless QObject casts
>       qobject: Drop useless QObject casts
>       qobject: Add helper macros for common scalar insertions
>       qobject: Use simpler QDict/QList scalar insertion macros
>       block: Simplify bdrv_append_temp_snapshot() logic
>       QemuOpts: Simplify qemu_opts_to_qdict()
>       fdc-test: Avoid deprecated 'change' command
>       test-qga: Actually test 0xff sync bytes
>=20
> John Snow (1):
>       qmp-shell: add persistent command history
>=20
> Marc-Andr=E9 Lureau (5):
>       test-keyval: fix leaks
>       qmp-shell: add -N option to skip negotiate
>       qmp-shell: Cope with query-commands error
>       qmp-shell: don't show version greeting if unavailable
>       qmp-shell: improve help
>=20
> Markus Armbruster (11):
>       sockets: Prepare vsock_parse() for flattened SocketAddress
>       sockets: Prepare inet_parse() for flattened SocketAddress
>       qapi: New QAPI_CLONE_MEMBERS()
>       sockets: Rename SocketAddress to SocketAddressLegacy
>       sockets: Rename SocketAddressFlat to SocketAddress
>       sockets: Limit SocketAddressLegacy to external interfaces
>       sockets: Delete unused helper socket_address_crumple()
>       qmp: Improve QMP dispatch error messages
>       qobject-input-visitor: Document full_name_nth()
>       qapi: Document intended use of @name within alternate visits
>       qobject-input-visitor: Catch misuse of end_struct vs. end_list
>=20
>  MAINTAINERS                         |   1 +
>  block.c                             |  70 ++++++--------
>  block/blkdebug.c                    |   8 +-
>  block/blkverify.c                   |  11 +--
>  block/curl.c                        |   2 +-
>  block/file-posix.c                  |   8 +-
>  block/file-win32.c                  |   4 +-
>  block/gluster.c                     |  48 +++++-----
>  block/nbd.c                         |  77 ++++++++-------
>  block/nfs.c                         |  43 ++++-----
>  block/null.c                        |   2 +-
>  block/qcow2.c                       |   4 +-
>  block/quorum.c                      |  16 ++--
>  block/rbd.c                         |  16 ++--
>  block/sheepdog.c                    |  20 ++--
>  block/snapshot.c                    |   2 +-
>  block/ssh.c                         |  16 ++--
>  block/vvfat.c                       |  10 +-
>  block/vxhs.c                        |   6 +-
>  blockdev-nbd.c                      |  21 +++--
>  blockdev.c                          |  30 +++---
>  chardev/char-socket.c               |  36 +++----
>  chardev/char-udp.c                  |  20 ++--
>  hmp.c                               |   3 +-
>  hw/block/xen_disk.c                 |   2 +-
>  hw/pci/pcie_aer.c                   |  48 ++++++----
>  hw/usb/xen-usb.c                    |  12 +--
>  include/block/nbd.h                 |   3 +
>  include/hw/pci/pcie_aer.h           |   4 -
>  include/io/channel-socket.h         |   4 +-
>  include/qapi/clone-visitor.h        |  14 +++
>  include/qapi/qmp/qdict.h            |   8 ++
>  include/qapi/qmp/qlist.h            |   8 ++
>  include/qapi/visitor.h              |   6 +-
>  include/qemu/sockets.h              |  16 ++--
>  io/dns-resolver.c                   |  17 ++--
>  migration/rdma.c                    |   4 +-
>  migration/socket.c                  |  20 ++--
>  monitor.c                           |  23 +++--
>  qapi-schema.json                    |  35 +++----
>  qapi/block-core.json                |   6 +-
>  qapi/block.json                     |   2 +-
>  qapi/qapi-clone-visitor.c           |  13 +++
>  qapi/qmp-dispatch.c                 |  14 +--
>  qapi/qmp-event.c                    |   2 +-
>  qapi/qobject-input-visitor.c        |  32 ++++++-
>  qemu-img.c                          |   6 +-
>  qemu-io.c                           |   2 +-
>  qemu-nbd.c                          |  11 +--
>  qga/main.c                          |   4 +-
>  qobject/qdict.c                     |   2 +-
>  scripts/coccinelle/qobject.cocci    |  35 +++++++
>  scripts/qmp/qmp-shell               |  44 ++++++++-
>  target/s390x/cpu_models.c           |   4 +-
>  tests/check-qdict.c                 | 144 ++++++++++++++--------------
>  tests/check-qlist.c                 |   4 +-
>  tests/device-introspect-test.c      |   4 +-
>  tests/fdc-test.c                    |   8 +-
>  tests/libqtest.c                    |   8 ++
>  tests/test-char.c                   |   5 +-
>  tests/test-io-channel-socket.c      |  52 +++++------
>  tests/test-keyval.c                 |   4 +
>  tests/test-qemu-opts.c              |   4 +-
>  tests/test-qga.c                    |  41 ++++++--
>  tests/test-qmp-commands.c           |  30 +++---
>  tests/test-qmp-event.c              |  30 +++---
>  tests/test-qobject-output-visitor.c |   6 +-
>  ui/vnc-auth-sasl.c                  |   5 +-
>  ui/vnc.c                            |  68 +++++++-------
>  util/qemu-option.c                  |   6 +-
>  util/qemu-sockets.c                 | 181 +++++++++++++++++-------------=
------
>  71 files changed, 806 insertions(+), 669 deletions(-)
>  create mode 100644 scripts/coccinelle/qobject.cocci
>=20
> --=20
> 2.7.4
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEgHuAAoJEJykq7OBq3PIkpUH+waa4u1lQ/nssmidHHOlD99t
EAdhVVviaH8KW4kwjFAbC202qNSfq41ajz2/cDw0Tg6BLLZQK6VZIpDSehSpJzI6
oKd1N4Y/OcbtvFgNWjciPAAAt6/vz2C9D81Yn5fWyQfA5FAScpUTsOIg1rvQ/ihE
Da1B4CSOSJDZKnQhosOGjLC/5XIM/Rpk/rt624e5SnhITKPyKvRdWexwvPiCHreX
IqLTcFDxfbv9OYMu0gzwDoFz9ErbKf7c+Figb/5YW9XQEcVo0BdjAp/PenSUSzWB
iTFofUMxa5h+tMOLLlLA2Eiurt2EjH65ZSjuwzbjUoUMQl+pyy6Xc7IDOfrhMdo=
=wPOe
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
