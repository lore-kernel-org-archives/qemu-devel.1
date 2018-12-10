Received: from eggs.gnu.org ([2001:4830:134:3::10]:38776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLmn-0006OB-7Z
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLWk-0005jB-E3
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:23:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWLWk-0005it-64
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:23:14 -0500
Date: Mon, 10 Dec 2018 14:23:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181210132311.2y4tfwy4ra5iqx4s@sirius.home.kraxel.org>
References: <20181130064700.5984-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130064700.5984-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] usb-host: reset and close
 libusb_device_handle before qemu exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: qemu-devel@nongnu.org, jianjay.zhou@huawei.com, wangxinxin.wang@huawei.com

On Fri, Nov 30, 2018 at 02:47:00PM +0800, linzhecheng wrote:
> we should perform these things as same as usb_host_close.
> 
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> 
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index b6602ded4e..2016375e6b 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -988,7 +988,9 @@ static void usb_host_exit_notifier(struct Notifier *n, void *data)
>  
>      if (s->dh) {
>          usb_host_release_interfaces(s);
> +	libusb_reset_device(s->dh);
>          usb_host_attach_kernel(s);
> +	libusb_close(s->dh);

qemu codesstyle uses spaces not tabs, please update your editor settings.

Fixed and added to usb queue.

thanks,
  Gerd
