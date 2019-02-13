Received: from eggs.gnu.org ([209.51.188.92]:48953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtzfr-0003tz-Gc
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:54:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtzfp-00047a-6i
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:54:23 -0500
References: <20190212173839.31587-1-chouteau@adacore.com>
	<CAKmqyKOAVDbJQ6avwWgDHP1fHD_EXdZmi+Sjucm05ZqNkQoUog@mail.gmail.com>
	<CAFEAcA_5jYqTWVBiTFjumkAHEEwvDkt_f_LHAo=00gkEfoY9sA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <49bd9805-2f40-7d5d-8814-e0a59a9c5be1@redhat.com>
Date: Wed, 13 Feb 2019 19:54:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_5jYqTWVBiTFjumkAHEEwvDkt_f_LHAo=00gkEfoY9sA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] SiFive RISC-V GPIO Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair23@gmail.com>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

On 2019-02-13 18:14, Peter Maydell wrote:
> On Wed, 13 Feb 2019 at 00:13, Alistair Francis <alistair23@gmail.com> w=
rote:
>> I know the other RISC-V files don't do it, but this should go in the
>> hw/gpio directory instead of hw/riscv.
>=20
> It might be nice to move those existing riscv devices into
> their proper places at some point: should be a fairly easy
> cleanup patch if somebody wants to take it on. (Advice
> on what should live where available on request.)

If devices only work on riscv, they should IMHO stay in hw/riscv/. I
think hw/gpio/ and friends should primarily be used if a device is
shared between architectures. If they stay in hw/riscv/ it is way easier
to match the devices with wildcards in the MAINTAINERS file. Just my
0.02 =E2=82=AC only, of course.

 Thomas
