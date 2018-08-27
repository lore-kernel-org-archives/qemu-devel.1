Received: from eggs.gnu.org ([2001:4830:134:3::10]:33238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuDZT-0001oa-Ke
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuDP6-00005C-7o
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:01:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fuDP6-000055-2u
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:01:44 -0400
Date: Mon, 27 Aug 2018 17:01:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180827090132.GG3020@xz-x1>
References: <48ae78d8-58ec-8813-8680-6f407ea46041@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48ae78d8-58ec-8813-8680-6f407ea46041@siemens.com>
Subject: Re: [Qemu-devel] [PATCH] kvm: x86: Fix kvm_arch_fixup_msi_route for
 remap-less case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christopher Goldsworthy <christopher.goldsworthy@outlook.com>

On Mon, Aug 27, 2018 at 10:47:51AM +0200, Jan Kiszka wrote:
> The AMD IOMMU does not (yet) support interrupt remapping. But
> kvm_arch_fixup_msi_route assumes that all implementations do and crashes
> when the AMD IOMMU is used in KVM mode.
> 
> Fixes: 8b5ed7dffa1f ("intel_iommu: add support for split irqchip")
> Reported-by: Christopher Goldsworthy <christopher.goldsworthy@outlook.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu
