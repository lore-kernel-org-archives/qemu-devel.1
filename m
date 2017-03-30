Received: from eggs.gnu.org ([2001:4830:134:3::10]:45463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cthpx-0005Ht-Fr
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 17:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cthpw-0002ja-C5
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 17:42:33 -0400
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <07160c3a-a9e5-ad4c-a600-5edbb5afa738@redhat.com>
Date: Thu, 30 Mar 2017 23:42:21 +0200
MIME-Version: 1.0
In-Reply-To: <1490895797-29094-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2D2ssDu2n63rQmrukSW9tIaIcWe49HegU"
Subject: Re: [Qemu-devel] [PATCH v3 for-2.9 0/9] Fixes and cleanups around
 SocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2D2ssDu2n63rQmrukSW9tIaIcWe49HegU
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com
Message-ID: <07160c3a-a9e5-ad4c-a600-5edbb5afa738@redhat.com>
Subject: Re: [PATCH v3 for-2.9 0/9] Fixes and cleanups around SocketAddress
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1490895797-29094-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.03.2017 19:43, Markus Armbruster wrote:
> What makes this 2.9 material is the crash bug fixed in PATCH 2 and the
> QAPI/QMP interface cleanups in PATCH 7+8.
>=20
> v3:
> * PATCH 1-3,5 unchanged
> * PATCH 4 comments reworded [Max, Eric]
> * PATCH 6 comment tweak [Eric]
> * PATCH 7 comment typo, don't rely on enum equivalence [Eric]
> * PATCH 8 is PATCH v2 08+09 squashed together
> * PATCH 9 sd_parse_filename() fixed to again supply defaults for
>   omitted host and port, whitespace tidied up [Max]
> v2:
> * PATCH 01+02+04+05 unchanged
> * PATCH 03 error message improved, blank line [Max]
> * PATCH 06 commit message typo [Max]
> * PATCH 07 new, factored out of old PATCH 7
> * PATCH 08-10 updated, please re-review
>=20
> Markus Armbruster (9):
>   nbd sockets vnc: Mark problematic address family tests TODO
>   char: Fix socket with "type": "vsock" address
>   io vnc sockets: Clean up SocketAddressKind switches
>   block: Document -drive problematic code and bugs
>   gluster: Prepare for SocketAddressFlat extension
>   qapi-schema: SocketAddressFlat variants 'vsock' and 'fd'
>   sockets: New helper socket_address_crumple()
>   nbd: Tidy up blockdev-add interface
>   sheepdog: Fix blockdev-add
>=20
>  block.c                | 48 +++++++++++++++++++++++++--
>  block/file-posix.c     |  6 ++++
>  block/gluster.c        | 28 ++++++++++------
>  block/nbd.c            | 62 ++++++++++++++++++++--------------
>  block/nfs.c            |  7 ++++
>  block/rbd.c            |  6 ++++
>  block/sheepdog.c       | 90 ++++++++++++++++++++++++++++++++----------=
--------
>  block/ssh.c            |  8 +++++
>  blockdev-nbd.c         |  1 +
>  chardev/char-socket.c  |  9 +++--
>  include/qemu/sockets.h | 11 ++++++
>  io/dns-resolver.c      |  7 ++--
>  qapi-schema.json       | 19 +++++------
>  qapi/block-core.json   |  6 ++--
>  ui/vnc.c               | 19 +++++++----
>  util/qemu-sockets.c    | 40 ++++++++++++++++++++--
>  16 files changed, 269 insertions(+), 98 deletions(-)

Thanks, fixed the typos in patch 4 and in the commit message of patch 8
and applied the series to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--2D2ssDu2n63rQmrukSW9tIaIcWe49HegU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljde70SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AG+MH/1hVIsk0Pmg0rvHS4daE6aiyuScRF4G0
ObaQQmKiPUaqtIJo57KHskYnUZ23BYdD4jU0GnPHCrKQc7Jl/9qhT03gT6LA9vpF
m5OjEkVg2hXZI8cAIg7trirhny91qN3zmSe3fHJHTQzgq59xuZQLOAXx6kTAhUa5
5CgXFEzmTiq5xQ/oREuiCHOIuSOeqQb/Kcwn9czK5lQuSc/oeKiIWxy3BNDCoaTk
tcXC77rbEkB1xo68fH3IVExovKmp2YSc/C4jBN22rAnjzMh+rtCdVRiJgNgUsWqT
kx4v4RapRQt22gCn25RrRaVBlgFSjKAeYlYxktVnW2pR+tMBRYAWT18=
=11F4
-----END PGP SIGNATURE-----

--2D2ssDu2n63rQmrukSW9tIaIcWe49HegU--
