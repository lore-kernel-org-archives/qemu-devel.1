Received: from eggs.gnu.org ([2001:4830:134:3::10]:37760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1emWHH-0001vO-3F
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1emWHC-0006uC-Ao
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:01:35 -0500
Received: from p3plsmtpa07-01.prod.phx3.secureserver.net
	([173.201.192.230]:44648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1emWHC-0006t0-4W
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:01:30 -0500
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Thu, 15 Feb 2018 22:01:13 -0500
Message-ID: <1954706.4zhPn1VUeE@wirbelwind>
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

All,

I think that the issue I pointed out the list is not a QEMU bug at all but a 
GDB bug. GDB's sparc software single step implementation seems to be what is 
stuck. It always re-sets the breakpoint at the current instruction in this 
case. It calculates the breakpoint offsets by analyzing the instruction and 
doesn't take this edge case into account. It does not appear to receive an 
invalid npc value from QEMU as I thought it was.

Steven
