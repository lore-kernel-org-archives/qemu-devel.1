Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16054C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27CD2063A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27CD2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAuk-0002uv-5O
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoj-0008IS-6t
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:21 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoh-0006kn-6S
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:20 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M4rHF-1ji0Qf1q59-001wJs; Fri, 05 Jun 2020 13:47:14 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 16/19] target/i386: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Fri,  5 Jun 2020 13:46:57 +0200
Message-Id: <20200605114700.1052050-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HNbpiXTBSavg1AxxxgVlQ8cq6UVStyJ9Y0yKZ2euPqRl5WhuSGB
 e1O64fQFfalmMWKsSINtT/3sLVezc6rJTtlky+EVT9lSxdQ/pRu/tJLuHKlUoaQBwcBUSQ6
 /TuHk/5Pipdn7kKMuXqlPXpicA9kCDPoKyalFFZCzoknYnl4GeKLbrcPiMDhv31C1v9umc5
 HFqf9G/W0zO9+MmtHJaug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lt4v5/XLozA=:jLzzQBN9eOGNekoYPG89sN
 xA/6grRP86lNUe9UgtvqCkuHXRXoG1cFB9IW+9itlrVsASf7iy0PWRFOMzjmMY2HhdNZftUZ6
 A5IBEzck32QYNT0qpkWoemNF/cW0XXWHgf6YJK4BP2Y46Aei9fbsOZ+rPP2BanxsZusyDkyUI
 xTLxybcQfBhHu5vpT86J7UsyDIPPXoEwHuOPw4BYrnQPLbSY9xgdtOFXatdcYuZ3FvpaL9NyT
 VrzYo5S9QJOmQMeZzCEBsMlGjd13UayonADvYs/irVSuW7vw5YHMIi6iiNcdrrG/zPh36uiFw
 +JqacPx4/So9XRfeVQet+lASo6ODpQ8xg0PHW7/Qzm3xws+VUok6Rps3ddFS7lEUXU1f+Pjws
 +Dp4QSy77co0F7nSAo9EOmiBYZ48772p8rguRh9Bmc8Y9Lq7xVj3rI/P+kqMUBRbRIqtJpSVd
 rqudFmVG18pYcJl5t/VBZDZL+7XFU7H/45JIjUUO9ndgd4/x7YGOMdhm8NIy7aFgigK/A451I
 ymPCCgbOUcktRCwJDIyITsa3R0v6eiGzM3PHl82nIRPYPc+akxZ+63LzNYpukMbujzGqV5FK3
 GInsIdGwJCVgklWazg4XtX2CEBNmuK3gM/omqYS8gIpN+wj4+ziFKMCnGaS+FJI+j8ahYv63Q
 hbJwO0Up3cpRFlw6FXXv+i99p5ijb85noE8Vta+ES+HG/ydtkgkZ/LEox2mkQQiEyT831YLR+
 5zkjYj6cvrPHczvHvF6vxdFb/G8yMLaUrzwCAMkIcofJCxtiUCln0EJHES1XZsiSeHDUgz4rc
 jUpJJ3hHYiTGzMsvlR0zqxp+MvbzlCXXU1QFFFDlys6tiExUyF77RKX8n5DXtv48vb9EyEj
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:27:03
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


