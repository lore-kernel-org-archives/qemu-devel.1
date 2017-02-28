Received: from eggs.gnu.org ([2001:4830:134:3::10]:40568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cidQB-0007oU-CT
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cidQA-0002KG-Es
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:46:11 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cidQA-0002Jj-8Z
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 03:46:10 -0500
Received: by mail-wm0-x229.google.com with SMTP id u199so5767031wmd.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 00:46:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488212323-26882-1-git-send-email-kraxel@redhat.com>
References: <1488212323-26882-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 08:45:48 +0000
Message-ID: <CAFEAcA8uJ5E66hDAaRdd2sRps+AfWMSiuWSzHyy95eAoa_KmZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/9] ui patch queue
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

On 27 February 2017 at 16:18, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Bringing some opengl improvements and fixes for gtk and vnc.
>
> please pull,
>   Gerd
>
> The following changes since commit 3b1d8169844fafee184366b0e0d7080534758b4d:
>
>   tests-aio-multithread: use atomic_read properly (2017-02-27 12:54:08 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/pull-ui-20170227-1
>
> for you to fetch changes up to 2dc120beb89b825033972db441ab540bcc42a17e:
>
>   vnc: fix double free issues (2017-02-27 16:22:01 +0100)
>
> ----------------------------------------------------------------
> gtk: fix kbd on xwayland
> vnc: fix double free issues
> opengl improvements
>
> ----------------------------------------------------------------
> Daniel P. Berrange (1):
>       ui: Use XkbGetMap and XkbGetNames instead of XkbGetKeyboard
>
> Gerd Hoffmann (8):
>       console: rename dpy_gl_scanout to dpy_gl_scanout_texture
>       console: add dpy_gl_scanout_disable
>       virtio-gpu: use dpy_gl_scanout_disable
>       spice: add scanout_disable support
>       sdl2: add scanout_disable support
>       gtk-egl: add scanout_disable support
>       spice: add display & head options
>       vnc: fix double free issues

Applied, thanks.

-- PMM
