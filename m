Received: from eggs.gnu.org ([209.51.188.92]:39958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grkuU-0000XN-8V
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grkuT-0005aF-I8
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:44:14 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1grkuT-0005Yi-74
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:44:13 -0500
Received: by mail-wm1-x341.google.com with SMTP id f16so103573wmh.4
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 06:44:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549545591.git.berto@igalia.com>
	<c741408825d01f5a186901c5a8248126ffebe9fd.1549545591.git.berto@igalia.com>
	<CAMxuvayhuXEWTvJqNyKFjuae3u47MnjN4NPQ_J+vVWLK9pM5Rg@mail.gmail.com>
	<CAMxuvawnNqvUYf2Z-+8zX63wRNFp+F_A7Uo==pY_9n1HDXumqQ@mail.gmail.com>
	<w51ftszhdwg.fsf@maestria.local.igalia.com>
In-Reply-To: <w51ftszhdwg.fsf@maestria.local.igalia.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 7 Feb 2019 15:43:59 +0100
Message-ID: <CAJ+F1CKA_WuJog780XFWXG3VHTtUzjMw8e+X_GPoWdMrQygY1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] main-loop: Don't leak GSources
 attached to a GMainContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hi

On Thu, Feb 7, 2019 at 3:37 PM Alberto Garcia <berto@igalia.com> wrote:
>
> On Thu 07 Feb 2019 03:24:40 PM CET, Marc-Andr=C3=A9 Lureau wrote:
> > On Thu, Feb 7, 2019 at 3:23 PM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> >>
> >> On Thu, Feb 7, 2019 at 2:23 PM Alberto Garcia <berto@igalia.com> wrote=
:
> >> >
> >> > After g_source_attach() the GMainContext holds a reference to the
> >> > GSource, so the caller does not need to keep it.
> >> >
> >> > pty_chr_state() and qio_task_thread_worker() are not doing this, so
> >> > the GSource is being leaked in both cases (pty_chr_open_src_cancel()
> >> > is the exception here because it does remove the extra reference
> >> > correctly).
> >> >
> >> > Signed-off-by: Alberto Garcia <berto@igalia.com>
> >>
> >> You could mention this is a fix for regression from
> >> a17536c594bfed94d05667b419f747b692f5fc7f
> >
> > and 938eb9e9c83d34d90cac6ec5c5388e7998840e4e
>
> Ok, feel free to add this to the commit message if I don't need to
> resend the series.

Well, the series conflicts with the currently queued chardev series. I
think I will send the pullreq and let you rebase.

(I also have a related series pending review "[PATCH v2 0/6] chardev:
various cleanups and improvements")


--=20
Marc-Andr=C3=A9 Lureau
