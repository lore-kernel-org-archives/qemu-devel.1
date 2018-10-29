Received: from eggs.gnu.org ([2001:4830:134:3::10]:42926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH9gs-0004qv-FA
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH9gr-0008K6-0s
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48046
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gH9gq-0008Jg-NB
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9TFdmAr006729
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:42:52 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ne4q3hd83-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:42:51 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Oct 2018 09:42:50 -0600
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Oct 2018 16:42:25 +0100
In-Reply-To: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
References: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1540827745-20795-5-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 4/4] MAINTAINERS: s390/boot: the ipl code and
 the bios belong together
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

The s390-ccw bios and the ipl code do work in lock-step. Let us merge
them in the maintainer file.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e63cfa2..8ce223d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -946,10 +946,11 @@ T: git git://github.com/cohuck/qemu.git s390-next
 T: git git://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
-S390-ccw Bios
+S390-ccw boot
 M: Christian Borntraeger <borntraeger@de.ibm.com>
 M: Thomas Huth <thuth@redhat.com>
 S: Supported
+F: hw/s390x/ipl.*
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
 T: git git://github.com/borntraeger/qemu.git s390-next
--=20
1.8.3.1
