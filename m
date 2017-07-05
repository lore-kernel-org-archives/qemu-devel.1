Received: from eggs.gnu.org ([2001:4830:134:3::10]:52713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dSghQ-0005OG-1m
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dSghO-0003Ru-Vf
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:34:20 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:32962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dSghO-0003RR-OI
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 05:34:18 -0400
Received: by mail-lf0-x241.google.com with SMTP id t72so20239673lff.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 02:34:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87a84jfob1.fsf@dusky.pond.sub.org>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<87a84jfob1.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Jul 2017 11:34:16 +0200
Message-ID: <CAJ+F1C+j-=E2TKU+WGwXhqXKm5NHMiLDsKwuS8Um3ihSqzOyhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/35] RFC: coroutine annotations & clang
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Wed, Jul 5, 2017 at 7:26 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Hi,
> >
> > After investigating a bit using clang-tidy to do some coroutine checks
> > (and hitting a wall as there are no pre-processor info in the AST), it
> > was suggested to me on the clang mailing list to try to use
> > -Wthread-safety. I had to modify clang a bit to make it work on qemu
> > code base (annotations on function typedef etc,
> > https://github.com/elmarco/clang qemu-ta branch - very hackish state).
>
> Hardcore!

I think the most hardcore part is experimenting with clang code base,
modifying a line, and waiting 10 minutes for the linker (and restart
it if it crashed!). This slows down progress and kill motivation. (so
happy qemu is written in C :)

>
> Are your clang modifications upstreamable once cleaned up?

I am trying to get some help on clang mailing list, but it is very far
from this point without it. My changes are gross (but it seems to do
the job..).

I would be also curious to know how hard a similar (only for this
purpose) check could be implemented for gcc, perhaps with plugins.

>
> > The analysis simply checks that coroutine_fn are called from a
> > coroutine "context" (or "role"). I couldn't find any misuse in qemu
> > code base, however, a number of coroutine_fn annotations are missing.
> >
> > (I think it would make sense to squash all the "mark coroutine_fn"
> > commits if we apply them, I tried to split them by domains/maintainer
> > to ease review)
> [...]
> >  49 files changed, 299 insertions(+), 132 deletions(-)
>
> "A number of coroutine_fn annotations are missing" seems to be an
> understatement :)
>
