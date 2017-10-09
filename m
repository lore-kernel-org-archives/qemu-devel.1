Received: from eggs.gnu.org ([2001:4830:134:3::10]:33055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1e1Xzj-0002Eo-Kg
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1e1Xzf-0001ga-M3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:21:19 -0400
Date: Mon, 9 Oct 2017 15:21:12 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20171009132112.GA5553@toto>
References: <20170922171323.10348-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170922171323.10348-1-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v5 0/7] Generalize MDIO framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Grant Likely <grant.likely@arm.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On Fri, Sep 22, 2017 at 02:13:16PM -0300, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> I have a follow up series using multiples PHY on the MDIO bus based on this
> series.

Hi Philippe!

I think this is a good improvement compared to todays state.
It may make sense to have the generic mdio bus functions in mdio.c
and specific phy models in separate files, thoughts?

Cheers,
Edgar


> 
> Regards,
> 
> Phil.
> 
> Grant's previous work:
> http://lists.nongnu.org/archive/html/qemu-devel/2013-02/msg00257.html
> 
> "There is more work to be done, particularly in moving to the common GPIO api,
>  but that work can be done as a follow on patch series."
> 
> Grant Likely (7):
>   hw/mdio: Generalize etraxfs MDIO bitbanging emulation
>   hw/mdio: Add PHY register definition
>   hw/mdio: Generalize phy initialization routine
>   hw/mdio: Mask out read-only bits.
>   hw/mdio: Refactor bitbanging state machine
>   hw/mdio: Add VMState support
>   hw/mdio: Use bitbang core for smc91c111 network device
> 
>  include/hw/net/mdio.h   | 124 +++++++++++++++++++++
>  hw/net/etraxfs_eth.c    | 291 +-----------------------------------------------
>  hw/net/mdio.c           | 280 ++++++++++++++++++++++++++++++++++++++++++++++
>  hw/net/smc91c111.c      |  27 ++++-
>  hw/net/xilinx_axienet.c | 189 +------------------------------
>  hw/net/Makefile.objs    |   2 +
>  6 files changed, 438 insertions(+), 475 deletions(-)
>  create mode 100644 include/hw/net/mdio.h
>  create mode 100644 hw/net/mdio.c
> 
> -- 
> 2.14.1
> 
