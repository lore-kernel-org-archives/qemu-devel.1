Received: from eggs.gnu.org ([2001:4830:134:3::10]:48119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dwk6g-0007V3-Mr
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 03:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dwk6d-0004tu-IU
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 03:16:38 -0400
Received: from thoth.sbs.de ([192.35.17.2]:57642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1dwk6d-0004se-7s
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 03:16:35 -0400
References: <20170926063820.30773-1-kraxel@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <053ad89e-9084-905e-a6cd-4a1f4c4638e8@siemens.com>
Date: Tue, 26 Sep 2017 09:16:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170926063820.30773-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb: fix libusb config variable name.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 2017-09-26 08:38, Gerd Hoffmann wrote:
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Fixes: 4e5ee5b21c84fe3023a64b5cc2e12a52ab0597c1
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 9255234c63..0e6d54b21f 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -42,7 +42,7 @@ redirect.o-cflags = $(USB_REDIR_CFLAGS)
>  redirect.o-libs = $(USB_REDIR_LIBS)
>  
>  # usb pass-through
> -ifeq ($(CONFIG_LIBUSB)$(CONFIG_USB),yy)
> +ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
>  common-obj-y += host-libusb.o host-legacy.o
>  else
>  common-obj-y += host-stub.o
> 

This won't still work, only patch did -> CONFIG_USB isn't set when
building the common objects.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
