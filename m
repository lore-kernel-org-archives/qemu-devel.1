Received: from eggs.gnu.org ([2001:4830:134:3::10]:43311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1emQjP-00034C-FP
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1emQjK-000146-ET
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:06:15 -0500
Received: from p3plsmtpa07-03.prod.phx3.secureserver.net
	([173.201.192.232]:48752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1emQjK-00013g-74
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:06:10 -0500
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Thu, 15 Feb 2018 16:06:03 -0500
Message-ID: <18994193.FvU4hPZK01@wirbelwind>
In-Reply-To: <CAFEAcA_xHpd5_RVp4_Be3wOa_U6YTpN0wiKheMYApuSOkbtjHw@mail.gmail.com>
References: <5193436.NpsRQSl3SI@wirbelwind>
	<CAFEAcA_xHpd5_RVp4_Be3wOa_U6YTpN0wiKheMYApuSOkbtjHw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/02] fix issue where a branch to pc+4
 confuses GDB because pc and npc are set to the same value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Oh, let me also add that this assertion fails in gdb: 

Thread 1 hit Breakpoint 3, 0x40f102d8 in ?? ()
(gdb) si
./../../src/gdb-8.1/gdb/sparc-tdep.c:1737: internal-error: std::vector<long 
unsigned int> sparc_software_single_step(regcache*): Assertion
`nnpc != npc || orig_npc == 0' failed.

I had this assertion commented out so when I unrolled my patch to repeat the 
test in order to write my previous reply to you, I saw it be stuck on the same 
instruction rather than fail this assertion.

I guess this could be a gdb bug, too.

Steven
