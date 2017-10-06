Received: from eggs.gnu.org ([2001:4830:134:3::10]:56537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1e0PKT-00035o-7q
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1e0PKQ-0001wu-5d
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:54:01 -0400
Message-ID: <1507283610.25065.148.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 06 Oct 2017 11:53:30 +0200
In-Reply-To: <20171006090722.GD10961@umbus.fritz.box>
References: <20171005164959.26024-1-clg@kaod.org>
	<20171005164959.26024-2-clg@kaod.org>
	<20171006090722.GD10961@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] spapr/rtas: disable the decrementer
 interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Fri, 2017-10-06 at 20:07 +1100, David Gibson wrote:
> Hm.  Checking mmu_model doesn't seem right to me.  I mean, it'll get
> the right answer in practice, but the LPCR programming has nothing
> whatsoever to do with the MMU.
> 
> I think explicitly checking if cpu_ is a POWER9 instance with
> object_dynamic_cast would be a better option.

Best is ARCH 300 ... do we hvae arch versions outside of MMU model
these days ?

Ben.
