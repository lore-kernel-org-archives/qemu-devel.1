Received: from eggs.gnu.org ([2001:4830:134:3::10]:53613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqIt4-0000N3-QW
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqIt0-0001JG-VI
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:59:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dqIt0-0001Ic-P1
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:59:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57D05356D4
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 12:59:53 +0000 (UTC)
References: <20170908111217.21985-1-kraxel@redhat.com>
	<20170908111217.21985-3-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <707d49a9-51cf-abe4-78bc-07343181ecce@redhat.com>
Date: Fri, 8 Sep 2017 14:59:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170908111217.21985-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] usb: only build usb-host with
 CONFIG_USB=y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 08.09.2017 13:12, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index a43ebbc17f..757e365562 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -38,7 +38,7 @@ endif
>  common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
>  
>  # usb pass-through
> -ifeq ($(CONFIG_LIBUSB),y)
> +ifeq ($(CONFIG_LIBUSB)$(CONFIG_USB),yy)
>  common-obj-y += host-libusb.o host-legacy.o
>  else
>  common-obj-y += host-stub.o

Strange that you did not need the hack with "common-obj-$(CONFIG_ALL)"
in this patch like I had to do in the patch that I sent today... but
I've just checked it, and it seems to work this way. So:

Tested-by: Thomas Huth <thuth@redhat.com>
