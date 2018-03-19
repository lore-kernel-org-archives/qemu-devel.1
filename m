Received: from eggs.gnu.org ([2001:4830:134:3::10]:43577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1exxTk-0007iV-5A
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1exxTf-00018E-8A
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:17:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:59994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1exxTf-00017g-1c
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:17:39 -0400
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 19 Mar 2018 17:17:36 +0100
Message-ID: <mvm1sggjazj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] qemu:handle_cpu_signal received signal outside vCPU
 context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>

I'm seeing this error while building gedit for riscv64 with linux-user
emulation:

$ LD_LIBRARY_PATH=gedit/.libs qemu-riscv64 gedit/.libs/gedit --introspect-dump=/tmp/tmp-introspectnj0xla07/functions.txt,/tmp/tmp-introspectnj0xla07/dump.xml
qemu:handle_cpu_signal received signal outside vCPU context @ pc=0x6003d7d5
qemu:handle_cpu_signal received signal outside vCPU context @ pc=0x60106a16

This is qemu as of today with the patches from
git://github.com/riscv/riscv-qemu / riscv-all on top.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
