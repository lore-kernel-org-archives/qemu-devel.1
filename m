Received: from eggs.gnu.org ([209.51.188.92]:55053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grk6y-0004eJ-Q2
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:53:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grk6w-0002qo-OI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:53:04 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1grk6w-0002pl-4m
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:53:02 -0500
Received: by mail-wr1-x444.google.com with SMTP id c8so4829741wrs.4
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 05:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20190205182848.29887-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA8zvq6eUVWhAVSmaxKe4hyrDu08m==RbwKXvL+2zBDrnQ@mail.gmail.com>
	<20190207132935.ijtfsiafpfggugiz@function>
In-Reply-To: <20190207132935.ijtfsiafpfggugiz@function>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 7 Feb 2019 14:52:48 +0100
Message-ID: <CAJ+F1CLc0kK30ZVOkksfSBNTbooYGv-Pf1AYwKAntVB4-QUiYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULLv3 00/32] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Hi

On Thu, Feb 7, 2019 at 2:31 PM Samuel Thibault <samuel.thibault@gnu.org> wr=
ote:
>
> Peter Maydell, le jeu. 07 f=C3=A9vr. 2019 11:46:23 +0000, a ecrit:
> > On Tue, 5 Feb 2019 at 18:28, Samuel Thibault
> > <samuel.thibault@ens-lyon.org> wrote:
> > >
> > > The following changes since commit 01a9a51ffaf4699827ea6425cb2b834a35=
6e159d:
> > >
> > >   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190205-pull-=
request' into staging (2019-02-05 14:01:29 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> > >
> > > for you to fetch changes up to 1e924479dce65a26a7432bf5920f89c1bf957d=
74:
> > >
> > >   slirp: API is extern C (2019-02-05 20:27:27 +0200)
> > >
> > > ----------------------------------------------------------------
> > > More work towards libslirp
> > >
> >
> > Format string issues for the Windows build:
>
> Oh, I am not getting these errors with make docker-test-mingw@fedora,
> perhaps something would need to be fixed there to test as much as you do?
>
> > All the other builds went OK.
>
> Good :) I'll have a look at these formatting issues.
>

I am also unable to reproduce yet. Any hint on how to reproduce?

I wonder if this is related to __USE_MINGW_ANSI_STDIO somehow (could
be, although glib doesn't use the same functions, the compiler might
not know the difference)

In any case, we should replace %PRI & %z with glib equivalents under slirp/=
.




--
Marc-Andr=C3=A9 Lureau
