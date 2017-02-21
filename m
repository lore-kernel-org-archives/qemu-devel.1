Received: from eggs.gnu.org ([2001:4830:134:3::10]:45667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg7j9-0002ql-B4
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cg7j8-0007Uu-BL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:31:23 -0500
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:35323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cg7j7-0007Uh-VH
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:31:22 -0500
Received: by mail-lf0-x234.google.com with SMTP id z127so61764709lfa.2
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:31:21 -0800 (PST)
MIME-Version: 1.0
References: <1487669841-13668-1-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487669841-13668-1-git-send-email-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Feb 2017 10:31:09 +0000
Message-ID: <CAJ+F1C+fOq+5W1Ym=Mw2nAj-M77pKkvxfNS2XeAfa-eib5Ek5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] ui: some gl scanout improvements.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, Feb 21, 2017 at 1:38 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> Upcoming intel vgpu support will need some updates for the qemu opengl
> support, specifically we will need support for importing dma-bufs.
> The kernel support for this is still brewing though and thus the qemu
> patches are still experimental and a moving target.
>
> While working on it I did some cleanups and improvements on the opengl
> code in qemu though, and there is no reason to wait with merging them,
> so here are the first bits.
>
> cheers,
>   Gerd
>
> Gerd Hoffmann (6):
>   console: rename dpy_gl_scanout to dpy_gl_scanout_texture
>   console: add dpy_gl_scanout_disable
>   virtio-gpu: use dpy_gl_scanout_disable
>   spice: add scanout_disable support
>   sdl2: add scanout_disable support
>   gtk-egl: add scanout_disable support
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



>
>  hw/display/virtio-gpu-3d.c | 13 ++++++------
>  include/ui/console.h       | 21 ++++++++++++-------
>  include/ui/gtk.h           | 25 +++++++++++++---------
>  include/ui/sdl2.h          | 13 +++++++-----
>  ui/console.c               | 30 +++++++++++++++++++-------
>  ui/gtk-egl.c               | 25 +++++++++++++---------
>  ui/gtk-gl-area.c           | 12 ++++++-----
>  ui/gtk.c                   |  5 +++--
>  ui/sdl2-gl.c               | 28 ++++++++++++++++---------
>  ui/sdl2.c                  |  3 ++-
>  ui/spice-display.c         | 52
> ++++++++++++++++++++++++++--------------------
>  11 files changed, 138 insertions(+), 89 deletions(-)
>
> --
> 1.8.3.1
>
>
> --
Marc-Andr=C3=A9 Lureau
