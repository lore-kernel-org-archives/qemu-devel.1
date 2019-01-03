Received: from eggs.gnu.org ([208.118.235.92]:39154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gf9jM-0001ts-EJ
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gf9jJ-0007T8-9o
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:36:40 -0500
Received: from mail-eopbgr750095.outbound.protection.outlook.com
	([40.107.75.95]:25845
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gf9jJ-0007ST-0v
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:36:37 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Thu, 3 Jan 2019 20:36:31 +0000
Message-ID: <CY4PR2201MB12545DB9FFF99B3138E2C09AC68D0@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <1545916380-12816-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<02d090d3-a486-7945-cc7d-43e24b281356@redhat.com>
In-Reply-To: <02d090d3-a486-7945-cc7d-43e24b281356@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] tests: Reorganize MIPS TCG directories
 and files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "noring@nocrew.org" <noring@nocrew.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Eric Blake <eblake@redhat.com>
> Sent: Thursday, January 3, 2019 9:06 PM
> To: Aleksandar Markovic; qemu-devel@nongnu.org
> Cc: noring@nocrew.org; Stefan Markovic; Aleksandar Rikalo; Aleksandar Mar=
kovic;
> alex.bennee@linaro.org; aurelien@aurel32.net
> Subject: Re: [Qemu-devel] [PATCH 0/2] tests: Reorganize MIPS TCG director=
ies and files
>=20
> On 12/27/18 7:12 AM, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Reorganize MIPS TCG directories and files. The file movement is done
> > using "git mv" command, so "git blame" will still display the original
> > information, regardles of the new names and locations of involved
> > files.
> >
> > Aleksandar Markovic (2):
> >   tests: tcg: mips: Move source files to new location
> >   tests: tcg: mips: Remove old directories after reorganization
> >
> >  tests/tcg/mips/mips32-dsp/Makefile                 | 136 ---------
>=20
> >  tests/tcg/mips/mipsr5900/multu.c                   |  68 -----
> >  .../mips/system/ase/dsp/test_64_dsp_r1_absq_s_ob.c |  63 +++++
>=20
> >  tests/tcg/mips/user/isa/r5900/test_r5900_multu.c   |  68 +++++
> >  976 files changed, 19288 insertions(+), 20087 deletions(-)
>=20
> You also need to turn on git rename detection before sending your v2, so
> that your mail will be MUCH smaller (showing only lines that changed
> between file renames, rather than a much larger patch of deleting the
> old file and creating a new file).  More patch submission hints,
> including the git config setup for rename detection, can be found at
> https://wiki.qemu.org/Contribute/SubmitAPatch
>

Great hint! OK, I'll try "git config diff.renames true" before creating v2.

Thanks,
Aleksandar

> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org=
