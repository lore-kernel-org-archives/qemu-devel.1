Received: from eggs.gnu.org ([2001:4830:134:3::10]:45902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fByyJ-00067g-2T
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:43:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fByyE-0007PW-Ly
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:43:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51882 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fByyE-0007P6-HO
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:43:10 -0400
Date: Fri, 27 Apr 2018 10:43:01 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180427084301.kqu7epidjsq6tqzy@sirius.home.kraxel.org>
References: <20180405132046.4968-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405132046.4968-1-git@johnthomson.fastmail.com.au>
Subject: Re: [Qemu-devel] [PATCH] Fix libusb-1.0.22 deprecated
 libusb_set_debug with libusb_set_option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Thomson <git@johnthomson.fastmail.com.au>
Cc: qemu-devel@nongnu.org

On Thu, Apr 05, 2018 at 11:20:46PM +1000, John Thomson wrote:
> libusb-1.0.22 marked libusb_set_debug deprecated
> it is replaced with
> libusb_set_option(libusb_context, LIBUSB_OPTION_LOG_LEVEL, libusb_log_level);
> 
> details here: https://github.com/libusb/libusb/commit/539f22e2fd916558d11ab9a66f10f461c5593168
> 
> Warning here:
> 
>   CC      hw/usb/host-libusb.o
> /builds/xen/src/qemu-xen/hw/usb/host-libusb.c: In function 'usb_host_init':
> /builds/xen/src/qemu-xen/hw/usb/host-libusb.c:250:5: error: 'libusb_set_debug' is deprecated: Use libusb_set_option instead [-Werror=deprecated-declarations]
>      libusb_set_debug(ctx, loglevel);
>      ^~~~~~~~~~~~~~~~
> In file included from /builds/xen/src/qemu-xen/hw/usb/host-libusb.c:40:0:
> /usr/include/libusb-1.0/libusb.h:1300:18: note: declared here
>  void LIBUSB_CALL libusb_set_debug(libusb_context *ctx, int level);
>                   ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/builds/xen/src/qemu-xen/rules.mak:66: hw/usb/host-libusb.o] Error 1
> make: Leaving directory '/builds/xen/src/xen/tools/qemu-xen-build'

Added to usb patch queue.

thanks,
  Gerd
