Received: from eggs.gnu.org ([2001:4830:134:3::10]:38245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cndBL-0005Y2-In
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cndBH-0005TF-Hf
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:31:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cndBH-0005SE-8u
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 23:31:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2E3SZtL007464
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 23:31:25 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	by mx0a-001b2d01.pphosted.com with ESMTP id 295w08y22p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 23:31:24 -0400
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 14 Mar 2017 13:31:22 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue, 14 Mar 2017 14:30:21 +1100
Message-Id: <cover.1489462214.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 0/1] scripts/update-linux-headers.sh:
 refactor extra files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, paulus@ozlabs.org, peter.maydell@linaro.org, pbonzini@redhat.com


Hi QEMU devs,

While doing some other work, I needed to update the update-linux-headers.sh
script to handle some new files and it seemed like it was getting big enough to
need a little refactoring. The actual files have already been added (on master)
but here's the refactoring because it might still be useful. There is no
functional change, this is maintenance only.

Cheers,
Sam.


Sam Bobroff (1):
  scripts/update-linux-headers.sh: refactor extra files

 scripts/update-linux-headers.sh | 44 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

-- 
2.11.0
