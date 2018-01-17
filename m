Received: from eggs.gnu.org ([2001:4830:134:3::10]:54696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebrxw-0006Ha-9h
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ebrxr-00047N-CB
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:57:36 -0500
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:44359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ebrxr-00046d-5B
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:57:31 -0500
Received: from player732.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 9A9FD181377
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 18:57:28 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0282b859-4d02-f908-4784-0f2a556343f5@kaod.org>
Date: Wed, 17 Jan 2018 18:57:17 +0100
MIME-Version: 1.0
In-Reply-To: <2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

> How does KVM knows which one to "activate" ?
> 
> Can't we add an extra IRQ type and use vcpu->arch.irq_type for that ? 
> I haven't studied all the low level details though.

I don't think connecting a vcpu to two different KVM devices makes sense ...
So we need to destroy/recreate the KVM device and disconnect/reconnect 
the vcpus. I will take a closer look. 

C.
