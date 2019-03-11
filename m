Received: from eggs.gnu.org ([209.51.188.92]:35835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h3KOK-0005dU-QN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h3KOJ-00014N-Ow
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:50:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:46439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1h3KOJ-00013O-FN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 08:50:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id i16so4928091wrs.13
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 05:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181127135037eucas1p18867a9ae8b1f2731ad4ce8d79fddae33@eucas1p1.samsung.com>
	<20181127135030.1671-1-i.maximets@samsung.com>
	<1fa60eac-9718-ee9d-e21c-3331c3bd60ff@samsung.com>
In-Reply-To: <1fa60eac-9718-ee9d-e21c-3331c3bd60ff@samsung.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Mar 2019 13:50:37 +0100
Message-ID: <CAJ+F1CKBJZ504S5sPvgXfcJvLkG1XpzJ499H54hT4cLffdm+Og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] memfd fixes.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi

On Mon, Mar 11, 2019 at 1:35 PM Ilya Maximets <i.maximets@samsung.com> wrot=
e:
>
> Hi.
>
> I'm trying to figure out the state of this patch set.
> Is there any chance for it to be accepted?
>
> The first patch needs minor rebase. I could send a new version.

Please do,

I prefer the solution proposed in v2: do not register hostmem-memfd if
sealing isn't supported (keep sealing=3Dtrue the default - it's one of
the main purpose of memfd imho).

Daniel, Eduardo: are you ok with this series for 4.0?

>
> BTW, even without the first patch that raised some discussion
> the last three patches are kind of straightforward and useful.
>
> Best regards, Ilya Maximets.
>
> On 27.11.2018 16:50, Ilya Maximets wrote:
> > Version 2:
> >     * First patch changed to just drop the memfd backend
> >       if seals are not supported.
> >
> > Ilya Maximets (4):
> >   hostmem-memfd: disable for systems wihtout sealing support
> >   memfd: always check for MFD_CLOEXEC
> >   memfd: set up correct errno if not supported
> >   memfd: improve error messages
> >
> >  backends/hostmem-memfd.c | 18 ++++++++----------
> >  tests/vhost-user-test.c  |  6 +++---
> >  util/memfd.c             | 10 ++++++++--
> >  3 files changed, 19 insertions(+), 15 deletions(-)
> >
>


--=20
Marc-Andr=C3=A9 Lureau
