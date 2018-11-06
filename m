Received: from eggs.gnu.org ([2001:4830:134:3::10]:49343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJzCg-0007C0-F2
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJzCb-0002fG-A9
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:07:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJzCb-0002et-58
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:07:21 -0500
Date: Tue, 6 Nov 2018 06:07:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181106060647-mutt-send-email-mst@kernel.org>
References: <20181105181353.39804-1-mst@redhat.com>
	<a4e0dd6a-a1d5-10a1-a9e0-d01ca8d88d84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e0dd6a-a1d5-10a1-a9e0-d01ca8d88d84@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/33] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>

On Tue, Nov 06, 2018 at 09:18:49AM +0100, Thomas Huth wrote:
> On 2018-11-05 19:14, Michael S. Tsirkin wrote:
> > The following changes since commit b2f7a038bb4c4fc5ce6b8486e8513dfd97665e2a:
> > 
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-softfloat-20181104' into staging (2018-11-05 10:32:49 +0000)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> > 
> > for you to fetch changes up to 6196df5c8e6688c1c3f06f73442820066335337c:
> > 
> >   vhost-scsi: prevent using uninitialized vqs (2018-11-05 12:59:35 -0500)
> > 
> > ----------------------------------------------------------------
> > pci, pc, virtio: fixes, features
> > 
> > AMD IOMMU VAPIC support + fixes all over the place.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ----------------------------------------------------------------
> > Gerd Hoffmann (1):
> >       pci-testdev: add optional memory bar
> > 
> > Laszlo Ersek (4):
> >       MAINTAINERS: list "tests/acpi-test-data" files in ACPI/SMBIOS section
> [...]
> >  tests/{acpi-test-data => data/acpi}/pc/APIC        | Bin
> >  tests/{acpi-test-data => data/acpi}/pc/APIC.cphp   | Bin
> >  .../{acpi-test-data => data/acpi}/pc/APIC.dimmpxm  | Bin
> >  tests/{acpi-test-data => data/acpi}/pc/DSDT        | Bin
> 
> So patch 1 moves tests/acpi-test-data/ to tests/data/acpi/ and patch 20
> adds an entry for tests/acpi-test-data/ ? Does not make much sense to me
> ... I think patch 20 needs to be adapted now.
> 
>  Thomas

Oh right, MAINTAINERS needs to be fixed. Can be done with a patch on top
though.

-- 
MST
