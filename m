Received: from eggs.gnu.org ([2001:4830:134:3::10]:56470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etAzR-0008LI-Tu
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etAzO-0007LL-QJ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:42:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etAzO-0007L2-Li
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:42:38 -0500
Date: Tue, 6 Mar 2018 12:42:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180306114232.v5gtwxald4mmelab@sirius.home.kraxel.org>
References: <20180306074053.22856-1-kraxel@redhat.com>
	<CAJ+F1CK5MsZ5=-z2yWznBcHjZqskHSdiyYxC30azEcQ9AXrRLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK5MsZ5=-z2yWznBcHjZqskHSdiyYxC30azEcQ9AXrRLg@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Tue, Mar 06, 2018 at 12:22:49PM +0100, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Tue, Mar 6, 2018 at 8:40 AM, Gerd Hoffmann <kraxel@redhat.com> wrote=
:
> > Add audio driver (host backend) registry.  Add audio module support.
> > Enable module builds for alsa, oss, pulse and sdl.
> >
> > Gerd Hoffmann (7):
> >   audio: add driver registry
> >   audio: add module loading support
> >   build: enable audio modules
> >   audio/alsa: build as module
> >   audio/oss: build as module
> >   audio/pulseaudio: build as module
> >   audio/sdl: build as module
> >
>=20
> Is this a problem on my side? (configure
> '--audio-drv-list=3Doss,alsa,pa,sdl' '--enable-modules')
>=20
> elmarco@boraha:~/src/qemu/build (master %)$
> x86_64-softmmu/qemu-system-x86_64 -audio-help
> Failed to open module:
> /home/elmarco/src/qemu/build/x86_64-softmmu/../audio-oss.so: undefined
> symbol: _TRACE_OSS_INVALID_AVAILABLE_SIZE_DSTATE
> Failed to open module:
> /home/elmarco/src/qemu/build/x86_64-softmmu/../audio-alsa.so:
> undefined symbol: _TRACE_ALSA_XRUN_OUT_DSTATE
> Failed to open module:
> /home/elmarco/src/qemu/build/x86_64-softmmu/../audio-pa.so: undefined
> symbol: audio_pt_unlock_and_signal
> Failed to open module:
> /home/elmarco/src/qemu/build/x86_64-softmmu/../audio-sdl.so: undefined
> symbol: audio_pcm_sw_write

Works fine here.  Tried "make clean && make"?

Qemu build system seems to not rebuild object files when the compiler
flags change.  So you can't switch between --enable-modules and
--disable-modules without "make clean" inbetween.  Same issue when
patches switch code from compiled-in to modular and you try an
incremental build.

I've seen only build failues due to this, not module load errors.  But
possibly only because I stopped doing incremental builds when working on
module patches ...

cheers,
  Gerd
