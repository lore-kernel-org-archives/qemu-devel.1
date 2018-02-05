Received: from eggs.gnu.org ([2001:4830:134:3::10]:44567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimSA-0004Lp-5G
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS8-0004vs-UY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:22 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimS8-0004vJ-My
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:20 -0500
Received: by mail-wm0-x241.google.com with SMTP id b21so28072091wme.4
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:26 +0100
Message-Id: <1517858941-5538-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 12/47] memory-internal.h: Remove obsolete claim
 that header is obsolete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

The memory-internal.h header claims that it is for "obsolete
exec.c functions" which "will be removed soon". This statement
was added in 2011, six years ago, but the header is still here.
(Admittedly none of the prototypes added in commit 67d95c153bef55f6
are still in the header.)

It's convenient to have a place to put prototypes for functions
which are used internally to the various .c files of the memory
system or by the accel/tcg code, which is inevitably fairly
closely coupled. So keep the header but update the comments to
reflect what we're actually using it for.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1511276888-17834-1-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory-internal.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 98d8296..4162474 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -1,5 +1,5 @@
 /*
- * Declarations for obsolete exec.c functions
+ * Declarations for functions which are internal to the memory subsystem.
  *
  * Copyright 2011 Red Hat, Inc. and/or its affiliates
  *
@@ -12,8 +12,9 @@
  */
 
 /*
- * This header is for use by exec.c and memory.c ONLY.  Do not include it.
- * The functions declared here will be removed soon.
+ * This header is for use by exec.c, memory.c and accel/tcg/cputlb.c ONLY,
+ * for declarations which are shared between the memory subsystem's
+ * internals and the TCG TLB code. Do not include it from elsewhere.
  */
 
 #ifndef MEMORY_INTERNAL_H
-- 
1.8.3.1
