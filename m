Received: from eggs.gnu.org ([2001:4830:134:3::10]:60163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTN5j-0007Hb-Jo
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 03:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTN5g-0005Y8-Hv
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 03:54:47 -0400
Date: Thu, 14 Jun 2018 09:54:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180614012754.GB3042@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806140951530.19899@zero.eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<8c404c8c4ee1bfd2e4d079877d481094f797df8f.1528291908.git.balaton@eik.bme.hu>
	<6aa1bc4e-a4b0-d7be-b9eb-85dfe8c06781@amsat.org>
	<alpine.BSF.2.21.1806061920120.94568@zero.eik.bme.hu>
	<20180613041115.GS30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131044020.620@zero.eik.bme.hu>
	<20180613100339.GK30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131603270.90524@zero.eik.bme.hu>
	<20180614012754.GB3042@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 5/8] hw/timer: Add basic
 M41T80 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Thu, 14 Jun 2018, David Gibson wrote:
> On Wed, Jun 13, 2018 at 04:13:57PM +0200, BALATON Zoltan wrote:
>> I don't see the problem. The addr register selects the register to read or
>> write. It is set by the first write when the device is accessed the first
>> time (this is denoted by addr == -1 (or really any negative value). The
>> device has 20 registers and trying to read any register outside addr between
>> 0-19 will result in returning 0 and logging a warning about invalid register
>> in m41t80_recv. What could fail here when guest sends garbage? It will set
>> addr to invalid value and try to read non-exitent register and get an error
>> just like for any other nonexistent value of addr (or start to read from
>> register 0 if it manages to set a negative value). All writes of registers
>> are ignored currently (except setting addr by the first write). What should
>> be enforced here?
>
> Ah, I see your point.  I mean strictly we should match the hardware
> behaviour if you write garbage addresses here, but really I don't
> think it matters much.

Problem is like usual I have no idea what the real hardware does. I've 
only seen the datasheet, never seen real device and have no way to test. 
All the clients I've tested seem to be OK with the current emulation so 
unless someone has more info on how this should work I think we can live 
with this version and then fix it later if found to be needed.

Regards,
BALATON Zoltan
