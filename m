Received: from eggs.gnu.org ([2001:4830:134:3::10]:36555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1emMkW-0007RN-Hz
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1emMkT-0005bP-BV
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:51:08 -0500
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:45115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1emMkT-0005aP-3y
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:51:05 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 6BA2A14E2AF
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 17:51:02 +0100 (CET)
Date: Thu, 15 Feb 2018 17:08:57 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180215170831.39645199@bahia.lan>
In-Reply-To: <20180215040818.GH5247@umbus.fritz.box>
References: <151863720814.3003.4939908778788942974.stgit@bahia.lan>
	<151863726311.3003.8227524786940828598.stgit@bahia.lan>
	<20180215040818.GH5247@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] spapr: drop DIV_ROUND_UP() from
 xics_max_server_number()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sam Bobroff <sam.bobroff@au1.ibm.com>, Laurent Vivier <lvivier@redhat.com>

On Thu, 15 Feb 2018 15:08:18 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Feb 14, 2018 at 08:41:03PM +0100, Greg Kurz wrote:

<snip>

> > 
> > It breaks migration of pre-2.7 machine types with unusual CPU topologies,
> > but I guess this is an acceptable trade-off.  
> 
> No, not really.  Weird topologies are still allowed on old machine
> types for backwards compatibility, and we shouldn't break that.  I
> like the idea of consolidating this calculation, but we can't do it by
> just breaking the older machines (at least not until they're formally
> deprecated).
> 

Heh, I had put this patch at the end because I was expecting you might
nack it :)

Per curiosity, when/how do we decide that an older machine type may be formally
deprecated ?
