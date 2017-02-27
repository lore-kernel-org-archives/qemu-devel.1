Received: from eggs.gnu.org ([2001:4830:134:3::10]:36135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgt-0004mB-46
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgs-0000fS-8D
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKgs-0000f7-3I
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:10 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41FA0C04B320
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 12:46:10 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-118.ams2.redhat.com
	[10.36.117.118])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1RCjpeA028718
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:46:09 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:49 +0100
Message-Id: <20170227124551.8673-16-pbonzini@redhat.com>
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 15/17] vmxcap: update for September 2016 SDM
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
 scripts/kvm/vmxcap | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index af8de15..d9a6db0 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -170,9 +170,13 @@ controls = [
             12: 'Enable INVPCID',
             13: 'Enable VM functions',
             14: 'VMCS shadowing',
+            15: 'Enable ENCLS exiting',
             16: 'RDSEED exiting',
+            17: 'Enable PML',
             18: 'EPT-violation #VE',
+            19: 'Conceal non-root operation from PT',
             20: 'Enable XSAVES/XRSTORS',
+            22: 'Mode-based execute control (XS/XU)',
             25: 'TSC scaling',
             },
         cap_msr = MSR_IA32_VMX_PROCBASED_CTLS2,
@@ -190,6 +194,8 @@ controls = [
             20: 'Save IA32_EFER',
             21: 'Load IA32_EFER',
             22: 'Save VMX-preemption timer value',
+            23: 'Clear IA32_BNDCFGS',
+            24: 'Conceal VM exits from PT',
             },
         cap_msr = MSR_IA32_VMX_EXIT_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_EXIT_CTLS,
@@ -205,6 +211,8 @@ controls = [
             13: 'Load IA32_PERF_GLOBAL_CTRL',
             14: 'Load IA32_PAT',
             15: 'Load IA32_EFER',
+            16: 'Load IA32_BNDCFGS',
+            17: 'Conceal VM entries from PT',
             },
         cap_msr = MSR_IA32_VMX_ENTRY_CTLS,
         true_cap_msr = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
@@ -223,6 +231,7 @@ controls = [
             (25,27): 'MSR-load/store count recommendation',
             28: 'IA32_SMM_MONITOR_CTL[2] can be set to 1',
             29: 'VMWRITE to VM-exit information fields',
+            30: 'Inject event with insn length=0',
             (32,63): 'MSEG revision identifier',
             },
         msr = MSR_IA32_VMX_MISC_CTLS,
-- 
2.9.3
