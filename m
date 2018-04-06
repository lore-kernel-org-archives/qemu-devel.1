Received: from eggs.gnu.org ([2001:4830:134:3::10]:50588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f4Md1-00088v-Ro
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 04:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f4Mcy-0002RD-M3
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 04:21:47 -0400
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:53190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f4Mcy-0002Qa-F5
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 04:21:44 -0400
Received: from player730.ha.ovh.net (unknown [10.109.120.69])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id D906CA507
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 10:21:42 +0200 (CEST)
Date: Fri, 6 Apr 2018 10:21:36 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180406102136.57efebb1@bahia.lan>
In-Reply-To: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
References: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for 2.13 0/2] target/ppc:
 Support adding memory to initially memory-less NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On Thu,  5 Apr 2018 10:35:21 -0400
Serhii Popovych <spopovyc@redhat.com> wrote:

> Now PowerPC Linux kernel supports hot-add to NUMA nodes not populated
> initially with memory we can enable such support in qemu. This requires
> two changes:
> 
>   o Add device tree property "ibm,max-associativity-domains" to let
>     guest kernel chance to find max possible NUMA node
> 
>   o Revert  commit b556854bd852 ("spapr: Don't allow memory hotplug to
>     memory less nodes") to remove check for hot-add to memory-less node.
> 

But the series do the changes in the opposite order... 

IIUC correctly a recent kernel will mis-behave as before linux commit
a346137e9142 if the property is not present... ie, patch 2 should come
first.

> See description messges for individual changes for more details.
> 
> Serhii Popovych (2):
>   Revert "spapr: Don't allow memory hotplug to memory less nodes"
>   spapr: Add ibm,max-associativity-domains property
> 
>  hw/ppc/spapr.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 
