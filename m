Received: from eggs.gnu.org ([2001:4830:134:3::10]:33358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsingharora@gmail.com>) id 1cg1xy-0005T1-FC
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsingharora@gmail.com>) id 1cg1xx-0007TJ-Mb
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:22:18 -0500
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 21 Feb 2017 15:22:05 +1100
Message-ID: <20170221042205.GA23350@balbir.ozlabs.ibm.com>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
	<1487563478-22265-5-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487563478-22265-5-git-send-email-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH V3 04/10] target/ppc/POWER9:
 Direct all instr and data storage interrupts to the hypv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, agraf@suse.de, sam.bobroff@au1.ibm.com, david@gibson.dropbear.id.au

On Mon, Feb 20, 2017 at 03:04:32PM +1100, Suraj Jitindar Singh wrote:
> The vpm0 bit was removed from the LPCR in POWER9, this bit controlled
> whether ISI and DSI interrupts were directed to the hypervisor or the
> partition. These interrupts now go to the hypervisor irrespective, thus
> it is no longer necessary to check the vmp0 bit in the LPCR.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
