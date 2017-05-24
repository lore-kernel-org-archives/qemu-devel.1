Received: from eggs.gnu.org ([2001:4830:134:3::10]:40435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <boddupavan@yahoo.com>) id 1dDPrH-0005X5-Ef
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <boddupavan@yahoo.com>) id 1dDPrD-0005fh-3F
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:33:23 -0400
Received: from sonic303-24.consmr.mail.gq1.yahoo.com ([98.137.64.205]:44985)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <boddupavan@yahoo.com>) id 1dDPrC-0005ct-Pe
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:33:19 -0400
Date: Wed, 24 May 2017 06:33:14 +0000 (UTC)
From: boddu pavan <boddupavan@yahoo.com>
Reply-To: boddu pavan <boddupavan@yahoo.com>
Message-ID: <1247874473.1264616.1495607594686@mail.yahoo.com>
In-Reply-To: <910323563.4048354.1495458265640@mail.yahoo.com>
References: <910323563.4048354.1495458265640.ref@mail.yahoo.com>
	<910323563.4048354.1495458265640@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ssi_auto_connect_slave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-discuss <qemu-discuss@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

+qemu-dev 

  Show original message     On Monday, May 22, 2017 6:34 PM, boddu pavan <boddupavan@yahoo.com> wrote:
 

 Hi,
I see that ssi_auto_connect_slave helper of ssi.c (https://github.com/qemu/qemu/blob/master/hw/ssi/ssi.c#L166) is used to connect SSISlave children of spi controller to its respective spi bus. But this function cannot handle the scenario where controller has two spi busses ( like xilinx_spips). In this case each SSISlave is registered on both the buses.
I cannot image a possible good way to fix this, other than assigning a bus number property for each SSISlave. Let me know if that works as a good patch if provided ?
Thanks,
Sai Pavan

   
