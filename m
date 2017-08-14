Received: from eggs.gnu.org ([2001:4830:134:3::10]:51894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dhDCp-0002o4-58
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dhDCl-0003q6-Vs
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:06:47 -0400
Date: Mon, 14 Aug 2017 13:06:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170814044454.GG3452@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1708141258050.10227@zero.eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<675e091387248b49c97ff99ef07eb23ed316aefb.1502643878.git.balaton@eik.bme.hu>
	<20170814044454.GG3452@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [RFC PATCH 11/12] ppc4xx: Export ECB and PLB
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>

On Mon, 14 Aug 2017, David Gibson wrote:
> On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
>> These devices are found in some other ppc4xx cores too.

Thanks for the quick review, hope more will follow for other patches 
too maybe also from others.

> Elsewhere in the series you moved things that were used elsewhere out
> of 405_uc, why not do that here as well?

I've moved those because those devices needed to be modified extensively 
while these two in this patch are used basically unchanged (they may not 
even be completely correct for 460EX but seem to work well enough) so I've 
left them here. I could add this explanation to the commit message or 
maybe move them to ppc4xx_devs to make it clearer that they are not only 
used by 405 emulation.

>> Also add some more PLB registers for 460EX.
>
> Separate patch for that please, it's logically unrelated.  Plus the
> commit message should say what these registers are, where they appear,
> why do we need them?

OK. I don't really know what these registers are. I guess we need them 
because U-Boot or other guests poke them but they are only added to avoid 
the crash, not really emulated (just read zero, ignore write) for now.

Regards,
BALATON Zoltan
