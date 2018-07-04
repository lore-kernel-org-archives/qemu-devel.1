Received: from eggs.gnu.org ([2001:4830:134:3::10]:53245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fae6D-0002dk-QQ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fae6A-00007q-M0
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:29:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Jul 2018 11:29:09 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <39a5cb1b-7dbc-f683-e4f8-0a655c146891@ilande.co.uk>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
	<20180703055804.13449-36-david@gibson.dropbear.id.au>
	<4fce9ddd-5079-e833-b6c2-e6935322c73d@ilande.co.uk>
	<b0f927a5f0eb2bd96798124e6925fa1f@sebastianbauer.info>
	<9108e419-3120-b887-0da8-3748dbc19a17@ilande.co.uk>
	<30fe8f08c522688f00af24ccc4f0629e@sebastianbauer.info>
	<39a5cb1b-7dbc-f683-e4f8-0a655c146891@ilande.co.uk>
Message-ID: <7181e8dda57df8d270d15b57130d981d@sebastianbauer.info>
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

Hi,

Am 2018-07-04 07:56, schrieb Mark Cave-Ayland:
> Right, but as the patch submitter it's your responsibility to ensure
> that your patch doesn't break other people's machines and/or follow up
> with the appropriate patches. If you're not willing to do that then we
> should revert the patch in its current form until a better way forward
> has been found.

Of course, I will come up with a follow up patch that will hopefully fix 
the problem (hopefully, as I simply have no clue how to test if some 
platforms break if it is not covered by 'make check', though I 
appreciate any hints on doing this as well). That's not the question. My 
question is what the scope of the patch actually should be. I mentioned 
two possible ways of proceeding.

>> Last but not least, all of the targets should still work as before if 
>> you use -vga std option.
> Except that -vga std has been the default for these machines for a
> long time, and it's going to be me that will get a large majority of
> the complaints if this behaviour changes.

I fully agree that -vga std makes the most sense, but why does QEMU 
prefer the Cirrus one over vga then when there seems to be some 
agreement that Cirrus is obsolete and many machines don't work with 
Cirrus?

My patch did not deliberately set a different -vga default, it is 
actually coded that way in QEMU and a side-effect of the inclusion: For 
any machine prefer the Cirrus card if it is available as default -vga. 
Should my patch address this (i.e., to lower the pri of the cirrus)?

Or should my patch add further exceptions to the respective machines?

It is also possible to do the latter now (as release is imminent) and 
schedule the former the next dev cycle.

Bye
Sebastian
