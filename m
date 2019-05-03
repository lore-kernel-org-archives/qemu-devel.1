Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4BDC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3564A206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qApfJgqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3564A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35077 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRGV-0003xW-EL
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 02:01:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9R-0005fU-2H
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9Q-0003Gq-1J
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:29 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR9P-0003Gb-S0; Fri, 03 May 2019 01:54:27 -0400
Received: by mail-pf1-x443.google.com with SMTP id e24so2329331pfi.12;
	Thu, 02 May 2019 22:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=JdwoaU5GV525JDI8/HF+XmgK9OOCinXikocReCcBxn4=;
	b=qApfJgqs8EpXqJRftrYvr5Ti9d0x/7e92xEzsVrMCFwax9zYcWfJRR9Ak6BqinjpJV
	DTVWQeUJEGFB2+6oENOrOc9pSnArvvfeARzx2iBcVGSzqO1es/jmpGd2iSHNb42axjoV
	OMO9J1qSgWvbi3YgSTo8tONv/2G/kzHA2f6UJ3guUtx8KsCX//IjPEtneTy6vnK7GTiG
	HcCCQjHaPnDq2X8LSsbLVU8ORqFjCByVQsvskvWnBrEI5a43D7lNuIKinOhbqTikVG5R
	H8+rKwo35dAziXqFaRqrwUA92Wvd7fRMgUUHBCaYyDP3wu9JAmmKhIh3qJGON1+TIbGS
	T0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=JdwoaU5GV525JDI8/HF+XmgK9OOCinXikocReCcBxn4=;
	b=ObkGcNEgVc5S6RTT+P4lyTZ0Lk/HDlLssQJP3GVgoAoPXLcOTJfDfp4O5Rd0c9BiG8
	L6XP1xfEBEnahgCmGUfp+1c1hNgq76lehSrxZE7+d15GLkPbKdRI0H5pjmXymIhrR3ob
	dI/KeVX2vef4wwLh5gvNCg4UTrznHRbttQbYY4IeIMGTKPl0VF2Nz7tHYCt7DG/6djuL
	soTy61lj9LitmZsUMmF6NOhBl4t+2r+UKS5zrIzDaYKLMEquYg3CJOfffihaexojyrME
	G40a1cJGDn7ydWggb55d8FLV8/Z6/nQOjkYNQVHolCKLobHdUd9geFCaTJkJEJOqT7hA
	rUhw==
X-Gm-Message-State: APjAAAWOmQrItqmNXHrfBu5jNxqAQAqLA0yAfWFx1+oRAcNt//F21HSK
	MNwSEp7Vo7lzX+0B+yoatqSUihLV1LA=
X-Google-Smtp-Source: APXvYqwSscdK1Ak4kgItbXamj3Q6FloJ5nr0fg9Ug3RWgZhmeCrjKOAjOQQwIacS0gU9Nmjr+7sdNA==
X-Received: by 2002:a62:5885:: with SMTP id m127mr8587947pfb.33.1556862866867; 
	Thu, 02 May 2019 22:54:26 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.54.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:54:26 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:13 +1000
Message-Id: <20190503055316.6441-11-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 10/13] target/ppc: Implement hcall
 H_TLB_INVALIDATE
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
Message-ID: <20190503055313.HsiFYP5OUSlxv13Zs5zksuTqpUN6t6x79XP6woQE5Vo@z>

The hcall H_TLB_INVALIDATE is used by a guest acting as a nested
hypervisor to perform partition scoped tlb invalidation since these
instructions are hypervisor privileged.

Check the arguments are valid and then invalidate the entire tlb since
this is about all we can do in tcg.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_hcall.c   | 28 ++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 ++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 68f3282214..a84d5e2163 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -2131,6 +2131,33 @@ void h_exit_nested(PowerPCCPU *cpu)
     env->gpr[3] = trap;
 }
 
+static target_ulong h_nested_tlb_invalidate(PowerPCCPU *cpu,
+                                            SpaprMachineState *spapr,
+                                            target_ulong opcode,
+                                            target_ulong *args)
+{
+    target_ulong instr = args[0];
+    target_ulong rbval = args[2];
+    int r, ric, prs, is;
+
+    if (spapr_get_cap(spapr, SPAPR_CAP_NESTED_KVM_HV) == 0) {
+        return H_FUNCTION;
+    }
+
+    ric = (instr >> 18) & 0x3;
+    prs = (instr >> 17) & 0x1;
+    r = (instr >> 16) & 0x1;
+    is = (rbval >> 10) & 0x3;
+
+    if ((!r) || (prs) || (ric == 3) || (is == 1) || ((!is) && (ric == 1 ||
+                                                               ric == 2)))
+        return H_PARAMETER;
+
+    /* Invalidate everything, not much else we can do */
+    cpu->env.tlb_need_flush = TLB_NEED_GLOBAL_FLUSH | TLB_NEED_LOCAL_FLUSH;
+    return H_SUCCESS;
+}
+
 static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
 static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_HCALL_BASE + 1];
 
@@ -2240,6 +2267,7 @@ static void hypercall_register_types(void)
     /* Platform-specific hcalls used for nested HV KVM */
     spapr_register_hypercall(H_SET_PARTITION_TABLE, h_set_partition_table);
     spapr_register_hypercall(H_ENTER_NESTED, h_enter_nested);
+    spapr_register_hypercall(H_TLB_INVALIDATE, h_nested_tlb_invalidate);
 
     /* Virtual Processor Home Node */
     spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 7083dea9ef..6a614c445f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -504,7 +504,8 @@ struct SpaprMachineState {
 /* Platform-specific hcalls used for nested HV KVM */
 #define H_SET_PARTITION_TABLE   0xF800
 #define H_ENTER_NESTED          0xF804
-#define KVMPPC_HCALL_MAX        H_ENTER_NESTED
+#define H_TLB_INVALIDATE        0xF808
+#define KVMPPC_HCALL_MAX        H_TLB_INVALIDATE
 
 typedef struct SpaprDeviceTreeUpdateHeader {
     uint32_t version_id;
-- 
2.13.6


