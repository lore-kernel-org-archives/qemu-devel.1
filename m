Received: from eggs.gnu.org ([209.51.188.92]:41016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44g-0001V5-MI
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44f-0003WO-Ly
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53942
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44f-0003NE-Dw
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1rUR095851
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:23 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkswegx1f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:22 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:21 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:17 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-44-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 43/97] block/rbd: add deprecation documentation
 for filename keyvalue pairs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeff Cody <jcody@redhat.com>

From: Jeff Cody <jcody@redhat.com>

Signed-off-by: Jeff Cody <jcody@redhat.com>
Message-id: 647f5b5ab7efd8bf567a504c832b1d2d6f719b23.1536704901.git.jcody@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit 3bebd37e04f972775b1ece1bdda95451bc9fb14c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-deprecated.texi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 9920a85adc..cff0e8b309 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -227,6 +227,21 @@ from old QEMU versions anymore. A newer machine type should be used instead.
 In order to prevent QEMU from automatically opening an image's backing
 chain, use ``"backing": null'' instead.
 
+@subsubsection rbd keyvalue pair encoded filenames: "" (since 3.1.0)
+
+Options for ``rbd'' should be specified according to its runtime options,
+like other block drivers.  Legacy parsing of keyvalue pair encoded
+filenames is useful to open images with the old format for backing files;
+These image files should be updated to use the current format.
+
+Example of legacy encoding:
+
+@code{json:@{"file.driver":"rbd", "file.filename":"rbd:rbd/name"@}}
+
+The above, converted to the current supported format:
+
+@code{json:@{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"@}}
+
 @subsection vio-spapr-device device options
 
 @subsubsection "irq": "" (since 3.0.0)
-- 
2.17.1
