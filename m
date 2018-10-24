Received: from eggs.gnu.org ([2001:4830:134:3::10]:42699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFQpc-0006AP-3v
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFQpX-0005rD-84
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gFQpX-0005qB-1k
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:36:43 -0400
Date: Wed, 24 Oct 2018 17:36:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181024173626-mutt-send-email-mst@kernel.org>
References: <20181023234112.188140-1-mst@redhat.com>
	<CAFEAcA_SPT=Ypyep9QgdyjKyFCFTjnH_ZG+99H008HCpnhbFqg@mail.gmail.com>
	<20181024165328-mutt-send-email-mst@kernel.org>
	<CAFEAcA-xg5izn=YK86cXZJ2J-7sWfV0bqp1UspiQ1EFZsHPU5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-xg5izn=YK86cXZJ2J-7sWfV0bqp1UspiQ1EFZsHPU5g@mail.gmail.com>
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

On Wed, Oct 24, 2018 at 10:06:41PM +0100, Peter Maydell wrote:
> On 24 October 2018 at 21:54, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Wed, Oct 24, 2018 at 07:21:17AM +0100, Peter Maydell wrote:
> >> Hi. This pull request seems to include an accidental update
> >> to the dtc submodule. It's in the "intel_iommu: move ce fetching out
> >> when sync shadow" commit, and it's not mentioned in the commit
> >> message, so I am assuming it is unintentional.
> 
> > Oh not again. At least now you have scripts that catch it,
> > I should write a script for that too. Thanks and sorry.
> 
> The relevant part of my scripts is this bit:
> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/apply-pullreq?id=eeb001fcc1aabd8f077cd2846724120a3aa8f962#n107
> 
> Specifically,
> 
> if git diff master..staging | grep -q 'Subproject commit'; then
>     # there's a submodule update in this set of commits
> fi
> 
> thanks
> -- PMM

Thanks added to my pull request script.

-- 
MST
