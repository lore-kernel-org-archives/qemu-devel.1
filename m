Received: from eggs.gnu.org ([2001:4830:134:3::10]:34322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjKx-00070b-EO
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjKw-0001Vy-CV
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:46:47 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqjKw-0001VR-7W
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:46:46 -0500
Received: by mail-oi0-x241.google.com with SMTP id c18so5145122oiy.9
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:46:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227080724.13585-1-kraxel@redhat.com>
References: <20180227080724.13585-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 17:46:25 +0000
Message-ID: <CAFEAcA_k9pXrfkLQSSG5UTYOteMZEZXErMCh6-3Wgj42mGqrfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] Ui 20180227 patches
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

On 27 February 2018 at 08:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:
>
>   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180227-pull-request
>
> for you to fetch changes up to 8742dcaf7bcfa1ef8720f34dab984f153c87c9f3:
>
>   curses: build as ui module (2018-02-26 15:10:12 +0100)
>
> ----------------------------------------------------------------
> ui: add & use display registry, build some UIs as module.
>
> ----------------------------------------------------------------

Hi. This failed to build on my OpenBSD test box:

  CC      qga/guest-agent-command-state.o
In file included from /home/qemu/include/qemu/osdep.h:30:0,
                 from /home/qemu/qga/guest-agent-command-state.c:12:
./config-host.h:29:0: warning: "CONFIG_SDL" redefined
 #define CONFIG_SDL m
 ^
./config-host.h:17:0: note: this is the location of the previous definition
 #define CONFIG_SDL 1
 ^

(warning repeated for pretty much every object file)

and then linking of the final executables failed with

../audio/audio.o:(.data.rel.ro+0x0): undefined reference to `sdl_audio_driver'

thanks
-- PMM
