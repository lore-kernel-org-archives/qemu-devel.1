Received: from eggs.gnu.org ([2001:4830:134:3::10]:50897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fleb2-0002gf-9f
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fleaz-00019a-1S
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:14:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49138 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fleay-000188-Rp
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:14:36 -0400
Date: Fri, 3 Aug 2018 21:14:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180803211129-mutt-send-email-mst@kernel.org>
References: <20180803083830.775669-1-mst@redhat.com>
	<CAFEAcA9r4K9qgFFqvRKqTFMUowyAAEV=QZEnhk3eheQRodbnvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9r4K9qgFFqvRKqTFMUowyAAEV=QZEnhk3eheQRodbnvA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/5] pc, virtio: fixes
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

On Fri, Aug 03, 2018 at 11:45:36AM +0100, Peter Maydell wrote:
> On 3 August 2018 at 10:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Please consider for 3.0 if there is another rc.
> >
> > The following changes since commit f7502360397d291be04bc040e9f96c92ff2d8030:
> >
> >   Update version for v3.0.0-rc3 release (2018-07-31 19:30:17 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 1c707d6990eaf3db0c9dc4557bba5458977e9f8d:
> >
> >   tests/acpi: update tables after memory hotplug changes (2018-08-03 11:35:21 +0300)
> >
> > ----------------------------------------------------------------
> > pc, virtio: fixes
> >
> > A couple of last minute fixes.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Dou Liyang (2):
> >       hw/acpi-build: Add a check for memory-less NUMA nodes
> >       tests/acpi-test: update ACPI tables test blobs

This fixes a regression but from an older release.


> >
> > Igor Mammedov (1):
> >       pc: acpi: fix memory hotplug regression by reducing stub SRAT entry size

This fixes a regression from 2.12.

> > Michael S. Tsirkin (1):
> >       tests/acpi: update tables after memory hotplug changes

This will have to be re-done if we pick this but drop two other fixes.

> >
> > Tiwei Bie (1):
> >       vhost: check region type before casting

Not a regression but an obvious fix.

> 
> Can you clarify which of these are regressions from 2.12, please?
> At this point in the release cycle I only want to apply fixes
> for regressions. (Test only updates might also be OK, but I
> need more information than just the commit message subject line.)
> 
> thanks
> -- PMM

I'll push a variant with just the two patches fixing
regression from 2.12 soon.

-- 
MST
