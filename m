Received: from eggs.gnu.org ([209.51.188.92]:46271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghzIz-0002gT-T2
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghzIy-0003uT-Aj
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:05:09 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:41339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghzIx-0003rp-Tl
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:05:08 -0500
Received: by mail-ot1-x32f.google.com with SMTP id u16so13518651otk.8
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 08:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20190110134917.16425-1-anthony.perard@citrix.com>
	<CAFEAcA-RQkXCvijrDkQY=QADq4O6c60ab1d-9oeq+vdObtQiUw@mail.gmail.com>
	<20190111155531.GM1508@perard.uk.xensource.com>
In-Reply-To: <20190111155531.GM1508@perard.uk.xensource.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jan 2019 16:04:52 +0000
Message-ID: <CAFEAcA9e6J7LqjQSJNFL-_68UaSqkkvYEo9FajWT0-CTpPQL3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] xen queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

On Fri, 11 Jan 2019 at 15:55, Anthony PERARD <anthony.perard@citrix.com> wr=
ote:
>
> On Fri, Jan 11, 2019 at 01:35:29PM +0000, Peter Maydell wrote:
> > On Thu, 10 Jan 2019 at 13:52, Anthony PERARD <anthony.perard@citrix.com=
> wrote:
> > >
> > > The following changes since commit 8ae951fbc1068308313b2c57a4fc3c6845=
1641f4:
> > >
> > >   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-2019=
0109' into staging (2019-01-09 16:08:31 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pu=
ll-xen-20190110
> > >
> > > for you to fetch changes up to 24edb91f5009fa941e1294aaf4bb2103d9ad07=
7e:
> > >
> > >   xen-block: avoid repeated memory allocation (2019-01-10 11:25:17 +0=
000)
> > >
> > > ----------------------------------------------------------------
> > > xen queue
> > >
> > > * Xen PV backend 'qdevification'.
> > >   Starting with xen_disk.
> > > * Performance improvements for xen-block.
> > > * Remove of the Xen PV domain builder.
> > > * bug fixes.
> > >
> > > ----------------------------------------------------------------
> >
> > Hi. This fails to compile for me (x86-64 Linux host):
> >
> >   CC      hw/block/xen-block.o
> > In file included from
> > /home/petmay01/linaro/qemu-for-merges/include/hw/xen/xen-block.h:11:0,
> >                  from
> > /home/petmay01/linaro/qemu-for-merges/hw/block/xen-block.c:22:
> > /home/petmay01/linaro/qemu-for-merges/include/hw/xen/xen-bus.h:32:5:
> > error: unknown type name =E2=80=98xenevtchn_port_or_error_t=E2=80=99
> >      xenevtchn_port_or_error_t local_port;
> >      ^
> > /home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
> > 'hw/block/xen-block.o' failed
> >
> > Probably the code is accidentally assuming a newer version
> > of the Xen headers than this system has installed? This
> > is Ubuntu 16.04.5 with libxen-dev  4.6.5-0ubuntu1.4.
>
> Sorry, I did stop build testing againt 4.6 as it went out of security
> support. Let me fix this and I'll resend a pull requests.

No problem. For fixing this pullreq a simple fix may be best,
but we should also consider dropping Xen 4.6 support from QEMU
if it's no longer within security support. We'd want to
make configure not enable Xen if the detected xenlibs are
too old (with the usual semantics for our configure of
silently just not building the Xen code by default but
failing with an error if the user explicitly asked for
Xen support to be enabled).

thanks
-- PMM
