Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B6C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8218208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+lU+NQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8218208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIBI-0006vw-Qv
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkz-0000wi-CN
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkk-00066E-Is
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:42528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkk-00065H-Cu
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:46 -0400
Received: by mail-wr1-x430.google.com with SMTP id x17so6205870wrl.9
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kXfByX7LWMudNMbfoxt6/9xb5IJTtcMJHhGnMirNo+g=;
 b=h+lU+NQOdr+2kOx1yPMb232eQGGb5CiqxSQr20VrTCZBl89Jm+0fLHhl+83xi4bHIF
 SjcpybdXreecfqoG6meVUW0h677GCwh426/56TvEr1jhi6IGp4FiWaBAeHshUUwOY04z
 Z/dkl2DnVirGaptx83uqXd826+CGchcBSVco1BEYe5qYbHlEVPxcVfqzH7WWPxSMt7pg
 gReZCxrWfaFGzQi2FLp3XYSyOwpltOeEyB95wKkgz67OmNgRJzwidH/+hcQdprloFxYx
 1NnVtgkiJfyVNQI9DlwpYfQ/M51kiHxv+YqqdWCbx6NR4UZNh0xhC+tURL2s9cPnNS3Q
 rKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=kXfByX7LWMudNMbfoxt6/9xb5IJTtcMJHhGnMirNo+g=;
 b=esYi8ZwvRDDjHU8HmpRvZy3Mx2tBiTGWOhRHLM5UgDIBGaUONH4gGVmprKdQo+9SK/
 GdxX5BVzTf/CO5d+H7qKn8psq98KFPQxC4tZyx+IYrqCXilms96nIRpC64Mwu6SV+kgd
 Ugucs7eRvD55Gs/917mHbUoR51ocaEepZx4jYJ2fMJedhvIPRmxRtzlc1AF8yp/Fxcfy
 1ej2VP808JP2yayCIr/OUpNK7K9FBzqqNi64HXjrv+pkFu2vnAxfcSp2lPbYo0SJmjoR
 PdpjA7IJOcDU2oYQVmahzOkm3gGJce5d7RqP2FUN3rGpa60OQc7Pu/6gDPMOEx0b50Xq
 ntsw==
X-Gm-Message-State: APjAAAUvRRJysHy8eT7+HGok6JAVrhAore1Gd/SwW4dXtG7sL3Ug/hum
 dibfynyebhLLuL7DasRhLRnGbGFT
X-Google-Smtp-Source: APXvYqwMMWgrqB8vhrFEVlD3JfxN+ZDRvWrGe47LyWlu3F5v/T3MIsA6LiQ6UQ6ra0s5EiVLCoua+w==
X-Received: by 2002:a5d:4489:: with SMTP id j9mr52585019wrq.15.1561116645008; 
 Fri, 21 Jun 2019 04:30:45 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:17 +0200
Message-Id: <1561116620-22245-23-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 22/25] target/i386: kvm: Add nested migration
 blocker only when kernel lacks required capabilities
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Previous commits have added support for migration of nested virtualization
workloads. This was done by utilising two new KVM capabilities:
KVM_CAP_NESTED_STATE and KVM_CAP_EXCEPTION_PAYLOAD. Both which are
required in order to correctly migrate such workloads.

Therefore, change code to add a migration blocker for vCPUs exposed with
Intel VMX or AMD SVM in case one of these kernel capabilities is
missing.

Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
Message-Id: <20190619162140.133674-11-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c     | 9 +++++++--
 target/i386/machine.c | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index c931e9d..e4b4f57 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1640,9 +1640,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
                                   !!(c->ecx & CPUID_EXT_SMX);
     }
 
-    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
+    if (cpu_has_vmx(env) && !nested_virt_mig_blocker &&
+        ((kvm_max_nested_state_length() <= 0) || !has_exception_payload)) {
         error_setg(&nested_virt_mig_blocker,
-                   "Nested virtualization does not support live migration yet");
+                   "Kernel do not provide required capabilities for "
+                   "nested virtualization migration. "
+                   "(CAP_NESTED_STATE=%d, CAP_EXCEPTION_PAYLOAD=%d)",
+                   kvm_max_nested_state_length() > 0,
+                   has_exception_payload);
         r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
         if (local_err) {
             error_report_err(local_err);
diff --git a/target/i386/machine.c b/target/i386/machine.c
index fc49e5a..851b249 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -233,7 +233,7 @@ static int cpu_pre_save(void *opaque)
 
 #ifdef CONFIG_KVM
     /* Verify we have nested virtualization state from kernel if required */
-    if (cpu_has_nested_virt(env) && !env->nested_state) {
+    if (kvm_enabled() && cpu_has_vmx(env) && !env->nested_state) {
         error_report("Guest enabled nested virtualization but kernel "
                 "does not support saving of nested state");
         return -EINVAL;
-- 
1.8.3.1



