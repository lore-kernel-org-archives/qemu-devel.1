Received: from eggs.gnu.org ([208.118.235.92]:33509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eR0PE-0001zh-7u
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eR0PA-0008ND-2U
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:44:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38780
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eR0P9-0008Le-QM
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:44:47 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIIefHB082555
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:44:43 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2exfjaa4xs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:44:42 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 18 Dec 2017 13:44:42 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 16:44:27 -0200
Message-Id: <20171218184428.15074-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/1] deprecate qmp_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, berrange@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

v2:
- added more details about why qmp_cpu is being deprecated
- added a deprecation note in qapi-schema.json

Daniel Henrique Barboza (1):
  qmp: marking qmp_cpu as deprecated

 qapi-schema.json |  5 ++++-
 qemu-doc.texi    | 10 ++++++++++
 qmp.c            |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

-- 
2.13.6
