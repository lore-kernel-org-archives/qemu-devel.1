Received: from eggs.gnu.org ([2001:4830:134:3::10]:56793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fWoyR-0001lM-71
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fWoyO-0004im-2M
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:17:31 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fWoyN-0004iU-R4
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 16:17:27 -0400
Received: by mail-pf0-x241.google.com with SMTP id a63-v6so4705884pfl.1
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 13:17:27 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
From: Michael Clark <mjc@sifive.com>
In-Reply-To: <CAFEAcA_mvKsVAbSt0kw_zJ3G1f8CaRi2UHHy=7kMGhfPNa72hg@mail.gmail.com>
Date: Sat, 23 Jun 2018 13:17:24 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <F32434A3-C850-4F03-ACE6-B3F01265D363@sifive.com>
References: <cover.1529695276.git.alistair.francis@wdc.com>
	<8eaf7bd5e178b897765f99abac553a664663193c.1529695276.git.alistair.francis@wdc.com>
	<CAFEAcA_mvKsVAbSt0kw_zJ3G1f8CaRi2UHHy=7kMGhfPNa72hg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hw/riscv/virt: Connect the Xilinx
 PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>



> On 23/06/2018, at 1:07 PM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On 22 June 2018 at 20:30, Alistair Francis <alistair.francis@wdc.com> =
wrote:
>> Connect the Xilinx PCIe device based on the device tree included in =
the
>> HiFive Unleashed ROM.
>=20
> Did you consider using the 'gpex' generic PCIe controller here?

Yes. Alastair and I talked about this yesterday and we agreed in =
principle to using =E2=80=98gpex=E2=80=99 on the virt machine and the =
Xilinx PCIe on the SiFive U (=E2=80=99sifive_u=E2=80=99) machine, as =
this reflects one of the IP configurations of SiFive=E2=80=99s Coreplex =
U series when run on FPGA.

By changing this patch to add Xilinx PCIe to =E2=80=98sifive_u=E2=80=99, =
we can plug IO devices into the U series machine, and instead add gpex =
to RISC-V virt. i.e. vendor agnostic generic PCIe controller for virt. =
We would like =E2=80=98virt=E2=80=99 to be a potential vendor agnostic =
hardware target when we have kvm, so using gpex fits with this strategy =
(speaking from a RISC-V perspective not a SiFive perspective).
