Received: from eggs.gnu.org ([2001:4830:134:3::10]:58112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciOnZ-0004Oc-3v
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciOnT-0005fW-BS
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:09:21 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciOnT-0005f4-4p
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:09:15 -0500
Received: by mail-wr0-x22c.google.com with SMTP id l37so12693391wrc.1
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 09:09:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488208291-14775-1-git-send-email-kraxel@redhat.com>
References: <1488208291-14775-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 17:08:53 +0000
Message-ID: <CAFEAcA_-F8WaJOz6zwj9Rr7T6UA0t91EOGoc9DdCZN=Vs5QO=Q@mail.gmail.com>
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

On 27 February 2017 at 15:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Three little audio patches, adding replay support
> and fixing audio with SDL2.
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
>   git://git.kraxel.org/qemu tags/pull-audio-20170227-1
>
> for you to fetch changes up to 516452fe6accef3f94b4bcf060b2518038f50c08:
>
>   audio/sdlaudio: Allow audio playback with SDL2 (2017-02-27 14:37:59 +0100)
>
> ----------------------------------------------------------------
> audio: replay support, sdl2 fix.

I'm afraid this fails to build on OSX:

/Users/pm215/src/qemu-for-merges/audio/mixeng.c:277:5: error: implicit
declaration of function 'error_report' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    error_report(
    ^

Forgotten include of "qapi/error.h" (it's probably being pulled in
implicitly by some other header on other platforms).

thanks
-- PMM
