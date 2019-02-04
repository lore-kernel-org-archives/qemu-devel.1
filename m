Received: from eggs.gnu.org ([209.51.188.92]:45802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaf-00066J-HZ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTO-0005TY-O6
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:47 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:32964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTO-0005SK-GE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:46 -0500
Received: by mail-qt1-f182.google.com with SMTP id l11so138276qtp.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:45 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-13-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 12/25] intel_iommu: reset intr_enabled when
 system reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

This is found when I was debugging another problem.  Until now no bug
is reported with this but we'd better reset the IR status correctly
after a system reset.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6d5cc1d039..ee22e754f0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3138,6 +3138,7 @@ static void vtd_init(IntelIOMMUState *s)
     s->root = 0;
     s->root_extended = false;
     s->dmar_enabled = false;
+    s->intr_enabled = false;
     s->iq_head = 0;
     s->iq_tail = 0;
     s->iq = 0;
-- 
MST
