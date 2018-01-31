Received: from eggs.gnu.org ([2001:4830:134:3::10]:59989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1egys5-00064L-Ck
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1egys0-0005X7-Ei
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:20:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1egys0-0005We-8C
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:20:36 -0500
Date: Wed, 31 Jan 2018 13:20:30 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180131132030.4bd5344f@w520.home>
In-Reply-To: <20180131121217.13557-1-kraxel@redhat.com>
References: <20180131121217.13557-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RfC PATCH v2 0/5] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

On Wed, 31 Jan 2018 13:12:12 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> This series adds support for a vgpu display to the qemu vfio code.
> For now only regions are supported, dmabufs will follow later.
> 
> The vfio API update is done, queued in drm-next, should land in the
> upstream kernel during the 4.16 merge window.  So the 4.16-rc1 kernel
> header sync should bring the header changes needed for this series.
> 
> Patch #1 of this series has the vfio.h updates too, for testing
> convinience, but I don't plan to include that patch in the final
> patch submission.
> 
> plese test and review,

Hi Gerd,

The vfio bits look reasonable to me, it'd be nice if we could operate
on the VFIODevice rather than VFIOPCIDevice to make this universal for
all vfio devices, but that's just a nit since non-PCI graphics devices
may never come to fruition.  As for testing, region support was
included for NVIDIA, dmabuf for Intel... is this testing request mainly
for the Kirti and others at NVIDIA?  Thanks,

Alex
