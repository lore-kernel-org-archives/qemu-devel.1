Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127C2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 23:50:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9922077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 23:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZi8NSDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9922077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju2mN-0003VW-Ta
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 19:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ju2lZ-000264-6T
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 19:49:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39122
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ju2lW-0002uf-QA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 19:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594424953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8utxLwaNAiiMOI2KtG/DyUw3rlELxriZ7d3RyB2kN8=;
 b=OZi8NSDCZy/zd/45SmE5ScqI1kYykP6Z1eNk4Ru+flMnM0otRPT3XuVkyfB97hmGSU/5jI
 jTKBnbFzUiZhwm3DvaUybxuQidD40FiO4w5YysAf8ToBHeElGJ/H6XE8KKpBZbFIEDnyut
 znNqI2Xl/0wDF5LRQ7bnyxjoKFH9hxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-XB3Emkh4Mc2nAp1ba4GGRQ-1; Fri, 10 Jul 2020 19:49:12 -0400
X-MC-Unique: XB3Emkh4Mc2nAp1ba4GGRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3341719057A0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 23:49:11 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 027355C298
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 23:49:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 47/47] linux-headers: update again to 5.8
Date: Fri, 10 Jul 2020 19:49:09 -0400
Message-Id: <20200710234909.21682-3-pbonzini@redhat.com>
In-Reply-To: <20200710234909.21682-1-pbonzini@redhat.com>
References: <20200710234909.21682-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 19:49:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

5.8-rc1 inadvertently broke userspace ABI compatibility.  Merge
again with latest kvm/master to undo that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-headers/asm-arm/unistd-common.h | 1 +
 linux-headers/asm-x86/kvm.h           | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-headers/asm-arm/unistd-common.h b/linux-headers/asm-arm/unistd-common.h
index 23de64e44c..57cd1f21db 100644
--- a/linux-headers/asm-arm/unistd-common.h
+++ b/linux-headers/asm-arm/unistd-common.h
@@ -392,5 +392,6 @@
 #define __NR_clone3 (__NR_SYSCALL_BASE + 435)
 #define __NR_openat2 (__NR_SYSCALL_BASE + 437)
 #define __NR_pidfd_getfd (__NR_SYSCALL_BASE + 438)
+#define __NR_faccessat2 (__NR_SYSCALL_BASE + 439)
 
 #endif /* _ASM_ARM_UNISTD_COMMON_H */
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 17c5a038f4..0780f97c18 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -408,14 +408,15 @@ struct kvm_vmx_nested_state_data {
 };
 
 struct kvm_vmx_nested_state_hdr {
-	__u32 flags;
 	__u64 vmxon_pa;
 	__u64 vmcs12_pa;
-	__u64 preemption_timer_deadline;
 
 	struct {
 		__u16 flags;
 	} smm;
+
+	__u32 flags;
+	__u64 preemption_timer_deadline;
 };
 
 struct kvm_svm_nested_state_data {
-- 
2.26.2


