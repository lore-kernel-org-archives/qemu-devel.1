Received: from eggs.gnu.org ([2001:4830:134:3::10]:47996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijK-0004cU-T1
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRijF-0002kQ-7J
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRijE-0002jd-Up
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BCC219D222
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:28 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-46.ams2.redhat.com
	[10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6FDC95B809
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 18:04:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:57 +0100
Message-Id: <20171220180358.29316-19-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/19] i386: hvf: remove VM_PANIC from "in"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Just give the obvious meaning to a 64-bit port, even though it
should not really happen.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 75a27ad5eb..3a41ba6ae1 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -745,7 +745,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 } else if (size == 4) {
                     RAX(env) = (uint32_t)val;
                 } else {
-                    VM_PANIC("size");
+                    RAX(env) = (uint64_t)val;
                 }
                 RIP(env) += ins_len;
                 store_regs(cpu);
-- 
2.14.3
