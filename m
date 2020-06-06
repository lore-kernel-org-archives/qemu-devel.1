Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9DAC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43974206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43974206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYrD-0002XJ-Hv
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgf-0007Qj-9W
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:37 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgb-0007gK-UX
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:36 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M9nlN-1jdxeY1SJJ-005uWB; Sat, 06 Jun 2020 15:16:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 13/19] target/riscv/cpu: Restrict CPU migration to
 system-mode
Date: Sat,  6 Jun 2020 15:16:01 +0200
Message-Id: <20200606131607.1250819-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9UhZ8rF6x9qroVqlPvbwJysM18+fds1WlEyFZVqCr530QxMHIFq
 Gxj0XISe5+D5T1vvli5wQYsVCJ0g2jz3Zgzuy8HQN/X1ZCGOqtW4i+yQd07+8zLwAUr7lIO
 u817uGTbdj3l1ptg3EcWy/kzs8b1y7RbjvJXqfhw3JVuMkvGh+HgxbriaHdNkF2QJ3x5Cei
 goOi3SWwLJQIyV8zb/dhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5RhwfZ8yzgc=:EoEsZ34bgV1AgVlsWga0zT
 st9WbcEeIot9eAmBUQNq/V5OC4JoLpeoiSyzjqOX4f+g2p1S6i7N0CW63ANOE70cB55PgohUs
 nk/m/8dfesHUz/fsF/EKkZLD3XF+1tbRlU7XqZHRanVqmVLn5xroqeqyjxAF98RGOSYNW1pja
 wyLiH9nlVeVBY9H6XQa7xT1zcnx/fq17FCOUwtERb0Q8VnwHLE3SDSdvgs/jOI3RItZBCkLkO
 Ku2VZ8pQULbGEcLYxvnoFnqHufABr4dbRkTbdz8ZUuqXhT6p/bkVx/HmBRZ2m0J0d3B3K4w/r
 tYf2kaTpZoe6XS6NzgxpaRY/60HO79ZF5/eZr6uI/SPGcqjqAfx1/hoT+gY2PckQU3f4i2GV1
 nx3enDZqTz/2U0DaPFM6dl5F5RL0lD3DVmW6kbJNgPM4uMkFKNYia1UDNRw/A1UMFikLtOD4i
 h0/x7PwIB/8eeh6gln9It86XxUU5AY7Qwsl+SuvbWPunhJLufLaerDVjXuQTowl53PWNUxcja
 t4y1wJNlDVb7xB9vbq0uvB6gg9PE2AzKZsQRUrAeSHDGUp8ReydcKqUlTn09M8uYNsbsYkyTA
 PmyYZ52V5x6ytvHYixJa91irZNTvhO1BPWdTxbJTj0CerJa1KCf/+nhsgaOm4TH28Wo65jvjL
 8yFf2hJ8UbRSnfkK60c4IVTMVv4coW7f5Sy4uUx7IzayHi7pO2B+wWaSOWiZzC46mvIwVyWi2
 q1TIDES+vmpY+rhoZjHlcsqryKS0scaHFnPrxLVCzgOx6XMJpxG0KaQFK4vSKjn7WNolYKrAM
 X/ZcXTC0bkDPA5199uLBppPc5gzNWFVIchAH+JiLj3t0Sck3dlzW0JT4IzVLk4Ku8Hai/R7
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:17
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-8-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/riscv/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059d71f2c715..6c78337858ad 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -485,10 +485,12 @@ static void riscv_cpu_init(Object *obj)
     cpu_set_cpustate_pointers(cpu);
 }
 
+#ifndef CONFIG_USER_ONLY
 static const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
     .unmigratable = 1,
 };
+#endif
 
 static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("i", RISCVCPU, cfg.ext_i, true),
@@ -544,13 +546,13 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->do_transaction_failed = riscv_cpu_do_transaction_failed;
     cc->do_unaligned_access = riscv_cpu_do_unaligned_access;
     cc->get_phys_page_debug = riscv_cpu_get_phys_page_debug;
+    /* For now, mark unmigratable: */
+    cc->vmsd = &vmstate_riscv_cpu;
 #endif
 #ifdef CONFIG_TCG
     cc->tcg_initialize = riscv_translate_init;
     cc->tlb_fill = riscv_cpu_tlb_fill;
 #endif
-    /* For now, mark unmigratable: */
-    cc->vmsd = &vmstate_riscv_cpu;
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
-- 
2.26.2


