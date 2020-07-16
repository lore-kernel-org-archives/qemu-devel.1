Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2194BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF08B2065E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBdT5d8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF08B2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvwv4-00017e-6H
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 01:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvwsr-0005fo-Kq; Thu, 16 Jul 2020 01:56:41 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jvwsp-0000L1-R6; Thu, 16 Jul 2020 01:56:41 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f139so9721387wmf.5;
 Wed, 15 Jul 2020 22:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YoykrVtjYqt8oRbnP42shFLWN1mv4jmw4/LHlHynF4c=;
 b=kBdT5d8T5IyPmNxFgjdDqoZ3KFrZcM5nHb47Cuvcd04cmx7rm3GTascv3NmtTycHJ0
 vg4zzWrpmAOQl++usns8ZvOTrQu60LniB7J6MRhv015L8bGfKbmvkV/hGIZpAlm75uZr
 X68PwT8MPZebOP76P6I76RiJCFeky7HKqnb9JGPkA7uUN2aNvzIJ56sEyu98w6XCOuJX
 OhhV3X0Pv5AuRYRcds/TUJTyU+dQLD4Z14SNBn+E92QR0GmG8WXkVNzrUC7vMM+3AtXe
 SHGslr5Q8S5Qx4Jzf/MV+Lnvr05N2SuOmUXyW3dowiyfUuC06ApQxgCcaEozRgUo/kXq
 t7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YoykrVtjYqt8oRbnP42shFLWN1mv4jmw4/LHlHynF4c=;
 b=Borzabavigw1U9veeVWH3tp4Gz6Fuw3+4G0S1/r/9NQiKNP2U8Psuu6uhdLTeBmUPd
 gNk2f4qHWH+JpD7vAbv1JF0KA+8GkTtNvm916to27v2A1dOni4q3ll3XGCFdq7f7Qg4m
 WQYie9u+t9AtcNtsfr0pKP4MaEKt3jg9Sb7X8qu9hYNk3MROQS3pqxGqvciSy4RV6Qt1
 g7cNswuLgvS3N2lkn4fspatFAU3TmexOilvTcdg0jST9tYM4TkEOXy+AYs7spVP4TuK6
 GGgLyQLgChEtw5VQvYAKHDLk7CDNwVBEFE+lCvTzMy5d08uU/SsfrwT3c6haN6i8b7nl
 +14g==
X-Gm-Message-State: AOAM5317NfQG6fU6aP2dWyu6U5gsmuuT9Egm6ILTd7a3VOw78r/+uctR
 zpggwExk8/igqCaM14Uu5aw=
X-Google-Smtp-Source: ABdhPJyu3z2D+5TGGDcnRiS5/hjk4uROU1VkH2MrkYMSKgDp4sUOkcMmIxSuoculHMilhZBAm8B4bg==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr2694443wmi.94.1594878997659; 
 Wed, 15 Jul 2020 22:56:37 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f12sm7193458wrw.53.2020.07.15.22.56.35
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Wed, 15 Jul 2020 22:56:37 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v5 2/7] roms/opensbi: Upgrade from v0.7 to v0.8
Date: Wed, 15 Jul 2020 22:56:06 -0700
Message-Id: <1594878971-26050-3-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
References: <1594878971-26050-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Upgrade OpenSBI from v0.7 to v0.8.

The v0.8 release includes the following commits:

1bb00ab lib: No need to provide default PMP region using platform callbacks
a9eac67 include: sbi_platform: Combine reboot and shutdown into one callback
6585fab lib: utils: Add SiFive test device
4781545 platform: Add Nuclei UX600 platform
3a326af scripts: adapt binary archive script for Nuclei UX600
5bdf022 firmware: fw_base: Remove CSR_MTVEC update check
e6c1345 lib: utils/serial: Skip baudrate config if input frequency is zero
01a8c8e lib: utils: Improve fdt_parse_uart8250() API
0a0093b lib: utils: Add fdt_parse_uart8250_node() function
243b0d0 lib: utils: Remove redundant clint_ipi_sync() declaration
e3ad7c1 lib: utils: Rename fdt_parse_clint() to fdt_parse_compat_addr()
a39cd6f lib: utils: Add FDT match table based node lookup
dd33b9e lib: utils: Make fdt_get_node_addr_size() public function
66185b3 lib: utils: Add fdt_parse_sifive_uart_node() function
19e966b lib: utils: Add fdt_parse_hart_id() function
44dd7be lib: utils: Add fdt_parse_max_hart_id() API
f0eb503 lib: utils: Add fdt_parse_plic_node() function
1ac794c include: Add array_size() macro
8ff2b94 lib: utils: Add simple FDT timer framework
76f0f81 lib: utils: Add simple FDT ipi framework
75322a6 lib: utils: Add simple FDT irqchip framework
76a8940 lib: utils: Add simple FDT serial framework
7cc6fa4 lib: utils: Add simple FDT reset framework
4d06353 firmware: fw_base: Introduce optional fw_platform_init()
f1aa9e5 platform: Add generic FDT based platform support
1f21b99 lib: sbi: Print platform hart count at boot time
2ba7087 scripts: Add generic platform to create-binary-archive.sh
4f18c6e platform: generic: Add Sifive FU540 TLB flush range limit override
13717a8 platform: Remove qemu/virt directory
65c06b0 platform: Remove spike directory
d626037 docs: Add missing links in platform.md
7993ca2 include: sbi: Remove redundant page table related defines
5338679 lib: sbi_tlb: Fix remote TLB HFENCE VVMA implementation
dc38929 lib: sbi: Improve misa_string() implementation
433bac7 docs: platform/generic: Add details about stdout-path DT property
b4efa70 docs: platform/generic: Add details about IPI and timer expectations
dfd9dd6 docs: Add platform requirements document
c2286b6 docs: Fix ordering of pages in table of contents
7be75f5 docs: Don't use italic text in page title
63a513e lib: Rename unprivileged trap handler
aef9a60 lib: Add csr detect support
13ca20d lib: Create a separate math helper function file
79d0fad lib: utils: Update reserved memory fdt node even if PMP is not present
6a053f6 lib: Add support for hart specific features
b2df751 platform: Move platform features to hart
4938024 platform: fpga: Remove redundant platform specific features
ec0d2a7 lib: timer: Provide a hart based timer feature
1f235ec lib: Add platform features in boot time print
22c4334 lib: Add hart features in boot time print
36833ab lib: Optimize inline assembly for unprivilege access functions
38a4b54 firmware: Correct spelling mistakes
28b4052 lib: sbi: detect features before everything else in sbi_hart_init()
4984183 lib: sbi: Improve get_feature_str() implementation and usage
3aa1036 lib: sbi: Remove extra spaces from boot time prints
3a8fc81 lib: sbi: Print platform HART count just before boot HART id
63b0f5f include: sbi: Use scratch pointer as parmeter in HART feature APIs
2966510 lib: sbi: Few cosmetic improvements to HART feature detection
a38bea9 lib: sbi_hart: Detect number of supported PMP regions
89ba634 include: sbi: Add firmware extension constants
73d6ef3 lib: utils: Remove redundant parameters from PLIC init functions
446a9c6 lib: utils: Allow PLIC functions to be used for multiple PLICs
2c685c2 lib: utils: Extend fdt_find_match() Implementation
d30bb68 lib: utils/irqchip: Initialize all matching irqchip DT nodes
a9a9751 lib: utils: Allow CLINT functions to be used for multiple CLINTs
569dd64 lib: utils: Add fdt_parse_clint_node() function
6956e83 lib: utils/ipi: Initialize all matching ipi DT nodes
a63f05f lib: utils/timer: Initialize all matching timer DT nodes
30b6040 Makefile: Fix builtin DTB compilation for out-of-tree platforms
64f1408 firmware: fw_base: Make builtin DTB available to fw_platform_init()
4ce6b7a firmware: fw_base: Don't OR forced FW_OPTIONS
86ec534 firmware: Allow fw_platform_init() to return updated FDT location
c6c65ee Makefile: Preprocess builtin DTS
4e3876d Makefile: Add mechanism for platforms to have multiple builtin DTBs
72019ee platform: kendryte/k210: Use new mechanism of builtin DTB
51f0e4a firmware: Remove FW_PAYLOAD_FDT and related documentation
1b8c012 lib: Add RISC-V hypervisor v0.6.1 support
79bfd67 docs: Use doxygen config to mark the main page
106b888 docs: Remove redundant documentation about combined payload use case
9802906 platform: Add AE350 platform specific SBI handler
32f87e5 platform: Add AE350 cache control SBIs
e2c3f01 lib: Fix __sbi_hfence_gvma_vmid_gpa() and __sbi_hfence_vvma_asid_va()
6966ad0 platform/lib: Allow the OS to map the regions that are protected by PMP
518e85c platform: Update Nuclei ux600 platform support
d5725c2 lib: Don't print delegation CSRs if there is no S-Mode
637b348 lib: Fix the SBI_HART_HAS_MCOUNTEREN feature check
db56ef3 platform: Add support for Shakti C-class SoC from IIT-M
9bd5f8f lib: sbi: Fix 32/64 bits variable compatibility
2314101 lib: Don't return any invalid error from SBI ecall
a98258d include: Bump-up version to 0.8

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

(no changes since v2)

Changes in v2:
- Upgrade OpenSBI to v0.8 release

 roms/opensbi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/opensbi b/roms/opensbi
index 9f1b72c..a98258d 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 9f1b72ce66d659e91013b358939e832fb27223f5
+Subproject commit a98258d0b537a295f517bbc8d813007336731fa9
-- 
2.7.4


