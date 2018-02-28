Received: from eggs.gnu.org ([2001:4830:134:3::10]:48108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqzzK-0005oo-4n
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqzzJ-0005xk-EQ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:33:34 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:34455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqzzJ-0005xL-8q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 06:33:33 -0500
Received: by mail-ot0-x232.google.com with SMTP id n74so1918641ota.1
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 03:33:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180228062634.eh3xknbo7oosi5fo@sirius.home.kraxel.org>
References: <20180227080724.13585-1-kraxel@redhat.com>
	<CAFEAcA_k9pXrfkLQSSG5UTYOteMZEZXErMCh6-3Wgj42mGqrfw@mail.gmail.com>
	<20180228062634.eh3xknbo7oosi5fo@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Feb 2018 11:33:11 +0000
Message-ID: <CAFEAcA-uvP2U_83bsiBE7ujEyZVBUiHDmQVzk3f872HRLq5A9Q@mail.gmail.com>
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

On 28 February 2018 at 06:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> Hi. This failed to build on my OpenBSD test box:
>>
>>   CC      qga/guest-agent-command-state.o
>> In file included from /home/qemu/include/qemu/osdep.h:30:0,
>>                  from /home/qemu/qga/guest-agent-command-state.c:12:
>> ./config-host.h:29:0: warning: "CONFIG_SDL" redefined
>>  #define CONFIG_SDL m
>>  ^
>> ./config-host.h:17:0: note: this is the location of the previous definition
>>  #define CONFIG_SDL 1
>>  ^
>>
>> (warning repeated for pretty much every object file)
>>
>> and then linking of the final executables failed with
>>
>> ../audio/audio.o:(.data.rel.ro+0x0): undefined reference to `sdl_audio_driver'
>
> Oh, right, there is sdl audio, completely forgot about that ...
>
> (this probably triggers on openbsd because sdl audio is the default
> there).
>
> I think modularizing SDL isn't that easy then.
> Can you just drop the "sdl: build as ui module" patch?

I can't drop patches from signed pull requests -- you need
to respin it.

thanks
-- PMM
