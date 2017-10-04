Received: from eggs.gnu.org ([2001:4830:134:3::10]:40709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzjK8-0006V0-If
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzjK5-0000ox-Gg
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:02:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dzjK5-0000nd-9y
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:02:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84DA1780C3
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 13:02:47 +0000 (UTC)
References: <20171004125210.7817-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6f745058-69e1-33a6-f585-8bcd97bef248@redhat.com>
Date: Wed, 4 Oct 2017 15:02:43 +0200
MIME-Version: 1.0
In-Reply-To: <20171004125210.7817-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb: fix host-stub.c build race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 04.10.2017 14:52, Gerd Hoffmann wrote:
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/Makefile.objs | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 0e6d54b21f..bdfead6701 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -47,6 +47,7 @@ common-obj-y += host-libusb.o host-legacy.o
>  else
>  common-obj-y += host-stub.o
>  endif
> +common-obj-$(CONFIG_ALL) += host-stub.o
>  
>  host-libusb.o-cflags := $(LIBUSB_CFLAGS)
>  host-libusb.o-libs := $(LIBUSB_LIBS)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
