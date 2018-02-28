Received: from eggs.gnu.org ([2001:4830:134:3::10]:45777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqvCQ-0002xD-4x
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqvCN-0001eU-11
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:26:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqvCM-0001e4-Se
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 01:26:42 -0500
Date: Wed, 28 Feb 2018 07:26:34 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180228062634.eh3xknbo7oosi5fo@sirius.home.kraxel.org>
References: <20180227080724.13585-1-kraxel@redhat.com>
	<CAFEAcA_k9pXrfkLQSSG5UTYOteMZEZXErMCh6-3Wgj42mGqrfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_k9pXrfkLQSSG5UTYOteMZEZXErMCh6-3Wgj42mGqrfw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/12] Ui 20180227 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> Hi. This failed to build on my OpenBSD test box:
> 
>   CC      qga/guest-agent-command-state.o
> In file included from /home/qemu/include/qemu/osdep.h:30:0,
>                  from /home/qemu/qga/guest-agent-command-state.c:12:
> ./config-host.h:29:0: warning: "CONFIG_SDL" redefined
>  #define CONFIG_SDL m
>  ^
> ./config-host.h:17:0: note: this is the location of the previous definition
>  #define CONFIG_SDL 1
>  ^
> 
> (warning repeated for pretty much every object file)
> 
> and then linking of the final executables failed with
> 
> ../audio/audio.o:(.data.rel.ro+0x0): undefined reference to `sdl_audio_driver'

Oh, right, there is sdl audio, completely forgot about that ...

(this probably triggers on openbsd because sdl audio is the default
there).

I think modularizing SDL isn't that easy then.
Can you just drop the "sdl: build as ui module" patch?

cheers,
  Gerd
