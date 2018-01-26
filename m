Received: from eggs.gnu.org ([2001:4830:134:3::10]:38374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef5Lk-0007Dz-AN
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ef5Lj-00081Y-EZ
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:51:28 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:33080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ef5Lj-00081I-AZ
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 09:51:27 -0500
Received: by mail-ot0-x235.google.com with SMTP id d7so613677oti.0
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 06:51:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180125143218.29528-1-kraxel@redhat.com>
References: <20180125143218.29528-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2018 10:08:39 +0000
Message-ID: <CAFEAcA-TgfeW9K_5tFADx9Py9Uu5efCGiAoLYrq7LZiThEvAgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Ui 20180125 patches
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

On 25 January 2018 at 14:32, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 834a336eb911db8a8ca00e760ee6a85faca19414:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-01-24 19:24:26 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180125-pull-request
>
> for you to fetch changes up to 04ff1a398a8d6e912eceaca9b62af0a09e927d63:
>
>   sdl: reorganize -no-frame support (2018-01-25 15:22:28 +0100)
>
> ----------------------------------------------------------------
> ui: convert to keycodedb, fix sign extension
> sdl: cleanups, deprecate sdl 1.2
>
> ----------------------------------------------------------------
>
> Daniel P. Berrange (6):
>   ui: avoid sign extension using client width/height
>   ui: convert the SDL2 frontend to keycodemapdb
>   ui: convert GTK and SDL1 frontends to keycodemapdb
>   ui: add fix for GTK Pause key handling on Win32
>   ui: ignore hardware keycode 255 on win32
>   ui: deprecate use of SDL 1.2 in favour of 2.0 series
>
> Gerd Hoffmann (2):
>   sdl: use ctrl-alt-g as grab hotkey
>   sdl: reorganize -no-frame support

Applied, thanks (and updated my buildtest machines to have SDL2
where necessary to avoid the configure warning).

thanks
-- PMM
