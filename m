Received: from eggs.gnu.org ([2001:4830:134:3::10]:60378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqoVd-0004n7-KZ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eqoVc-0007TY-KX
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:18:09 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170922171323.10348-1-f4bug@amsat.org>
	<20171009132112.GA5553@toto>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4b2297e8-3db9-2ddc-dbaa-16c9e372a571@amsat.org>
Date: Tue, 27 Feb 2018 20:18:01 -0300
MIME-Version: 1.0
In-Reply-To: <20171009132112.GA5553@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 0/7] Generalize MDIO framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Grant Likely <grant.likely@arm.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Hi Edgar,

On 10/09/2017 10:21 AM, Edgar E. Iglesias wrote:
> On Fri, Sep 22, 2017 at 02:13:16PM -0300, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> I have a follow up series using multiples PHY on the MDIO bus based on this
>> series.
> 
> Hi Philippe!
> 
> I think this is a good improvement compared to todays state.
> It may make sense to have the generic mdio bus functions in mdio.c
> and specific phy models in separate files, thoughts?

I'm sorry I missed your mail and noticed it today since this thread got
awakened with Alistair's reviews.

I'll raise this series priority in my TODO and respin with Grant correct
S-o-b, Alistair comments addressed and split MDIO/PHY as you suggested.

After spending 2 months with the SD bus, I now fill more confident to
rework the MDIO bus and think of unit testing and tracing.

Regards,

Phil.

>>
>> Grant's previous work:
>> http://lists.nongnu.org/archive/html/qemu-devel/2013-02/msg00257.html
>>
>> "There is more work to be done, particularly in moving to the common GPIO api,
>>  but that work can be done as a follow on patch series."
>>
>> Grant Likely (7):
>>   hw/mdio: Generalize etraxfs MDIO bitbanging emulation
>>   hw/mdio: Add PHY register definition
>>   hw/mdio: Generalize phy initialization routine
>>   hw/mdio: Mask out read-only bits.
>>   hw/mdio: Refactor bitbanging state machine
>>   hw/mdio: Add VMState support
>>   hw/mdio: Use bitbang core for smc91c111 network device
>>
>>  include/hw/net/mdio.h   | 124 +++++++++++++++++++++
>>  hw/net/etraxfs_eth.c    | 291 +-----------------------------------------------
>>  hw/net/mdio.c           | 280 ++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/net/smc91c111.c      |  27 ++++-
>>  hw/net/xilinx_axienet.c | 189 +------------------------------
>>  hw/net/Makefile.objs    |   2 +
>>  6 files changed, 438 insertions(+), 475 deletions(-)
>>  create mode 100644 include/hw/net/mdio.h
>>  create mode 100644 hw/net/mdio.c
>>
>> -- 
>> 2.14.1
>>
