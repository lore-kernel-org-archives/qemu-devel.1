Received: from eggs.gnu.org ([2001:4830:134:3::10]:42660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fZ1k7-0001u5-9G
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 18:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fZ1k3-00089f-7D
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 18:19:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fZ1k2-00088n-UW
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 18:19:47 -0400
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Fri, 29 Jun 2018 17:19:07 -0500
Message-Id: <20180629221907.3662-5-venu.busireddy@oracle.com>
In-Reply-To: <20180629221907.3662-1-venu.busireddy@oracle.com>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH v3 virtio 1/1] Add "Group Identifier" to virtio
 PCI capabilities.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: venu.busireddy@oracle.com, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

Add VIRTIO_PCI_CAP_GROUP_ID_CFG (Group Identifier) capability to the
virtio PCI capabilities to allow for the grouping of devices.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 content.tex | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/content.tex b/content.tex
index be18234..34627e5 100644
--- a/content.tex
+++ b/content.tex
@@ -599,6 +599,8 @@ The fields are interpreted as follows:
 #define VIRTIO_PCI_CAP_DEVICE_CFG        4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG           5
+/* Group Identifier */
+#define VIRTIO_PCI_CAP_GROUP_ID_CFG      6
 \end{lstlisting}
 
         Any other value is reserved for future use.
@@ -997,6 +999,34 @@ address \field{cap.length} bytes within a BAR range
 specified by some other Virtio Structure PCI Capability
 of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
 
+\subsubsection{Group Identifier capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
+
+The VIRTIO_PCI_CAP_GROUP_ID_CFG capability provides means for grouping
+devices together.
+
+The capability is immediately followed by an identifier of type u64
+as below:
+
+\begin{lstlisting}
+struct virtio_pci_group_id_cap {
+        struct virtio_pci_cap cap;
+        u64 group_id; /* Group Identifier */
+};
+\end{lstlisting}
+
+\devicenormative{\paragraph}{Group Identifier capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
+
+The device MAY present the VIRTIO_PCI_CAP_GROUP_ID_CFG capability.
+
+When this capability is present, the device must set the fields
+\field{cap.bar}, \field{cap.offset} and \field{cap.length} to 0, and
+set the group_id to a unique identifier.
+
+\drivernormative{\paragraph}{Group Identifier capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
+
+The fields \field{cap.bar}, \field{cap.offset}, \field{cap.length}
+and \field{group_id} are read-only for the driver.
+
 \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
 
 Transitional devices MUST present part of configuration
