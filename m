Received: from eggs.gnu.org ([2001:4830:134:3::10]:36507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZkYK-0002ie-Iq
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 17:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZkYJ-0004vJ-LV
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 17:42:56 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZkYJ-0004v3-Gd
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 17:42:55 -0500
Received: by mail-oi1-x243.google.com with SMTP id c206so3010700oib.0
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 14:42:55 -0800 (PST)
MIME-Version: 1.0
References: <20170809202712.6951-1-f4bug@amsat.org>
	<20170809202712.6951-13-f4bug@amsat.org>
	<CAAdtpL7UE2dGie9zYOx3=L98vFr16dyrk2cdLZi1Nu58i+9DOQ@mail.gmail.com>
In-Reply-To: <CAAdtpL7UE2dGie9zYOx3=L98vFr16dyrk2cdLZi1Nu58i+9DOQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Dec 2018 22:42:43 +0000
Message-ID: <CAFEAcA98P9ZagjLTMvAMDdKiktUp3hQPjO0rq9qBXBc7SHO3jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 12/16] travis/osx: silent
 texinfo warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 19 Dec 2018 at 21:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Hey Alex, Peter, what do you think about this patch?
>
> On Wed, Aug 9, 2017 at 10:27 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >
> >   $ make info
> >     GEN     qemu-doc.html
> >   qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.
> >     GEN     qemu-doc.txt
> >   qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  .travis.yml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index 4bf69b0116..24f62fb7cf 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -74,9 +74,11 @@ git:
> >    # we want to do this ourselves
> >    submodules: false
> >  before_install:
> > +  # silent texinfo warnings (https://github.com/xiaohanyu/oh-my-emacs/=
blob/c664894e2f1c1cb0f95a9f2da88d41b00f190856/core/ome-basic.org#homebrew)
> >    - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then
> >          brew update ;
> > -        brew install libffi gettext glib pixman ;
> > +        brew install libffi gettext glib pixman texinfo ;
> > +        brew link texinfo --force ;
> >      fi

The commit message is a bit lacking in detail about how it's
fixing things. IIRC this message is caused because the stock
OSX texinfo is too old, so installing a newer version via
brew makes sense. But what does the "brew link" command do?

thanks
-- PMM
