Received: from eggs.gnu.org ([2001:4830:134:3::10]:44782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVh8T-0008J0-2P
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dVh8P-00017H-51
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:38:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dVh8O-00016d-RU
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:38:37 -0400
Date: Thu, 13 Jul 2017 19:38:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170713191304-mutt-send-email-mst@kernel.org>
References: <CAFEAcA8-o28j-FvHWz3=nZX_pO=+XOc_6MnmyFWB324+G7Ppqw@mail.gmail.com>
	<CAFEAcA-ireu_2fW00dX=Z3hu4Jongftab_ysymbJMB0893M4Ww@mail.gmail.com>
	<20170711220915-mutt-send-email-mst@kernel.org>
	<CAFEAcA_-hCV2Ogy3BS2RV4_AWYYQDT+fCNChVcz8uKZ8-VxhWA@mail.gmail.com>
	<273a7da7-2243-171f-e96d-39e8e8031984@redhat.com>
	<3CA8C399-80D0-4BC8-ACC6-FD72A09D9685@skyportsystems.com>
	<CAFEAcA8ZiTqAGS01Rtu8Vv9FHKXtUXwfc9mULkCkanQzirB14Q@mail.gmail.com>
	<06cbc0c4-73bc-d527-a466-de5a05b0641e@redhat.com>
	<CAJ+F1CJaRE2hAJUxfeqLYi3Bj46E9nRUOdyWxPHbHQS6oDoQEg@mail.gmail.com>
	<00D9C394-98C2-4AC0-99A9-427117B678F9@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00D9C394-98C2-4AC0-99A9-427117B678F9@skyportsystems.com>
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
To: Ben Warren <ben@skyportsystems.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jul 13, 2017 at 06:34:33AM -0700, Ben Warren wrote:
> Hi,
>=20
>     On Jul 13, 2017, at 4:51 AM, Marc-Andr=C3=A9 Lureau <marcandre.lure=
au@gmail.com>
>     wrote:
>=20
>     Hi
>=20
>     On Thu, Jul 13, 2017 at 1:32 PM Laszlo Ersek <lersek@redhat.com> wr=
ote:
>=20
>         On 07/13/17 12:47, Peter Maydell wrote:
>         > On 12 July 2017 at 00:43, Ben Warren <ben@skyportsystems.com>=
 wrote:
>         >> Yes, it=E2=80=99s definitely a setup time problem.  With the=
 values that are
>         checked
>         >> in, I can=E2=80=99t get it to fail on my setup, but if I win=
d the numbers
>         down I see
>         >> the same failure as Peter.  So now we have the ages-old prob=
lem of
>         =E2=80=9Cwhat new
>         >> arbitrary value should I use that will not cause false failu=
res but
>         will
>         >> eventually time out=E2=80=9D.
>         >
>         > Empirically, we already have an answer to this, in the form
>         > of the existing code in tests/boot-sector.c, which is used
>         > by both that test and the bios-tables-test.c code to wait
>         > for the BIOS initialization to complete, and which doesn't
>         > cause false test timeouts in practice.
>         >
>         > Can we make this test just use that existing function to
>         > wait for the BIOS to be done, rather than having its own
>         > timeout loop?
>=20
>         This is incredibly cool. Now that I've looked at "tests/boot-se=
ctor.c"
>         (again), I recall having seen it earlier, but I couldn't have
>         remembered
>         it off-hand.
>=20
>         Perhaps this boot sector code should be factored out and moved =
to
>         "tests/acpi-utils".
>=20
>         Marc-Andr=C3=A9, do you think it would be feasible for the vmco=
reinfo unit
>         test as well? (Which is derived from the vmgenid unit test.)
>=20
>=20
>     It seems likely.
>=20
>     Ben, are you going to work on the fix?
>=20
>=20
> Yes, I will take care of this.  I remember seeing the boot-sector
> synchronization code before, but didn=E2=80=99t really grok it.  This t=
ime I=E2=80=99ll dig
> deeper.

It's already a library, I don't think you need changes or refactoring.
You can just link boot_sector.c and call boot_sector_test like the pxe
test does. If this passes you know all acpi tables are in memory.

I'll post a patch.

There's no clever logic around timeout there though - right now your
timeout is 10 seconds while boot_sector_test has a timeout of 90
seconds.

So it is still worth improving to check the per-thread clock imho,
but I agree it's best to rework vm gen id test.
While at it, I think it's best to drop the assumption that vmgenid
is the 1st table in the ssdt.

>     Thanks
>     --=20
>     Marc-Andr=C3=A9 Lureau
>=20
>=20
> =E2=80=94Ben
>=20
