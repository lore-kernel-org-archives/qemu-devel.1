Received: from eggs.gnu.org ([2001:4830:134:3::10]:42897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH9gr-0004qH-Tb
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gH9gp-0008IW-C8
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47244
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gH9gp-0008F2-0j
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:42:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9TFdmd7104534
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:42:46 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ne337f3p4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:42:46 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 29 Oct 2018 09:42:45 -0600
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 29 Oct 2018 16:42:24 +0100
In-Reply-To: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
References: <1540827745-20795-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1540827745-20795-4-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH 3/4] MAINTAINERS: s390/pci: add Collin Walling
 as maintainer for zpci
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

Collin will take over the maintainership from Yi Min. Let us add a
separate s390 pci section.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cb23555..e63cfa2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -955,6 +955,12 @@ F: pc-bios/s390-ccw.img
 T: git git://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
+S390 PCI
+M: Collin Walling <walling@linux.ibm.com>
+S: Supported
+F: hw/s390x/s390-pci*
+L: qemu-s390x@nongnu.org
+
 UniCore32 Machines
 -------------
 PKUnity-3 SoC initramfs-with-busybox
--=20
1.8.3.1
