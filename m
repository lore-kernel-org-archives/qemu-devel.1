Received: from eggs.gnu.org ([2001:4830:134:3::10]:40765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dXQsd-00059A-P8
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dXQsa-0004x5-NW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:41:31 -0400
Message-ID: <1500375719.2865.115.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 18 Jul 2017 21:01:59 +1000
In-Reply-To: <8760eqe2og.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
References: <20170717041639.16137-1-nikunj@linux.vnet.ibm.com>
	<20170718044619.GC3140@umbus.fritz.box>
	<8760eqe2og.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] spapr: disable decrementer during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com

On Tue, 2017-07-18 at 10:56 +0530, Nikunj A Dadhania wrote:
> In case of reboot, all CPUs are resumed after reboot. So we check the
> next condition cpu_has_work() in cpu_thread_is_idle(), where we see a
> DECR interrupt and remove the CPU from halted state as the CPU has work.

Shouldn't we put them back in the stopped state then ?

Cheers,
Ben.
