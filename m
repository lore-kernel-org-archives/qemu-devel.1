Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2B2C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B409A206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trskbFfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B409A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35144 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRKf-00079G-1G
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 02:06:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9J-0005Xi-Pz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9H-0003BA-Ts
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:21 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR9H-00039B-N6; Fri, 03 May 2019 01:54:19 -0400
Received: by mail-pg1-x544.google.com with SMTP id i21so2180212pgi.12;
	Thu, 02 May 2019 22:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=gtYREJ6wLh93MiaNJLpdXl6ZvqtubSybEdUbcIWsFl0=;
	b=trskbFfQefrhnK+Cjs5e1j/6cAjG4RZmdk3u3FYCGxANeGiqRBmZnQnCQbKTrzcSRX
	p+ArU1UzDRgJ1IHpqSfMTmpwRKReSLX+1XHxgvANKExOIF17AnHC/lckAt4+R/EKu5tk
	7OTw18lmLXTKjszvsKSIbDs5TgjebVDAd0YsvPV7B/Ze9KnX8Dv/3Q9zjC8K9dVSEGY0
	pre5iT5N8QDj9+uwIP2bSQEysYluhIjP0KLhiMKQdcYfvQpIcvx4x37H5DaZUFNYZ7FK
	qykHSl+N66+D6abCjLdle0WwPa9VBX5r21eGhsTrlFKkMUy+yqagU2R8GSbhegqRL7q0
	dMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=gtYREJ6wLh93MiaNJLpdXl6ZvqtubSybEdUbcIWsFl0=;
	b=Mg+77HoEvb4xh9zKL+Prw2yi0CJYob9COYHJRM4Z3hFjeXd6etr5Nh1iW3NORALBhK
	ld1xRNk/82Mq12uzs91YZPFZjcZvhyr9amdggxdlDhdOv/kHN8Zh7n0FdEkd1LQxzB/j
	NLWgG7l7FXt8ADPbjwEzkdu/hxxm1WvQHkPgn8NX6NrlMszUNEeKCOcABcII8j9DzP/m
	YMK+fh8gFlhaEdG/ShvVz/EX19cFTFxr2r9ibL+X7czGzepAdBLeN/D2XZn76Q2RL2C8
	/3NIxlb0dN6cg4U9DppbAkEMYbQvuEaZzmAOzQS9f0Pl4E/kef6LaUvbs7EMn3B9nBg2
	9A7A==
X-Gm-Message-State: APjAAAUfrKhpi5wNHptYc0I7jZmknv7uhGK1hQtaED1Qu5Am8HsOZaiP
	WOUxrsXKEBfidn2DFVjQbhQUXpOMgBI=
X-Google-Smtp-Source: APXvYqwKLHECau+wOCXrfcfYSijLgBdqgF3WdrOFfHw1FnjUDAlavv2il/LNe9O5XieDoEBHo098Ug==
X-Received: by 2002:a63:4714:: with SMTP id u20mr8224571pga.316.1556862857150; 
	Thu, 02 May 2019 22:54:17 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.54.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:54:16 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:11 +1000
Message-Id: <20190503055316.6441-9-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 08/13] target/ppc: Implement hcall
 H_SET_PARTITION_TABLE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503055311.lCJy2r88IMIwXp4JcPMVkQZXrAkiUlE_94mF3vL3SJ0@z>

The hcall H_SET_PARTITION_TABLE is used by a guest acting as a nested
hypervisor to register the partition table entry for one of its guests
with the real hypervisor.

Implement this hcall for a spapr guest.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_hcall.c   | 22 ++++++++++++++++++++++
 include/hw/ppc/spapr.h |  4 +++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 4d7fe337a1..704ceff8e1 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1828,6 +1828,25 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_set_partition_table(PowerPCCPU *cpu,
+                                          SpaprMachineState *spapr,
+                                          target_ulong opcode,
+                                          target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong ptcr = args[0];
+
+    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV) == 0) {
+        return H_FUNCTION;
+    }
+
+    if ((ptcr & PTCR_PATS) > 24)
+        return H_PARAMETER;
+
+    env->spr[SPR_PTCR] = ptcr;
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -1934,6 +1953,9 @@ static void hypercall_register_types(void)
 
     spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
 
+    /* Platform-specific hcalls used for nested HV KVM */
+    spapr_register_hypercall(H_SET_PARTITION_TABLE, h_set_partition_table);
+
     /* Virtual Processor Home Node */
     spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
                              h_home_node_associativity);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4251215908..e591ee0ba0 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -501,7 +501,9 @@ struct SpaprMachineState {
 /* Client Architecture support */
 #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
 #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
-#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
+/* Platform-specific hcalls used for nested HV KVM */
+#define H_SET_PARTITION_TABLE   0xF800
+#define KVMPPC_HCALL_MAX        H_SET_PARTITION_TABLE
 
 typedef struct SpaprDeviceTreeUpdateHeader {
     uint32_t version_id;
-- 
2.13.6


