Received: from eggs.gnu.org ([2001:4830:134:3::10]:33252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dKihb-0005eM-UX
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dKihX-0007pP-8O
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:05:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dKihX-0007p0-2c
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:05:31 -0400
References: <20170608115939.30985-1-marcandre.lureau@redhat.com>
	<9e20350b-aac2-b099-ebac-03e61ad1d79e@redhat.com>
	<CAJ+F1CLAM+wNS3oL=VJYs+d6FziXY4wH1=6pmqHuLHrkz4zigg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <503ea7db-b9d7-7666-3485-dbc3ef77378f@redhat.com>
Date: Tue, 13 Jun 2017 12:05:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLAM+wNS3oL=VJYs+d6FziXY4wH1=6pmqHuLHrkz4zigg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, Peter Maydell <peter.maydell@linaro.org>



On 12/06/2017 21:01, Marc-Andr=C3=A9 Lureau wrote:
> Hi Paolo
>=20
> On Mon, Jun 12, 2017 at 8:06 PM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>=20
>=20
>     On 08/06/2017 13:59, Marc-Andr=C3=A9 Lureau wrote:
>     > Hi,
>     >
>     > The patch "char: move CharBackend handling in char-fe unit" broke
>     > chardev aliases. Here is a small series to fix it, and add a simp=
le
>     > unit test to check the alias keep working.
>     >
>     > v2:
>     > - move HAVE_CHARDEV_* in osdep.h (Markus Armbruster)
>     > - add r-b tags from Eric for the patches that didn't change
>     >
>     > Marc-Andr=C3=A9 Lureau (3):
>     >   char: fix alias devices regression
>     >   chardev: don't use alias names in parse_compat()
>     >   test-char: start a /char/serial test
>     >
>     >  include/chardev/char-parallel.h |  5 -----
>     >  include/chardev/char-serial.h   |  8 --------
>     >  include/qemu/osdep.h            | 13 +++++++++++++
>     >  chardev/char.c                  |  4 ++--
>     >  tests/test-char.c               | 30 +++++++++++++++++++++++++++=
+++
>     >  5 files changed, 45 insertions(+), 15 deletions(-)
>     >
>=20
>     Queued, thanks.
>=20
>=20
> I also sent a pull request with those patches "[PULL0/3] Charpatches" a
> few days ago. I should take the habit to notice it on the PATCH series.

No problem, I would have noticed sooner or later. :)

Paolo
