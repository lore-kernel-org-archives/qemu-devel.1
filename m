Received: from eggs.gnu.org ([2001:4830:134:3::10]:56125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg6RZ-00021V-DK
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg6RT-0006Ap-G7
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:09:09 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cg6RT-00069P-9W
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:09:03 -0500
Received: by mail-wr0-x241.google.com with SMTP id z61so13687625wrc.3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 01:09:03 -0800 (PST)
Received: from donizetti.lan (94-39-187-56.adsl-ull.clienti.tiscali.it.
	[94.39.187.56]) by smtp.gmail.com with ESMTPSA id
	x135sm16752878wme.23.2017.02.21.01.09.01 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 Feb 2017 01:09:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Feb 2017 10:08:59 +0100
Message-Id: <20170221090859.10172-2-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] vmxcap: update for September 2016 SDM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kvm/vmxcap | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index af8de15..e0990c7 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -171,8 +171,11 @@ controls = [
             13: 'Enable VM functions',
             14: 'VMCS shadowing',
             16: 'RDSEED exiting',
+            17: 'Enable PML',
             18: 'EPT-violation #VE',
+            19: 'Conceal non-root operation from PT',
             20: 'Enable XSAVES/XRSTORS',
+            22: 'Mode-based execute control (XS/XU)',
             25: 'TSC scaling',
             },
         cap_msr = MSR_IA32_VMX_PROCBASED_CTLS2,
@@ -190,6 +193,8 @@ controls = [
             20: 'Save IA32_EFER',
             21: 'Load IA32_EFER',
             22: 'Save VMX-preemption timer value',
+            23: 'Clear IA32_BNDCFGS',
+            24: 'Conceal VM exits from PT',
             },
         cap_msr = MSR_IA32_VMX_EXIT_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_EXIT_CTLS,
@@ -205,6 +210,8 @@ controls = [
             13: 'Load IA32_PERF_GLOBAL_CTRL',
             14: 'Load IA32_PAT',
             15: 'Load IA32_EFER',
+            16: 'Load IA32_BNDCFGS',
+            17: 'Conceal VM entries from PT',
             },
         cap_msr = MSR_IA32_VMX_ENTRY_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
@@ -223,6 +230,7 @@ controls = [
             (25,27): 'MSR-load/store count recommendation',
             28: 'IA32_SMM_MONITOR_CTL[2] can be set to 1',
             29: 'VMWRITE to VM-exit information fields',
+            30: 'Inject event with insn length=0',
             (32,63): 'MSEG revision identifier',
             },
         msr = MSR_IA32_VMX_MISC_CTLS,
-- 
2.9.3
