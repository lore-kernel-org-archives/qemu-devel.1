Received: from eggs.gnu.org ([2001:4830:134:3::10]:44959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNBIs-0002We-Ez
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 23:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cNBIp-0006IS-Dy
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 23:29:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:41552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cNBIp-0006IH-58
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 23:29:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cNBIn-0008OQ-2S
	for <qemu-devel@nongnu.org>; Sat, 31 Dec 2016 04:29:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 47F752E80DD
	for <qemu-devel@nongnu.org>; Sat, 31 Dec 2016 04:29:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Dec 2016 04:17:23 -0000
From: Launchpad Bug Tracker <1047999@bugs.launchpad.net>
Reply-To: Bug 1047999 <1047999@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120908204412.13799.65838.malonedeb@soybean.canonical.com>
Message-Id: <20161231041723.5270.63151.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1047999] Re: error building process in sdlaudio.o
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1047999

Title:
  error building process in sdlaudio.o

Status in QEMU:
  Expired

Bug description:
  ./configure --enable-sdl --enable-virtfs --enable-vnc --enable-cocoa
  --enable-mixemu --enable-brlapi --enable-vnc-tls --enable-vnc-sasl
  --enable-vnc-jpeg --enable-vnc-png --enable-curses --enable-curl
  --enable-bluez --enable-tcg-interpreter --enable-nptl --enable-system
  --enable-user --enable-linux-user --enable-guest-base --enable-pie
  --enable-uuid --enable-vde --enable-attr --enable-docs --enable-vhost-
  net --enable-smartcard --enable-guest-agent --enable-seccomp --audio-
  drv-list=3D"alsa oss sdl esd pa" --audio-card-list=3D"ac97 es1370 sb16
  cs4231a adlib gus hda" --prefix=3D/opt/qemu

  CC    audio/sdlaudio.o
  audio/sdlaudio.c:24:17: warning: SDL.h: File not found
  audio/sdlaudio.c:25:24: warning: SDL_thread.h: File not found
  audio/sdlaudio.c:55: error: expected specifier-qualifier-list before =E2=
=80=98SDL_mutex=E2=80=99
  audio/sdlaudio.c: In function =E2=80=98sdl_logerr=E2=80=99:
  audio/sdlaudio.c:69: warning: implicit declaration of function =E2=80=98S=
DL_GetError=E2=80=99
  audio/sdlaudio.c:69: warning: nested extern declaration of =E2=80=98SDL_G=
etError=E2=80=99
  audio/sdlaudio.c:69: warning: format =E2=80=98%s=E2=80=99 expects type =
=E2=80=98char *=E2=80=99, but argument 3 has type =E2=80=98int=E2=80=99
  audio/sdlaudio.c: In function =E2=80=98sdl_lock=E2=80=99:
  audio/sdlaudio.c:74: warning: implicit declaration of function =E2=80=98S=
DL_LockMutex=E2=80=99
  audio/sdlaudio.c:74: warning: nested extern declaration of =E2=80=98SDL_L=
ockMutex=E2=80=99
  audio/sdlaudio.c:74: error: =E2=80=98SDLAudioState=E2=80=99 has no member=
 named =E2=80=98mutex=E2=80=99
  audio/sdlaudio.c: In function =E2=80=98sdl_unlock=E2=80=99:
  audio/sdlaudio.c:83: warning: implicit declaration of function =E2=80=98S=
DL_UnlockMutex=E2=80=99
  audio/sdlaudio.c:83: warning: nested extern declaration of =E2=80=98SDL_U=
nlockMutex=E2=80=99
  audio/sdlaudio.c:83: error: =E2=80=98SDLAudioState=E2=80=99 has no member=
 named =E2=80=98mutex=E2=80=99
  audio/sdlaudio.c: In function =E2=80=98sdl_post=E2=80=99:
  audio/sdlaudio.c:92: warning: implicit declaration of function =E2=80=98S=
DL_SemPost=E2=80=99
  audio/sdlaudio.c:92: warning: nested extern declaration of =E2=80=98SDL_S=
emPost=E2=80=99
  audio/sdlaudio.c:92: error: =E2=80=98SDLAudioState=E2=80=99 has no member=
 named =E2=80=98sem=E2=80=99
  audio/sdlaudio.c: In function =E2=80=98sdl_wait=E2=80=99:
  audio/sdlaudio.c:101: warning: implicit declaration of function =E2=80=98=
SDL_SemWait=E2=80=99
  audio/sdlaudio.c:101: warning: nested extern declaration of =E2=80=98SDL_=
SemWait=E2=80=99
  audio/sdlaudio.c:101: error: =E2=80=98SDLAudioState=E2=80=99 has no membe=
r named =E2=80=98sem=E2=80=99
  audio/sdlaudio.c: In function =E2=80=98aud_to_sdlfmt=E2=80=99:
  audio/sdlaudio.c:121: error: =E2=80=98AUDIO_S8=E2=80=99 undeclared (first=
 use in this function)
  audio/sdlaudio.c:121: error: (Each undeclared identifier is reported only=
 once
  audio/sdlaudio.c:121: error: for each function it appears in.)
  audio/sdlaudio.c:124: error: =E2=80=98AUDIO_U8=E2=80=99 undeclared (first=
 use in this function)
  audio/sdlaudio.c:127: error: =E2=80=98AUDIO_S16LSB=E2=80=99 undeclared (f=
irst use in this function)
  audio/sdlaudio.c:130: error: =E2=80=98AUDIO_U16LSB=E2=80=99 undeclared (f=
irst use in this function)
  audio/sdlaudio.c: In function =E2=80=98sdl_to_audfmt=E2=80=99:
  audio/sdlaudio.c:144: error: =E2=80=98AUDIO_S8=E2=80=99 undeclared (first=
 use in this function)
  audio/sdlaudio.c:149: error: =E2=80=98AUDIO_U8=E2=80=99 undeclared (first=
 use in this function)
  audio/sdlaudio.c:154: error: =E2=80=98AUDIO_S16LSB=E2=80=99 undeclared (f=
irst use in this function)
  audio/sdlaudio.c:159: error: =E2=80=98AUDIO_U16LSB=E2=80=99 undeclared (f=
irst use in this function)
  audio/sdlaudio.c:164: error: =E2=80=98AUDIO_S16MSB=E2=80=99 undeclared (f=
irst use in this function)
  audio/sdlaudio.c:169: error: =E2=80=98AUDIO_U16MSB=E2=80=99 undeclared (f=
irst use in this function)
  audio/sdlaudio.c: At top level:
  audio/sdlaudio.c:182: error: expected =E2=80=98)=E2=80=99 before =E2=80=
=98*=E2=80=99 token
  audio/sdlaudio.c: In function =E2=80=98sdl_close=E2=80=99:
  audio/sdlaudio.c:222: error: =E2=80=98SDLAudioState=E2=80=99 has no membe=
r named =E2=80=98initialized=E2=80=99
  audio/sdlaudio.c:226: warning: implicit declaration of function =E2=80=98=
SDL_PauseAudio=E2=80=99
  audio/sdlaudio.c:226: warning: nested extern declaration of =E2=80=98SDL_=
PauseAudio=E2=80=99
  audio/sdlaudio.c:227: warning: implicit declaration of function =E2=80=98=
SDL_CloseAudio=E2=80=99
  audio/sdlaudio.c:227: warning: nested extern declaration of =E2=80=98SDL_=
CloseAudio=E2=80=99
  audio/sdlaudio.c:228: error: =E2=80=98SDLAudioState=E2=80=99 has no membe=
r named =E2=80=98initialized=E2=80=99
  audio/sdlaudio.c: At top level:
  audio/sdlaudio.c:232: error: expected declaration specifiers or =E2=80=98=
...=E2=80=99 before =E2=80=98Uint8=E2=80=99
  audio/sdlaudio.c: In function =E2=80=98sdl_callback=E2=80=99:
  audio/sdlaudio.c:274: error: =E2=80=98buf=E2=80=99 undeclared (first use =
in this function)
  audio/sdlaudio.c: In function =E2=80=98sdl_init_out=E2=80=99:
  audio/sdlaudio.c:339: error: =E2=80=98SDL_AudioSpec=E2=80=99 undeclared (=
first use in this function)
  audio/sdlaudio.c:339: error: expected =E2=80=98;=E2=80=99 before =E2=80=
=98req=E2=80=99
  audio/sdlaudio.c:345: error: =E2=80=98req=E2=80=99 undeclared (first use =
in this function)
  audio/sdlaudio.c:352: warning: implicit declaration of function =E2=80=98=
sdl_open=E2=80=99
  audio/sdlaudio.c:352: warning: nested extern declaration of =E2=80=98sdl_=
open=E2=80=99
  audio/sdlaudio.c:352: error: =E2=80=98obt=E2=80=99 undeclared (first use =
in this function)
  audio/sdlaudio.c:370: error: =E2=80=98SDLAudioState=E2=80=99 has no membe=
r named =E2=80=98initialized=E2=80=99
  audio/sdlaudio.c: In function =E2=80=98sdl_audio_init=E2=80=99:
  audio/sdlaudio.c:396: warning: implicit declaration of function =E2=80=98=
SDL_InitSubSystem=E2=80=99
  audio/sdlaudio.c:396: warning: nested extern declaration of =E2=80=98SDL_=
InitSubSystem=E2=80=99
  audio/sdlaudio.c:396: error: =E2=80=98SDL_INIT_AUDIO=E2=80=99 undeclared =
(first use in this function)
  audio/sdlaudio.c:401: error: =E2=80=98SDLAudioState=E2=80=99 has no membe=
r named =E2=80=98mutex=E2=80=99
  audio/sdlaudio.c:401: warning: implicit declaration of function =E2=80=98=
SDL_CreateMutex=E2=80=99
  audio/sdlaudio.c:401: warning: nested extern declaration of =E2=80=98SDL_=
CreateMutex=E2=80=99
  audio/sdlaudio.c:402: error: =E2=80=98SDLAudioState=E2=80=99 has no membe=
r named =E2=80=98mutex=E2=80=99
  audio/sdlaudio.c:404: warning: implicit declaration of function =E2=80=98=
SDL_QuitSubSystem=E2=80=99
  audio/sdlaudio.c:404: warning: nested extern declaration of =E2=80=98SDL_=
QuitSubSystem=E2=80=99
  audio/sdlaudio.c:408: error: =E2=80=98SDLAudioState=E2=80=99 has no membe=
r named =E2=80=98sem=E2=80=99
  audio/sdlaudio.c:408: warning: implicit declaration of function =E2=80=98=
SDL_CreateSemaphore=E2=80=99
  audio/sdlaudio.c:408: warning: nested extern declaration of =E2=80=98SDL_=
CreateSemaphore=E2=80=99
  audio/sdlaudio.c:409: error: =E2=80=98SDLAudioState=E2=80=99 has no membe=
r named =E2=80=98sem=E2=80=99
  audio/sdlaudio.c:411: warning: implicit declaration of function =E2=80=98=
SDL_DestroyMutex=E2=80=99
  audio/sdlaudio.c:411: warning: nested extern declaration of =E2=80=98SDL_=
DestroyMutex=E2=80=99
  audio/sdlaudio.c:411: error: =E2=80=98SDLAudioState=E2=80=99 has no membe=
r named =E2=80=98mutex=E2=80=99
  audio/sdlaudio.c: In function =E2=80=98sdl_audio_fini=E2=80=99:
  audio/sdlaudio.c:423: warning: implicit declaration of function =E2=80=98=
SDL_DestroySemaphore=E2=80=99
  audio/sdlaudio.c:423: warning: nested extern declaration of =E2=80=98SDL_=
DestroySemaphore=E2=80=99
  audio/sdlaudio.c:423: error: =E2=80=98SDLAudioState=E2=80=99 has no membe=
r named =E2=80=98sem=E2=80=99
  audio/sdlaudio.c:424: error: =E2=80=98SDLAudioState=E2=80=99 has no membe=
r named =E2=80=98mutex=E2=80=99
  audio/sdlaudio.c:425: error: =E2=80=98SDL_INIT_AUDIO=E2=80=99 undeclared =
(first use in this function)
  make: *** [audio/sdlaudio.o] Error 1

  System:
  Linux insanelive 3.5.3-iatom-bfq #3 SMP Sat Sep 1 20:30:22 MSK 2012 i686 =
GNU/Linux
  Debian 6.0.5 Squeeze

  SDL headers present:
  ls -m /usr/include/SDL  =

  "begin_code.h", "close_code.h", "SDL_active.h", "SDL_audio.h", "SDL_byteo=
rder.h", "SDL_cdrom.h", "SDL_config.h",
  "SDL_cpuinfo.h", "SDL_endian.h", "SDL_error.h", "SDL_events.h", "SDL_gete=
nv.h", "SDL.h", "SDL_joystick.h", "SDL_keyboard.h",
  "SDL_keysym.h", "SDL_loadso.h", "SDL_main.h", "SDL_mouse.h", "SDL_mutex.h=
", "SDL_name.h", "SDL_opengl.h", "SDL_platform.h",
  "SDL_quit.h", "SDL_rwops.h", "SDL_stdinc.h", "SDL_syswm.h", "SDL_thread.h=
", "SDL_timer.h", "SDL_types.h", "SDL_version.h",
  "SDL_video.h"

  problem is solved by a direct setting of the location of the each
  header files in the source file

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1047999/+subscriptions
