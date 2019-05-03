Received: from eggs.gnu.org ([209.51.188.92]:55446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXl9-0003rY-03
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXl8-0006L2-1g
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:57:50 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMXl6-0006IL-6O
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:57:48 -0400
Received: by mail-oi1-x241.google.com with SMTP id 143so4328257oii.4
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190425145420.8888-1-stefanha@redhat.com>
	<20190501162055.GB21155@stefanha-x1.localdomain>
	<CAFEAcA8Go-8Ux9AGzw5CGiU3wDyAQSrV1HOb0gbZP8+b06-EPQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8Go-8Ux9AGzw5CGiU3wDyAQSrV1HOb0gbZP8+b06-EPQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 13:57:36 +0100
Message-ID: <CAFEAcA--Gn=7aAH1i28sr7ifk23vprw24rqO7TTs=8D7hKG95g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] gitmodules: use qemu.org git mirrors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Thu, 2 May 2019 at 11:11, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Wed, 1 May 2019 at 17:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Thu, Apr 25, 2019 at 03:54:20PM +0100, Stefan Hajnoczi wrote:
> > > qemu.org hosts git repository mirrors of all submodules.  Update
> > > .gitmodules to use the mirrors and not the upstream repositories.
> > >
> > > Mirroring upstream repositories ensures that QEMU continues to build
> > > even when upstream repositories are deleted or temporarily offline.
> > >
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > ---
> > >  .gitmodules | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > Ping?

> This won't apply because currently master's .gitmodules
> has no [submodule "slirp"] entry. I was assuming you'd
> ping or repost once the slirp changes went in.

The slirp changes are now in master, so I've applied this.

thanks
-- PMM
