Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB16C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09A521920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 16:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKY8y2bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09A521920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFhtM-0007CC-TO
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 12:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrB-0005Ct-L9
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrA-0003Co-KS
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrA-0003Bs-Bz
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id w12so20494305wro.5
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=U3fj+xNWWNXfmdtAjAlU14qxTz9PIMStcxxgkK/Civo=;
 b=CKY8y2bkZSLO4tm2tnPhELY/R+/TqMpvQedSOw6Tv/bA2h8iqN0KiD2kdZHmCmlWxi
 IdnLQDxZyqkS/f12ai47ialorCkVL2t2kUrFn8C6eOpTg4vMhoZToF1EZZZdRgJYK2YW
 sev0tfWYDFIh21soDgOl959p/3HO1oIAk58o8SeIJqsYDOg2XOGB5udHx6Zcfybs2s/z
 WW/v8kcFah5Z+IKnkOBY0txjrxQ8qt71wDaS+lDp/lLY1LxSs3yo8zQIXyasqjeqmxEJ
 MO89EDvYGDONMUCeRvcRPmp0pEH7PeOZAVbwEh/RZt2gS8zWoU9xXLLByvDjDtqEOjzL
 7Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=U3fj+xNWWNXfmdtAjAlU14qxTz9PIMStcxxgkK/Civo=;
 b=HiFtwWTl1Q7h1rZzIkU5ihuuTTiguOAZJW6LHChKtp9z+KxoCab6h2nEO6uBpsY9v1
 zYUUoGK/pib+duxONnrybk4Cn0Zn2WAlR5I6PfNqvnmzbUwyt8HxZpzCJ18rmZJyChuB
 kb1cOgOGy8bzbzzfLNTRQ09sUbRYH1C84cKKG3AIgf/DLjTcAKHmIetz18xJfEIwPqzR
 vziJlZmKUoTAlMAg1poF581WgzIo5/HI9og83/l9rhOSE1LdE2ACQ/Vg5Ue8IZSrfL2b
 mHkxAnF+LA2H1fNlP31KXHOQePZ+QNi0fP3zbBRkgPo1+8UHNU5Qx+jsu2QCourjVMaE
 Oi4g==
X-Gm-Message-State: APjAAAX+JonZ+NSnjbob9ALPaCRzuspmWUZgjxko16EhsiNSoaHcV0K4
 nOdw8j8xQNeRlkhpVtSq5pe/ittr
X-Google-Smtp-Source: APXvYqzwGAYEySuxFVf3S6XfRQQOwnf+uBFoLzB7tMfBFXIJ38Xn0KcDqps98o0zqWliA8BHHn4rnw==
X-Received: by 2002:adf:9d87:: with SMTP id p7mr3339852wre.245.1570035123196; 
 Wed, 02 Oct 2019 09:52:03 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/30] target/i386: work around KVM_GET_MSRS bug for secondary
 execution controls
Date: Wed,  2 Oct 2019 18:51:31 +0200
Message-Id: <1570035113-56848-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
index 7c5ad26..91d0bf6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -479,6 +479,23 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
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



