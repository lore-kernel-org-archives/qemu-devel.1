Received: from eggs.gnu.org ([2001:4830:134:3::10]:54295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dGQMf-0000AA-1Y
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dGQMa-0007Hm-P5
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:42:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dGQMa-0007HX-GR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:42:08 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51DdeYX017926
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 09:42:06 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ate7u2y5q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 09:42:06 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 10:42:01 -0300
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 1 Jun 2017 10:41:51 -0300
MIME-Version: 1.0
In-Reply-To: <20170601015218.9299-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <95217255-6504-1293-4885-9ad8231b34ae@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/4] spapr:DRC cleanups (part I)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com
Cc: lvivier@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com



On 05/31/2017 10:52 PM, David Gibson wrote:
> The code managing DRCs[0] has quite a few things that are more
> complicated than they need to be.  In particular the object
> representing a DRC has a bunch of method pointers, despite the fact
> that there are currently no subclasses, and even if there were the
> method implementations would be unlikely to differ.
>
> This appears to be a misguided attempt to "abstract" or hide things in
> a way which is bureaucraticl, rather than meaningful.  We may have an
> object model, but we don't have to adopt Java's kingdom-of-nouns
> nonsense[1].
>
> This series makes a start on simplifying things.  There's still plenty
> more, but you have to start somewhere.
>
> [0] "Dynamic Reconfiguration Connectors" a firmware abstraction used
>      in hotplug operations
> [1] https://steve-yegge.blogspot.com.au/2006/03/execution-in-kingdom-of-nouns.html
>
> David Gibson (4):
>    spapr: Move DRC RTAS calls into spapr_drc.c
>    spapr: Abolish DRC get_fdt method
>    spapr: Abolish DRC set_configured method
>    spapr: Make DRC get_index and get_type methods into plain functions
>
>   hw/ppc/spapr.c             |  13 +-
>   hw/ppc/spapr_drc.c         | 404 ++++++++++++++++++++++++++++++++++++++-------
>   hw/ppc/spapr_events.c      |  10 +-
>   hw/ppc/spapr_pci.c         |   4 +-
>   hw/ppc/spapr_rtas.c        | 304 ----------------------------------
>   hw/ppc/trace-events        |   2 -
>   include/hw/ppc/spapr_drc.h |   9 +-
>   7 files changed, 355 insertions(+), 391 deletions(-)
>
Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
