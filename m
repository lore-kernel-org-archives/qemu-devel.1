Received: from eggs.gnu.org ([208.118.235.92]:55310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIYTB-0003MX-2Y
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIYT5-00056b-Fy
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:50:17 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:34399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIYT5-00055R-Ai
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:50:11 -0400
Received: by mail-oi0-x22b.google.com with SMTP id l1-v6so13672504oii.1
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 04:50:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515091901.27774-1-kraxel@redhat.com>
References: <20180515091901.27774-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 12:49:49 +0100
Message-ID: <CAFEAcA8ejSxKXhh19FzEduSriAvauSjar8atoF=CkgEW_TyWTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20180515 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>

On 15 May 2018 at 10:18, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit fbd3a489df9953e2a5d017c922f3c103b2426952:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180514' into staging (2018-05-14 18:53:42 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180515-pull-request
>
> for you to fetch changes up to 677b490501823c1cb6946d8bb9e7907c12cd0c71:
>
>   gtk: disable the F10 menubar key (2018-05-15 10:47:01 +0200)
>
> ----------------------------------------------------------------
> ui: qapi parser for -display cmd line.
> gtk: multiple fixes.
> sdl: opts bugfix.
> vnc: magic cookie.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (7):
>   sdl2: move opts assignment into loop
>   vnc: add magic cookie to VncState
>   ui: add qapi parser for -display
>   ui: switch trivial displays to qapi parser
>   ui: switch gtk display to qapi parser
>   ui: document non-qapi parser cases.
>   console: use linked list for QemuConsoles
>
> Peter Wu (2):
>   gtk: make it possible to hide the menu bar
>   gtk: disable the F10 menubar key
>
> Tomeu Vizoso (1):
>   ui/gtk: Only try to initialize EGL/X11 if GtkGlArea failed
>

Applied, thanks.

-- PMM
