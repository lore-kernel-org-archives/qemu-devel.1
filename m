Received: from eggs.gnu.org ([2001:4830:134:3::10]:41425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIkHa-0004Ig-4x
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dIkHW-0002zo-2M
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:22:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dIkHV-0002zA-Pd
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 19:22:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v57NJAYU103533
	for <qemu-devel@nongnu.org>; Wed, 7 Jun 2017 19:22:27 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2axr89p5pc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 19:22:27 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 7 Jun 2017 17:22:26 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170607032018.19588-1-david@gibson.dropbear.id.au>
References: <20170607032018.19588-1-david@gibson.dropbear.id.au>
Date: Wed, 07 Jun 2017 18:22:16 -0500
Message-Id: <149687773632.5725.15561233501001316710@loki>
Subject: Re: [Qemu-devel] [PATCHv2 0/7] spapr: DRC cleanups (part III)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Quoting David Gibson (2017-06-06 22:20:11)
> A third batch of cleanups to the DRC code.  This continues to clear
> away relatively simple cruft, to get a clearer look at the fundamental
> state handling.
> =

> Changes since v1:
>   * Some comment updates suggested by Mike Roth
>   * Changed approach to the get_name cleanup, using generated on the
>     fly names, instead of externally assigned names
>   * Added in some cleanups to hotplug code in spapr_pci.c

Series:

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> =

> David Gibson (7):
>   spapr: Clean up DR entity sense handling
>   spapr: Don't misuse DR-indicator in spapr_recover_pending_dimm_state()
>   spapr: Clean up RTAS set-indicator
>   spapr: Clean up handling of DR-indicator
>   spapr: Change DRC attach & detach methods to functions
>   spapr: Fold spapr_phb_{add,remove}_pci_device() into their only
>     callers
>   spapr: Rework DRC name handling
> =

>  hw/ppc/spapr.c             |  30 ++---
>  hw/ppc/spapr_drc.c         | 269 ++++++++++++++++++++-------------------=
------
>  hw/ppc/spapr_pci.c         |  72 +++++-------
>  hw/ppc/trace-events        |   5 +-
>  include/hw/ppc/spapr_drc.h |  30 ++---
>  5 files changed, 171 insertions(+), 235 deletions(-)
> =

> -- =

> 2.9.4
>=20
