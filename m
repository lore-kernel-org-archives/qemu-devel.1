Received: from eggs.gnu.org ([2001:4830:134:3::10]:38496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1eslrT-0007M8-1K
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1eslrP-0006B0-Vh
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:52:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1eslrP-0006AY-Qq
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:52:43 -0500
Date: Mon, 5 Mar 2018 09:52:39 +0100
From: Erik Skultety <eskultet@redhat.com>
Message-ID: <20180305085239.GR2872@erzo-ntb>
References: <20180228123110.6507-1-kraxel@redhat.com>
	<20180228123110.6507-8-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228123110.6507-8-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 7/9] vfio/display: core & wireup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Tina Zhang <tina.zhang@intel.com>

> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> new file mode 100644
> index 0000000000..3e997f8a44
> --- /dev/null
> +++ b/hw/vfio/display.c
> @@ -0,0 +1,56 @@
> +/*
> + * display support for mdev based vgpu devices
> + *
> + * Copyright Red Hat, Inc. 2017

Just curious here since I don't really know close to nothing about the legal
stuff, but isn't vGPU NVIDIA's trademark - [1,2,3] (especially [1]) would
suggest so. Therefore, I'm just curious whether we can mention this as we
please, especially when this should also work for Intel, which uses a different
name for the technology. On the other hand, grepping through kernel modules,
there's a lot of vGPU misuse in Intel's context, so I guess everything's fine.
Again, I'm just curious since I have no clue about this stuff.

[1] https://www.geforce.com/en_GB/gfecnt/support/NVIDIA-Legal-Notices
[2] https://trademarks.justia.com/859/42/vgpu-85942337.html
[3] https://trademarks.justia.com/859/42/nvidia-grid-85942341.html

Erik
