Received: from eggs.gnu.org ([2001:4830:134:3::10]:32845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsouv-0001y1-LI
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsous-0005XC-JT
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:36:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dsous-0005WP-Dt
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 07:36:14 -0400
Date: Fri, 15 Sep 2017 19:36:11 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170915113611.GI17199@lemon>
References: <20170915090253.12201-1-famz@redhat.com>
	<CAFEAcA_b71j3v5Ag7uSTPBgUT2_Qej+KJxH57cKV+6QdRgCw9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA_b71j3v5Ag7uSTPBgUT2_Qej+KJxH57cKV+6QdRgCw9A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/38] Test and build patches
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

On Fri, 09/15 11:55, Peter Maydell wrote:
> On 15 September 2017 at 10:02, Fam Zheng <famz@redhat.com> wrote:
> > The following changes since commit 04ef33052c205170c92df21ca0b4be4f3b=
102188:
> >
> >   tcg/tci: do not use ldst label (never implemented) (2017-09-11 19:2=
4:05 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/famz/qemu.git tags/test-and-build-pull-request
> >
> > for you to fetch changes up to be78fe670401af14e6d63fce5c5467f7512078=
71:
> >
> >   buildsys: Move rdma libs to per object (2017-09-15 15:05:24 +0800)
> >
> > ----------------------------------------------------------------
> >
> > ----------------------------------------------------------------
> >
> > Alex Benn=E9e (4):
> >   docker: ensure NOUSER for travis images
> >   docker: docker.py make --no-cache skip checksum test
> >   docker: don't install device-tree-compiler build-deps in travis.doc=
ker
> >   docker: reduce noise when building travis.docker
> >
> > Fam Zheng (34):
> >   docker: Update ubuntu image
> >   docker: Enable features explicitly in test-full
> >   tests/docker: Clean up paths
> >   gitignore: Ignore vm test images
> >   qemu.py: Add "wait()" method
> >   scripts: Add archive-source.sh
> >   tests: Add a test key pair
>=20
> So, before I commit an ssh private key to our git repo,
> can you explain why it's ok that this is public? The
> commit message for the relevant patch doesn't really say.

It's under tests/, and the key is only used to access a temporarily spawn=
ed test
VM.

Fam
