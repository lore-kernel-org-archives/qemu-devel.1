Received: from eggs.gnu.org ([2001:4830:134:3::10]:37484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1faZkh-0008Fv-Fd
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1faZkg-0005Gf-Fq
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 00:50:51 -0400
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
	<20180703055804.13449-36-david@gibson.dropbear.id.au>
	<4fce9ddd-5079-e833-b6c2-e6935322c73d@ilande.co.uk>
	<b0f927a5f0eb2bd96798124e6925fa1f@sebastianbauer.info>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9108e419-3120-b887-0da8-3748dbc19a17@ilande.co.uk>
Date: Wed, 4 Jul 2018 05:50:19 +0100
MIME-Version: 1.0
In-Reply-To: <b0f927a5f0eb2bd96798124e6925fa1f@sebastianbauer.info>
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
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

On 03/07/18 20:24, Sebastian Bauer wrote:

> Am 2018-07-03 21:00, schrieb Mark Cave-Ayland:
>> On 03/07/18 06:58, David Gibson wrote:
>>
>>> From: Sebastian Bauer <mail@sebastianbauer.info>
>>>
>>> Drivers for this card exists on PPC-based AmigaOS guests so it is 
>>> useful to
>>> allow users to emulate the graphics card for PPC machines.
>>>
>>> As cirrus vga is currently preferred over std(vga) in absence of any 
>>> user
>>> choice, this change also sets the default display of spapr machines to
>>> std as otherwise qemu refuses to start these machines.
>>
>> ... which has quite nicely broken the VGA display for both the PPC Mac
>> machines. Patch to follow shortly.
> 
> Please see my note in the comment section of the patch where I propose 
> two possible solutions:
> 
> Either to give up the vga cirrus preference or to apply the same as was 
> done with the spapr machine. I would prefer the first variant but it 
> would also cause some differences on other machines.

I understand that the decision was taken to add VGA cirrus to the PPC 
build and therefore accept the default VGA device change, however your 
the commit message only mentions spapr and not all the other PPC 
machines whose defaults are also potentially affected:

$ ./qemu-system-ppc -M ?
Supported machines are:
40p                  IBM RS/6000 7020 (40p)
bamboo               bamboo
g3beige              Heathrow based PowerMAC (default)
mac99                Mac99 based PowerMAC
mpc8544ds            mpc8544ds
none                 empty machine
ppce500              generic paravirt e500 platform
prep                 PowerPC PREP platform
ref405ep             ref405ep
sam460ex             aCube Sam460ex
taihu                taihu
virtex-ml507         Xilinx Virtex ML507 reference design

I'm not able to personally validate all of these, but a quick check 
shows that at least both PReP machines (-M prep and -M 40p) are also 
broken by this patch which tells me it hasn't had much testing.

David, do you know what the defaults are for the other PPC machines in 
order for Sebastian to test and send a follow-up patch?


ATB,

Mark.
