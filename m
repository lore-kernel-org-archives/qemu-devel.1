Received: from eggs.gnu.org ([209.51.188.92]:47440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=92777afac=atish.patra@wdc.com>)
	id 1gpI4b-0008UI-OX
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=92777afac=atish.patra@wdc.com>)
	id 1gpHy0-0006iu-2v
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:25:42 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=92777afac=atish.patra@wdc.com>)
	id 1gpHxt-0006aF-QL
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 14:25:37 -0500
From: Atish Patra <atish.patra@wdc.com>
Message-ID: <17ecfa78-7098-8cdd-7318-68a997cd685d@wdc.com>
Date: Thu, 31 Jan 2019 11:25:20 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] RISC-V Open source Supervisor Binary Interface
 (OpenSBI) Version 0.1 Released
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, U-Boot Mailing List <u-boot@lists.denx.de>, qemu-devel@nongnu.org, "sw-dev@groups.riscv.org" <sw-dev@groups.riscv.org>
Cc: Anup Patel <Anup.Patel@wdc.com>, Damien Le Moal <Damien.LeMoal@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>, Jorge Campello De Souza <jorge.campello@wdc.com>, Palmer Dabbelt <palmer@sifive.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, Christoph Hellwig <hch@infradead.org>, "David.Abdurachmanov@cern.ch" <David.Abdurachmanov@cern.ch>, Bin Meng <bmeng.cn@gmail.com>, Alexander Graf <agraf@suse.de>, "olof.johansson@gmail.com" <olof.johansson@gmail.com>, "rminnich@gmail.com" <rminnich@gmail.com>

OpenSBI version 0.1 is now publicly available in GitHub at
https://github.com/riscv/opensbi.

OpenSBI is an open source implementation of the RISC-V Supervisor Binary
Interface (SBI). RISC-V SBI specifications are maintained as an 
independent project by the RISC-V Foundation in [Github].

This initial release of OpenSBI provides an implementation of the RISC-V 
SBI specifications version 0.1. These specifications define the legacy 
SBI interface currently in use by various products as well as by RISC-V 
QEMU virtual machines.

OpenSBI also implements SBI compliant early boot firmwares capable of 
handling various boot flows and payloads on various environments. 
OpenSBI firmwares have been tested with payloads such as U-Boot and 
Linux kernel, showing that these open firmwares can fully replace the 
legacy non-standard BBL intermediate boot loader.

The platforms supported with this first release are as follows.
* Sifive HiFive Unleashed board
* RISC-V QEMU *virt* and *sifive_u* virtual machines
* Kendryte K210 SoC based boards.

OpenSBI implementation can be easily extended by RISC-V platform vendors 
and System-on-Chip vendors to fit new hardware configurations.

As SBI specifications evolve and extend beyond the current base legacy
features, OpenSBI will be modified to provide a reference implementation 
for new SBI specifications.

More information on OpenSBI capabilities as well as a contribution 
guideline are available in OpenSBI documentation included with the 
source code in GitHub.

[Github]: https://github.com/riscv/riscv-sbi-doc
