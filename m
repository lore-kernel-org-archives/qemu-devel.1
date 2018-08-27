Received: from eggs.gnu.org ([2001:4830:134:3::10]:56949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDHT-0005n6-Sy
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDHP-0004se-2X
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuDHO-0004rz-Tw
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:46 -0400
Date: Mon, 27 Aug 2018 10:53:42 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180827085342.q3vnnyssxag5qio5@sirius.home.kraxel.org>
References: <20180823095653.14556-1-kraxel@redhat.com>
	<CAFEAcA-QhN14Sbo8r9OO-8G_pV6+2mACih+ECFM+TOwgky+Htw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-QhN14Sbo8r9OO-8G_pV6+2mACih+ECFM+TOwgky+Htw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/12] Ui 20180823 v3 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>

On Fri, Aug 24, 2018 at 11:09:50PM +0100, Peter Maydell wrote:
> On 23 August 2018 at 10:56, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > The following changes since commit d0092d90eb546a8bbe9e9120426c189474123797:
> >
> >   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180820' into staging (2018-08-20 17:41:18 +0100)
> >
> > are available in the git repository at:
> >
> >   git://git.kraxel.org/qemu tags/ui-20180823-v3-pull-request
> >
> > for you to fetch changes up to 63cde1d13d0767f778a130e2c93c15ad709e1276:
> >
> >   util: promote qemu_egl_rendernode_open() to libqemuutil (2018-08-23 11:53:26 +0200)
> >
> > ----------------------------------------------------------------
> > ui: misc fixes which piled up during 3.0 release freeze
> >
> > ----------------------------------------------------------------
> 
> Hi; this failed to build on openbsd (the VM setup in tests/vm).
> Linking of all the qemu-system-foo binaries failed with:
> 
> ../ui/egl-helpers.o: In function `egl_rendernode_init':
> ui/egl-helpers.c:153: undefined reference to `qemu_drm_rendernode_open'

Fixed, v4 sent.

> 
> 
> thanks
> -- PMM
