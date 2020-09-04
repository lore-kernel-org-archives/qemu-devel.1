Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9066C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0DE22073B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DE22073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDDu-0003C1-TU
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8G-0000rl-Pu
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33409
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kED8E-0007E2-Ap
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:56:04 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-M6o4meO-Mn-bAiiyl1Y6mQ-1; Fri, 04 Sep 2020 10:54:53 -0400
X-MC-Unique: M6o4meO-Mn-bAiiyl1Y6mQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55F548D3287
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 14:54:52 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAA437E416;
 Fri,  4 Sep 2020 14:54:50 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 10/22] i386: add reserved
 FEAT_HV_RECOMM_ECX/FEAT_HV_RECOMM_EDX CPUID leaves
Date: Fri,  4 Sep 2020 16:54:19 +0200
Message-Id: <20200904145431.196885-11-vkuznets@redhat.com>
In-Reply-To: <20200904145431.196885-1-vkuznets@redhat.com>
References: <20200904145431.196885-1-vkuznets@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As a preparation to expanding Hyper-V CPU features early, add reserved
FEAT_HV_RECOMM_ECX/FEAT_HV_RECOMM_EDX CPUID leaves.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 target/i386/cpu.c | 10 ++++++++++
 target/i386/cpu.h |  2 ++
 target/i386/kvm.c |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 70588571ccb1..3665f22093e9 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1021,6 +1021,16 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = { .eax = 0x40000004, .reg = R_EAX, },
     },
+    [FEAT_HV_RECOMM_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        /* reserved */
+        .cpuid = { .eax = 0x40000004, .reg = R_ECX, },
+    },
+    [FEAT_HV_RECOMM_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        /* reserved */
+        .cpuid = { .eax = 0x40000004, .reg = R_EDX, },
+    },
     [FEAT_HV_NESTED_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = { .eax = 0x4000000A, .reg = R_EAX, },
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 39e0e89aa41f..0668fe74df4f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -524,6 +524,8 @@ typedef enum FeatureWord {
     FEAT_HYPERV_ECX,    /* CPUID[4000_0003].ECX */
     FEAT_HYPERV_EDX,    /* CPUID[4000_0003].EDX */
     FEAT_HV_RECOMM_EAX, /* CPUID[4000_0004].EAX */
+    FEAT_HV_RECOMM_ECX, /* CPUID[4000_0004].ECX */
+    FEAT_HV_RECOMM_EDX, /* CPUID[4000_0004].EDX */
     FEAT_HV_NESTED_EAX, /* CPUID[4000_000A].EAX */
     FEAT_SVM,           /* CPUID[8000_000A].EDX */
     FEAT_XSAVE,         /* CPUID[EAX=0xd,ECX=1].EAX */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 259be2d514dd..c18f221cd301 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1267,7 +1267,10 @@ static int hyperv_handle_properties(CPUState *cs,
         if (c) {
             env->features[FEAT_HV_RECOMM_EAX] = c->eax;
             cpu->hyperv_spinlock_attempts = c->ebx;
+            env->features[FEAT_HV_RECOMM_ECX] = c->ecx;
+            env->features[FEAT_HV_RECOMM_EDX] = c->edx;
         }
+
         c = cpuid_find_entry(cpuid, HV_CPUID_NESTED_FEATURES, 0);
         if (c) {
             env->features[FEAT_HV_NESTED_EAX] = c->eax;
@@ -1358,6 +1361,8 @@ static int hyperv_handle_properties(CPUState *cs,
     c->function = HV_CPUID_ENLIGHTMENT_INFO;
     c->eax = env->features[FEAT_HV_RECOMM_EAX];
     c->ebx = cpu->hyperv_spinlock_attempts;
+    c->ecx = env->features[FEAT_HV_RECOMM_ECX];
+    c->edx = env->features[FEAT_HV_RECOMM_EDX];
 
     c = &cpuid_ent[cpuid_i++];
     c->function = HV_CPUID_IMPLEMENT_LIMITS;
-- 
2.25.4


