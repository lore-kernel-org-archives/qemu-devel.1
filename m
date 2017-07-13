Received: from eggs.gnu.org ([2001:4830:134:3::10]:33870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dVeHk-000833-Mr
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dVeHf-0005Dm-Pu
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:36:04 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1dVeHf-00051m-I1
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:35:59 -0400
Received: by mail-oi0-f43.google.com with SMTP id x187so45859988oig.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:35:36 -0700 (PDT)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <00D9C394-98C2-4AC0-99A9-427117B678F9@skyportsystems.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Thu, 13 Jul 2017 06:34:33 -0700
In-Reply-To: <CAJ+F1CJaRE2hAJUxfeqLYi3Bj46E9nRUOdyWxPHbHQS6oDoQEg@mail.gmail.com>
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
	<CAJ+F1CJaRE2hAJUxfeqLYi3Bj46E9nRUOdyWxPHbHQS6oDoQEg@mail.gmail.com>
Content-Type: text/plain;
	charset=utf-8
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
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

Hi,
> On Jul 13, 2017, at 4:51 AM, Marc-Andr=C3=A9 Lureau =
<marcandre.lureau@gmail.com> wrote:
>=20
> Hi
>=20
> On Thu, Jul 13, 2017 at 1:32 PM Laszlo Ersek <lersek@redhat.com =
<mailto:lersek@redhat.com>> wrote:
> On 07/13/17 12:47, Peter Maydell wrote:
> > On 12 July 2017 at 00:43, Ben Warren <ben@skyportsystems.com =
<mailto:ben@skyportsystems.com>> wrote:
> >> Yes, it=E2=80=99s definitely a setup time problem.  With the values =
that are checked
> >> in, I can=E2=80=99t get it to fail on my setup, but if I wind the =
numbers down I see
> >> the same failure as Peter.  So now we have the ages-old problem of =
=E2=80=9Cwhat new
> >> arbitrary value should I use that will not cause false failures but =
will
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
>=20
> This is incredibly cool. Now that I've looked at "tests/boot-sector.c"
> (again), I recall having seen it earlier, but I couldn't have =
remembered
> it off-hand.
>=20
> Perhaps this boot sector code should be factored out and moved to
> "tests/acpi-utils".
>=20
> Marc-Andr=C3=A9, do you think it would be feasible for the vmcoreinfo =
unit
> test as well? (Which is derived from the vmgenid unit test.)
>=20
> It seems likely.
>=20
> Ben, are you going to work on the fix?
>=20
Yes, I will take care of this.  I remember seeing the boot-sector =
synchronization code before, but didn=E2=80=99t really grok it.  This =
time I=E2=80=99ll dig deeper.
> Thanks
> --=20
> Marc-Andr=C3=A9 Lureau

=E2=80=94Ben
