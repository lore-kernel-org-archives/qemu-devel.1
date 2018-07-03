Received: from eggs.gnu.org ([2001:4830:134:3::10]:50003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1faQYE-0007Uw-Ax
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1faQYD-0003Bk-KT
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:01:22 -0400
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
	<20180703055804.13449-36-david@gibson.dropbear.id.au>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <4fce9ddd-5079-e833-b6c2-e6935322c73d@ilande.co.uk>
Date: Tue, 3 Jul 2018 20:00:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180703055804.13449-36-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 35/35] ppc: Include vga cirrus card into the
 compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Sebastian Bauer <mail@sebastianbauer.info>, mdroth@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org

On 03/07/18 06:58, David Gibson wrote:

> From: Sebastian Bauer <mail@sebastianbauer.info>
> 
> Drivers for this card exists on PPC-based AmigaOS guests so it is useful to
> allow users to emulate the graphics card for PPC machines.
> 
> As cirrus vga is currently preferred over std(vga) in absence of any user
> choice, this change also sets the default display of spapr machines to
> std as otherwise qemu refuses to start these machines.

... which has quite nicely broken the VGA display for both the PPC Mac 
machines. Patch to follow shortly.


ATB,

Mark.
