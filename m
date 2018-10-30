Received: from eggs.gnu.org ([2001:4830:134:3::10]:54915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHKhJ-0002Gl-4d
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHKhF-0006kK-4Q
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:28:05 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHKhE-0006jr-Ay
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:28:00 -0400
Received: by mail-qk1-x744.google.com with SMTP id o125so3147122qkf.3
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 20:27:59 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <cover.1540293795.git.tgolembi@redhat.com>
References: <cover.1540293795.git.tgolembi@redhat.com>
Message-ID: <154087006527.11226.7369141331047618040@sif>
Date: Mon, 29 Oct 2018 22:27:45 -0500
Subject: Re: [Qemu-devel] [PATCH v5 00/14] qga: report serial number and
 disk node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>

Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2018-10-23 06:23:09)
> Note that PCI controller reporting on Windows was and still is broken.
> Unfortunately I don't know how to fix it at the momemnt. See commit messa=
ge and
> code comment. If anyone has environment where the original code works let=
 me
> know. CCing author of the code In case I missed something obvious.
> =

> v5:
>   - return -1 in PCI info
>     I have cherry-picked three commits from Sameeh Jubran and Michael Rot=
h:
>     https://github.com/mdroth/qemu/commit/89f145d7e90d721dbc7c9d0082e564b=
ad7e88247
>     https://github.com/mdroth/qemu/commit/d5f5f7e7dc265a9e62e5f4c2ee342ab=
7e56cca53
>     https://github.com/mdroth/qemu/commit/201db36b56d7d1ba5ff720eedcb3b62=
b75306fde
>   - remove =3D=3D TRUE from if-conditions
>   - separate Linux and Windows changes so that the Linux part can be push=
ed
>     independently; the relevant commits are ordered first.
>   - fixed several typos
> =

> v4:
>   - split changes into more patches
>   - fixed UNC for physical drive to use device namespace
>   - renamed g_debug_err() to debug_error()
>   - fixed build without libudev
> =

> v3:
>   - fix typos
>   - add configure test for libudev
>   - change order of patches fixing PCI controller info and build fix to a=
void
>     exposing broken code
>   - split reporting of serial number and device node into two separate pa=
tches
> =

> v2:
>   - fix checkpatch error
> =

> Michael Roth (1):
>   *additonal fixup for NULL pci_controller field
> =

> Sameeh Jubran (2):
>   qga-win: prevent crash when executing fsinfo command
>   qga-win: fsinfo: pci-info: allow partial info
> =

> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (11):
>   configure: add test for libudev
>   qga: linux: report disk serial number
>   qga: linux: return disk device in guest-get-fsinfo
>   build: rename CONFIG_QGA_NTDDDISK to CONFIG_QGA_NTDDSCSI
>   qga-win: add debugging information
>   qga-win: refactor disk properties (bus)
>   qga-win: report disk serial number
>   qga-win: refactor disk info
>   qga-win: handle multi-disk volumes
>   qga-win: return disk device in guest-get-fsinfo
>   qga-win: demystify namespace stripping

Thanks, applied to qga tree with some small fix-ups:
  https://github.com/mdroth/qemu/commits/qga

> =

>  configure            |  24 +++-
>  dtc                  |   2 +-
>  qga/Makefile.objs    |   1 +
>  qga/commands-posix.c |  37 +++++-
>  qga/commands-win32.c | 269 +++++++++++++++++++++++++++++++++++--------
>  qga/qapi-schema.json |   5 +-
>  6 files changed, 287 insertions(+), 51 deletions(-)
> =

> -- =

> 2.19.0
>=20
