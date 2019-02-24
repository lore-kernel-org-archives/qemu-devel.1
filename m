Received: from eggs.gnu.org ([209.51.188.92]:58871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gxhkH-0004Rh-GF
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 19:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gxhkG-0000L8-PV
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 19:34:17 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gxhkG-0000Ks-LC
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 19:34:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id z13so3356578qki.2
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 16:34:16 -0800 (PST)
Date: Sat, 23 Feb 2019 19:34:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190223193335-mutt-send-email-mst@kernel.org>
References: <20190221173326.31874-1-mst@redhat.com>
	<CAFEAcA_Nmo1bpWr5rUmXotB_J9J78wvqB9TU174WWyqt+CEZZw@mail.gmail.com>
	<20190222105159-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222105159-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PULL 00/26] pci, pc, virtio: fixes, cleanups,
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, david@gibson.dropbear.id.au

On Fri, Feb 22, 2019 at 10:53:54AM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 22, 2019 at 03:47:36PM +0000, Peter Maydell wrote:
> > On Fri, 22 Feb 2019 at 02:40, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:
> > >
> > >   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > >
> > > for you to fetch changes up to 1f8c04f18d2ee2f6ec88217dfd547ab38d2be5c5:
> > >
> > >   pci: Sanity test minimum downstream LNKSTA (2019-02-21 12:28:41 -0500)
> > >
> > > ----------------------------------------------------------------
> > > pci, pc, virtio: fixes, cleanups, tests
> > >
> > > Lots of work on tests: BiosTablesTest UEFI app,
> > > vhost-user testing for non-Linux hosts.
> > > Misc cleanups and fixes all over the place
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> > > ----------------------------------------------------------------
> > 
> > Compile failure on clang:
> > 
> > /home/petmay01/linaro/qemu-for-merges/hw/virtio/virtio-balloon.c:40:3:
> > error: redefinition of typedef 'PartiallyBalloonedPage' is a C11
> > feature [-Werror,-Wtypedef-redefinition]
> > } PartiallyBalloonedPage;
> >   ^
> > /home/petmay01/linaro/qemu-for-merges/include/hw/virtio/virtio-balloon.h:33:39:
> > note: previous definition is here
> > typedef struct PartiallyBalloonedPage PartiallyBalloonedPage;
> >                                       ^
> > 1 error generated.
> > /home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
> > 'hw/virtio/virtio-balloon.o' failed
> > 
> > thanks
> > -- PMM
> 
> Fixed up and re-pushed.

Peter, can you merge for_upstream now pls? Don't want to spam
the list with a trivial change like that ...

> David, pls note above and don't add duplicate typedefs in the future.
> There's always include/qemu/typedefs.h if you don't know where
> to put a typedef.
> 
> -- 
> MST
