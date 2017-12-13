Received: from eggs.gnu.org ([2001:4830:134:3::10]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ePBZb-0007cU-BI
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ePBZY-0002M1-3X
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:16:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48886
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ePBZX-0002KO-Ua
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:16:00 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBDIDjfL005383
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:15:57 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eu6mmrt78-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 13:15:56 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 13 Dec 2017 11:15:55 -0700
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 13 Dec 2017 16:15:38 -0200
Message-Id: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 0/2] QMP: implementing qmp_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

This small series (re)implements qmp_cpu inside qmp.c, adapting docs
and hmp code accordingly. A fix was also made in qmp_query_cpus in
resulting of the qmp_cpu usage.

The first and unique qmp_cpu implementation so far was made in commit
755f196898, ("qapi: Convert the cpu command"). This is a 6 year old commit
that was part of the following series:

https://lists.gnu.org/archive/html/qemu-devel/2011-10/msg02767.html

I don't understand in the original context why the qmp_cpu function
was left blank while implementing hmp_cpu, but today I believe we
can have both qmp_cpu and hmp_cpu co-existing.

Daniel Henrique Barboza (2):
  qmp.c: (re)implement qmp_cpu
  cpus.c: change qmp_query_cpus 'value->current' logic

 cpus.c           |  2 +-
 hmp.c            | 14 ++++----------
 qapi-schema.json | 14 +++++++++++---
 qmp.c            |  4 +++-
 4 files changed, 19 insertions(+), 15 deletions(-)

-- 
2.13.6
