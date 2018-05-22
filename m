Received: from eggs.gnu.org ([2001:4830:134:3::10]:59058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fLAvy-0006yK-KD
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fLAvu-0001Ar-LF
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:18:50 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:56257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fLAvu-0001Ai-GJ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 13:18:46 -0400
Received: by mail-it0-f51.google.com with SMTP id 144-v6so865028iti.5
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 10:18:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180522165058.15404-7-kraxel@redhat.com>
References: <20180522165058.15404-1-kraxel@redhat.com>
	<20180522165058.15404-7-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 22 May 2018 19:18:45 +0200
Message-ID: <CAMxuvaxP+TrwQSuMmFxmQmJojyLB1WYijJY0MPfv+3S8VVdJaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/6] MAINTAINERS: add vga entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Tue, May 22, 2018 at 6:50 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Add entries for standard vga, virtio-gpu and cirrus.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

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
> +W: https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harm=
ful/
> +F: hw/display/cirrus*
> +
>  Subsystems
>  ----------
>  Audio
> --
> 2.9.3
>
