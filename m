Received: from eggs.gnu.org ([209.51.188.92]:47963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amagdy.afifi@gmail.com>) id 1gxDfI-0007sh-DP
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amagdy.afifi@gmail.com>) id 1gxDfH-0001uN-IH
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:27:08 -0500
From: amagdy.afifi@gmail.com
Date: Fri, 22 Feb 2019 18:25:54 +0200
Message-Id: <20190222162555.13764-1-amagdy.afifi@gmail.com>
Subject: [Qemu-devel] Add proper alignment check and pending 'C' extension
 for riscv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, mjc@sifive.com, palmer@sifive.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, amagdy.afifi@gmail.com


Dear All,

I'm submiting this patch to properly check the next instruction alignment and scheduale compression extenstion enable upon 'MISA' register writes to later aligned instruction through exporting next instruction 'pc' to riscv cpu state

Thanks,
Ahmed
