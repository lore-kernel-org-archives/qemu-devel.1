Received: from eggs.gnu.org ([2001:4830:134:3::10]:50595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etAgJ-0004OT-JE
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etAgF-0002yH-Mj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:22:55 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:34970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1etAgF-0002xz-Fo
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:22:51 -0500
Received: by mail-wr0-x244.google.com with SMTP id l43so20547592wrc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:22:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306074053.22856-1-kraxel@redhat.com>
References: <20180306074053.22856-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Mar 2018 12:22:49 +0100
Message-ID: <CAJ+F1CK5MsZ5=-z2yWznBcHjZqskHSdiyYxC30azEcQ9AXrRLg@mail.gmail.com>
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

On Tue, Mar 6, 2018 at 8:40 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Add audio driver (host backend) registry.  Add audio module support.
> Enable module builds for alsa, oss, pulse and sdl.
>
> Gerd Hoffmann (7):
>   audio: add driver registry
>   audio: add module loading support
>   build: enable audio modules
>   audio/alsa: build as module
>   audio/oss: build as module
>   audio/pulseaudio: build as module
>   audio/sdl: build as module
>

Is this a problem on my side? (configure
'--audio-drv-list=3Doss,alsa,pa,sdl' '--enable-modules')

elmarco@boraha:~/src/qemu/build (master %)$
x86_64-softmmu/qemu-system-x86_64 -audio-help
Failed to open module:
/home/elmarco/src/qemu/build/x86_64-softmmu/../audio-oss.so: undefined
symbol: _TRACE_OSS_INVALID_AVAILABLE_SIZE_DSTATE
Failed to open module:
/home/elmarco/src/qemu/build/x86_64-softmmu/../audio-alsa.so:
undefined symbol: _TRACE_ALSA_XRUN_OUT_DSTATE
Failed to open module:
/home/elmarco/src/qemu/build/x86_64-softmmu/../audio-pa.so: undefined
symbol: audio_pt_unlock_and_signal
Failed to open module:
/home/elmarco/src/qemu/build/x86_64-softmmu/../audio-sdl.so: undefined
symbol: audio_pcm_sw_write

>  configure             |  7 ++++-
>  Makefile              |  4 +++
>  Makefile.objs         |  1 +
>  audio/audio_int.h     | 14 ++++-----
>  include/qemu/module.h |  1 +
>  audio/alsaaudio.c     |  8 ++++-
>  audio/audio.c         | 83 +++++++++++++++++++++++++++++++++++----------=
------
>  audio/coreaudio.c     |  8 ++++-
>  audio/dsoundaudio.c   |  8 ++++-
>  audio/noaudio.c       |  8 ++++-
>  audio/ossaudio.c      |  8 ++++-
>  audio/paaudio.c       |  8 ++++-
>  audio/sdlaudio.c      |  8 ++++-
>  audio/spiceaudio.c    |  8 ++++-
>  audio/wavaudio.c      |  8 ++++-
>  audio/Makefile.objs   | 30 +++++++++++++------
>  scripts/create_config |  2 +-
>  17 files changed, 159 insertions(+), 55 deletions(-)
>
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
