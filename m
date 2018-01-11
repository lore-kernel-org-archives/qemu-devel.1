Received: from eggs.gnu.org ([2001:4830:134:3::10]:41602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZcl8-00054Q-08
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZcl7-0007Mj-3b
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:19:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZcl6-0007LW-Tl
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:19:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B8F63C92
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:19:04 +0000 (UTC)
Received: from donizetti.redhat.com (unknown [10.36.118.66])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8918F9835
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:19:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Jan 2018 14:19:00 +0100
Message-Id: <20180111131900.10708-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] target-i386: update hflags on
 Hypervisor.framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This ensures that x86_cpu_dump_state shows registers with the correct
size.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86hvf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 71c0515073..7803e09a28 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -297,7 +297,6 @@ int hvf_get_registers(CPUState *cpu_state)
     X86CPU *x86cpu = X86_CPU(cpu_state);
     CPUX86State *env = &x86cpu->env;
 
-
     env->regs[R_EAX] = rreg(cpu_state->hvf_fd, HV_X86_RAX);
     env->regs[R_EBX] = rreg(cpu_state->hvf_fd, HV_X86_RBX);
     env->regs[R_ECX] = rreg(cpu_state->hvf_fd, HV_X86_RCX);
@@ -333,6 +332,7 @@ int hvf_get_registers(CPUState *cpu_state)
     env->dr[6] = rreg(cpu_state->hvf_fd, HV_X86_DR6);
     env->dr[7] = rreg(cpu_state->hvf_fd, HV_X86_DR7);
     
+    x86_update_hflags(env);
     return 0;
 }
 
-- 
2.14.3
