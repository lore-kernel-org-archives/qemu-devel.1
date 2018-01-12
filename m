Received: from eggs.gnu.org ([2001:4830:134:3::10]:41901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZ3-0007iK-CM
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZ2-0005kv-FE
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:01 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZ2-0005kH-8I
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:00 -0500
Received: by mail-wr0-x241.google.com with SMTP id d9so5042457wre.3
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:00 -0800 (PST)
Received: from 640k.lan (dynamic-adsl-78-12-229-84.clienti.tiscali.it.
	[78.12.229.84])
	by smtp.gmail.com with ESMTPSA id l8sm2732271wmg.46.2018.01.12.03.31.57
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Jan 2018 03:31:58 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:58 +0100
Message-Id: <1515756676-3860-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/52] target-i386: update hflags on
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
index 71c0515..7803e09 100644
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
1.8.3.1
