Received: from eggs.gnu.org ([2001:4830:134:3::10]:47739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZXn8-0004Ti-Sw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZXn5-0001Uy-OR
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:28:34 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:45139)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZXn5-0001U0-HY
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 03:28:31 -0400
Received: from player792.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 01CF470428
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 09:28:22 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<20170719030053.GP3140@umbus.fritz.box>
	<1500436532.3350.8.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <89336f55-bcc1-c496-5277-66219149f17a@kaod.org>
Date: Mon, 24 Jul 2017 09:28:09 +0200
MIME-Version: 1.0
In-Reply-To: <1500436532.3350.8.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 00/26] guest exploitation of the XIVE
 interrupt controller (POWER9)
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

On 07/19/2017 05:55 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2017-07-19 at 13:00 +1000, David Gibson wrote:
>> So, this is probably obvious, but I'm not considering this a candidate
>> for qemu 2.10 (seeing as the soft freeze was yesterday).  I'll still
>> try to review and, once ready, queue for 2.11.
> 
> Right. I need to review still and we need to make sure we have the
> right plumbing for migration etc... and of course I need to do the
> KVM bits. So it's definitely not 2.10 material.

yes. This is not for 2.10 clearly. This is just an RFC to get
some feedback on the approach and on some ugly hacks I have 
put in place.

I have given KVM a quick look and it should be addressed before
we start merging anything. I think PowerNV should wait a bit. 

As for TCG, my branch supports reset, changing model XICS <-> XIVE, 
migration and CPU hotplug. KVM+kernel_irqchip=off is supported
also. Most of the issues have found a solution but now we need 
to discuss.   

I was out last week. Catching up.

Thanks,

C.
