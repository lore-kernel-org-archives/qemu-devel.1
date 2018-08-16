Received: from eggs.gnu.org ([2001:4830:134:3::10]:49068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fqFn4-0004Nc-Nn
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fqFmt-0001cG-BM
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:46:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57930 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fqFmt-0001ba-4x
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 06:45:55 -0400
Date: Thu, 16 Aug 2018 12:45:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180816104552.ul7sxdbon4xyi2bn@sirius.home.kraxel.org>
References: <20180816094356.16396-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816094356.16396-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] usb-host: insert usb device into hostdevs
 to be scaned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, wangxinxin.wang@huawei.com

On Thu, Aug 16, 2018 at 05:43:56PM +0800, linzhecheng wrote:
> According to the comment of usb_host_post_load_bh, after removing the
> usb device passed through, we will kick host to scan it again, but the emulated
> usb device is not added to global list hostdevs, so it can never be discovered then.
> So just do it before usb_host_auto_check. What's more, it's futile to walk devs in
> usb_host_auto_check periodically if hostdevs is empty, so let's delete the usb_auto_timer.

Hmm, needs_autoscan is a fixed property of the device (depending on
configuration), it should not be switched on and off.

What problem you are trying to solve?

cheers,
  Gerd
