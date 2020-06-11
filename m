Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AF2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A38C2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8mzQ1Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A38C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTwV-000839-PB
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAP-0001uf-SF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25832
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAN-0001QC-4c
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQuqoF6ysfE+PJsNjiFp4bgJ5ewc0pmiCefhv+JlDGM=;
 b=P8mzQ1MtqFAfyXXXUG6/9Key/ovmAnHSlmTPdvNKBN/JC2qrVu9EjPpuUWOUTK3VpEPbnc
 RVd3ki/I33vRrBl5QlJRyyB6OrZ4MdpdQ3IeUw91M0RPo/ZgtWEGs2l8uLaU7f8X0ydsf3
 +KYpz0zHS4T57YH/xkmmUALWHs6QAGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-hDbcjJ8aPoSTZN_bzTw1Kg-1; Thu, 11 Jun 2020 15:47:08 -0400
X-MC-Unique: hDbcjJ8aPoSTZN_bzTw1Kg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D91E01005512;
 Thu, 11 Jun 2020 19:47:04 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C91410013D0;
 Thu, 11 Jun 2020 19:47:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 098/115] i386: hvf: Drop HVFX86EmulatorState
Date: Thu, 11 Jun 2020 15:44:32 -0400
Message-Id: <20200611194449.31468-99-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Bolshakov <r.bolshakov@yadro.com>

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200528193758.51454-14-r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/typedefs.h | 1 -
 target/i386/cpu.h       | 1 -
 target/i386/hvf/hvf.c   | 1 -
 target/i386/hvf/x86.h   | 4 ----
 4 files changed, 7 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index de68d51d52..ce4a78b687 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -51,7 +51,6 @@ typedef struct FWCfgIoState FWCfgIoState;
 typedef struct FWCfgMemState FWCfgMemState;
 typedef struct FWCfgState FWCfgState;
 typedef struct HostMemoryBackend HostMemoryBackend;
-typedef struct HVFX86EmulatorState HVFX86EmulatorState;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
 typedef struct IOMMUMemoryRegion IOMMUMemoryRegion;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index da511a23b3..c6f816c58d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1600,7 +1600,6 @@ typedef struct CPUX86State {
 #if defined(CONFIG_HVF)
     hvf_lazy_flags hvf_lflags;
     void *hvf_mmio_buf;
-    HVFX86EmulatorState *hvf_emul;
 #endif
 
     uint64_t mcg_cap;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 57696c46c7..be016b951a 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -568,7 +568,6 @@ int hvf_init_vcpu(CPUState *cpu)
 
     hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
     env->hvf_mmio_buf = g_new(char, 4096);
-    env->hvf_emul = g_new0(HVFX86EmulatorState, 1);
 
     r = hv_vcpu_create((hv_vcpuid_t *)&cpu->hvf_fd, HV_VCPU_DEFAULT);
     cpu->vcpu_dirty = 1;
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index 483fcea762..bacade7b65 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -228,10 +228,6 @@ typedef struct x68_segment_selector {
     };
 } __attribute__ ((__packed__)) x68_segment_selector;
 
-/* Definition of hvf_x86_state is here */
-struct HVFX86EmulatorState {
-};
-
 /* useful register access  macros */
 #define x86_reg(cpu, reg) ((x86_register *) &cpu->regs[reg])
 
-- 
2.26.2



