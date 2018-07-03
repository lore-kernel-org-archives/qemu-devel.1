Received: from eggs.gnu.org ([2001:4830:134:3::10]:54362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1faQua-0003VE-4d
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1faQuW-0004yq-Vw
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 15:24:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Jul 2018 21:24:14 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <4fce9ddd-5079-e833-b6c2-e6935322c73d@ilande.co.uk>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
	<20180703055804.13449-36-david@gibson.dropbear.id.au>
	<4fce9ddd-5079-e833-b6c2-e6935322c73d@ilande.co.uk>
Message-ID: <b0f927a5f0eb2bd96798124e6925fa1f@sebastianbauer.info>
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org

Am 2018-07-03 21:00, schrieb Mark Cave-Ayland:
> On 03/07/18 06:58, David Gibson wrote:
> 
>> From: Sebastian Bauer <mail@sebastianbauer.info>
>> 
>> Drivers for this card exists on PPC-based AmigaOS guests so it is 
>> useful to
>> allow users to emulate the graphics card for PPC machines.
>> 
>> As cirrus vga is currently preferred over std(vga) in absence of any 
>> user
>> choice, this change also sets the default display of spapr machines to
>> std as otherwise qemu refuses to start these machines.
> 
> ... which has quite nicely broken the VGA display for both the PPC Mac
> machines. Patch to follow shortly.

Please see my note in the comment section of the patch where I propose 
two possible solutions:

Either to give up the vga cirrus preference or to apply the same as was 
done with the spapr machine. I would prefer the first variant but it 
would also cause some differences on other machines.

Bye
Sebastian
