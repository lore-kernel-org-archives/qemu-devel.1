Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C8BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFFF2078B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3hgz2Q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFFF2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtbIg-0007w7-H5
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 14:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtbI5-0007X4-7H
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:29:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20845
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtbI3-00059s-Bh
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594319338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VKcBXJ2letvmBnO5KZw8Cctm61HH48N0nrHNFiOaC8M=;
 b=O3hgz2Q8PIUXI1UYwOpEf7hXYynizXFGBOVXyoAY+dZZAiBLkkAK+j1JCvIQlZfsRjC30D
 66WMJYYrkidFbUIYmi0zwvjB+lbvIUt6I7TNPrPaf9+3pUkf+5mT08UkkRNe9Bj0flkAjd
 WEu2CZUzetC5VRcQz125PtiI6jL2TTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-9G3BIYoAM0u782SW3X9W4w-1; Thu, 09 Jul 2020 14:28:53 -0400
X-MC-Unique: 9G3BIYoAM0u782SW3X9W4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98B7218FF663
 for <qemu-devel@nongnu.org>; Thu,  9 Jul 2020 18:28:52 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FC8360BE2;
 Thu,  9 Jul 2020 18:28:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-headers: update again to 5.8-rc
Date: Thu,  9 Jul 2020 14:28:49 -0400
Message-Id: <20200709182849.10309-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:02:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cohuck@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

5.8-rc1 inadvertently broke userspace ABI compatibility.  Merge
again with latest kvm/master to undo that.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	The patch should get to Linus tomorrow.  Posting here to
	ensure it is on people's radar for hard freeze, because
	I probably won't be around.

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


