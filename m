Received: from eggs.gnu.org ([2001:4830:134:3::10]:55976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etzKe-00089z-Bb
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etzKd-00014R-60
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:27:56 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:47012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etzKc-000143-Vt
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:27:55 -0500
Received: by mail-ot0-x243.google.com with SMTP id g97so6108336otg.13
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 09:27:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180308083231.20180-1-kraxel@redhat.com>
References: <20180308083231.20180-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 17:27:33 +0000
Message-ID: <CAFEAcA8wUN_T9XrUULCROVFdv+vGipdMuhNz5km1mcX_nVrQgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Ui 20180308 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 March 2018 at 08:32, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit f32408f3b472a088467474ab152be3b6285b2d7b:
>
>   misc: don't use hwaddr as a type in trace events (2018-03-06 14:24:30 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180308-pull-request
>
> for you to fetch changes up to 5c71cfd94d46a9c2e09d041dcc82b297efab2b57:
>
>   ui/gtk-egl: add cursor_dmabuf support (2018-03-08 08:59:01 +0100)
>
> ----------------------------------------------------------------
> gtk: add dmabuf support. cleanups, i18n fix.
> sdl: workaround sdl 2.0.8 header bug,
>
> ----------------------------------------------------------------
>
> Bruce Rogers (1):
>   make: switch language file build to be gtk module aware
>
> Gerd Hoffmann (7):
>   sdl: workaround bug in sdl 2.0.8 headers
>   ui/gtk: make GtkGlArea usage a runtime option
>   ui/gtk: group gtk.mo declarations in Makefile
>   ui/opengl: Makefile cleanup
>   ui/gtk: use GtkGlArea on wayland only
>   ui/gtk-egl: add scanout_dmabuf support
>   ui/gtk-egl: add cursor_dmabuf support
>

Hi. This gives me a new warning on FreeBSD:

  CC      ui/gtk.o
/root/qemu/ui/gtk.c:2141:13: warning: 'gtk_widget_set_double_buffered'
is deprecated [-Wdeprecated-declarations]
            gtk_widget_set_double_buffered(vc->gfx.drawing_area, FALSE);
            ^
/usr/local/include/gtk-3.0/gtk/gtkwidget.h:876:23: note:
'gtk_widget_set_double_buffered' has been explicitly marked deprecated
here
void                  gtk_widget_set_double_buffered    (GtkWidget    *widget,
                      ^
1 warning generated.


thanks
-- PMM
