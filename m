Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC04DC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ABE422275
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABE422275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXfgQ-0008PU-VA
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 03:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kXfcl-0004pD-FQ; Wed, 28 Oct 2020 03:11:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2421)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kXfcj-0003Lw-Km; Wed, 28 Oct 2020 03:11:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CLfrr5jxGzLqcG;
 Wed, 28 Oct 2020 15:11:56 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 15:11:47 +0800
Message-ID: <5F9919B3.9070605@huawei.com>
Date: Wed, 28 Oct 2020 15:11:47 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: <pbonzini@redhat.com>, <chenhc@lemote.com>, <pasic@linux.ibm.com>,
 <borntraeger@de.ibm.com>, <mtosatti@redhat.com>, <cohuck@redhat.com>
Subject: [PATCH 4/4] i386/kvm: make printf always compile in debug output
References: <5F97FD61.4060804@huawei.com> <5F991331.4020604@huawei.com>
 <5F9914EE.8050209@huawei.com> <5F991641.4050606@huawei.com>
In-Reply-To: <5F991641.4050606@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=alex.chen@huawei.com;
 helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 03:11:46
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: zhengchuan@huawei.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: AlexChen <alex.chen@huawei.com>
---
 target/i386/kvm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3e9344aed5..64492cb851 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -50,14 +50,13 @@
 #include "exec/memattrs.h"
 #include "trace.h"

-#ifdef CONFIG_DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
+#ifndef CONFIG_DEBUG_KVM
+#define CONFIG_DEBUG_KVM  0
 #endif

+#define DPRINTF(fmt, ...) \
+    do { if (CONFIG_DEBUG_KVM) { fprintf(stderr, fmt, ## __VA_ARGS__); } } while (0)
+
 /* From arch/x86/kvm/lapic.h */
 #define KVM_APIC_BUS_CYCLE_NS       1
 #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
-- 
2.19.1

