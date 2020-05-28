Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5633CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B51207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Saape6FQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B51207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeOUw-00069z-A8
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOMD-0000oG-CT
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:26 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35590 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOMC-00076x-8X
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:25 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 13A8A4C862;
 Thu, 28 May 2020 19:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1590694689; x=1592509090; bh=f5NDlVcrfB8PcbqTeueHnMo2+38qPV8/4mc
 0Vtwyjgo=; b=Saape6FQPgx4JQpqG39uBHsvGTMVGFoRhxqpV03SBx0zB4B0s3g
 8c3yk+7/z+2VG2+1+FGZB9iPWvXkvX5wMbpX8+2XlOueaqUUcdJV0qajvGoDzpZv
 1HXRQ90zixDEkfjnFWfUBuojM71Q0YfidjJ0G6RVa08VVlDGARpHzRws=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id el7UULZuXwJz; Thu, 28 May 2020 22:38:09 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 7FA364C865;
 Thu, 28 May 2020 22:38:06 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 28
 May 2020 22:38:08 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 13/13] i386: hvf: Drop HVFX86EmulatorState
Date: Thu, 28 May 2020 22:37:58 +0300
Message-ID: <20200528193758.51454-14-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200528193758.51454-1-r.bolshakov@yadro.com>
References: <20200528193758.51454-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 15:38:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 include/qemu/typedefs.h | 1 -
 target/i386/cpu.h       | 1 -
 target/i386/hvf/hvf.c   | 1 -
 target/i386/hvf/x86.h   | 4 ----
 4 files changed, 7 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index ecf3cde26c..6ce0356f2c 100644
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
index be44e19154..abf9d10d86 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1594,7 +1594,6 @@ typedef struct CPUX86State {
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
2.26.1


