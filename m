Received: from eggs.gnu.org ([2001:4830:134:3::10]:55685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpW52-0007gh-8a
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpW51-0005on-Ah
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:53:04 -0400
Date: Wed, 6 Sep 2017 10:52:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170906085259.GB3753@dhcp-200-186.str.redhat.com>
References: <CAJ+F1C+mPu9ftXwgs4UrGTQp4f65-thhvmWoB-kuRmu0=vnFFw@mail.gmail.com>
	<87zia9palk.fsf@dusky.pond.sub.org>
	<CAJ+F1CJaxdbHnLQy6H=5=Q3ZMw0w01xsvK3ybhj80=6F9dR6gQ@mail.gmail.com>
	<87fuc1ma7d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87fuc1ma7d.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] clang-tidy: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, qemu trival <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>

Am 05.09.2017 um 17:33 hat Markus Armbruster geschrieben:
> Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> writes:
> > code base). I find it easier to write a tidy check, and more friendly
> > command line / output etc:
> >
> > /tmp/test.c:3:17: warning: use g_new() instead [qemu-use-gnew]
> >         int *f =3D (int*)malloc(sizeof(int) * 2);
> >                  ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
> >                  g_new(int, 2)
> >
> > clang-tidy should also respect clang-format rules when modifying the =
code
> > (see also
> > https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg05762.htm=
l).
> >
> > I also imagine it should be possible to integrate to clang warnings i=
n the
> > future (similar to libreoffice clang plugins for ex). All in all,
> > coccinelle or clang-tidy are probably both capable of doing this job,=
 but
> > clang-tidy is snappier and has more potentials for toolchain integrat=
ion.
>=20
> Suggest you show us cool things you can do with clang-tidy that haven't
> been done with Coccinelle :)

Well, I don't really know clang-tidy, but if the above is what it does,
that _is_ cool. With Coccinelle scripts you run the script from time to
time and remove any new offenders. But if clang-tidy allows us to turn
any new offender into a build error so that they don't even make it into
master, then to me that's way superior.

Not all users are using clang, obviously, so even if we can
automatically enable this for clang, not everyone would see the
warnings. But if we can make some patchew hosts use it, that would
already be enough to catch those things.

Unless I'm misinterpreting what Marc-Andr=E9 is saying and running
clang-tidy actually requires more than is reasonable for patchew.

Kevin
