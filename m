Received: from eggs.gnu.org ([2001:4830:134:3::10]:56625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKTdr-0004RD-Io
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKTdq-0006nN-Ny
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:00:43 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:34793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKTdq-0006n2-EQ
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 14:00:42 -0400
Received: by mail-wr0-x236.google.com with SMTP id g76so104762084wrd.1
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 11:00:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170608070716.2954-1-kraxel@redhat.com>
References: <20170608070716.2954-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jun 2017 19:00:19 +0100
Message-ID: <CAFEAcA9+194DyFJ=grKX6o9LAUeXHAJgX92gc419+Aa64_PHig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] ui patch queue
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

On 8 June 2017 at 08:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here is the ui patch queue.  Switches the default
> to gtk3 and sdl2 and fixes some bugs.
>
> please pull,
>   Gerd
>
> The following changes since commit a0d4aac7467dd02e5657b79e867f067330266a24:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20170605' into staging (2017-06-05 18:03:43 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/pull-ui-20170608-1
>
> for you to fetch changes up to 468949958fdfa4347a66e3cf5c8240a428532602:
>
>   spice: don't enter opengl mode in case another UI provides opengl support (2017-06-08 08:13:46 +0200)
>
> ----------------------------------------------------------------
> ui: prefer gtk3 and sdl2, various fixes.
>
> ----------------------------------------------------------------

This causes configure to barf warnings in my build logs on half
my build machines:

WARNING: Support for gtk2 will be dropped in future releases.
WARNING: Please consider using gtk3 instead.

I don't think it is yet possible to drop gtk2.

thanks
-- PMM
