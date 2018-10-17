Received: from eggs.gnu.org ([2001:4830:134:3::10]:35926)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+09575c8a9ff34f5a189b+5533+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1gChmv-0008SX-3R
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+09575c8a9ff34f5a189b+5533+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1gChmu-0007Ed-Be
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:06:45 -0400
Received: from bombadil.infradead.org ([2607:7c80:54:e::133]:46962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<BATV+09575c8a9ff34f5a189b+5533+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1gChmt-0006ji-Vq
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:06:44 -0400
Date: Wed, 17 Oct 2018 02:06:21 -0700
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20181017090621.GB19942@infradead.org>
References: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
	<1539713558-2453-2-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539713558-2453-2-git-send-email-kwankhede@nvidia.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 1/4] VFIO KABI for migration
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: alex.williamson@redhat.com, cjia@nvidia.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Tue, Oct 16, 2018 at 11:42:35PM +0530, Kirti Wankhede wrote:
> - Added vfio_device_migration_info structure to use interact with vendor
>   driver.

There is no such thing as a 'vendor driver' in Linux - all drivers ate
treated equal.  And I don't see any single driver supporting this yet,
so you really should submit your noveau or whatever patches first.
