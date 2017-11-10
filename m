Received: from eggs.gnu.org ([2001:4830:134:3::10]:50305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD6rl-0005iJ-2Z
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eD6rh-0003xU-Qc
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:48:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eD6rh-0003wg-Jr
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 05:48:49 -0500
Date: Fri, 10 Nov 2017 11:48:42 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171110104842.wuhe2n64bujv5aq5@sirius.home.kraxel.org>
References: <20171010140334.8231-1-kraxel@redhat.com>
	<20171010140334.8231-6-kraxel@redhat.com>
	<20171010142703.19e50e0d@t450s.home>
	<1507718840.31518.9.camel@redhat.com>
	<20171011105539.7a5346ae@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011105539.7a5346ae@t450s.home>
Subject: Re: [Qemu-devel] [RfC PATCH 5/6] vfio/display: adding region support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

  Hi,

> The overhead of a VFIORegion seems to be that we setup a MemoryRegion
> for r/w access to the vfio region and overlap that with one or more
> MemoryRegions for the mmap(s).  That's a bit of structural overhead,
> but we'd simply never map those into a guest visible address space.
> OTOH, it saves you from dealing with the region info, and potentially
> sparse mmap (you could call vfio_region_setup() and check nr_mmaps = 1,
> mmaps[0].offset/size, then call vfio_region_mmap() if it checks out,
> otherwise error).  Just seems like duplicate code here even if the
> VFIORegion includes some things we don't need.  Thanks,

Update pushed to https://www.kraxel.org/cgit/qemu/log/?h=work/vgpu-vfio

Addressed review comments from alex.  Updated vfio header to v17 patch
series.  Rebased to -rc0.  Incremental fixes not squashed (yet).

This series waits for:
  (1) vfio api update (linux kernel) landing upstream.
  (2) testing feedback from nvidia.
  (3) qemu 2.11 freeze being over.

If all goes well this should be able to land in the 2.12 devel cycle.

cheers,
  Gerd
