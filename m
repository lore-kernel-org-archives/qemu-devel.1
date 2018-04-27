Received: from eggs.gnu.org ([2001:4830:134:3::10]:53687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fC5Bo-00084v-Kl
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fC5Bk-0004hR-JU
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:21:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fC5Bk-0004h0-EL
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:21:32 -0400
Date: Fri, 27 Apr 2018 18:21:31 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180427182101-mutt-send-email-mst@kernel.org>
References: <1524799751-151698-1-git-send-email-mst@redhat.com>
	<CAFEAcA-FNy7cdKkUDctnf08Ska-piZo7QKwRD90G=zB5_QsS_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-FNy7cdKkUDctnf08Ska-piZo7QKwRD90G=zB5_QsS_A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/4] pc, pci, virtio: fixes, features
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

On Fri, Apr 27, 2018 at 10:49:06AM +0100, Peter Maydell wrote:
> On 27 April 2018 at 04:29, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit 4743c23509a51bd4ee85cc272287a41917d1be35:
> >
> >   Update version for v2.12.0 release (2018-04-24 16:44:55 +0100)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to fb6fd86f712c73a40fbe0c6be86d4635239b1304:
> >
> >   virtio-balloon: add hugetlb page allocation counts (2018-04-27 06:25:27 +0300)
> >
> > ----------------------------------------------------------------
> > pc, pci, virtio: fixes, features
> >
> > A bugfix that just missed 2.12, a new PCI,
> > and a new virtio balloon stat.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> > Peter Xu (1):
> >       intel-iommu: send PSI always when notify_unmap set
> 
> This patch is still missing:
>  * a clear description of when the bug applies and its severity

I'm still working on that. Do we want to defer merging until we have
that?

>  * a cc:stable marking

Will do.

> Please can you fix that and resend?
> 
> thanks
> -- PMM
