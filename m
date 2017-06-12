Received: from eggs.gnu.org ([2001:4830:134:3::10]:53907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKKaG-0007gR-PP
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 04:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKKaB-00057T-T7
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 04:20:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dKKaB-00057L-Mg
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 04:20:19 -0400
Message-ID: <1497255616.6334.4.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 12 Jun 2017 10:20:16 +0200
In-Reply-To: <CAJ+F1CLy2nt-PgqDPNAvQBMcjMt_oTAUrSLY8trPtD-fyufd5A@mail.gmail.com>
References: <20170606110459.9771-1-kraxel@redhat.com>
	<20170606110459.9771-3-kraxel@redhat.com>
	<CAJ+F1CLy2nt-PgqDPNAvQBMcjMt_oTAUrSLY8trPtD-fyufd5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/4] egl-headless: use framebuffer helper
 functions.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org

On Wed, 2017-06-07 at 21:02 +0000, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> The patch looks good to me, but I tried to use egl-headless for the
> first time, and I get a weird crash on virgl init:
> (gdb) bt
> #0=C2=A0 0x00007fffd8cd935f in rawmemchr () at /lib64/libc.so.6
> #1=C2=A0 0x00007fffd8cc1832 in _IO_str_init_static_internal () at
> /lib64/libc.so.6
> #2=C2=A0 0x00007fffd8cb37e7 in vsscanf () at /lib64/libc.so.6
> #3=C2=A0 0x00007ffff6e818a6 in vsscanf () at /lib64/libasan.so.3
> #4=C2=A0 0x00007ffff6e819d3 in sscanf () at /lib64/libasan.so.3
> #5=C2=A0 0x00007ffff6bfe239 in vrender_get_glsl_version
> (glsl_version=3D0x60e00001f2b8) at vrend_renderer.c:6026
> #6=C2=A0 0x00007ffff6bfe239 in vrend_create_context (id=3Did@entry=3D0, n=
len=3Dn
> len@entry=3D0, debug_name=3Ddebug_name@entry=3D0x0) at
> vrend_renderer.c:4033
> #7=C2=A0 0x00007ffff6c04f2f in vrend_renderer_context_create_internal
> (handle=3D0, nlen=3D0, debug_name=3D0x0) at vrend_decode.c:1066
> #8=C2=A0 0x00007ffff6bf72a3 in vrend_renderer_init (cbs=3D<optimized out>=
,
> flags=3D0) at vrend_renderer.c:3874
> #9=C2=A0 0x0000555556b52cc1 in virtio_gpu_virgl_init (g=3D0x633000008d10)=
 at
> /home/elmarco/src/qemu/hw/display/virtio-gpu-3d.c:623
>=20
> This doesn't happen when I use virgl/spice (gl=3Don obviously)
>=20
> I guess you don't know what's going on,

No, havn't seen this before.

cheers,
  Gerd
