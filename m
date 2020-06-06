Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED84C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647FE206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647FE206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYm0-0007ZD-EX
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgV-0007CD-6N
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:27 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgU-0007fC-2V
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:26 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Myb4H-1ikuC31Eyb-00yy0x; Sat, 06 Jun 2020 15:16:22 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 16/19] target/i386: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Sat,  6 Jun 2020 15:16:04 +0200
Message-Id: <20200606131607.1250819-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hGmWWUrnidlbqWrM475Qa7LsXTKgep3+u42mFTEx0ReD1frOOm6
 5d+6hDuGSIh6wspZYRl1iKGNCRGJw/iE8G4u39JAGyuYUjWIys6w5MRFTiplDIGpz8vnC3M
 gMUvEs8zVDJ12VuP5klqfZFERC4FiWJJELxhPhz2HyzLIGiujk37gx2+EnCNfFPxEooMBja
 d/NQ6Uzvu2wyhWm8QtCpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mEjE+vpSH+c=:VZ82BG56nTrURGRfUbGBgf
 j5xHOxLL76KtbrUpx2dgkWvrZcQgakMuOCmgrpfUWyuR3nGC8WKr2MQNe68yll1y/d8ucTELx
 6zNBeiNrKMZogjmpu8akuEJVeBKlMOhk1+lTzMOKcBn1z6tKLuztvaclSjkh/mseyH1mnyUJR
 LSeLeN+J/pixzmmcofWq0Y5ZLqFjZK9qaTzI2qv+NaP6XCoA1bGyapzcY9s9W9r2uOzzEnFhU
 08tUinBcWdFTyBY0EzglRT31mJLA/bVmysGwayGQzcPTGgGl1LyVDBh03Ep7P3uW+DrAGMKYC
 x6eNEZTZdB0iWFFUzl2v3xxapSZu9MyWK0ru417lEp/c5QlO/92iEk/0sfUGkjAF9oplUXdNr
 USrYNukcams/fBE3qTnGh8I/RNJ2mKHWafN7bxGL+pzW7+V8wQNir9TZWydRQawVrENVg2Abs
 aiyTbi9ePGKN1+wpKdJvquCTg+0urAEEuQ0l1kJnw+T6enO6NsgMrIagFGFnewjkpzM7JQoZW
 e91FQL35foN0tdbU6fBYCgyUE3DOBE3m5Lye5uFBIZ8Fzusd6a23h7cSWO0OhmqeYA3ogBTCo
 hIzX63MsJ676vK5NCsnL//fjN2vXwHbbyF0dCkLhYqKbd3fxLs624BEezfsskNCyOgVTFvTXu
 XAno2yUhZDhskVpYwN5KNAmQg9UQAi5W0NLeTYo3zgfAq6YlU7vItMOoJMIH5HDLbCLR3RMgJ
 SBAI6y0QBeX3j87fzeTj82ddx5cCiHzsecPAccidaMgArrZBIX7w97bFzQusIo25WMDVHNGm9
 WUmv2xjd6GxgzRptODdI8wOIzoh+3dc/xoyAZdl2c3Y9I8BS3fYGoBCPSUhnrhfufaYlihO
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
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
Message-Id: <20200522172510.25784-11-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/i386/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7a4a8e3847f0..dd31c1de5f2b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6843,6 +6843,7 @@ static void x86_cpu_register_feature_bit_props(X86CPU *cpu,
     x86_cpu_register_bit_prop(cpu, name, w, bitnr);
 }
 
+#if !defined(CONFIG_USER_ONLY)
 static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -6886,6 +6887,7 @@ static void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                      errp);
     qapi_free_GuestPanicInformation(panic_info);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static void x86_cpu_initfn(Object *obj)
 {
@@ -6932,8 +6934,10 @@ static void x86_cpu_initfn(Object *obj)
                         x86_cpu_get_unavailable_features,
                         NULL, NULL, NULL);
 
+#if !defined(CONFIG_USER_ONLY)
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
+#endif
 
     for (w = 0; w < FEATURE_WORDS; w++) {
         int bitnr;
@@ -7245,7 +7249,6 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
 #endif
     cc->dump_state = x86_cpu_dump_state;
-    cc->get_crash_info = x86_cpu_get_crash_info;
     cc->set_pc = x86_cpu_set_pc;
     cc->synchronize_from_tb = x86_cpu_synchronize_from_tb;
     cc->gdb_read_register = x86_cpu_gdb_read_register;
@@ -7256,6 +7259,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->asidx_from_attrs = x86_asidx_from_attrs;
     cc->get_memory_mapping = x86_cpu_get_memory_mapping;
     cc->get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug;
+    cc->get_crash_info = x86_cpu_get_crash_info;
     cc->write_elf64_note = x86_cpu_write_elf64_note;
     cc->write_elf64_qemunote = x86_cpu_write_elf64_qemunote;
     cc->write_elf32_note = x86_cpu_write_elf32_note;
-- 
2.26.2


