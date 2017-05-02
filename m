Received: from eggs.gnu.org ([2001:4830:134:3::10]:36355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d5Zgu-0006Rj-H5
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d5Zgr-0003EN-6y
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:26:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d5Zgq-0003Ch-VU
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:26:13 -0400
Date: Tue, 2 May 2017 18:26:00 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170502182248-mutt-send-email-mst@kernel.org>
References: <52559520-f311-71de-a849-cac83d0c0e81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52559520-f311-71de-a849-cac83d0c0e81@redhat.com>
Subject: Re: [Qemu-devel] userspace emulated smmu/vfio integration: how to
 trap updates to the table structures?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Will Deacon <Will.Deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org

On Tue, May 02, 2017 at 09:30:39AM +0200, Auger Eric wrote:
> 
> I have been working on the integration between user-space emulated
> SMMU-v3 and VFIO in QEMU. At the moment I fail identifying a proper easy
> way to trap page table updates. This is requested to keep the host
> translation structures consistent to guest translation structures.
> 
> On Intel VTD there is a so-called "caching mode" (CM, see VTD spec
> paragraph 6.1) that forces the OS to explicitly invalidate caches
> whenever it updates any remapping structure (updates to not-present or
> present entries). Those invalidation commands are used to trap and
> update host structures. This mode was devised for virtualization. I was
> not able to find such "caching mode" on ARM SMMU. Is there any?
> 
> If not, do you have any other suggestion, I mean, besides the
> virtio-based solution.

Nothing really prevents us from emulating e.g. an ARM system with
intel's or AMD's IOMMU.  Linux normally isn't building these for
ARM but it's mostly just tweaking the config.

Non-linux guest support might be harder though.

-- 
MST
