Received: from eggs.gnu.org ([2001:4830:134:3::10]:52968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dVcfX-0002tV-NJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dVcfT-0007dL-RY
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:52:31 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dVcfT-0007cE-Gp
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:52:27 -0400
Received: by mail-lf0-f45.google.com with SMTP id b207so35153648lfg.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 04:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-20-git-send-email-mst@redhat.com>
	<CAFEAcA_giHFa-aw=WuuqmVFL+dr7HeD9E1o=oLszQywJbAd0wA@mail.gmail.com>
	<7EC3FA95-777F-4F8F-B02D-85FA09BAFC00@skyportsystems.com>
	<CAFEAcA8-o28j-FvHWz3=nZX_pO=+XOc_6MnmyFWB324+G7Ppqw@mail.gmail.com>
	<CAFEAcA-ireu_2fW00dX=Z3hu4Jongftab_ysymbJMB0893M4Ww@mail.gmail.com>
	<20170711220915-mutt-send-email-mst@kernel.org>
	<CAFEAcA_-hCV2Ogy3BS2RV4_AWYYQDT+fCNChVcz8uKZ8-VxhWA@mail.gmail.com>
	<273a7da7-2243-171f-e96d-39e8e8031984@redhat.com>
	<3CA8C399-80D0-4BC8-ACC6-FD72A09D9685@skyportsystems.com>
	<CAFEAcA8ZiTqAGS01Rtu8Vv9FHKXtUXwfc9mULkCkanQzirB14Q@mail.gmail.com>
	<06cbc0c4-73bc-d527-a466-de5a05b0641e@redhat.com>
In-Reply-To: <06cbc0c4-73bc-d527-a466-de5a05b0641e@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 13 Jul 2017 11:51:12 +0000
Message-ID: <CAJ+F1CJaRE2hAJUxfeqLYi3Bj46E9nRUOdyWxPHbHQS6oDoQEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 19/21] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Thu, Jul 13, 2017 at 1:32 PM Laszlo Ersek <lersek@redhat.com> wrote:

> On 07/13/17 12:47, Peter Maydell wrote:
> > On 12 July 2017 at 00:43, Ben Warren <ben@skyportsystems.com> wrote:
> >> Yes, it=E2=80=99s definitely a setup time problem.  With the values th=
at are
> checked
> >> in, I can=E2=80=99t get it to fail on my setup, but if I wind the numb=
ers down
> I see
> >> the same failure as Peter.  So now we have the ages-old problem of
> =E2=80=9Cwhat new
> >> arbitrary value should I use that will not cause false failures but wi=
ll
> >> eventually time out=E2=80=9D.
> >
> > Empirically, we already have an answer to this, in the form
> > of the existing code in tests/boot-sector.c, which is used
> > by both that test and the bios-tables-test.c code to wait
> > for the BIOS initialization to complete, and which doesn't
> > cause false test timeouts in practice.
> >
> > Can we make this test just use that existing function to
> > wait for the BIOS to be done, rather than having its own
> > timeout loop?
>
> This is incredibly cool. Now that I've looked at "tests/boot-sector.c"
> (again), I recall having seen it earlier, but I couldn't have remembered
> it off-hand.
>
> Perhaps this boot sector code should be factored out and moved to
> "tests/acpi-utils".
>
> Marc-Andr=C3=A9, do you think it would be feasible for the vmcoreinfo uni=
t
> test as well? (Which is derived from the vmgenid unit test.)
>

It seems likely.

Ben, are you going to work on the fix?

Thanks
--=20
Marc-Andr=C3=A9 Lureau
