Received: from eggs.gnu.org ([2001:4830:134:3::10]:53230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcol-0006wo-Eh
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cUcoh-00062m-GN
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:17:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cUcoh-00062Z-Ak
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:17:35 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AFBEC04BD23
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 17:17:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 20 Jan 2017 18:17:32 +0100
Message-Id: <20170120171732.32055-2-pbonzini@redhat.com>
In-Reply-To: <20170120171732.32055-1-pbonzini@redhat.com>
References: <20170120171732.32055-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 35/35] pc.h: move x-mach-use-reliable-get-clock
 compat entry to PC_COMPAT_2_8
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

As noticed by David Gilbert, commit 6053a86 'kvmclock: reduce kvmclock
differences on migration' added 'x-mach-use-reliable-get-clock' and a
compatibility entry that turns it off; however it got merged after 2.8.0
was released but the entry has gone into PC_COMPAT_2_7 where it should
have gone into PC_COMPAT_2_8.

Fix it by moving the entry to PC_COMPAT_2_8.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170118175343.GA26873@amt.cnet>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 230e9e7..738bfd6 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -376,15 +376,14 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
-
-
-#define PC_COMPAT_2_7 \
-    HW_COMPAT_2_7 \
     {\
         .driver   = "kvmclock",\
         .property = "x-mach-use-reliable-get-clock",\
         .value    = "off",\
     },\
+
+#define PC_COMPAT_2_7 \
+    HW_COMPAT_2_7 \
     {\
         .driver   = TYPE_X86_CPU,\
         .property = "l3-cache",\
-- 
2.9.3
