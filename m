Received: from eggs.gnu.org ([2001:4830:134:3::10]:53359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2v8X-0004Bi-0a
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2v8S-0004q9-DZ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:16:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2v8S-0004pZ-5k
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:16:00 -0400
Message-ID: <1507882558.21465.4.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 13 Oct 2017 10:15:58 +0200
In-Reply-To: <CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
References: <20171011083604.11820-1-kraxel@redhat.com>
	<CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20171011 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 2017-10-11 at 15:37 +0100, Peter Maydell wrote:
> On 11 October 2017 at 09:35, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > The following changes since commit
> > 567d0a19c7998fa366598b83d5a6e5f0759d3ea9:
> >=20
> > =C2=A0 Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-
> > machine-pull-request' into staging (2017-10-10 13:25:46 +0100)
> >=20
> > are available in the git repository at:
> >=20
> > =C2=A0 git://git.kraxel.org/qemu tags/ui-20171011-pull-request
> >=20
> > for you to fetch changes up to
> > 92328b7104ffc825f10c33f3fd1866e940a523f7:
> >=20
> > =C2=A0 ui/gtk: Fix deprecation of vte_terminal_copy_clipboard (2017-1=
0-
> > 11 10:03:31 +0200)
> >=20
> > ----------------------------------------------------------------
> > ui: use keycodemapdb for key code mappings, part one (v2)
> > ui: add qemu-keymap, update reverse keymaps (for qemu -k $map)
> > ui: fix for vte 0.50
> >=20
> > ----------------------------------------------------------------
>=20
> Build failures:
>=20
> NetBSD:
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap.o
> /root/qemu/ui/input-keymap.c:8:44: fatal error:
> ui/input-keymap-linux-to-qcode.c: No such file or directory
> =C2=A0#include "ui/input-keymap-linux-to-qcode.c"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
>=20
> FreeBSD:
>=20
>=20
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap.o
> /root/qemu/ui/input-keymap.c:8:10: fatal error:
> 'ui/input-keymap-linux-to-qcode.c' file not found
> #include "ui/input-keymap-linux-to-qcode.c"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^
>=20
> OpenBSD:
>=20
> gmake: Entering directory '/home/qemu/build/all'
> /bin/sh: ./scripts/git-submodule.sh: No such file or directory
> gmake: Leaving directory '/home/qemu/build/all'
> gmake: Entering directory '/home/qemu/build/all'
> =C2=A0 GIT
> /bin/sh: ./scripts/git-submodule.sh: No such file or directory
> gmake: *** [Makefile:30: git-submodule-update] Error 1
> gmake: Leaving directory '/home/qemu/build/all'
> gmake: *** Waiting for unfinished jobs....
> gmake: Entering directory '/home/qemu/build/all'
> config-host.mak is out-of-date, running configure
> Install prefix=C2=A0=C2=A0=C2=A0=C2=A0/usr/local
> [configure output snipped]
> gmake: Leaving directory '/home/qemu/build/all'
>=20
> AArch32 Linux:
>=20
> make: Entering directory '/home/peter.maydell/qemu/build/all-a32'
> config-host.mak is out-of-date, running configure
> Install prefix=C2=A0=C2=A0=C2=A0=C2=A0/usr/local
> BIOS directory=C2=A0=C2=A0=C2=A0=C2=A0/usr/local/share/qemu
> [...]
> VxHS block device no
> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0config-host.h
> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0module_block.h
> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap-linux-to-qcode.=
c
> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap-qcode-to-qnum.c
> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ui/input-keymap-qnum-to-qcode.c
> =C2=A0 GIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ui/keycodemapdb dtc
> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace/generated-tcg-tracers.h
> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace/generated-helpers-wrapper=
s.h
> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace/generated-helpers.h
> =C2=A0 GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0trace/generated-helpers.c
> Makefile:30: recipe for target 'git-submodule-update' failed
> make: *** [git-submodule-update] Error 128
> make: *** Waiting for unfinished jobs....
> make: Leaving directory '/home/peter.maydell/qemu/build/all-a32'
>=20
>=20
> The OpenBSD failure is because make now tries to run a
> script that uses #!/bin/bash, and this machine doesn't
> have bash installed. Do we really need to add bash to
> our build-dependencies? The script doesn't seem like it's
> doing anything that critically requires bash...
>=20
> thanks
> -- PMM

New pull out, with bash dropped, repo switched to qemu mirror and one
additional gtk fix picked up from the list.

cheers,
  Gerd
