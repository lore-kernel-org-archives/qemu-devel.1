Received: from eggs.gnu.org ([2001:4830:134:3::10]:59653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjSfE-0000go-MO
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjSf9-0006Wn-NM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:29:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cjSf9-0006WT-HH
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 10:29:03 -0500
Date: Thu, 2 Mar 2017 17:29:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170302172602-mutt-send-email-mst@kernel.org>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
	<CAFEAcA9eo4f7pNR0vchTrKrASNcRvgizDEnj7OcirkvKqe_kdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9eo4f7pNR0vchTrKrASNcRvgizDEnj7OcirkvKqe_kdQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/15] virtio, pc: fixes, features
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

On Thu, Mar 02, 2017 at 08:34:42AM +0000, Peter Maydell wrote:
> On 2 March 2017 at 06:20, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit 1e0addb682c3c552fd97480037d4f8ff18e2b87e:
> >
> >   Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170228-tag' into staging (2017-03-01 20:33:47 +0000)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 077dd74239a99f6c1e77c5c1aa24cfc7f58cd20c:
> >
> >   hw/pxb-pcie: fix PCI Express hotplug support (2017-03-02 07:31:26 +0200)
> >
> > ----------------------------------------------------------------
> > virtio, pc: fixes, features
> >
> > virtio support for region caches broke a bunch of stuff - fixing most of
> > it though it's not ideal.  Still pondering the right way to fix it.
> > New: VM gen ID and hotplug for PXB.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> This is now well past the softfreeze deadline; do you have
> a justification for putting new features in during freeze?
> 
> thanks
> -- PMM

pxb hotplug support is more a bugfix than a feature - we just forgot to
include the acpi bits, and the patches are very small.  vm gen id has
been in my tree for a long time and bios bits have been merged. If we
keep it out of this release there's more of a chance they will bitrot
which would be a mess.

-- 
MST
