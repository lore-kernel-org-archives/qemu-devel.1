Received: from eggs.gnu.org ([2001:4830:134:3::10]:52442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f0Ik4-0002FB-GJ
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 23:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f0Ik1-0003Ae-T9
	for qemu-devel@nongnu.org; Sun, 25 Mar 2018 23:24:16 -0400
Date: Mon, 26 Mar 2018 05:24:12 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180326022012.GB2104@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1803260518540.80357@zero.eik.bme.hu>
References: <20180326001421.0E0937456D7@zero.eik.bme.hu>
	<20180326022012.GB2104@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix reserved bit mask of dstst
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

On Mon, 26 Mar 2018, David Gibson wrote:
> On Mon, Mar 26, 2018 at 01:54:28AM +0200, BALATON Zoltan wrote:
>> According to the Vector/SIMD extension documentation bit 6 that is
>> currently masked is valid (listed as transient bit) but bits 7 and 8
>> should be reserved instead. Fix the mask to match this.
>
> What document can I find information on dstst in?  The ISA documents I
> have handy are either too early (the instruction didn't exist yet) or
> too late (the instruction was considered obsolete and no details are
> given).

I've found it in "PowerPC Microprocessor Family: Vector/SIMD Multimedia 
Extension Technology Programming Environments Manual" Version 2.06 which 
was the first one Google found. According to this document dstst should 
have the same reserved bits as dst.

Regards,
BALATON Zoltan
