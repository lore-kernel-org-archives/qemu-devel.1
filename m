Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDA4C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0675621670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcy/TTqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0675621670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAB8E-0004CT-PT
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 06:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAAov-0001pU-VK
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAAou-00050z-Sc
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iAAot-0004zi-04
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 06:34:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id o18so2515988wrv.13
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Kd0p6yXmgjigeU61/QAXfYOPrIpw2GObANA3tBzEWzw=;
 b=Tcy/TTqmdP3cFF8IWO4M8trtmbMDxfiSL9FtaY5WehJOFL8MKjoAHX0nP8mMQNW9eF
 4wGBZymVJoYoOok5p1MNni3BO1YMpfGW7928XVgleiMzGbtaNOpOFUloOlqCOmpWX+0Q
 +xKJi0AN+yq2BvdMQlZ4G2ccLhPCFyHVYuO//OQZQXr+UwcHWh/lKDb6newdHjWhuoLs
 Nzwt49+dNJA6qbj1S2L0+EVypMWtzvjlTyaXR62QJf51qa0nv4CkjJx7OVbAncojP1MV
 DWS8HJWJX0Az/CjAetUiCYEQVQ4EyIiWMO/AQ0/OxW5TQNds4DhuQaZ9w65J9ES1QfqO
 TNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Kd0p6yXmgjigeU61/QAXfYOPrIpw2GObANA3tBzEWzw=;
 b=jfvsmEjnxLxprHoJodofUMz08OfvmH7DXXZWhQH9AfuFkVCRG+uq9zbJR4HxZR+NSi
 feZYzGYLlLOQBy5ws9H5f5W+aJC+5EbXrIeNI5JBdmk5yNgH2XOXKY278IpUpsV0veIq
 2ug5sPznV64rROQDVEGXJnTyCwczH6LLMVD2lIXAPVq5Bt/iUT972wBnubYgg2UsL+/9
 ioJUtahAQxdIr1/iakF4MuV7CDmqYfYcYrj424RHFHyXJQ16mys4x97IOSoxd248lsBf
 f1ATAzzJ0RDgZLEHGMwjHyLRfiRvTOuJXpI6UxWz9VB346EOTwzu7nfvU2H/Q0iUkSXY
 KKUg==
X-Gm-Message-State: APjAAAVD9IKlkBZppTw5n7j914wPwH6A2Cz2l9EsHarNxHMqDPl3WgwD
 JinKYYhLEqLeMHke1wAp7hIS3bsl
X-Google-Smtp-Source: APXvYqw+9KAl0Byh1d2oNvbFfXtqjeaYoqdkpBc7zLE9aqUDgNP4li2hXn3ISv1cGVuZIsaWNxL4fA==
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr2237822wrw.174.1568716489579; 
 Tue, 17 Sep 2019 03:34:49 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q3sm1985415wrm.86.2019.09.17.03.34.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 17 Sep 2019 03:34:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 12:34:40 +0200
Message-Id: <1568716480-9973-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
References: <1568716480-9973-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 7/7] target/i386: work around KVM_GET_MSRS bug
 for secondary execution controls
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
Cc: liran.alon@oracle.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some secondary controls are automatically enabled/disabled based on the CPUID
values that are set for the guest.  However, they are still available at a
global level and therefore should be present when KVM_GET_MSRS is sent to
/dev/kvm.

Unfortunately KVM forgot to include those, so fix that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index bba1930..4843f8c 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -478,6 +478,23 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
     value = msr_data.entries[0].data;
     switch (index) {
     case MSR_IA32_VMX_PROCBASED_CTLS2:
+        /* KVM forgot to add these bits for some time, do this ourselves.  */
+        if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) & CPUID_XSAVE_XSAVES) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) & CPUID_EXT_RDRAND) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX_INVPCID) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX_RDSEED) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING << 32;
+        }
+        if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) & CPUID_EXT2_RDTSCP) {
+            value |= (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
+        }
+        /* fall through */
     case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
     case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
     case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
-- 
1.8.3.1


