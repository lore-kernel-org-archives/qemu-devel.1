Received: from eggs.gnu.org ([2001:4830:134:3::10]:55041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1ea02a-0001DM-Ta
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1ea02a-0006ML-2a
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:10:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Fri, 12 Jan 2018 15:10:33 +0100
From: Jean-Christophe Dubois <jcd@tribudubois.net>
In-Reply-To: <ea0e6a65-fd7b-e62b-8aa0-2531bbcbf49f@adacore.com>
References: <20180110204327.22510-1-jcd@tribudubois.net>
	<a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
	<548464fa8211307b397a5f50122abd3d@tribudubois.net>
	<ea0e6a65-fd7b-e62b-8aa0-2531bbcbf49f@adacore.com>
Message-ID: <04ce75e9cdb6e001830c720196208e7f@tribudubois.net>
Subject: Re: [Qemu-devel] [PATCH] LEON3 IRQMP: Fix IRQ software ack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabien Chouteau <chouteau@adacore.com>
Cc: Qemu-devel <qemu-devel-bounces+jcd=tribudubois.net@nongnu.org>, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org

Le 2018-01-12 11:55, Fabien Chouteau a écrit :
> On 11/01/2018 13:35, Jean-Christophe Dubois wrote:
>> Thanks Fabien,
>> 
>> Now, as a side question, could you tell me which reference LEON3 
>> platform is implemented by Qemu in leon3_generic?
>> 
> 
> I think it was the based on the FPGA version of Leon3 I was using at 
> the
> time. The name leon3_generic comes from my will to make it a
> configurable board where users could define the number and the location
> of the different peripherals, I never had time to work on this.

I see. I am not sure how to bring configurability to Qemu. There is the 
possibility to describe the hw PTF with DTC/DTB or something similar. I 
think some people were working on it for the ARM Qemu platform (but I am 
not sure what happened to this initiative).

Now in the meantime, would it make sense to move leon3_generic to a tsim 
compatible platform?

This would allow to validate the same software on the 2 simulators 
(obviously it would not be compatible with your specific FPGA version 
for now).

JC
