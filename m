Received: from eggs.gnu.org ([2001:4830:134:3::10]:47366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dVcLe-0004Fu-Mp
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dVcLZ-00049d-Pn
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:31:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dVcLZ-00049R-Jo
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:31:53 -0400
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
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <06cbc0c4-73bc-d527-a466-de5a05b0641e@redhat.com>
Date: Thu, 13 Jul 2017 13:31:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ZiTqAGS01Rtu8Vv9FHKXtUXwfc9mULkCkanQzirB14Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Peter Maydell <peter.maydell@linaro.org>, Ben Warren <ben@skyportsystems.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 07/13/17 12:47, Peter Maydell wrote:
> On 12 July 2017 at 00:43, Ben Warren <ben@skyportsystems.com> wrote:
>> Yes, it=E2=80=99s definitely a setup time problem.  With the values th=
at are checked
>> in, I can=E2=80=99t get it to fail on my setup, but if I wind the numb=
ers down I see
>> the same failure as Peter.  So now we have the ages-old problem of =E2=
=80=9Cwhat new
>> arbitrary value should I use that will not cause false failures but wi=
ll
>> eventually time out=E2=80=9D.
>=20
> Empirically, we already have an answer to this, in the form
> of the existing code in tests/boot-sector.c, which is used
> by both that test and the bios-tables-test.c code to wait
> for the BIOS initialization to complete, and which doesn't
> cause false test timeouts in practice.
>=20
> Can we make this test just use that existing function to
> wait for the BIOS to be done, rather than having its own
> timeout loop?

This is incredibly cool. Now that I've looked at "tests/boot-sector.c"
(again), I recall having seen it earlier, but I couldn't have remembered
it off-hand.

Perhaps this boot sector code should be factored out and moved to
"tests/acpi-utils".

Marc-Andr=C3=A9, do you think it would be feasible for the vmcoreinfo uni=
t
test as well? (Which is derived from the vmgenid unit test.)

Thanks!
Laszlo
