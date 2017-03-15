Received: from eggs.gnu.org ([2001:4830:134:3::10]:52379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1co5Oi-0006i7-DB
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1co5Of-0004YS-8o
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 05:39:12 -0400
Message-ID: <1489570720.26634.13.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 15 Mar 2017 20:38:40 +1100
In-Reply-To: <20170315061630.GF12603@umbus.fritz.box>
References: <1488970371-8865-1-git-send-email-clg@kaod.org>
	<1488970371-8865-7-git-send-email-clg@kaod.org>
	<20170315061630.GF12603@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 6/8] ppc/pnv: Add cut down PSI
 bridge model and hookup external interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 2017-03-15 at 17:16 +1100, David Gibson wrote:
> It might be cleaner to just revaluate the irq level from scratch
> here,
> and set the level, rather than doing this complicated dance to work
> out if it has changed.

Hrm... there was a reason I did it this way but I can't quite remember
why...

Cheers,
Ben.
