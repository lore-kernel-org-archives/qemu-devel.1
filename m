Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF92C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FFBE2063A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFBE2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAtJ-0008V7-Mq
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAok-0008Jl-2Y
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:24 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoi-0006lQ-G0
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:21 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MdNHa-1j872y2HYG-00ZLOh; Fri, 05 Jun 2020 13:47:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 18/19] hw/core: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Fri,  5 Jun 2020 13:46:59 +0200
Message-Id: <20200605114700.1052050-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XKi7JayfZ4bIxgyCevFuE8LkpS48h36jMCNo6wIMbki2NLRjQ2e
 dEhXtm19lPVfUII39nWqvzWoGn2OzFqyPz64x/LuiaLrcoOYvKVrA1uNcCG4iUwwrOWncHH
 6cBON7M8HLr0VKcH9T7MHz8qCAXGRAB3A9fNBuOMyS4Mc8qh5iTtmw+isyyN3276giA1VUV
 dfaH6afLBiYZEDp16kd8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xLyV42TbOaI=:zqSL0zpqLVK7m/z+HwG2hX
 lCBVKG8EYGAVN8wpMz8zuU54SYApinSxyq8+lyWcwhGPxIwGwmYAl/bRQ7d9XWr1+DM94n0Yh
 j5nhxg38EfxI07kr5ySKy9jOz0RLDrj8yyo+iLm2dJMOh0vdTAAATGQBNV+rq1xUrJTrRM33t
 PWm6o0RJLXpCW1G+vmP2mqfw79CTQEP38jBh1zkb09LWEOJoHqWVHmKxlT4EIap5Bd0uUqEX3
 1oehMPQtY4JQYSyUnZryDqWj7VK6I6d//kn9W2L9mMhZHUE1AUFEZbrPc72mLv/1EISPkRyf7
 RqpBpoeeU8acqP+qQhBn84Wn6EHabZ8f2a8tdNvZNsK1RKqpJtlOQfQAZOQg7F8fJu16rWH/g
 qxv6ECMXLue9BkJmXwQrhKaBmLd0aLcmFTAc0YP8yfM4Wm94dljLqyzgw5AWuT/T2NtDRZkLY
 C0XMmX1NFHOYPldaCuK/YdMk6TvSOc7SUWEjt2YQ1D2OYvjdyhYW4OlhYC89Xr7pt9o9n3Aly
 gf9fStXAl59tNFClpmsaVjI0j1nABhtuvHlLvs386QRLKpM9pwgjLcZX4kT7RdRuN8Mf+rsm6
 bR1ff1h6s8OqrHZ/swVIDhD4Uztu9WtlvWLTg0VcDiRCfLyRx+DKG7SL6G0USkBOY7BriW/nN
 L04JJU8aJDKF+ROMzx9y8c4wdTXZLiYBo7teAVzpOWxzBL6gX/EIGPO8tLw36m70Gb896ldGG
 uu4uycxQykZA/GhdG+vbBd1uPb3evcQyqT/UvBplBAiSx8+gbzaPQ/VinYwI9xhDhVBsrPNq9
 VWhvgZUFIxGG6k/By/18fbcTvoujgNyeLqoPBKdCvzyCJH4yl9LsQdoFTeRQCE51bAMYLWU
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-13-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/core/cpu.c         | 2 ++
 include/hw/core/cpu.h | 7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 5284d384fb6b..f31ec48ee61e 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -209,6 +209,7 @@ static bool cpu_common_exec_interrupt(CPUState *cpu, int int_req)
     return false;
 }
 
+#if !defined(CONFIG_USER_ONLY)
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
@@ -219,6 +220,7 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
     }
     return res;
 }
+#endif
 
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
 {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 07f769815502..497600c49efa 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -490,6 +490,8 @@ bool cpu_paging_enabled(const CPUState *cpu);
 void cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp);
 
+#if !defined(CONFIG_USER_ONLY)
+
 /**
  * cpu_write_elf64_note:
  * @f: pointer to a function that writes memory to a file
@@ -539,6 +541,8 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
  */
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
 
+#endif /* !CONFIG_USER_ONLY */
+
 /**
  * CPUDumpFlags:
  * @CPU_DUMP_CODE:
@@ -632,7 +636,8 @@ static inline int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
     }
     return ret;
 }
-#endif
+
+#endif /* CONFIG_USER_ONLY */
 
 /**
  * cpu_list_add:
-- 
2.26.2


