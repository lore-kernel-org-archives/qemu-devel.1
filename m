Received: from eggs.gnu.org ([2001:4830:134:3::10]:50848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dX3ja-0006SA-Na
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:58:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dX3jZ-0004Rk-Pd
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:58:38 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34259)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dX3jZ-0004QL-EV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:58:37 -0400
Received: by mail-lf0-x242.google.com with SMTP id g21so12893553lfk.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 03:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20170717101700.23552-1-kraxel@redhat.com>
	<CAJ+F1C+1pVwXxAH=g_5hx25VXBeMU7irpvkJ+guaqMEc7yS2Ag@mail.gmail.com>
	<1500288560.12570.3.camel@redhat.com>
In-Reply-To: <1500288560.12570.3.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 17 Jul 2017 10:58:25 +0000
Message-ID: <CAJ+F1C+yg2jzSZf4PM8L=5-NBwgg25buHjTS-FBT2hF4jzpkxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] add scripts/indent.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Hi

On Mon, Jul 17, 2017 at 12:49 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Mon, 2017-07-17 at 10:36 +0000, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Jul 17, 2017 at 12:18 PM Gerd Hoffmann <kraxel@redhat.com>
> > wrote:
> > > Script to reformat sources in qemu style.
> > >
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >
> > A quite powerful approach would be to use clang-format: https://lists
> > .gnu.org/archive/html/qemu-devel/2015-10/msg01278.html
> >
> > It comes with a bunch of editor integration and scripts. My config
> > could use a bit more tweaking though, I haven't been using it for a
> > while, and newer version have more options.
>
> Hmm, I want reformat all audio stuff to qemu code style some day, the
> current situation where patches are either break qemu code style or
> lead to mixed-style in the audio source files isn't very good.
>
> I don't mind much which tool we use for that, I picked indent mostly
> because I know that one.  If clang-format can do that too, fine with
> me.  I'm missing documentation though, there is no man-page and there
> isn't anything in /usr/share/doc/clang-3.4.2 either ...
>

Afaik, most of clang-tools documentation is only in html. The most recent
version is online at https://clang.llvm.org/docs/ClangFormat.html &
https://clang.llvm.org/docs/ClangFormatStyleOptions.html

Another advantage of using clang-format, is that it should be used by other
clang refactoring tools (as in my clang-tidy series for ex).


> cheers,
>   Gerd
>
> --
Marc-Andr=C3=A9 Lureau
