Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A657C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4F021775
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 13:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQK3okQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4F021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXPJ8-0006Oh-2D
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 09:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEZ-0004S0-Ex; Sat, 09 May 2020 09:09:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXPEY-0004jo-J3; Sat, 09 May 2020 09:09:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id z8so5142038wrw.3;
 Sat, 09 May 2020 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dOtABLpYucdkmo0UeAZ60MKjOPNkZbYs54q0kVYNjc4=;
 b=HQK3okQo3XgNVWABTcc/YPdQSiaGJ3DfZD6sUUm77Yk8M91/zHxprIHjBdeBsmNIdg
 Bn3+sNvRRbzvzyVK7o+vMnT7F6lWE1Iz3Dc5pZD8yA9Su/M/W/MQvv9soEeS1saLjcTe
 1nsJCoI4Dt3gaLZtddO2soy9KlYTqguUaHTrFAwy1FsijxkmQEF8Ye47gY/UgB+Ingrx
 MXCjshWY7FIM1TOUdJ8OPNMRLvDuykIdDhp0rhL65CbYVOl8DVPRp2ITd3RjPSV48+KN
 dvEWFWdZoycY7hiqyy+y32YfKU0m1Agt5JeQFR0A3mdwVcz9WhrfrydHnlsV1s0wWDZY
 JRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dOtABLpYucdkmo0UeAZ60MKjOPNkZbYs54q0kVYNjc4=;
 b=ox6lqT3O/fT4moBwL2DnU4lLErqkAbpAO+PSL1bptqMKlRBUcqSXBYlUKxU7nLNC1a
 ddYvLux7TrAsmy6Ikhjp2+tCPHHF+AQQCiuvBw7SLoqgJzuLmSzxI99ScYuR0jFAbJuk
 9AlY93tcqi8/WGX3ZU05YbKEpj4gmtBBcA8YTvoqfLMry0vYDqPKqYwHQUdpogrhoyYW
 s2yy9WH1jO1zCo5tWBa+7vViw7UhuQpCEwJ/vey2f+HmdC287/NjlitCCLChF3NXuQJM
 DVDeD1OUzXErY0q4CXq4/7oFWD6emPiYZ2+dL/dZadp/MxCdMizF5Q8PnjyImsxygMcN
 f7nw==
X-Gm-Message-State: AGi0PuZOswPyeF8gui4PkdGhfXUTlbdIFnwaUz0sB2OlWZIygIvVp181
 IqFcCIlQRN2oIJ9SaWgaclVYgmq2rnk=
X-Google-Smtp-Source: APiQypIV8V4JDCd+NtoSYkuzj8e2yB4xHjwhOrS9F9Bxn7DYiVKkt3jysGRG12LFj+3ejc82YWxp8A==
X-Received: by 2002:adf:d841:: with SMTP id k1mr8240629wrl.129.1589029775565; 
 Sat, 09 May 2020 06:09:35 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m65sm1411410wmm.17.2020.05.09.06.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2020 06:09:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/11] target/s390x/helper: Clean ifdef'ry
Date: Sat,  9 May 2020 15:09:06 +0200
Message-Id: <20200509130910.26335-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200509130910.26335-1-f4bug@amsat.org>
References: <20200509130910.26335-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

All this code is guarded checking CONFIG_USER_ONLY definition.
Drop the duplicated checks.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Suspicious ifdef'ry in s390_handle_wait() from commit 83f7f32901c.
---
 target/s390x/helper.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 09f60406aa..26e3b366e8 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -33,6 +33,7 @@
 #endif
 
 #ifndef CONFIG_USER_ONLY
+
 void s390x_tod_timer(void *opaque)
 {
     cpu_inject_clock_comparator((S390CPU *) opaque);
@@ -42,9 +43,6 @@ void s390x_cpu_timer(void *opaque)
 {
     cpu_inject_cpu_timer((S390CPU *) opaque);
 }
-#endif
-
-#ifndef CONFIG_USER_ONLY
 
 hwaddr s390_cpu_get_phys_page_debug(CPUState *cs, vaddr vaddr)
 {
@@ -98,14 +96,12 @@ void s390_handle_wait(S390CPU *cpu)
     CPUState *cs = CPU(cpu);
 
     if (s390_cpu_halt(cpu) == 0) {
-#ifndef CONFIG_USER_ONLY
         if (is_special_wait_psw(cpu->env.psw.addr)) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
             cpu->env.crash_reason = S390_CRASH_REASON_DISABLED_WAIT;
             qemu_system_guest_panicked(cpu_get_crash_info(cs));
         }
-#endif
     }
 }
 
@@ -328,6 +324,7 @@ int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
     cpu_physical_memory_unmap(sa, len, 1, len);
     return 0;
 }
+
 #endif /* CONFIG_USER_ONLY */
 
 void s390_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-- 
2.21.3


