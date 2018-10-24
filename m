Received: from eggs.gnu.org ([2001:4830:134:3::10]:60311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFQAR-00025V-TK
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 16:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFQAN-0003XB-Pw
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 16:54:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gFQAN-0003Wh-JF
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 16:54:11 -0400
Date: Wed, 24 Oct 2018 16:54:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181024165328-mutt-send-email-mst@kernel.org>
References: <20181023234112.188140-1-mst@redhat.com>
	<CAFEAcA_SPT=Ypyep9QgdyjKyFCFTjnH_ZG+99H008HCpnhbFqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_SPT=Ypyep9QgdyjKyFCFTjnH_ZG+99H008HCpnhbFqg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/28] pci, pc, virtio: fixes, features
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

On Wed, Oct 24, 2018 at 07:21:17AM +0100, Peter Maydell wrote:
> On 24 October 2018 at 00:41, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966ba3:
> >
> >   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22' into staging (2018-10-23 17:20:23 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 57b279df457c2c4ef66ce9e1b813df35abde69f7:
> >
> >   vhost-scsi: prevent using uninitialized vqs (2018-10-23 19:29:58 -0400)
> >
> > ----------------------------------------------------------------
> > pci, pc, virtio: fixes, features
> >
> > AMD IOMMU VAPIC support + fixes all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> 
> >  dtc                                  |   2 +-
> 
> Hi. This pull request seems to include an accidental update
> to the dtc submodule. It's in the "intel_iommu: move ce fetching out
> when sync shadow" commit, and it's not mentioned in the commit
> message, so I am assuming it is unintentional.
> 
> Could you fix that and resubmit, please?
> 
> thanks
> -- PMM

Oh not again. At least now you have scripts that catch it,
I should write a script for that too. Thanks and sorry.

-- 
MST
