Received: from eggs.gnu.org ([2001:4830:134:3::10]:46290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwZ4K-0007VV-99
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwZ4J-0000Zv-JC
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:29:28 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:46766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwZ4J-0000Zj-DD
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:29:27 -0400
Received: by mail-wr0-x22f.google.com with SMTP id o42so9664009wrb.3
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 12:29:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <af89f372-3fa7-a727-b49c-6418c3fab985@siemens.com>
References: <af89f372-3fa7-a727-b49c-6418c3fab985@siemens.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Sep 2017 20:29:05 +0100
Message-ID: <CAFEAcA-Am0f7-6B=6GevEf6o9+OyAs-BDk1wxJER4Y43oZaVQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] usb: Fix usb-host build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Gerd, ping? If you provide a reviewed-by or acked-by
I can apply this to master as a buildfix...

thanks
-- PMM

On 22 September 2017 at 08:42, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This reverts the incorrect commit 2041649f0b04 (these are
> machine-independent objects) and fixes the name of the config var.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  hw/usb/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index 757e365562..c7f0a52f44 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -38,7 +38,7 @@ endif
>  common-obj-$(CONFIG_USB_REDIR) += redirect.o quirks.o
>
>  # usb pass-through
> -ifeq ($(CONFIG_LIBUSB)$(CONFIG_USB),yy)
> +ifeq ($(CONFIG_USB_LIBUSB),y)
>  common-obj-y += host-libusb.o host-legacy.o
>  else
>  common-obj-y += host-stub.o
> --
> 2.12.3
