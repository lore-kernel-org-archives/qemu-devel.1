Received: from eggs.gnu.org ([2001:4830:134:3::10]:39327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etBwD-0004cp-M8
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etBwC-0004tb-MR
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:43:25 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:37226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1etBwC-0004tD-Fr
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 07:43:24 -0500
Received: by mail-wr0-x243.google.com with SMTP id z12so20797277wrg.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 04:43:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306114232.v5gtwxald4mmelab@sirius.home.kraxel.org>
References: <20180306074053.22856-1-kraxel@redhat.com>
	<CAJ+F1CK5MsZ5=-z2yWznBcHjZqskHSdiyYxC30azEcQ9AXrRLg@mail.gmail.com>
	<20180306114232.v5gtwxald4mmelab@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Mar 2018 13:43:22 +0100
Message-ID: <CAJ+F1CJo28aN6mwihp8UTwq4jtgz21BxT+U7F-jGu7fyhefBkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] audio: modularize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Mar 6, 2018 at 12:42 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Tue, Mar 06, 2018 at 12:22:49PM +0100, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Tue, Mar 6, 2018 at 8:40 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> > Add audio driver (host backend) registry.  Add audio module support.
>> > Enable module builds for alsa, oss, pulse and sdl.
>> >
>> > Gerd Hoffmann (7):
>> >   audio: add driver registry
>> >   audio: add module loading support
>> >   build: enable audio modules
>> >   audio/alsa: build as module
>> >   audio/oss: build as module
>> >   audio/pulseaudio: build as module
>> >   audio/sdl: build as module
>> >
>>
>> Is this a problem on my side? (configure
>> '--audio-drv-list=3Doss,alsa,pa,sdl' '--enable-modules')
>>
>> elmarco@boraha:~/src/qemu/build (master %)$
>> x86_64-softmmu/qemu-system-x86_64 -audio-help
>> Failed to open module:
>> /home/elmarco/src/qemu/build/x86_64-softmmu/../audio-oss.so: undefined
>> symbol: _TRACE_OSS_INVALID_AVAILABLE_SIZE_DSTATE
>> Failed to open module:
>> /home/elmarco/src/qemu/build/x86_64-softmmu/../audio-alsa.so:
>> undefined symbol: _TRACE_ALSA_XRUN_OUT_DSTATE
>> Failed to open module:
>> /home/elmarco/src/qemu/build/x86_64-softmmu/../audio-pa.so: undefined
>> symbol: audio_pt_unlock_and_signal
>> Failed to open module:
>> /home/elmarco/src/qemu/build/x86_64-softmmu/../audio-sdl.so: undefined
>> symbol: audio_pcm_sw_write
>
> Works fine here.  Tried "make clean && make"?
>
> Qemu build system seems to not rebuild object files when the compiler
> flags change.  So you can't switch between --enable-modules and
> --disable-modules without "make clean" inbetween.  Same issue when
> patches switch code from compiled-in to modular and you try an
> incremental build.

Fresh directory, cleaned ccache. That didn't help. fwiw, I am
compiling on f27, gcc (GCC) 7.3.1 20180130. I'll investigate further
if you can't reproduce.

> I've seen only build failues due to this, not module load errors.  But
> possibly only because I stopped doing incremental builds when working on
> module patches ...
>
> cheers,
>   Gerd
>



--=20
Marc-Andr=C3=A9 Lureau
