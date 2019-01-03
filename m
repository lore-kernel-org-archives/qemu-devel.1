Received: from eggs.gnu.org ([208.118.235.92]:57482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gf3ao-000742-IO
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gf3al-0005MO-9l
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:03:26 -0500
Date: Thu, 3 Jan 2019 15:03:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190102041507.GN27457@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.9999.1901031501030.39019@zero.eik.bme.hu>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<16d6e1b4987d30c11ace0211e9d6a57303784467.1546394798.git.balaton@eik.bme.hu>
	<20190102041507.GN27457@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 4/8] ppc4xx: Use ram_addr_t in
 ppc4xx_sdram_adjust()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Wed, 2 Jan 2019, David Gibson wrote:
> On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
>> To avoid overflow if larger values are added later use ram_addr_t for
>> the sdram_bank_sizes parameter to match ram_size to which it is
>> compared.
>
> So, technically I think these should be 'hwaddr' (which represents a
> guest physical address) rather tham ram_addr_t which
> represents... something subtley different I've never properly
> understood.

I don't understand the difference either but ram_size in MachineState 
where this value comes from is ram_addr_t now so I've left is for now. If 
someone knows which type should this be can change it in another patch 
later.

Regards,
BALATON Zoltan
