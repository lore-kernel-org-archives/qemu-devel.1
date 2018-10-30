Received: from eggs.gnu.org ([2001:4830:134:3::10]:59145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gHQpG-0006wp-2R
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 06:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gHQpA-0001dR-5s
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 06:00:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gHQp9-0001bi-H0
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 06:00:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so11081125wma.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 03:00:33 -0700 (PDT)
Date: Tue, 30 Oct 2018 11:00:28 +0100
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20181030110028.02aa2ab7@fiorina>
In-Reply-To: <154087006527.11226.7369141331047618040@sif>
References: <cover.1540293795.git.tgolembi@redhat.com>
	<154087006527.11226.7369141331047618040@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>

On Mon, 29 Oct 2018 22:27:45 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (2018-10-23 06:23:09)
> > Note that PCI controller reporting on Windows was and still is broken.
> > Unfortunately I don't know how to fix it at the momemnt. See commit mes=
sage and
> > code comment. If anyone has environment where the original code works l=
et me
> > know. CCing author of the code In case I missed something obvious.
> >=20
> > v5:
> >   - return -1 in PCI info
> >     I have cherry-picked three commits from Sameeh Jubran and Michael R=
oth:
> >     https://github.com/mdroth/qemu/commit/89f145d7e90d721dbc7c9d0082e56=
4bad7e88247
> >     https://github.com/mdroth/qemu/commit/d5f5f7e7dc265a9e62e5f4c2ee342=
ab7e56cca53
> >     https://github.com/mdroth/qemu/commit/201db36b56d7d1ba5ff720eedcb3b=
62b75306fde
> >   - remove =3D=3D TRUE from if-conditions
> >   - separate Linux and Windows changes so that the Linux part can be pu=
shed
> >     independently; the relevant commits are ordered first.
> >   - fixed several typos
> >=20
> > v4:
> >   - split changes into more patches
> >   - fixed UNC for physical drive to use device namespace
> >   - renamed g_debug_err() to debug_error()
> >   - fixed build without libudev
> >=20
> > v3:
> >   - fix typos
> >   - add configure test for libudev
> >   - change order of patches fixing PCI controller info and build fix to=
 avoid
> >     exposing broken code
> >   - split reporting of serial number and device node into two separate =
patches
> >=20
> > v2:
> >   - fix checkpatch error
> >=20
> > Michael Roth (1):
> >   *additonal fixup for NULL pci_controller field
> >=20
> > Sameeh Jubran (2):
> >   qga-win: prevent crash when executing fsinfo command
> >   qga-win: fsinfo: pci-info: allow partial info
> >=20
> > Tom=C3=A1=C5=A1 Golembiovsk=C3=BD (11):
> >   configure: add test for libudev
> >   qga: linux: report disk serial number
> >   qga: linux: return disk device in guest-get-fsinfo
> >   build: rename CONFIG_QGA_NTDDDISK to CONFIG_QGA_NTDDSCSI
> >   qga-win: add debugging information
> >   qga-win: refactor disk properties (bus)
> >   qga-win: report disk serial number
> >   qga-win: refactor disk info
> >   qga-win: handle multi-disk volumes
> >   qga-win: return disk device in guest-get-fsinfo
> >   qga-win: demystify namespace stripping =20
>=20
> Thanks, applied to qga tree with some small fix-ups:
>   https://github.com/mdroth/qemu/commits/qga

Thank you

>=20
> >=20
> >  configure            |  24 +++-
> >  dtc                  |   2 +-
> >  qga/Makefile.objs    |   1 +
> >  qga/commands-posix.c |  37 +++++-
> >  qga/commands-win32.c | 269 +++++++++++++++++++++++++++++++++++--------
> >  qga/qapi-schema.json |   5 +-
> >  6 files changed, 287 insertions(+), 51 deletions(-)
> >=20
> > --=20
> > 2.19.0
> >  =20


--=20
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
