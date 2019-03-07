Received: from eggs.gnu.org ([209.51.188.92]:38682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjaggi.dev@gmail.com>) id 1h1tYc-0000r3-BZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjaggi.dev@gmail.com>) id 1h1tYb-0005Z9-Hz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:59:34 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f]:33833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjaggi.dev@gmail.com>)
	id 1h1tYb-0005Wh-AA
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:59:33 -0500
Received: by mail-lf1-x12f.google.com with SMTP id d26so11750589lfa.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 05:59:32 -0800 (PST)
MIME-Version: 1.0
From: manish jaggi <mjaggi.dev@gmail.com>
Date: Thu, 7 Mar 2019 19:29:18 +0530
Message-ID: <CAKSw8c6QTBSG6YDr1nLATrQYqybw+eUxEgVyEAQg+z7NqLqoxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] egl: EGL_MESA_image_dma_buf_export not supported /
 Failed to initialize EGL render node for SPICE GL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jayachandran Chandrasekharan Nair <jnair@marvell.com>, mjaggi@marvell.com

Hi List,
I am trying to run qemu with spice gl=on with the below command line
and getting errors.

qemu-system-x86_64 -cdrom ubuntu-18.04.2-desktop-amd64.iso -hda
u1.qcow2 -enable-kvm -m 1G -cpu host -smp 8 -machine vmport=off -boot
order=dc -device virtio-vga,virgl=on -spice
gl=on,unix,addr=/home/mjaggi/spice.sock,password=1,disable-ticketing
-soundhw hda -device virtio-serial -chardev
spicevmc,id=vdagent,debug=0,name=vdagent -device
virtserialport,chardev=vdagent,name=com.redhat.spice.0

qemu-system-x86_64: egl: EGL_MESA_image_dma_buf_export not supported
qemu-system-x86_64: Failed to initialize EGL render node for SPICE GL

Qemu configuration
./configure --enable-sdl --with-sdlabi=2.0 --enable-opengl
--enable-virglrenderer --enable-system --enable-modules
--target-list=x86_64-softmmu --enable-kvm  --disable-werror

...
OpenGL support    yes
OpenGL dmabufs    yes

As per configure script

#include <epoxy/egl.h>
#ifndef EGL_MESA_image_dma_buf_export
# error mesa/epoxy lacks support for dmabufs (mesa 10.6+)
#endif
int main(void) { return 0; }
EOF
  if compile_prog "" "" ; then
    opengl_dmabuf=yes
  fi
fi

So if OpenGL dmabufs   is yes, should I be getting
EGL_MESA_image_dma_buf_export not supported error ?
What I could be missing here
Need help/guidance.

-Thanks
Manish
