Received: from eggs.gnu.org ([209.51.188.92]:53570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1CR-0002mt-4b
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1CN-0001Sm-Vt
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:55:03 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:45101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1CN-0001Qa-Ja
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:54:59 -0500
Received: by mail-oi1-x22b.google.com with SMTP id y1so18285102oie.12
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20190121141152.948-1-kraxel@redhat.com>
In-Reply-To: <20190121141152.948-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 16:08:41 +0000
Message-ID: <CAFEAcA93m=WproC2bpcT1WL7aDkDMVV4oPMV5B4CmsEAUw7pyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/5] Ui 20190121 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On Mon, 21 Jan 2019 at 14:15, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 681d61362d3f766a00806b89d6581869041f73=
cb:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-01-17 12:48:42 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20190121-pull-request
>
> for you to fetch changes up to fbd57c754f32804a63295f70f271d1ef128ee590:
>
>   egl-helpers.h: do not depend on X11 Window type, use EGLNativeWindowTyp=
e (2019-01-21 09:44:32 +0100)
>
> ----------------------------------------------------------------
> ui: highres logo for sdl and gtk, bugfixes for vnc and egl.
>
> ----------------------------------------------------------------
>
> Alexander Kanavin (1):
>   egl-helpers.h: do not depend on X11 Window type, use
>     EGLNativeWindowType
>
> Daniel P. Berrang=C3=A9 (3):
>   ui: install logo icons to $prefix/share/icons
>   ui: fix icon display for GTK frontend under GNOME Shell with Wayland
>   sdl: add support for high resolution window icon
>
> Gerd Hoffmann (1):
>   vnc: detect and optimize pageflips

>  delete mode 100644 pc-bios/qemu-icon.bmp

Doesn't this break the SDL UI? ui/sdl.c still looks for
qemu-icon.bmp...

thanks
-- PMM
