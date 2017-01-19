Received: from eggs.gnu.org ([2001:4830:134:3::10]:36855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxw-0000hN-AD
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxs-0008Ui-Tp
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:52 -0500
Received: from mail.kernel.org ([198.145.29.136]:56872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJxs-0008Si-NA
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:09:48 -0500
Date: Thu, 19 Jan 2017 23:09:44 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484860116-25361-13-git-send-email-mst@redhat.com>
References: <1484860116-25361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484860116-25361-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 12/17] pci_regs: update to latest linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

this drops a duplicate definition of
PCI_EXT_CAP_ATS_SIZEOF

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/standard-headers/linux/pci_regs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index be5b066..e5a2e68 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -678,7 +678,6 @@
 #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PTM
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
-#define PCI_EXT_CAP_ATS_SIZEOF	8
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
 
 /* Advanced Error Reporting */
-- 
MST
