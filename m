Received: from eggs.gnu.org ([2001:4830:134:3::10]:34026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1coSAV-0003l2-9u
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1coSAS-0007Z3-9Y
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:58:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35401
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1coSAS-0007Yp-33
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:58:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2G9rfsf011138
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 05:57:59 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 297r0csnys-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 05:57:58 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 16 Mar 2017 09:57:57 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu, 16 Mar 2017 10:57:49 +0100
Message-Id: <20170316095750.26952-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/1] bugfix for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Cornelia Huck <cornelia.huck@de.ibm.com>

A fix for a bug in the s390x css implementation.

The especially annoying thing about that bug is that things seem
to work fine after migration -- until you get funny errors when
you try to add/delete some devices...

Dong Jia Shi (1):
  s390x/css: reassign subchannel if schid is changed after migration

 hw/s390x/css.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.11.0
