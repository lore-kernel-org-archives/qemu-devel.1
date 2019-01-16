Received: from eggs.gnu.org ([209.51.188.92]:48576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gje8t-0004E5-K8
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gje8r-0006IW-L6
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:53:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gje8j-0006Ay-Kb
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:53:29 -0500
Date: Wed, 16 Jan 2019 06:53:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190116055311.go6kwaemxfvbgtbb@sirius.home.kraxel.org>
References: <20190115115047.39326-1-alex.kanavin@gmail.com>
	<bde5dc1a-2ec3-98fa-1b4c-9147ddbadd86@redhat.com>
	<CANNYZj8RLr0ZQJjgXD065WzuYUHbi-dCN1-j_gQNq+28U9h6Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CANNYZj8RLr0ZQJjgXD065WzuYUHbi-dCN1-j_gQNq+28U9h6Qw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] egl-helpers.h: add a missing X11 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Tue, Jan 15, 2019 at 09:47:08PM +0100, Alexander Kanavin wrote:
> On Tue, 15 Jan 2019 at 20:58, Philippe Mathieu-Daud=E9 <philmd@redhat.c=
om> wrote:
> > Cc'ing Gerd (the maintainer) and Marc-Andr=E9.
> >
> > > |  EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, Window win=
);
> > > |                                                        ^~~~~~
> > > |                                                        minor

> > <epoxy/egl.h> includes <EGL/eglplatform.h> which contains:
> >
> >   #if defined(MESA_EGL_NO_X11_HEADERS)
> >   typedef void            *EGLNativeDisplayType;
> >   typedef khronos_uintptr_t EGLNativePixmapType;
> >   typedef khronos_uintptr_t EGLNativeWindowType;
> >   #else
> >   /* X11 (tentative)  */
> >   #include <X11/Xlib.h>
> >
> > So Window should already be declared.
>=20
> Hello Philippe,
>=20
> we build mesa explicitly using "--with-platforms=3D'drm surfaceless'"
> (x11 is not in the list), which means MESA_EGL_NO_X11_HEADERS is
> indeed defined according to [1]. We also enable opengl and gtk in
> qemu.

Hmm, should we use EGLNativeWindowType instead of Window then?

cheers,
  Gerd
