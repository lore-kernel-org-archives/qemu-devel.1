Received: from eggs.gnu.org ([209.51.188.92]:55240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTZ-0001Ls-Nf
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTZ-00082M-06
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:41 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gknTW-0007pC-VR
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:40 -0500
Received: by mail-wr1-x444.google.com with SMTP id v13so17926606wrw.5
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 02:03:21 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 19 Jan 2019 12:03:06 +0200
Message-Id: <20190119100315.23985-2-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
References: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 01/10] docs/pvrdma: Update rdmacm-mux
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, liq3ea@163.com, cohuck@redhat.com, philmd@redhat.com

From: Kamal Heib <kamalheib1@gmail.com>

Before running the rdmacm-mux need to make sure that both the ib_cm
and rdma_cm kernel modules are unloaded.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Message-Id: <20190109132829.19164-1-kamalheib1@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 docs/pvrdma.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt
index 5175251b47..81959378b1 100644
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
2.17.1
