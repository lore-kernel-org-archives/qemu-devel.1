Received: from eggs.gnu.org ([209.51.188.92]:49707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.kanavin@gmail.com>) id 1gjjXp-0007vE-4J
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.kanavin@gmail.com>) id 1gjjXk-0002Vs-Cm
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:39:38 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.kanavin@gmail.com>)
	id 1gjjXj-0002Ng-Rk
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:39:36 -0500
Received: by mail-ot1-x344.google.com with SMTP id s5so6650974oth.7
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 03:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20190115115047.39326-1-alex.kanavin@gmail.com>
	<bde5dc1a-2ec3-98fa-1b4c-9147ddbadd86@redhat.com>
	<CANNYZj8RLr0ZQJjgXD065WzuYUHbi-dCN1-j_gQNq+28U9h6Qw@mail.gmail.com>
	<20190116055311.go6kwaemxfvbgtbb@sirius.home.kraxel.org>
	<85a3b4c9-017a-edbd-d991-172dc1528a7c@redhat.com>
In-Reply-To: <85a3b4c9-017a-edbd-d991-172dc1528a7c@redhat.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 16 Jan 2019 12:39:15 +0100
Message-ID: <CANNYZj-dgqK8bNTCLRFMz0cTuJ9QEqrEY--SydpGq7pES1NdwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] egl-helpers.h: add a missing X11 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Wed, 16 Jan 2019 at 12:10, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:

> >> we build mesa explicitly using "--with-platforms=3D'drm surfaceless'"
> >> (x11 is not in the list), which means MESA_EGL_NO_X11_HEADERS is
> >> indeed defined according to [1]. We also enable opengl and gtk in
> >> qemu.
> >
> > Hmm, should we use EGLNativeWindowType instead of Window then?
>
> Yes, I prefer this too but was not sure you'd like that :)
>
> Alexander do you want to write the patch or should I?

I just sent the patch; I am not subscribed to qemu-devel so might take
a moment to get through moderation (I suppose?).

Alex
