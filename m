Received: from eggs.gnu.org ([2001:4830:134:3::10]:46845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1faamP-000299-EK
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 01:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1faamO-00018t-D1
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 01:56:41 -0400
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
	<20180703055804.13449-36-david@gibson.dropbear.id.au>
	<4fce9ddd-5079-e833-b6c2-e6935322c73d@ilande.co.uk>
	<b0f927a5f0eb2bd96798124e6925fa1f@sebastianbauer.info>
	<9108e419-3120-b887-0da8-3748dbc19a17@ilande.co.uk>
	<30fe8f08c522688f00af24ccc4f0629e@sebastianbauer.info>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <39a5cb1b-7dbc-f683-e4f8-0a655c146891@ilande.co.uk>
Date: Wed, 4 Jul 2018 06:56:13 +0100
MIME-Version: 1.0
In-Reply-To: <30fe8f08c522688f00af24ccc4f0629e@sebastianbauer.info>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

On 04/07/18 06:33, Sebastian Bauer wrote:

> Am 2018-07-04 06:50, schrieb Mark Cave-Ayland:
>>> Either to give up the vga cirrus preference or to apply the same as 
>>> was done with the spapr machine. I would prefer the first variant but 
>>> it would also cause some differences on other machines.
>>
>> I understand that the decision was taken to add VGA cirrus to the PPC
>> build and therefore accept the default VGA device change, however your
>> the commit message only mentions spapr and not all the other PPC
>> machines whose defaults are also potentially affected:
>>
>> $ ./qemu-system-ppc -M ?
>> Supported machines are:
>> 40p                  IBM RS/6000 7020 (40p)
>> bamboo               bamboo
>> g3beige              Heathrow based PowerMAC (default)
>> mac99                Mac99 based PowerMAC
>> mpc8544ds            mpc8544ds
>> none                 empty machine
>> ppce500              generic paravirt e500 platform
>> prep                 PowerPC PREP platform
>> ref405ep             ref405ep
>> sam460ex             aCube Sam460ex
>> taihu                taihu
>> virtex-ml507         Xilinx Virtex ML507 reference design
>>
>> I'm not able to personally validate all of these, but a quick check
>> shows that at least both PReP machines (-M prep and -M 40p) are also
>> broken by this patch which tells me it hasn't had much testing.
>>
>> David, do you know what the defaults are for the other PPC machines in
>> order for Sebastian to test and send a follow-up patch?
> 
> I don't know much how to validate these machines (I did a 'make check' 
> but it does not show up any problems) and what impact these change has. 
> But I suggested in the note section (which is not the commit message) 
> that some of the machines properly behave different now (OTOH CirrusGD 
> is a vga card nonetheless, I would have expected that at least the Mac 
> can deal with that card). This can either be fixed by following the 
> 'spapr' approach (as it explicitly forbids this card as the primary 
> display and was therefore visible immediately) or by generally 
> rethinking whether CirrusGD really should be the preferred card over std 
> vga (after all it is considered as obsolete so why should it be 
> preferred?). I think it would be nice if a consensus can be found about 
> the "correct approach" way to fix it. I personally think that adding 
> more exceptions is not the right way :)

Right, but as the patch submitter it's your responsibility to ensure 
that your patch doesn't break other people's machines and/or follow up 
with the appropriate patches. If you're not willing to do that then we 
should revert the patch in its current form until a better way forward 
has been found.

> Last but not least, all of the targets should still work as before if 
> you use -vga std option.

Except that -vga std has been the default for these machines for a long 
time, and it's going to be me that will get a large majority of the 
complaints if this behaviour changes.


ATB,

Mark.
