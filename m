Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318FAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC504204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LREDIWJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC504204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddLP-0002ZU-0O
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJl-0006u1-Rb; Tue, 26 May 2020 13:24:45 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:45448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jddJl-0004TN-2C; Tue, 26 May 2020 13:24:45 -0400
Received: by mail-ed1-x541.google.com with SMTP id s19so18295187edt.12;
 Tue, 26 May 2020 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lXlYd5mDWippGeVthUR2pLi5N4ankzNYCPx8o3NujjY=;
 b=LREDIWJxx4B3Ha0/bpf0Hk8y68xksGN7GewX10ouk3K/VyGQ6SzDZ0TI0k4ZR9j5Eu
 WlSoWLAuCA0NX7VNXdta0cqgKlEWX63INWLmjzHiNwfG6KyGubPS+99979AQaLKsrBFq
 wbbRQEDT1pp19nvVXJQT0uCIcZXfnGbYHURQs+pfnkrLnrg7STKTKhvgfzfL6BC7X1sU
 8sFsi4tw9PiWIwgAiESJBsZEqPZhQH5oUU2LzL1FOEJ80iQmX9/B4n7cCEAqrR+7RnoP
 crV5gHm41/knqqIYrQaoc2ha/xIYcDGFvulW0hBUHhpd7L90AbAz7dtb9TvAEp++/qk8
 YH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lXlYd5mDWippGeVthUR2pLi5N4ankzNYCPx8o3NujjY=;
 b=fqpg0dM4nNbJIPOFfYwkUIBIKB5TJNg0qWDfTE7Z7n5GjbwSurtXIVUfdApgBXsdR3
 9M/gsRU8I73SoysFdUB/PadjaT/2x9lueL0HYnndNviunqBqQZeTOObyBKkubgqn3IVr
 2/9PEcZD8Spaj27KL/7JBKv2wA6NXFk5HvJOOCUq7/UzEkkS5RBiX7QVgAtu2JFJ8X5D
 1oFoRZXxI2Y14Da0KDQaOLnnJMx+byZuDmicR6P9CHn3kXhETMenMZrO6WCgv0SdpGt7
 zf8kG/jCzXdrysWeDNFqrrNA9Ez7UZ7y+vhf/K9fjTapH/jVYJGL+13PKBhVOvFYkeB4
 QjWA==
X-Gm-Message-State: AOAM530ckK1GkX6AwspRgJ1v4T0rI/0yrecNwhzljhXE4r7q9wJQSfUo
 kaq0naNrWrbi1LdEAbMG6sGkIDvqHmM=
X-Google-Smtp-Source: ABdhPJww+rvpUSymARdYrNqFwgPT5+khuR2IHpjHQddzMvQeMt90fV3tOlMSBBEAxGxtj8uC+vpu1g==
X-Received: by 2002:a05:6402:31b1:: with SMTP id
 dj17mr20998881edb.142.1590513882606; 
 Tue, 26 May 2020 10:24:42 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id bf15sm421357edb.46.2020.05.26.10.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 10:24:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] target/s390x: Restrict system-mode declarations
Date: Tue, 26 May 2020 19:24:27 +0200
Message-Id: <20200526172427.17460-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526172427.17460-1-f4bug@amsat.org>
References: <20200526172427.17460-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As these declarations are restricted to !CONFIG_USER_ONLY in
helper.c, only declare them when system-mode emulation is used.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Keep load_psw() is /* cc_helper.c */ section (cohuck)
---
 target/s390x/internal.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index c1678dc6bc..b1e0ebf67f 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -236,9 +236,11 @@ int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
 
 /* cc_helper.c */
 const char *cc_name(enum cc_op cc_op);
-void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
 uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
                  uint64_t vr);
+#ifndef CONFIG_USER_ONLY
+void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
+#endif /* CONFIG_USER_ONLY */
 
 
 /* cpu.c */
@@ -303,18 +305,18 @@ void s390_cpu_gdb_init(CPUState *cs);
 
 /* helper.c */
 void s390_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
-hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
+void do_restart_interrupt(CPUS390XState *env);
+#ifndef CONFIG_USER_ONLY
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


