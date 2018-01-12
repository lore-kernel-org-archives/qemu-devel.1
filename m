Received: from eggs.gnu.org ([2001:4830:134:3::10]:57968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1eZwzq-0006w8-Ni
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1eZwzq-0005ja-20
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:55:38 -0500
References: <20180110204327.22510-1-jcd@tribudubois.net>
	<a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
	<548464fa8211307b397a5f50122abd3d@tribudubois.net>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <ea0e6a65-fd7b-e62b-8aa0-2531bbcbf49f@adacore.com>
Date: Fri, 12 Jan 2018 11:55:31 +0100
MIME-Version: 1.0
In-Reply-To: <548464fa8211307b397a5f50122abd3d@tribudubois.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] LEON3 IRQMP: Fix IRQ software ack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, Qemu-devel <qemu-devel-bounces+jcd=tribudubois.net@nongnu.org>

On 11/01/2018 13:35, Jean-Christophe Dubois wrote:
> Thanks Fabien,
> 
> Now, as a side question, could you tell me which reference LEON3 platform is implemented by Qemu in leon3_generic?
> 

I think it was the based on the FPGA version of Leon3 I was using at the
time. The name leon3_generic comes from my will to make it a
configurable board where users could define the number and the location
of the different peripherals, I never had time to work on this.
