Received: from eggs.gnu.org ([2001:4830:134:3::10]:43973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZl1Y-0000HR-Qj
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 18:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZl1U-0000HD-6Q
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 18:13:08 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gZl1T-0000Gc-W7
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 18:13:04 -0500
Received: by mail-yb1-f196.google.com with SMTP id h10so8577837ybp.6
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20170809202712.6951-1-f4bug@amsat.org>
	<20170809202712.6951-13-f4bug@amsat.org>
	<CAAdtpL7UE2dGie9zYOx3=L98vFr16dyrk2cdLZi1Nu58i+9DOQ@mail.gmail.com>
	<CAFEAcA98P9ZagjLTMvAMDdKiktUp3hQPjO0rq9qBXBc7SHO3jg@mail.gmail.com>
In-Reply-To: <CAFEAcA98P9ZagjLTMvAMDdKiktUp3hQPjO0rq9qBXBc7SHO3jg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 20 Dec 2018 00:12:51 +0100
Message-ID: <CAAdtpL5FtLunqQcru3+ZBL1HGL=8ZYtjZs0MPkAikqB_tBGu1A@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Dec 19, 2018 at 11:42 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On Wed, 19 Dec 2018 at 21:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> >
> > Hey Alex, Peter, what do you think about this patch?
> >
> > On Wed, Aug 9, 2017 at 10:27 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> > >
> > >   $ make info
> > >     GEN     qemu-doc.html
> > >   qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.
> > >     GEN     qemu-doc.txt
> > >   qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.
> > >
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > ---
> > >  .travis.yml | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/.travis.yml b/.travis.yml
> > > index 4bf69b0116..24f62fb7cf 100644
> > > --- a/.travis.yml
> > > +++ b/.travis.yml
> > > @@ -74,9 +74,11 @@ git:
> > >    # we want to do this ourselves
> > >    submodules: false
> > >  before_install:
> > > +  # silent texinfo warnings (https://github.com/xiaohanyu/oh-my-emac=
s/blob/c664894e2f1c1cb0f95a9f2da88d41b00f190856/core/ome-basic.org#homebrew=
)
> > >    - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then
> > >          brew update ;
> > > -        brew install libffi gettext glib pixman ;
> > > +        brew install libffi gettext glib pixman texinfo ;
> > > +        brew link texinfo --force ;
> > >      fi
>
> The commit message is a bit lacking in detail about how it's
> fixing things. IIRC this message is caused because the stock
> OSX texinfo is too old, so installing a newer version via
> brew makes sense. But what does the "brew link" command do?

This was more than 1 year ago, now I try/force myself to write more
verbose commit message...
I don't remember exactly why I added the 'link' and will have to check
again (another thing I learned, write commit message for your self,
else you won't remember in 1 year ahead...).
I'm trying to reduce OSX warnings, as of current QEMU master I count
80 warnings using Xcode 10, which result in me not looking at them (or
worst, at new ones...).
I'll include this patch reworded in an OSX cleanup series.
Thanks,
Phil.
