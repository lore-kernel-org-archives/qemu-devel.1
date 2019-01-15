Received: from eggs.gnu.org ([209.51.188.92]:47153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjHQT-0004Gg-3R
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 00:38:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gjHQS-0004dP-B3
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 00:38:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gjHQS-0004b8-5A
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 00:38:12 -0500
Date: Tue, 15 Jan 2019 13:38:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190115053802.GH24343@xz-x1>
References: <20190115003812.11329-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115003812.11329-1-mst@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/44] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Mon, Jan 14, 2019 at 08:35:11PM -0500, Michael S. Tsirkin wrote:
> The following changes since commit 89bd861c2b470e3fb45596945509079c72af3ac2:
> 
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2019-01-14 17:35:00 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to b421506a3ac2f1b2a4f18d6f423a92dfa16e2645:
> 
>   acpi: update expected files (2019-01-14 19:31:05 -0500)
> 
> ----------------------------------------------------------------
> pci, pc, virtio: fixes, features
> 
> tpm physical presence interface
> rsc support in virtio net
> ivshmem is removed
> misc cleanups and fixes all over the place

Hi, Michael,

Do you want to review/queue some VT-d patches that I posted recently?

[PATCH 0/5] intel_iommu: misc fixes for error exposed after error_report_once()
(https://patchwork.kernel.org/cover/10751913/, patch 5 dropped though)

They fix some bugs that were recently exposed.  Currently only the
first two patches got acked-by from Jason.

They don't worth to block the pull but IMHO they fix real problems so
just to make sure they won't fall through the cracks.

Thanks!

-- 
Peter Xu
