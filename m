Received: from eggs.gnu.org ([2001:4830:134:3::10]:53343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZvD9-0005FR-82
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZvD6-0007sY-35
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:28:59 -0400
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:43276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZvD5-0007rp-SW
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:28:56 -0400
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 2432E88E79
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 10:28:54 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
	<20170724043624.GE17228@umbus.fritz.box>
	<1500879657.10674.64.camel@kernel.crashing.org>
	<20170724095052.GO17228@umbus.fritz.box>
	<1500894439.10674.76.camel@kernel.crashing.org>
	<20170725041841.GA8978@umbus.fritz.box>
	<1500961657.10674.105.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b859ae92-b1b2-4696-1ea5-6ff3a7a56df3@kaod.org>
Date: Tue, 25 Jul 2017 10:28:49 +0200
MIME-Version: 1.0
In-Reply-To: <1500961657.10674.105.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] ppc/xive: add flags to the XIVE
 interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/25/2017 07:47 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2017-07-25 at 14:18 +1000, David Gibson wrote:
>>> Well, at this point I think nothing will set that flag.... It's there
>>> for workaround around HW bugs on some chips. At least in full emu it
>>> shouldn't happen unless we try to emulate those bugs. Hopefully direct
>>> MMIO will just work.
>>
>> Hm.  That doesn't seem like a good match for a per-irq state
>> structure.
> 
> The flag is returned to the guest on a per-IRQ basis, so are the LSI
> etc... flags, but at the HW level, indeed, they correspond to
> attributes of blocks of interrupts.
> 
> It might be easier in qemu to keep that in the per-source flags
> though.

Theses flags are at the source level :

  XIVE_SRC_H_INT_ESB 
  XIVE_SRC_TRIGGER    
  XIVE_SRC_STORE_EOI  


The XIVE_SRC_LSI flag is only returned in the GET_SOURCE_INFO hcall 
but, internally, we use the ICSIRQState flags XICS_FLAGS_IRQ_LSI to 
store the information per-irq.       
 
Thanks,

C.


> Especially when we start having actual HW interrupts under the
> hood with KVM. it's easier to keep the state self contained
> for each of them.
> 
> Ben.
> 
