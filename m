Received: from eggs.gnu.org ([2001:4830:134:3::10]:44443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS2-0004DM-Kn
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS1-0004sw-Uo
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:14 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:54129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimS1-0004sc-O3
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:13 -0500
Received: by mail-wm0-x22d.google.com with SMTP id t74so28413145wme.3
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:13 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:20 +0100
Message-Id: <1517858941-5538-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/47] qemu: improve hugepage allocation failure
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>

From: Marcelo Tosatti <mtosatti@redhat.com>

Improve hugepage allocation failure message, indicating
what is happening to the user.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Message-Id: <20180115201700.GA4439@amt.cnet>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/numa.c b/numa.c
index 83675a0..a9528aa 100644
--- a/numa.c
+++ b/numa.c
@@ -463,6 +463,7 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
             if (mem_prealloc) {
                 exit(1);
             }
+            error_report("falling back to regular RAM allocation.");
 
             /* Legacy behavior: if allocation failed, fall back to
              * regular RAM allocation.
-- 
1.8.3.1
