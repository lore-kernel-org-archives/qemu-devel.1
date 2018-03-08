Received: from eggs.gnu.org ([2001:4830:134:3::10]:50996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etkGR-0005mU-Se
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 20:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1etkGN-000588-8c
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 20:22:35 -0500
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:43206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1etkGN-00057a-0q
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 20:22:31 -0500
Received: by mail-pf0-x22d.google.com with SMTP id j2so1697811pff.10
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 17:22:30 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Message-Id: <0CFE64FD-742F-4668-BF7B-5056608C29DB@sifive.com>
Date: Thu, 8 Mar 2018 14:22:24 +1300
Subject: [Qemu-devel] QEMU hackers in the Portland area next week
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Palmer Dabbelt <palmer@sifive.com>

Hi Folks,

FYI. SiFive is hosting a RISC-V hackathon in Portland at the Embedded =
Linux Conference next week:

Date: Monday, March 12 =E2=80=93 Wednesday, March 14=20
Time: 10:30am Monday =E2=80=93 1:00pm Wednesday=20
Location: Embedded Linux Conference, Hilton Portland Downtown, Skyline =
II, Floor 23=20

QEMU is being featured as the preferred full system emulator for teams =
working on the challenges:

- =
https://www.sifive.com/blog/2018/03/03/all-aboard-part-11-risc-v-hackathon=
-presented-by-sifive/

The challenges are primarily hardware based however I am told there is =
an open category for particularly creative outcomes. One of the =
challenges is to get a browser up and running on the Linux capable =
HiFive Unleashed board, to run a JavaScript benchmark suite the fastest. =
The HiFive Unleashed board is a fully Linux capable SOC, and can tunnel =
PCIe over SiFive=E2=80=99s chiplink interface, as a mezzanine on a =
Xilinx VC707 FPGA to Xilinx PCIe IP on the FPGA allowing the board to =
run X.org OpenGL graphics with an ATI graphics card using the Open =
Source Radeon Linux drivers on a completely RISC-V based Linux system =
(this challenge is based on the U540 SOC or =E2=80=98sifive-u54=E2=80=99 =
in the RISC-V QEMU port). The Open Source graphics setup apparently will =
be demoed at the SiFive booth (Quake on RISC-V). There is also the =
HiFive1 E-series Arduino compatible board with a challenge to implement =
a software solution to bitbang USB over GPIOs (this challenge is based =
on the E310 SOC or =E2=80=98sifive-e31=E2=80=99 in RISC-V QEMU port). =
This would allow the LoFive board to be programmed without requiring a =
proprietary FTDI. The specs for the chips are all open and of course =
similar models can be synthesised in FPGA using the freedom rocket-chip =
generator. There will be lots of HiFive Unleashed boards, HiFive1 =
boards, and SiFive Hardware engineers present. We=E2=80=99ll also have =
the freedom U Open Source soft-cores running on FPGA. This is the =
hardware that we are trying to model in the QEMU RISC-V port, and a =
large proportion of the HDL is Open Source. One of the goals is an Open =
Source USB solution.

There is QEMU specific development that is relevant for both challenges. =
Bringing up graphical framebuffer on the RISC-V port is probably a good =
idea for the HiFive Unleashed challenge but would be relatively easy for =
an expert QEMU hacker, however bringing up VirGL support in QEMU RISC-V =
would likely be hard enough to qualify as a creative outcome that would =
benefit both the QEMU and RISC-V ecosystem. Pragmatists may just run =
Xvnc using ssh, however that doesn=E2=80=99t really benefit QEMU. There =
is also a need to add SiFive GPIO support to the RISC-V QEMU port =
=E2=80=98sifive_e=E2=80=99 machine, so that we could use QEMU to test =
user-space USB protocol stacks, for the HiFive1/LoFive challenge =
(however I=E2=80=99m likely to be working on GPIO support in my day job, =
and the intent is more to have fun than to get free work).

The idea of the hackathon is to get together Open Source software and =
hardware folk and to have some fun hacking on software that is based on =
an Open Source RISC-V stack from the chip all the way up.

Perhaps something creative might be beating the real hardware with a =
QEMU based solution. I think this is relevant to the QEMU community =
because we could benefit the RISC-V QEMU and Linux ports in the process. =
There is a really good opportunity with an Open Source ISA and platform =
to re-define a clean slate set of interfaces between the firmware and =
operating system, and QEMU is key modelling platforms for full system =
emulation. We could even have a QEMU BOF.

Anyway, at minimum this is a call to any QEMU developers in the Portland =
area who might be keen to meet up next week.

My focus will certainly be on benefiting QEMU, and i=E2=80=99m almost =
certainly going to be hacking on QEMU during the hackathon.

Regards,
Michael.

P.S. We asked on IRC about posting to the list about this, and the =
consensus amongst who was present, was that it would be relevant if the =
event could benefit QEMU. I think it could=E2=80=A6=
