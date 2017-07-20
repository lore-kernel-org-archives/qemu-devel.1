Received: from eggs.gnu.org ([2001:4830:134:3::10]:55409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dY9cM-0004sJ-By
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dY9cJ-0001Me-AW
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:27:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50371
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dY9cJ-0001M2-5g
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 07:27:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6KBOHhP045731
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 07:27:38 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2btpr84yc3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 07:27:37 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 20 Jul 2017 12:27:36 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 20 Jul 2017 13:27:30 +0200
Message-Id: <1500550051-7821-1-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 0/1] fixup for the z14 cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

More testing revealed a small issue with the z14 cpu model.

Christian Borntraeger (1):
  s390/cpumodel: remove KSS from the default model of z14

 target/s390x/cpu_models.c   | 1 +
 target/s390x/gen-features.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4
