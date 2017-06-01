Received: from eggs.gnu.org ([2001:4830:134:3::10]:37029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dGSTA-0002wx-1g
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dGST5-0005A7-6o
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:57:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56599
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dGST5-00059u-0O
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 11:56:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51FrffB036537
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 11:56:58 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2atjysa7ag-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 11:56:57 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 11:56:57 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170601015218.9299-2-david@gibson.dropbear.id.au>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601015218.9299-2-david@gibson.dropbear.id.au>
Date: Thu, 01 Jun 2017 10:56:50 -0500
Message-Id: <149633261057.3207.5755197867144524820@loki>
Subject: Re: [Qemu-devel] [PATCH 1/4] spapr: Move DRC RTAS calls into
 spapr_drc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, nikunj@linux.vnet.ibm.com, sursingh@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com

Quoting David Gibson (2017-05-31 20:52:15)
> Currently implementations of the RTAS calls related to DRCs are in
> spapr_rtas.c.  They belong better in spapr_drc.c - that way they're closer
> to related code, and we'll be able to make some more things local.
> =

> spapr_rtas.c was intended to contain the RTAS infrastructure and core cal=
ls
> that don't belong anywhere else, not every RTAS implementation.
> =

> Code motion only.

Technically rtas-get-sensor-state and rtas-set-indicator aren't specific
to DRCs, but looking through the documented indicators/sensors (tables
40 and 42 in LoPAPR v11) it doesn't seem too likely we'll ever implement
any others so the move seems reasonable.

> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_drc.c  | 322 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  hw/ppc/spapr_rtas.c | 304 ----------------------------------------------=
---
>  2 files changed, 315 insertions(+), 311 deletions(-)
