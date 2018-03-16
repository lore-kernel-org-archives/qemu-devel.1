Received: from eggs.gnu.org ([2001:4830:134:3::10]:44538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gregkh@linuxfoundation.org>) id 1ewkDW-0004wM-LB
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 03:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gregkh@linuxfoundation.org>) id 1ewkDT-0007y9-JF
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 03:55:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gregkh@linuxfoundation.org>)
	id 1ewkDT-0007xc-DB
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 03:55:55 -0400
Date: Fri, 16 Mar 2018 08:55:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20180316075553.GA11982@kroah.com>
References: <20180316074650.5415-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316074650.5415-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, qemu-devel@nongnu.org, David Airlie <airlied@linux.ie>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Daniel Vetter <daniel@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, Shuah Khan <shuah@kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>

On Fri, Mar 16, 2018 at 08:46:49AM +0100, Gerd Hoffmann wrote:
> --- /dev/null
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -0,0 +1,261 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

No SPDX line or copyright here?  You put it in the .h file :(

thanks,

greg k-h
