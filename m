Received: from eggs.gnu.org ([2001:4830:134:3::10]:55870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cgngi-0004dk-L2
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cgngd-0008A3-Nv
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:19:40 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:60729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cgngd-00089t-Gt
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 02:19:35 -0500
Received: from player796.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id C744959DEF
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 08:19:33 +0100 (CET)
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<20170222033423.GK12577@umbus.fritz.box>
	<e58f7cfa-c03c-ca25-a973-7894253d2dcc@kaod.org>
	<20170223030711.GC12577@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <811fbebe-91d5-b4ee-aef7-f05427c6205d@kaod.org>
Date: Thu, 23 Feb 2017 08:19:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170223030711.GC12577@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 00/22] ppc/xics: simplify ICS
 and ICP creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

> Apart from that I'm pretty happy with the endpoint you reach.  I'm a
> bit less convinced about the path taken to get there.  I'm not sure if
> it's worth the churn of doing this reorg, but I think we'd get there
> more clearly and with less intermediate abstraction violations if it
> was done by:
> 
>      1. Introduce the xics qom interface, but have it implemented by
>         the existing xics object
>      2. Change the ics and icp to only interact with the xics object
>         via the qom interface
>      3. Implement the qom interface in the spapr machine
>      4. Change to spapr directly creating ics and icp objects,
>         pointing back to itself as the xics interface provider
>      5. Remove the xics concrete object

So that's a full rewrite of the patchset to reach the same point. 
I can only grumble for such a proposal :/ 

> This also has the advantage that the qom path changing parts are
> isolated to step (4), meaning problems with migration should be easier
> to localize.

and migration works.

C.
