Received: from eggs.gnu.org ([2001:4830:134:3::10]:55696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEIo-0002Hh-2P
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEIk-0001si-V7
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:54:38 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:40963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLEIk-0001sL-RY
	for qemu-devel@nongnu.org; Tue, 22 May 2018 16:54:34 -0400
Received: by mail-qt0-x235.google.com with SMTP id g13-v6so25324390qth.8
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 13:54:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180522165058.15404-1-kraxel@redhat.com>
	<20180522165058.15404-7-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7a07853d-601b-f49d-2543-d176e781f297@amsat.org>
Date: Tue, 22 May 2018 17:54:29 -0300
MIME-Version: 1.0
In-Reply-To: <20180522165058.15404-7-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] MAINTAINERS: add vga entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 05/22/2018 01:50 PM, Gerd Hoffmann wrote:
> Add entries for standard vga, virtio-gpu and cirrus.

Thanks :)

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  MAINTAINERS | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e187b1f18f..2af3ad5172 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1314,6 +1314,27 @@ S: Maintained
>  F: include/hw/misc/unimp.h
>  F: hw/misc/unimp.c
>  
> +Standard VGA
> +M: Gerd Hoffmann <kraxel@redhat.com>
> +S: Maintained
> +F: hw/display/vga*
> +F: hw/display/bochs-display.c
> +F: include/hw/display/vga.h
> +F: include/hw/display/bochs-vbe.h
> +
> +virtio-gpu
> +M: Gerd Hoffmann <kraxel@redhat.com>
> +S: Maintained
> +F: hw/display/virtio-gpu*
> +F: hw/display/virtio-vga.c
> +F: include/hw/virtio/virtio-gpu.h
> +
> +Cirrus VGA
> +M: Gerd Hoffmann <kraxel@redhat.com>
> +S: Odd Fixes
> +W: https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/
> +F: hw/display/cirrus*
> +
>  Subsystems
>  ----------
>  Audio
> 
