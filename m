Received: from eggs.gnu.org ([209.51.188.92]:40550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gsSVH-0007IG-39
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gsSVG-0005VQ-Fm
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:17:07 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gsSVG-0005Ta-8O
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:17:06 -0500
Received: by mail-wm1-x343.google.com with SMTP id a62so8367285wmh.4
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 05:17:06 -0800 (PST)
MIME-Version: 1.0
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
	<20190208181122.23393-5-marcandre.lureau@redhat.com>
	<20190209114041.ibd3adln5vw4iky5@function>
	<CAMxuvaxT-ULfE8-EmVbX1muCrTXyUPQ7V574R9J6gSy0uabg6w@mail.gmail.com>
	<20190209131243.uiob7rzcwi3paw77@function>
In-Reply-To: <20190209131243.uiob7rzcwi3paw77@function>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 9 Feb 2019 14:16:53 +0100
Message-ID: <CAJ+F1C+YcDgNvUnH5j5GdFLcMQDDoEVOdTwVL1R=TQrg0=X44w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH slirp 4/5] slirp: add state saving/loading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi

On Sat, Feb 9, 2019 at 2:13 PM Samuel Thibault <samuel.thibault@gnu.org> wr=
ote:
>
> Marc-Andr=C3=A9 Lureau, le sam. 09 f=C3=A9vr. 2019 14:09:02 +0100, a ecri=
t:
> > On Sat, Feb 9, 2019 at 12:40 PM Samuel Thibault <samuel.thibault@gnu.or=
g> wrote:
> > >
> > > marcandre.lureau@redhat.com, le ven. 08 f=C3=A9vr. 2019 19:11:21 +010=
0, a ecrit:
> > > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > >
> > > > Based on qemu vmstate serialization code. At this point it should
> > > > produce the same result. However, with future state versions, slirp
> > > > should be free to change its format, by bumping the reported state
> > > > version.
> > >
> > > Mmm, then qemu needs to be taught to call slirp_state_save/load/versi=
on?
> >
> > Yes, see "[Qemu-devel] [PATCH 1/1] RFC: net/slirp: link with libslirp"
>
> Ah, I did have a look there but somehow missed it because burried within
> file removals :)
>

Indeed, the original patch series was splited in 2, but I thought as
an RFC it was easier to send a single patch. Bad choice I suppose.



--=20
Marc-Andr=C3=A9 Lureau
