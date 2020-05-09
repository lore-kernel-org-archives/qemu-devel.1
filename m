Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DE6C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A71214D8
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl0CXBPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A71214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXPI1-00041O-GD
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 09:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEc-0004aQ-9s; Sat, 09 May 2020 09:09:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEb-0005Q0-HU; Sat, 09 May 2020 09:09:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id m24so3357702wml.2;
 Sat, 09 May 2020 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IIEEHUjsrjg149IdCnCJKS5PWD554RDC6FHVKmSpxnE=;
 b=Nl0CXBPpXNxQ0v8jKUxF1Se16t8u56AbbYFOXIfPtb3ZUkfj0ZUg/dU3Thk8Lr1Q7t
 kabpZj03s+ZUNpvujY4Zy+nYe12FYxm2JYH0Sat58Kz7SFKvyQ3iMSG3y1MYqATHFUve
 XyfFNfP52J7d35j7A/kxh/ByzGKFK/Wgnz3+tTUgFcDTmF7jMtKEdpgxQ5PP4ZMZjUd+
 EH1224KiMOCijg6RGClqqyea+dKpk/2QfqW51WcpNx9UN98xYL+BD6Ueqm040CnlBCEx
 dKrqgMaikR6NN+CpCvHMTBA3/73OgPdGOl6ZD8FHNRWIL1RhGB+33Jxa+5cdqfwouDCs
 SHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IIEEHUjsrjg149IdCnCJKS5PWD554RDC6FHVKmSpxnE=;
 b=H6cMrgyIKSxWy1xD7Wz0qKFu3NyPRonjAiTJ0O4HKfWwD4ofhhzIeChYouFjSpFXnI
 07hm98z4p+YsEu8g++pBlSOLgT8iLuHb0fh2pXmDJokf8XgW1A6rG/qNjunvoloq435e
 tOzAH4OhCxxks+K/YM5YbFtIuMlTxTfC9uX5KyM6j4wX9PndNOYWozXhkxRZ/88IzlQc
 exP92mp6vz89XNfshuJduvN+sEMLejDdzafVyv/iSa0EvQ/kpGZe2Z3mO2KKoL2nj2HU
 bD9nS2QeC5m/XBa8cnORvPY1FbyK7gxIYv83vCyyr5jtRs+TOtGYUYhgOcneNS/6yF2k
 pcXw==
X-Gm-Message-State: AGi0PuYOIiBwJlGjWSZBCfomI7eS8VGeO85WtFoV3XJiDAfbKKLNmp9d
 fDiq5oiVLaqqffcB1JApYkAykf2WlQk=
X-Google-Smtp-Source: APiQypIQv5dktkJhLCJa+f5nseiL+K4OPMQciaBIjnNe4IrHVAf2DQjQGyL8101k14juuCgRuJvDfA==
X-Received: by 2002:a1c:2e4d:: with SMTP id u74mr22275473wmu.145.1589029778450; 
 Sat, 09 May 2020 06:09:38 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m65sm1411410wmm.17.2020.05.09.06.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2020 06:09:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/11] target/s390x: Restrict system-mode declarations
Date: Sat,  9 May 2020 15:09:07 +0200
Message-Id: <20200509130910.26335-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509130910.26335-1-f4bug@amsat.org>
References: <20200509130910.26335-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As these declarations are restricted to !CONFIG_USER_ONLY in
helper.c, only declare them when system-mode emulation is used.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/s390x/internal.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index c1678dc6bc..ddc276cdf4 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -236,7 +236,6 @@ int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
 
 /* cc_helper.c */
 const char *cc_name(enum cc_op cc_op);
-void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
 uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
                  uint64_t vr);
 
@@ -303,18 +302,20 @@ void s390_cpu_gdb_init(CPUState *cs);
 
 /* helper.c */
 void s390_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+void do_restart_interrupt(CPUS390XState *env);
+
+#ifndef CONFIG_USER_ONLY
+void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
 uint64_t get_psw_mask(CPUS390XState *env);
 void s390_cpu_recompute_watchpoints(CPUState *cs);
 void s390x_tod_timer(void *opaque);
 void s390x_cpu_timer(void *opaque);
-void do_restart_interrupt(CPUS390XState *env);
 void s390_handle_wait(S390CPU *cpu);
+hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 #define S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
 int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
 int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
-#ifndef CONFIG_USER_ONLY
 LowCore *cpu_map_lowcore(CPUS390XState *env);
 void cpu_unmap_lowcore(LowCore *lowcore);
 #endif /* CONFIG_USER_ONLY */
-- 
2.21.3


