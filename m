Received: from eggs.gnu.org ([2001:4830:134:3::10]:49662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dN5Xa-00024u-Vq
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dN5XX-0006Mk-UY
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:53:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dN5XX-0006MG-Kz
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:52:59 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5JMmY0I001137
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 18:52:56 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b6chd8x7x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 18:52:56 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Jun 2017 16:52:55 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170608050930.2613-1-david@gibson.dropbear.id.au>
References: <20170608050930.2613-1-david@gibson.dropbear.id.au>
Date: Mon, 19 Jun 2017 17:52:44 -0500
Message-Id: <149791276464.25078.16276260311623099840@loki>
Subject: Re: [Qemu-devel] [PATCH 0/6] spapr: DRC cleanups (part IV)
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

Quoting David Gibson (2017-06-08 00:09:24)
> This fourth isntallment of cleanups to the DRC code introduces the
> first changes to the fundamental state handling.  We change the
> initial states in the reset code and attach code for PCI devices, and
> are able to remove the 'signalled' state variable with those fixes.
> =

> There are also some more mechanical cleanups in preparation for
> further cleanups and fixes to the state management.
> =

> David Gibson (6):
>   spapr: Start hotplugged PCI devices in ISOLATED state
>   spapr: Eliminate DRC 'signalled' state variable
>   spapr: Split DRC release from DRC detach
>   spapr: Make DRC reset force DRC into known state
>   spapr: Clean up DRC set_allocation_state path
>   spapr: Clean up DRC set_isolation_state() path

Series:

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> =

>  hw/ppc/spapr.c             |  15 --
>  hw/ppc/spapr_drc.c         | 363 +++++++++++++++++++++++----------------=
------
>  hw/ppc/spapr_events.c      |  10 --
>  include/hw/ppc/spapr_drc.h |  10 +-
>  4 files changed, 188 insertions(+), 210 deletions(-)
> =

> -- =

> 2.9.4
>=20
