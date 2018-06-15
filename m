Received: from eggs.gnu.org ([2001:4830:134:3::10]:47371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fTrwk-00089i-7o
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fTrwj-0007jt-HF
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 12:51:34 -0400
References: <20180613122948.18149-1-kraxel@redhat.com>
	<20180613122948.18149-5-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8451099d-52d0-741c-4810-12829b4b5927@redhat.com>
Date: Fri, 15 Jun 2018 18:51:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180613122948.18149-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/4] Add ramfb MAINTAINERS entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/13/18 14:29, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a94517e9e..2401028766 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1331,6 +1331,12 @@ F: hw/display/bochs-display.c
>  F: include/hw/display/vga.h
>  F: include/hw/display/bochs-vbe.h
>  
> +ramfb
> +M: Gerd Hoffmann <kraxel@redhat.com>
> +S: Maintained
> +F: hw/display/ramfb*.c
> +F: include/hw/display/ramfb.h
> +
>  virtio-gpu
>  M: Gerd Hoffmann <kraxel@redhat.com>
>  S: Maintained
> 

I wonder if we should have a separate "display" section in this text
file, or some such.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
