Received: from eggs.gnu.org ([2001:4830:134:3::10]:49770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bauerman@linux.vnet.ibm.com>) id 1dilLy-0007m6-9j
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bauerman@linux.vnet.ibm.com>) id 1dilLv-0007Nl-7u
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:46:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37924
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bauerman@linux.vnet.ibm.com>)
	id 1dilLv-0007Mo-2G
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:46:35 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7IHi4pO001304
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 13:46:34 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ce2s4f9dd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 13:46:33 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bauerman@linux.vnet.ibm.com>;
	Fri, 18 Aug 2017 13:46:33 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Date: Fri, 18 Aug 2017 14:46:14 -0300
Message-Id: <20170818174614.10930-1-bauerman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] .dir-locals.el: Explicitly set indentation
 level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

At least in some configurations, setting c-file-style is not enough to
conform to the QEMU coding style, so explicitly set c-basic-offset as well.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---

My emacs was using indentation level of 8 spaces and this patch convinced
it to use the correct value.

I set c-basic-offset set to tab-width in my ~/.spacemacs which perhaps
isn't the wisest thing to do, but since there's a .dir-locals.el we can
make the editor always do the right thing.

 .dir-locals.el | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.dir-locals.el b/.dir-locals.el
index 3ac0cfc6f0d6..8e47418c5996 100644
--- a/.dir-locals.el
+++ b/.dir-locals.el
@@ -1,2 +1,3 @@
 ((c-mode . ((c-file-style . "stroustrup")
-	    (indent-tabs-mode . nil))))
+	    (indent-tabs-mode . nil)
+	    (c-basic-offset . 4))))
