Received: from eggs.gnu.org ([2001:4830:134:3::10]:35376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermxw-0007Sa-VG
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermxt-0000hf-V7
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:51:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ermxt-0000gv-RG
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:51:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 599BB87ABA
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 15:51:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  2 Mar 2018 16:51:09 +0100
Message-Id: <20180302155110.5481-2-pbonzini@redhat.com>
In-Reply-To: <20180302155110.5481-1-pbonzini@redhat.com>
References: <20180302155110.5481-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] net: add e1000e model to the "simple"
 -net/-nic options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, berrange@redhat.com

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e006b6ac71..af3c85a46f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1822,6 +1822,7 @@ static const char * const pci_nic_models[] = {
     "i82559er",
     "rtl8139",
     "e1000",
+    "e1000e",
     "pcnet",
     "virtio",
     "sungem",
@@ -1835,6 +1836,7 @@ static const char * const pci_nic_names[] = {
     "i82559er",
     "rtl8139",
     "e1000",
+    "e1000e",
     "pcnet",
     "virtio-net-pci",
     "sungem",
-- 
2.14.3
