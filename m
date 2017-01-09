Received: from eggs.gnu.org ([2001:4830:134:3::10]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQaKn-00034X-8p
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:50:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQaKm-0004l4-4b
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:50:01 -0500
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:33753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQaKl-0004ky-W3
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:50:00 -0500
Received: by mail-vk0-x22a.google.com with SMTP id 137so342049595vkl.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 05:49:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 13:49:38 +0000
Message-ID: <CAFEAcA_npQNeiSosYGEX2N4OofNaYk_nuti9rhYk12HByVPfFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/11] ui patch queue
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

On 9 January 2017 at 13:09, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here comes the ui patch queue with a bunch of small changes and fixes
> all over the place: gtk, vnc, curses, sdl, keyboard.
>
> v2 changes:  Replace the ps2 fix (v3 instead of v2 of the patch).
>
> please pull,
>   Gerd
>
> The following changes since commit dbe2b65566e76d3c3a0c3358285c0336ac61e757:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2016-12-28 17:11:11 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-ui-20170109-1
>
> for you to fetch changes up to f46c4259f489d2e7742890ddfaa862bde3731e3e:
>
>   ps2: Fix lost scancodes by recent changes (2017-01-06 10:36:49 +0100)
>
> ----------------------------------------------------------------
> gtk,vnc: misc bugfixes.
> kbd: add jp keys, fix ps2 regressions.
> sdl: export window id for baum, remove sdl hooks from baum.
> egl: egl-helpers.c license change.

Hi. I'm afraid this fails to build on OSX:

/Users/pm215/src/qemu-for-merges/ui/cocoa.m:688:21: error: use of
undeclared identifier 'MOUSE_EVENT_WHEELUP'
                    MOUSE_EVENT_WHEELUP : MOUSE_EVENT_WHEELDN;
                    ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:710:45: error: use of
undeclared identifier 'MOUSE_EVENT_WHEELUP'
                [INPUT_BUTTON_WHEEL_UP]   = MOUSE_EVENT_WHEELUP,
                                            ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:711:45: error: use of
undeclared identifier 'MOUSE_EVENT_WHEELDN'
                [INPUT_BUTTON_WHEEL_DOWN] = MOUSE_EVENT_WHEELDN,
                                            ^

thanks
-- PMM
