Received: from eggs.gnu.org ([2001:4830:134:3::10]:60097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg6lv-0005mb-0n
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cg6lu-0003gy-0i
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:30:11 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cg6lt-0003gY-Qq
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:30:09 -0500
Received: by mail-wm0-x22b.google.com with SMTP id r141so70511990wmg.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 01:30:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487599939-4776-1-git-send-email-kraxel@redhat.com>
References: <1487599939-4776-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 09:29:48 +0000
Message-ID: <CAFEAcA-g6=gTub53rinuVa6WbmaqcJ_oFQ6q6Vvsz=k5Xb4TgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] audio patch queue
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

On 20 February 2017 at 14:12, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here is the audio queue, bringing support for replay and fixing audio
> with SDL2.
>
> please pull,
>   Gerd
>
> The following changes since commit 5d42ff913bb294c661aed8dfcd386fed9e185148:
>
>   Merge remote-tracking branch 'remotes/huth/tags/coldfire-20170219' into staging (2017-02-20 11:55:37 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-audio-20170220-1
>
> for you to fetch changes up to 255a694376960826ead9a6e47c5c661d51b5e25b:
>
>   audio/sdlaudio: Allow audio playback with SDL2 (2017-02-20 14:24:51 +0100)
>
> ----------------------------------------------------------------
> audio: add sdl2 support, add replay support.
>
> ----------------------------------------------------------------

This doesn't build on OSX, I'm afraid:

/Users/pm215/src/qemu-for-merges/audio/mixeng.c:277:5: error: implicit
declaration of function 'error_report' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    error_report(
    ^

Missing #include ?

thanks
-- PMM
