Received: from eggs.gnu.org ([209.51.188.92]:51582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1ghDuS-0007d9-P9
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:28:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kamalheib1@gmail.com>) id 1ghDuS-00058L-2A
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:28:40 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kamalheib1@gmail.com>)
	id 1ghDuR-000562-QW
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:28:40 -0500
Received: by mail-wm1-x342.google.com with SMTP id t200so8286291wmt.0
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 05:28:39 -0800 (PST)
From: Kamal Heib <kamalheib1@gmail.com>
Date: Wed,  9 Jan 2019 15:28:29 +0200
Message-Id: <20190109132829.19164-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docs/pvrdma: Update rdmacm-mux documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Yuval Shaia <yuval.shaia@oracle.com>, Kamal Heib <kamalheib1@gmail.com>

Before running the rdmacm-mux need to make sure that both the ib_cm
and rdma_cm kernel modules are unloaded.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 docs/pvrdma.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt
index 5175251b47d6..81959378b120 100644
--- a/docs/pvrdma.txt
+++ b/docs/pvrdma.txt
@@ -99,6 +99,9 @@ MAD layer to send and receive RDMA-CM MAD packets.
 To build rdmacm-mux run
 # make rdmacm-mux
 
+Before running the rdmacm-mux make sure that both ib_cm and rdma_cm kernel
+modules aren't loaded, otherwise the rdmacm-mux service will fail to start.
+
 The application accepts 3 command line arguments and exposes a UNIX socket
 to pass control and data to it.
 -d rdma-device-name  Name of RDMA device to register with
-- 
2.20.1
