Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA1CC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD182146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9ldxjFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD182146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKTV-00041f-FT
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57083)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKIS-0001ms-2i
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hiKIP-0004sx-Tj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hiKIC-0004Tk-9l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:02:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id n4so18251414wrs.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wOuMJApxDA9WcfQrsT3Xap/eF0wAVuDrPdCETgZJjl4=;
 b=b9ldxjFVGG30XlPUvOdbU5qIq8qSmhD111Vb2ye2gBF9uaJOAaPx9Gm3/G7GryaBNY
 2NYJt24C2gvuLIZcc68QBqVpKqC8HLgsoOqFeB5N/JeXSexUfWM99b9D7h37n42Z/AOe
 qwiZ22byvibvHkL3bAc4E93mPfXAQuxSWNBaKfAhyab760P5jst9TqsndY9Q4Q4spsF9
 +9HUvGuZ3xKolSI4XlkWldC5XCWid8y2YaqlrFo5NdmG6ZTSruE04ZL5c6mc+8lV8utG
 5kkFQqiaSv8L5/FUxH75gX7uC90bhobsgOH+H9u4nEDYjLyNvV8ooyhJtXhM1W+x/795
 V48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=wOuMJApxDA9WcfQrsT3Xap/eF0wAVuDrPdCETgZJjl4=;
 b=QlSbBdYPH6a1jf9kYy1F4sVk3IDW55Y09+917BzDQo2JPfrGHyb4BRyoyqyZvC9WYL
 uvkC8vfd8FzQK8/AWRIHkrvLPxWUeSg3GeIZTH++HtrF48f81v+9yXWnd+JXP/gcm8zr
 L9K4XxPjIzoRIqgG4cxrPdFx19NeZSIRIbM9wdsB8ACraUCsuWEOb5b0lIDnOZjboXUL
 TlScR5w5EtL6rsrKHuIm7W9J+i0d7EQ5C3o19e8ZUmDUlxg0hHmbr1STG27uXi3OxMym
 flGoEH/7nG2wJ0Bxj+57YxfOT6nHxS2PEhAMsb5ybZktb923MJaP9NMG89R1Zp370m02
 IgMQ==
X-Gm-Message-State: APjAAAWXPeH7ZHfv4rS3pFti1F1jAi19L0G0vujvK8s96fYHaD8xgUIN
 HrZtHk7vquqRwIFfTZ724uOZ3tjl/KY=
X-Google-Smtp-Source: APXvYqwCFDtv9wDTFLZGuX40Xnum0JzAHGBBzldyyo6z/sgbFYslZm8WIajiwjaPEjCXtiOx7IfBcw==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr23124832wrs.289.1562079692906; 
 Tue, 02 Jul 2019 08:01:32 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id m24sm3006262wmi.39.2019.07.02.08.01.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 08:01:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 17:01:21 +0200
Message-Id: <1562079681-19204-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Liran Alon <liran.alon@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>
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
index e35489c..84b42a5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -469,6 +469,23 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
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


