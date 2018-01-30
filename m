Received: from eggs.gnu.org ([2001:4830:134:3::10]:57226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1egW7V-0000rz-RO
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1egW7R-0008Ql-32
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:38:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55656
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1egW7Q-0008QR-SD
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:38:36 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0UDb3V0179117
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 08:38:35 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ftsr4837q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 08:38:35 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 30 Jan 2018 13:38:33 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 30 Jan 2018 14:38:27 +0100
Message-Id: <20180130133828.77336-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/1] Fix binary build of qemu-system-s390x
 on alpine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Alice Frosi <alice@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Peter, Paolo,

sending this to you as you have the most commits on configure.
If you are ok with it, we can also carry that via the s390 tree.

Alice Frosi (1):
  Fix configure for s390 qemu on alpine and other busybox environments

 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.13.4
