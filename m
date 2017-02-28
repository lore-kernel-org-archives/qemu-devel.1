Received: from eggs.gnu.org ([2001:4830:134:3::10]:50184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cilkO-0003mn-AP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cilkN-0005WV-Cr
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:36 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cilkN-0005WR-5y
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:39:35 -0500
Received: by mail-wm0-x235.google.com with SMTP id v77so17717785wmv.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 09:39:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488274334-6387-1-git-send-email-kraxel@redhat.com>
References: <1488274334-6387-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 17:39:13 +0000
Message-ID: <CAFEAcA8zEiENj51EDHGc=VDCCn08apBT16ajzVPVHV_0m00qXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 0/3] audio patch queue
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

On 28 February 2017 at 09:32, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Three little audio patches, adding replay support
> and fixing audio with SDL2.
>
> v2: fix osx build failure.
>
> please pull,
>   Gerd
>
> The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af59144442785f:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-1' into staging (2017-02-27 19:19:46 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-audio-20170228-1
>
> for you to fetch changes up to 6d6616aa655850925ec2a0d096f5c22cb4522fa4:
>
>   audio/sdlaudio: Allow audio playback with SDL2 (2017-02-28 10:09:35 +0100)
>
> ----------------------------------------------------------------
> audio: replay support, sdl2 fix.
>
> ----------------------------------------------------------------

/Users/pm215/src/qemu-for-merges/audio/mixeng.c:278:5: error: implicit
declaration of function 'error_report' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    error_report(
    ^

Sorry, I gave you the wrong include filename last time :-(
error_report() is in qemu/error-report.h, not qapi/error.h.
(I misread the grep output...)

thanks
-- PMM
