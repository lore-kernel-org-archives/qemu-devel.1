Received: from eggs.gnu.org ([2001:4830:134:3::10]:42841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dKUav-0004bE-3z
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dKUau-0002RA-4B
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:01:45 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dKUat-0002QL-SZ
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 15:01:44 -0400
Received: by mail-lf0-x243.google.com with SMTP id o28so10224358lfk.1
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 12:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20170608115939.30985-1-marcandre.lureau@redhat.com>
	<9e20350b-aac2-b099-ebac-03e61ad1d79e@redhat.com>
In-Reply-To: <9e20350b-aac2-b099-ebac-03e61ad1d79e@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Jun 2017 19:01:28 +0000
Message-ID: <CAJ+F1CLAM+wNS3oL=VJYs+d6FziXY4wH1=6pmqHuLHrkz4zigg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] char: fix chardev aliases regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, Peter Maydell <peter.maydell@linaro.org>

Hi Paolo

On Mon, Jun 12, 2017 at 8:06 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

>
>
> On 08/06/2017 13:59, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > The patch "char: move CharBackend handling in char-fe unit" broke
> > chardev aliases. Here is a small series to fix it, and add a simple
> > unit test to check the alias keep working.
> >
> > v2:
> > - move HAVE_CHARDEV_* in osdep.h (Markus Armbruster)
> > - add r-b tags from Eric for the patches that didn't change
> >
> > Marc-Andr=C3=A9 Lureau (3):
> >   char: fix alias devices regression
> >   chardev: don't use alias names in parse_compat()
> >   test-char: start a /char/serial test
> >
> >  include/chardev/char-parallel.h |  5 -----
> >  include/chardev/char-serial.h   |  8 --------
> >  include/qemu/osdep.h            | 13 +++++++++++++
> >  chardev/char.c                  |  4 ++--
> >  tests/test-char.c               | 30 ++++++++++++++++++++++++++++++
> >  5 files changed, 45 insertions(+), 15 deletions(-)
> >
>
> Queued, thanks.
>

I also sent a pull request with those patches "[PULL 0/3] Char patches" a
few days ago. I should take the habit to notice it on the PATCH series.

Thanks
--=20
Marc-Andr=C3=A9 Lureau
