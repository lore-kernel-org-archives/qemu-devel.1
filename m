Received: from eggs.gnu.org ([2001:4830:134:3::10]:48277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dXpU0-0000Rs-3U
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1dXpTw-0004HD-4x
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:57:44 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:21961)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1dXpTv-0004GY-R7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:57:40 -0400
Date: Wed, 19 Jul 2017 09:57:26 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <20170719135726.GG5722@char.us.oracle.com>
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Allow RedHat PCI bridges reserve
 more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: seabios@seabios.org, marcel@redhat.com, qemu-devel@nongnu.org

On Wed, Jul 19, 2017 at 04:20:12PM +0300, Aleksandr Bezzubikov wrote:
> Now PCI bridges (and PCIE root port too) get a bus range number in system init,
> basing on currently plugged devices. That's why when one wants to hotplug another bridge,
> it needs his child bus, which the parent is unable to provide.

Could you explain how you trigger this?

> The suggested workaround is to have vendor-specific capability in RedHat generic pcie-root-port
> that contains number of additional bus to reserve on BIOS PCI init.

But wouldn't the proper fix be for the PCI bridge to have the subordinate
value be extended to fit more bus ranges?

> 
> Aleksandr Bezzubikov (2):
>   pci: add support for direct usage of bdf for capability lookup
>   pci: enable RedHat pci bridges to reserve more buses
> 
>  src/fw/pciinit.c   | 12 ++++++++++--
>  src/hw/pcidevice.c | 24 ++++++++++++++++++++++++
>  src/hw/pcidevice.h |  1 +
>  3 files changed, 35 insertions(+), 2 deletions(-)
> 
> -- 
> 2.7.4
> 
> 
