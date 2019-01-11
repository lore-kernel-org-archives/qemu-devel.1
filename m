Received: from eggs.gnu.org ([209.51.188.92]:35405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1ghv8B-00066O-7I
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1ghv8A-0000U7-5S
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:37:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1ghv89-0000Sq-OH
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:37:42 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0BBOgCj012707
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 06:37:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pxqm58eqg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 06:37:39 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Fri, 11 Jan 2019 11:37:37 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 11 Jan 2019 12:36:55 +0100
Message-Id: <20190111113657.66195-1-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] s390x: Diag 308 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

Let's make it architecture compliant and a bit more readable.

Each non implemented diag 308 supcode should result in a specification
exception. Operating systems use the exceptions to query which codes
are available.

Janosch Frank (2):
  s390x: Diag308 move common parameter checking into function
  s390x: Return specification exception for unimplemented diag 308
    subcodes

 target/s390x/diag.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

-- 
2.14.3
