Received: from eggs.gnu.org ([2001:4830:134:3::10]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZtg6-0005SR-FH
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZtg2-0005Hz-3q
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:50:46 -0400
Message-ID: <1500961745.10674.106.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 25 Jul 2017 15:49:05 +1000
In-Reply-To: <20170725041923.GB8978@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
	<20170724043624.GE17228@umbus.fritz.box>
	<1500879657.10674.64.camel@kernel.crashing.org>
	<20170724095052.GO17228@umbus.fritz.box>
	<1500894439.10674.76.camel@kernel.crashing.org>
	<c94d515a-0d8b-921e-1ccb-bd92284c3967@kaod.org>
	<20170725041923.GB8978@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] ppc/xive: add flags to the XIVE
 interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 2017-07-25 at 14:19 +1000, David Gibson wrote:
> > Nevertheless I have added support for the hcall in Linux and QEMU.
> > To use, I think we could create a specific source.
> 
> So, IIUC, it's host constraints that would make this one way or the
> other.  So what happens when a guest migrates from a host which has it
> one way to one which has it the other way?

It's probably ok to always call the hcall for the awy set -> unset, the
other way around is a problem, but it will end up depending on the kind
of interrupts we pass through.

Ben.
