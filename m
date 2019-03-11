Received: from eggs.gnu.org ([209.51.188.92]:45998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1h3Tu6-0000lV-6b
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 19:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1h3TrP-0004Gf-3d
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:57:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
	id 1h3TrO-0004Fm-Nu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:57:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x2BMrmph128277
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 18:57:28 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r60pnggxh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 18:57:28 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <maxiwell@linux.ibm.com>;
	Mon, 11 Mar 2019 22:57:27 -0000
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Date: Mon, 11 Mar 2019 19:57:07 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20190311225709.5535-1-maxiwell@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v5 0/2] spapr-rtas: add ibm,
 get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>

Here are two patches to add a handler for ibm,get-vpd RTAS calls.
This RTAS exposes host information in case of set QEMU options
'host-serial' and 'host-model' as 'passthrough'.

The patch 1 creates helper functions to get valid 'host-serial'
and 'host-model' parameters, guided by QEMU command line. These
parameters are useful to build the guest device tree and to return
get-vpd RTAS calls. The patch 2 adds the ibm,get-vpd itself.


Maxiwell S. Garcia (2):
  spapr: helper functions to get valid host fields
  spapr-rtas: add ibm,get-vpd RTAS interface

 hw/ppc/spapr.c         |  58 +++++++++++++---------
 hw/ppc/spapr_rtas.c    | 110 +++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  15 +++++-
 3 files changed, 160 insertions(+), 23 deletions(-)

-- 
2.20.1
