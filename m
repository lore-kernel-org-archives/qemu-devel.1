Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A4AC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A2C21734
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuFnzhxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A2C21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhw7-0003HZ-Vt
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:37:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hLhuI-00022w-7d
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hLhuF-0002ah-6E
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:35:50 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hLhuE-0002aT-Uy; Wed, 01 May 2019 01:35:47 -0400
Received: by mail-pg1-x543.google.com with SMTP id h1so7899804pgs.2;
	Tue, 30 Apr 2019 22:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jMPw4+T1aUXXvMawKhd3pNQEvpVoHaZ7PltWVwe184o=;
	b=JuFnzhxLa5wHiFRjZR095O2VlJhlehCl4vaITfsyY/BDKtHsgIb+HOTg3nW13A0Rca
	kUQiDtiDzMZK7FY9DctCY0rT9l8D4VvZzIgxOTUPkJ4wPOLhLcdpLWDnowYE+9n35NOi
	vZwqbGGhWMo0+MzoIQDdQY5uw+F4RZukZCwNJ+EeaIBLb+yOfW55fLLgu94Nkxhy1oL/
	OkjFT7YNrujmXUwPB/uY2NhPs4UkIlrmKXPyXqCDsJaUvM/4aRwLDtOVhErMzm3dqVoO
	ypynlBSP9HW5yLKbIeOroqPsfCFHsKidz3imekDB3tiIotskThJXH19dYwOBUCzr14IF
	P8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jMPw4+T1aUXXvMawKhd3pNQEvpVoHaZ7PltWVwe184o=;
	b=qHtvl2aaTAi9xAWhTOedeopjX3YS2/9Q0QDu0DQby9dyL2EOUJk+S/jN6IAjA83aXq
	haQe1maNkzoNTu3Eeb2rBt4pmmi8yCvT6AJJe6U5+Gz4XmAV2pvSFFStIezNKu+5nV7I
	Zux7EjzFG6FUT+EBL77mRvf0WBsWZTeWQIB36o3+A69p2iSrd5VId9d6hb4lai2mLgtx
	LE6mZPGVwfbsLRXlzxECDev9Ujp9zBrEAU3ygWrsIxybJkjsVEG5n4CLcOG6MApe7Cr3
	E5Qk2JI60tzihsibKkq0/hmidLST+2NsyPkVImgXOFTW0Lbl9F+Kv0jB/yf6jv5bCR4s
	WEAA==
X-Gm-Message-State: APjAAAWc1X/eG4+Xi7yNft4MBdwT03ZJSQD2sXLXFAVJaTgn04K507Em
	D7vM7OMvaeQriPvrprMY1XHuozY5
X-Google-Smtp-Source: APXvYqyKolQw7k+oWyXzPUaN4q/JRwteXrTo4Efo/wXBt7Ibq5sRhdonY9iPEb2cqEb1xjcMUZGbYA==
X-Received: by 2002:a63:550c:: with SMTP id j12mr3334248pgb.450.1556688945808; 
	Tue, 30 Apr 2019 22:35:45 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com.ozlabs.ibm.com ([122.99.82.10])
	by smtp.gmail.com with ESMTPSA id
	h19sm62932986pfd.130.2019.04.30.22.35.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 22:35:45 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 15:35:22 +1000
Message-Id: <20190501053522.10967-2-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190501053522.10967-1-sjitindarsingh@gmail.com>
References: <20190501053522.10967-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 2/2] ppc: Add dump-stack implementation
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
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, dgilbert@redhat.com,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501053522.xnZNOporOEesprEXMjISemnHI-wdIL1cbMODxlThu38@z>

The monitor function dump-stack is used to dump the stack for a cpu.
This can be useful for debugging purposes when the stack cannot be
dumped by another means.

Add a ppc implementation ppc_cpu_dump_stack().
The stack pointer is stored in R1 with the back pointer at offset 0 and
the link register at offset 2.
Also dump the registers from the stack frame if the marker "regshere" is
found.
This only dumps the kernel stack, stopping if a non-kernel address is
found in the stack.

Sample output:
(qemu) dump-stack
sp: 0xc00000007bfc5690 lr: 0xc0000000000974b8
sp: 0xc00000007bfc56f0 lr: 0xc00000000065aab4
sp: 0xc00000007bfc5720 lr: 0xc00000000065ab04
sp: 0xc00000007bfc5740 lr: 0xc0000000000c29b8
sp: 0xc00000007bfc57b0 lr: 0xc0000000000bc9e8
sp: 0xc00000007bfc57e0 lr: 0xc0000000000bd584
sp: 0xc00000007bfc5800 lr: 0xc0000000000bee14
sp: 0xc00000007bfc5ac0 lr: 0xc0000000000c2100
sp: 0xc00000007bfc5c60 lr: 0xc000000000029460
sp: 0xc00000007bfc5ca0 lr: 0xc00000000010b5e8
sp: 0xc00000007bfc5d00 lr: 0xc000000000105f34
	trap : 0x0000000000000700
	pc   : 0xc000000000104490
	msr  : 0x9000000002843003
	lr   : 0xc000000000103ffc
	gpr 0: 0x0000000000000001
	gpr 1: 0xc00000005051f530
	gpr 2: 0xc000000001088200
	gpr 3: 0x0000000000000001
	gpr 4: 0xc000000032d60000
	gpr 5: 0xc0000000014b8f00
	gpr 6: 0x0000000000c835e0
	gpr 7: 0x0000000000000000
	gpr 8: 0x0000000000000000
	gpr 9: 0xc000000032f00000
	gpr10: 0x9000000002803033
	gpr11: 0xc000000000b60f00
	gpr12: 0x0000000000002000
	gpr13: 0xc000000001250000
	gpr14: 0x0000000000000000
	gpr15: 0x0000000000000008
	gpr16: 0x0000000000000000
	gpr17: 0xc00000000114f790
	gpr18: 0x00000000ffffffff
	gpr19: 0xc00000005051f8e8
	gpr20: 0x0000000000000001
	gpr21: 0x0000000000000000
	gpr22: 0x0000000000000001
	gpr23: 0x0000000000000001
	gpr24: 0x0000000000000001
	gpr25: 0xc0000000014b8f70
	gpr26: 0x0000000000000000
	gpr27: 0x0000000000000001
	gpr28: 0x0000000000000001
	gpr29: 0x0000000000000000
	gpr30: 0xc0000000014b8f00
	gpr31: 0xc0000000014b8f00
sp: 0xc00000005051f530 lr: 0x0000000000000000
sp: 0xc00000005051f600 lr: 0xc000000000103ffc
sp: 0xc00000005051f670 lr: 0xc0000000000f60a8
sp: 0xc00000005051f850 lr: 0xc0000000000f18c0
sp: 0xc00000005051fa10 lr: 0xc0000000000f5184
sp: 0xc00000005051fae0 lr: 0xc0000000000ddf54
sp: 0xc00000005051fb00 lr: 0xc0000000000dab9c
sp: 0xc00000005051fb90 lr: 0xc0000000000cbf88
sp: 0xc00000005051fd00 lr: 0xc0000000003e7480
sp: 0xc00000005051fdb0 lr: 0xc0000000003e7ce4
sp: 0xc00000005051fe00 lr: 0xc0000000003e7d88
sp: 0xc00000005051fe20 lr: 0xc00000000000b3a4
	trap : 0x0000000000000c01
	pc   : 0x00007fffa6c9d8d0
	msr  : 0x900000000280f033
	lr   : 0x0000000010090f40
	gpr 0: 0x0000000000000036
	gpr 1: 0x00007fffa62fdd70
	gpr 2: 0x00007fffa6d57300
	gpr 3: 0x000000000000000d
	gpr 4: 0x000000002000ae80
	gpr 5: 0x0000000000000000
	gpr 6: 0x0000000000000537
	gpr 7: 0x0000000000000000
	gpr 8: 0x000000000000000d
	gpr 9: 0x0000000000000000
	gpr10: 0x0000000000000000
	gpr11: 0x0000000000000000
	gpr12: 0x0000000000000000
	gpr13: 0x00007fffa6306380
	gpr14: 0x0000000000000000
	gpr15: 0x0000000000000001
	gpr16: 0x0000000039ba6928
	gpr17: 0x0000000000000000
	gpr18: 0x0000000000000000
	gpr19: 0x00007fffa6d702f0
	gpr20: 0x00007fffa62fddf0
	gpr21: 0x0000000000000080
	gpr22: 0x0000000000000004
	gpr23: 0x0000000000000000
	gpr24: 0x0000000010ac85c0
	gpr25: 0x0000000000000008
	gpr26: 0x00007fffa62fde10
	gpr27: 0x0000000000000000
	gpr28: 0x0000000000000002
	gpr29: 0x0000000000000000
	gpr30: 0x0000000039ba6900
	gpr31: 0x0000000010ac85c0
sp: 0x00007fffa62fdd70

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/cpu.h                |  1 +
 target/ppc/translate.c          | 60 +++++++++++++++++++++++++++++++++++++++++
 target/ppc/translate_init.inc.c |  1 +
 3 files changed, 62 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 5e7cf54b2f..28c4dffca1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1284,6 +1284,7 @@ struct PPCVirtualHypervisorClass {
 void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
+void ppc_cpu_dump_stack(CPUState *cpu, FILE *f);
 void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
 hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8d08625c33..b162998ce7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7705,6 +7705,66 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #undef RFPL
 }
 
+struct ppc_pt_regs {
+        unsigned long gpr[32];
+        unsigned long nip;
+        unsigned long msr;
+        unsigned long orig_gpr3;
+        unsigned long ctr;
+        unsigned long link;
+        unsigned long xer;
+        unsigned long ccr;
+        unsigned long softe;
+        unsigned long trap;
+        unsigned long dar;
+        unsigned long dsisr;
+        unsigned long result;
+};
+
+void ppc_cpu_dump_stack(CPUState *cs, FILE *f)
+{
+#if defined(TARGET_PPC64)
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    uint64_t sp, next_sp, lr, buf[4];
+
+    /* stack pointer stored in r1 */
+    sp = env->gpr[1];
+
+    while (sp && (sp & (0xCUL << 60))) {
+        uint64_t marker = 0UL;
+
+        /* read and print LR */
+        cpu_physical_memory_read(sp & ~(0xCUL << 60), buf, sizeof(*buf) * 4);
+        next_sp = buf[0];
+        lr = buf[2];
+        qemu_fprintf(f, "sp: 0x%.16lx lr: 0x%.16lx\n", sp, lr);
+        sp &= ~(0xCUL << 60);
+
+        /* Does the stackframe contain regs? */
+        cpu_physical_memory_read(sp + 96, &marker, sizeof(marker));
+        if (marker == 0x7265677368657265) { /* regshere */
+            struct ppc_pt_regs regs;
+            int i;
+
+            cpu_physical_memory_read(sp + 112, &regs, sizeof(regs));
+
+            qemu_fprintf(f, "\ttrap : 0x%.16lx\n", regs.trap);
+            qemu_fprintf(f, "\tpc   : 0x%.16lx\n", regs.nip);
+            qemu_fprintf(f, "\tmsr  : 0x%.16lx\n", regs.msr);
+            qemu_fprintf(f, "\tlr   : 0x%.16lx\n", regs.link);
+            for (i = 0; i < 32; i++)
+                qemu_fprintf(f, "\tgpr%2d: 0x%.16lx\n", i,
+                            regs.gpr[i]);
+        }
+
+        sp = next_sp;
+    }
+
+    qemu_fprintf(f, "sp: 0x%.16lx\n", sp);
+#endif
+}
+
 void ppc_cpu_dump_statistics(CPUState *cs, int flags)
 {
 #if defined(DO_PPC_STATISTICS)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 0394a9ddad..3fd24f85cc 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10587,6 +10587,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     cc->do_interrupt = ppc_cpu_do_interrupt;
     cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt;
     cc->dump_state = ppc_cpu_dump_state;
+    cc->dump_stack = ppc_cpu_dump_stack;
     cc->dump_statistics = ppc_cpu_dump_statistics;
     cc->set_pc = ppc_cpu_set_pc;
     cc->gdb_read_register = ppc_cpu_gdb_read_register;
-- 
2.13.6


