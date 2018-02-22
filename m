Received: from eggs.gnu.org ([2001:4830:134:3::10]:38150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eonDZ-0006HH-B5
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eonDW-00038M-6b
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:31:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eonDW-00038B-1p
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:31:06 -0500
Date: Thu, 22 Feb 2018 10:30:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180222093055.u34o2pp6twcx645f@sirius.home.kraxel.org>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219151649.13a197f9@w520.home>
	<20180220102814.rtcvsrsdtdndcfez@sirius.home.kraxel.org>
	<20180220170417.p7hkqbong5euul7p@sirius.home.kraxel.org>
	<20180222064003.yzrcmh7hi6qvgcij@zhen-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222064003.yzrcmh7hi6qvgcij@zhen-hp.sh.intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/7] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, intel-gvt-dev@lists.freedesktop.org, qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>

  Hi,

> Nice! Seems to be the last missing gap for local spice with cursor
> dmabuf support, we'll do more testing on that for sure. Btw, another
> method might be to add direct cursor dmabuf passing for spice as gl
> output, is that correct way?

Passing on the cursor sprite needs the hotspot information, so spice
client can position the cursor correctly.  I didn't got hotspot
information in my testing yet, but maybe the guest kernel was too old.
Is that supported meanwhile?  If so, which kernel version is needed?

Spice already has support for setting pointers, we can simply use
that, at least initially.  Doesn't use dma-bufs.  If it turns out to be
a performance issue we can add support for using dma-bufs instead, but
that needs spice server changes.

> And really like to see dmabuf support could be in upstream soon. Do
> you have any predict for which qemu version?

I want have this in 2.12, at least the current, initial version.
Improved cursor support might take a little longer.

cheers,
  Gerd
