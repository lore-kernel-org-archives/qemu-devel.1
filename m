Received: from eggs.gnu.org ([2001:4830:134:3::10]:35341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGkbd-0004Xn-Gp
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGkbc-0003aE-Bq
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:19:01 -0400
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:34454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dGkbb-0003Z2-Ul
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:19:00 -0400
Received: by mail-lf0-x22d.google.com with SMTP id v20so9209806lfa.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 04:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-5-marcandre.lureau@redhat.com>
	<8737cbv53y.fsf@dusky.pond.sub.org>
	<CAJ+F1C+9WAO2RZt-x7hzzh5M6HBv4UjR6svj71vLJD31axC_Zw@mail.gmail.com>
	<87lgpel8z2.fsf@dusky.pond.sub.org>
	<CAJ+F1C+wcUgiW6QhQUpsA133F+XR8p4wHDHYnr-y11FhRj1Bxg@mail.gmail.com>
	<87h8zyoq92.fsf@dusky.pond.sub.org>
In-Reply-To: <87h8zyoq92.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 02 Jun 2017 11:18:47 +0000
Message-ID: <CAJ+F1CLbKy1YcoHtjTt9noX0EcbA4uc3M6ooXhM3tiSQbLexxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/17] qapi: merge QInt and QFloat in QNum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

Hi

On Fri, Jun 2, 2017 at 10:30 AM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> >
> > On Tue, May 30, 2017 at 6:23 PM Markus Armbruster <armbru@redhat.com>
> wrote:
> >
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> >>
> >> > Hi
> >> >
> >> > On Thu, May 11, 2017 at 6:30 PM Markus Armbruster <armbru@redhat.com=
>
> wrote:
> [...]
> >> >> g_assert_not_reached() is problematic, see "[PATCH] checkpatch:
> Disallow
> >> >> glib asserts in main code".
> >> >>
> >> >> Message-Id: <20170427165526.19836-1-dgilbert@redhat.com>
> >> >> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg05499.html
> >> >>
> >> >>
> >> > Actually g_assert() and g_assert_not_reached() are accepted.
> >>
> >> What exactly does g_assert() buy us over plain assert(), and
> >> g_assert_not_reached() over assert(0)?
> >>
> >
> > g_assert() brings a bit more context, afaik, can be trapped for error
> > testing, and error reporting can be handled by an handler. Not that
> useful
> > to qemu, but could be for the graphical UI though.
> >
> > g_assert_not_reached() is quite more readable than assert(0)
>
> I'm all for making intent explicit, but what else could assert(0)
> possibly mean?
>
> >> qapi/ overwhelmingly uses assert().
> >>
> >
> > ok, it's already a mix of assert & g_assert in qemu though
>
> True.
>
> In my opinion, we should use only one outside tests.  g_assert() if it
> adds value, else plain assert().  "Outside tests", because g_assert()
> might add sufficient value in tests even when it doesn't elsewhere.
>
>
g_assert*() is useful in the unit under test, so you can check the assert
behaviour. This could be useful in particular for the assertions under
qapi/ since we have unit tests for those


> Until then, I prefer to use only one *locally*.  In qapi/, that's plain
> assert() now.
>

ok, fair enough
--=20
Marc-Andr=C3=A9 Lureau
