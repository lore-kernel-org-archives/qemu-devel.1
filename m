Received: from eggs.gnu.org ([209.51.188.92]:47644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gznth-0007fj-7g
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzntf-000246-Kl
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:32:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gznte-0001xk-1r
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:32:39 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x21JOEt8048953
	for <qemu-devel@nongnu.org>; Fri, 1 Mar 2019 14:32:34 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qyaegska1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 14:32:34 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 1 Mar 2019 19:32:31 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 01 Mar 2019 20:32:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155146874478.147873.5019623412212796259.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 0/2] spapr: Fix CPU unplug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

This series follows another approach suggested by Mike Roth in
order to fix the recent breakage of CPU unplug tests caused by
commit b8165118f52c, as discussed here:

https://patchwork.ozlabs.org/patch/1050227/

--
Greg

---

Greg Kurz (2):
      Revert "spapr: support memory unplug for qtest"
      spapr: Simulate CAS for qtest


 hw/ppc/spapr.c      |   11 +++++++++++
 hw/ppc/spapr_ovec.c |    6 ------
 2 files changed, 11 insertions(+), 6 deletions(-)
