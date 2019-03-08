Received: from eggs.gnu.org ([209.51.188.92]:34812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjaggi.dev@gmail.com>) id 1h29GQ-0003ny-SQ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjaggi.dev@gmail.com>) id 1h29GQ-0002NB-7I
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:45:50 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjaggi.dev@gmail.com>)
	id 1h29GP-0002MO-S4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 01:45:50 -0500
Received: by mail-lj1-x244.google.com with SMTP id 199so16485328ljj.5
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 22:45:49 -0800 (PST)
MIME-Version: 1.0
References: <CAKSw8c6QTBSG6YDr1nLATrQYqybw+eUxEgVyEAQg+z7NqLqoxA@mail.gmail.com>
	<CAJ+F1CLA3q_2Bz+k7MjWC28Z8TuBSX5MSHR6Gd4Vbu+BkGcQaQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CLA3q_2Bz+k7MjWC28Z8TuBSX5MSHR6Gd4Vbu+BkGcQaQ@mail.gmail.com>
From: manish jaggi <mjaggi.dev@gmail.com>
Date: Fri, 8 Mar 2019 12:15:37 +0530
Message-ID: <CAKSw8c4y94bOJNO5vMQvCKMgjOhO4m-9ht89BHCbaMVhwU7tgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] egl: EGL_MESA_image_dma_buf_export not supported /
 Failed to initialize EGL render node for SPICE GL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, mjaggi@marvell.com, Jayachandran Chandrasekharan Nair <jnair@marvell.com>

On Thu, Mar 7, 2019 at 9:55 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, Mar 7, 2019 at 3:00 PM manish jaggi <mjaggi.dev@gmail.com> wrote:
> >
> > Hi List,
> > I am trying to run qemu with spice gl=3Don with the below command line
> > and getting errors.
> >
> > qemu-system-x86_64 -cdrom ubuntu-18.04.2-desktop-amd64.iso -hda
> > u1.qcow2 -enable-kvm -m 1G -cpu host -smp 8 -machine vmport=3Doff -boot
> > order=3Ddc -device virtio-vga,virgl=3Don -spice
> > gl=3Don,unix,addr=3D/home/mjaggi/spice.sock,password=3D1,disable-ticket=
ing
> > -soundhw hda -device virtio-serial -chardev
> > spicevmc,id=3Dvdagent,debug=3D0,name=3Dvdagent -device
> > virtserialport,chardev=3Dvdagent,name=3Dcom.redhat.spice.0
> >
> > qemu-system-x86_64: egl: EGL_MESA_image_dma_buf_export not supported
> > qemu-system-x86_64: Failed to initialize EGL render node for SPICE GL
>
> It's a limitation of your graphics driver, it doesn't support the
> required extensions.
>
> Which GPU and driver do you have?
>
AMD RX560, using mainline 5.0 kernel.
is  EGL_MESA_image_dma_buf_export  must for spice gl=3Don?

> thanks
>
> >
> > Qemu configuration
> > ./configure --enable-sdl --with-sdlabi=3D2.0 --enable-opengl
> > --enable-virglrenderer --enable-system --enable-modules
> > --target-list=3Dx86_64-softmmu --enable-kvm  --disable-werror
> >
> > ...
> > OpenGL support    yes
> > OpenGL dmabufs    yes
> >
> > As per configure script
> >
> > #include <epoxy/egl.h>
> > #ifndef EGL_MESA_image_dma_buf_export
> > # error mesa/epoxy lacks support for dmabufs (mesa 10.6+)
> > #endif
> > int main(void) { return 0; }
> > EOF
> >   if compile_prog "" "" ; then
> >     opengl_dmabuf=3Dyes
> >   fi
> > fi
> >
> > So if OpenGL dmabufs   is yes, should I be getting
> > EGL_MESA_image_dma_buf_export not supported error ?
> > What I could be missing here
> > Need help/guidance.
> >
> > -Thanks
> > Manish
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
