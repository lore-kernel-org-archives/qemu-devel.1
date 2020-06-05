Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB4AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C642320659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C642320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAx9-0008VA-0e
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAok-0008Jt-MY
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:24 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoj-0006ld-Bo
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MnItm-1jHyx51YLE-00jHXv; Fri, 05 Jun 2020 13:47:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 17/19] target/s390x: Restrict CpuClass::get_crash_info() to
 system-mode
Date: Fri,  5 Jun 2020 13:46:58 +0200
Message-Id: <20200605114700.1052050-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:j05KdHmdCVgMP8p1kUx62yWEaDCFPR+YNFkE+3yH5fYYGyLFBAR
 HuogOPZIKXX3g+D0Wlq9waEj1N2YUVqHUqMAXVhaxzOArWVe2FZh1V1yfQbRwuVimYNRF9Y
 NMLlDc2SlL4lossZ55UO1ML4y5gd5hzXl4yvV1KEMg36OQ0ObDvwXbtzSjqABfXmReiowV4
 fcoIOoUePNLSFiu/vg8Og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JB7nqQ54VMU=:tZXkYWHTfvlaC6e6UErCXs
 WaAeDdUtNvcHjUP5rF7Pu1AMUgP5oZyJaeVWza9DZtEfP4PGFkspv1PzVwOKyqYaq7qTNWbS7
 GBSoaBKc9N4jzgLdgARXwPvY6lR/Ir/iss1jkadnQKzlMWrCvq9Pg5jbuERn+Wb4ZV6L4cVhX
 nBb8oOv1Mg0nSgg+4XmXRJSzIkVSvASG+zLL/hWBbo/cR6riYQaNpvuhvztrGaeinlMDaxh3g
 QnJNShwQ4XTIW/HvXQhFRW4DFqnb1gEp4I6oU0h2X8gcACnvhzWzqKzZvvSxigmO83o6SCFAV
 s+9/uZ6IzbId/U6lCO21HcTQSGi3VEUKtPsQFYCuD+rwkxXn8ELG2ZDvVuc0+TI5GJaMGPAhv
 hSMW8e7p0NaNiOGXTouAA1QEhdvnGZhuMxRcicWuitrxpnKAuiyr2xWh4hCaHygt93C3oVODe
 NguJlJbKeCQWe3DhShEHZLPXEqtnalLykDy8yrKw7jhL5p5lpudLiRr8TKgpwnVQVUj+H6aon
 7QN0YKfI+2uapIX+qadYbb4BBBdfZwl5MyKhcTyPd7pRDy8BA1NgpQWYBFzpadkFBxHmeHZv3
 Q5+URJqQYI9fid23QWXpDwxiumu8VWKrf/gbCQm1rG2L7SzbFApdeAXK4+LR/A/qilLl2VhC6
 +81n0Cwzi+KXc7HWMvSERYOHAN8zAbTPLcYvw2Kf6nlLNyKeIiQsICxu0wHn7ptc1lIPz4/Jk
 OSV+Ozkj3sOJAGaW2Wk77haUaywQScCtJXdOnltbSZpemhlgx5vffl/Lp1xXBwFZWFuePxtdZ
 uw22/3/+qn4+o0NWbE77n3qyB75E7gib+R2hm+i2ScTTMqskKkwnDgiaocP5/WDE9DPGg7K
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:47:20
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
 Laurent Vivier <laurent@vivier.eu>, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-12-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/s390x/cpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index ca50b7045198..08eb674d22b4 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -247,6 +247,7 @@ out:
     error_propagate(errp, err);
 }
 
+#if !defined(CONFIG_USER_ONLY)
 static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
 {
     GuestPanicInformation *panic_info;
@@ -256,11 +257,7 @@ static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
     panic_info = g_malloc0(sizeof(GuestPanicInformation));
 
     panic_info->type = GUEST_PANIC_INFORMATION_TYPE_S390;
-#if !defined(CONFIG_USER_ONLY)
     panic_info->u.s390.core = cpu->env.core_id;
-#else
-    panic_info->u.s390.core = 0; /* sane default for non system emulation */
-#endif
     panic_info->u.s390.psw_mask = cpu->env.psw.mask;
     panic_info->u.s390.psw_addr = cpu->env.psw.addr;
     panic_info->u.s390.reason = cpu->env.crash_reason;
@@ -286,6 +283,7 @@ static void s390_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                      errp);
     qapi_free_GuestPanicInformation(panic_info);
 }
+#endif
 
 static void s390_cpu_initfn(Object *obj)
 {
@@ -295,16 +293,16 @@ static void s390_cpu_initfn(Object *obj)
     cpu_set_cpustate_pointers(cpu);
     cs->halted = 1;
     cs->exception_index = EXCP_HLT;
+#if !defined(CONFIG_USER_ONLY)
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL);
-    s390_cpu_model_register_props(obj);
-#if !defined(CONFIG_USER_ONLY)
     cpu->env.tod_timer =
         timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
     cpu->env.cpu_timer =
         timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 #endif
+    s390_cpu_model_register_props(obj);
 }
 
 static void s390_cpu_finalize(Object *obj)
@@ -488,13 +486,13 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->do_interrupt = s390_cpu_do_interrupt;
 #endif
     cc->dump_state = s390_cpu_dump_state;
-    cc->get_crash_info = s390_cpu_get_crash_info;
     cc->set_pc = s390_cpu_set_pc;
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
     cc->get_phys_page_debug = s390_cpu_get_phys_page_debug;
     cc->vmsd = &vmstate_s390_cpu;
+    cc->get_crash_info = s390_cpu_get_crash_info;
     cc->write_elf64_note = s390_cpu_write_elf64_note;
 #ifdef CONFIG_TCG
     cc->cpu_exec_interrupt = s390_cpu_exec_interrupt;
-- 
2.26.2


