Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F011F2084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNwcaauS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F011F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXG3-0005Ql-7S
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7e-00073v-PG
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:51 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdX7d-0002C5-O1
 for qemu-devel@nongnu.org; Tue, 26 May 2020 06:47:50 -0400
Received: by mail-ej1-x641.google.com with SMTP id l21so23288909eji.4
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 03:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SzMnP+v0boOKzPS/hAbB4oxH7IK6D4Ae63ekoZyVIXc=;
 b=DNwcaauSQDgl16ob7UQBkgTmNH/gmXz5+zn3dPBOik4fCqYtS3pmmgd9GgdqaKt44q
 dmGvfEnBZzBzLuNau/wtJmL6YeoeFRQPSAuK28ftn5eIKhrsiVVyNmOVn9P3iwfbrhv/
 QHfxGzW0VGpK+gNSMefsyFQonngHZWYA0oROkwTzy+jf8ai/rYHRl6XEKVJc/+DAo5vr
 5gMZ0uQoUQEyk9UI9CQNyYhhAHrpL47XTji9mVmeV5kqxNbuemlRqBYgsqDJthVFsI9I
 5IXick6YbDrTMd3diRolSd3wJc1k9t3rdpmogJfv4R+A6JOxjEMU1KAw9jOljiUtcpwH
 korg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SzMnP+v0boOKzPS/hAbB4oxH7IK6D4Ae63ekoZyVIXc=;
 b=hvk5pz+Q1ltoff7AN1BUm8+kNZ2UGaF6bgxBPQBCD1L2fF2YSs5ocsNMXmyjr53z6+
 Q69zrsEBcspsapK6GZfV8nSMnjXwMNvUqDwLaCIrJEqsqm4b7KFY/cHfn9yHl5GkjxB1
 i8/A6MaufM/iPsgX0Xe3cXpF0lXZCNLavmbeY1+HL2gifrRRjLbYdA5DqmO77G6rioyT
 l/PBJf6k5d9xzIfAYp+Y91NRpitsKCfs6PfKGTz12pVcs+0UKK0y9Gl8taDcildP9tSs
 yg/h1nUKfTPItz4rm3rxgmymr7LNDWA/YbgHILCgFQP30Mx4AVe16uJLSacjqwq0DQ5T
 Bjlw==
X-Gm-Message-State: AOAM532ZfDVq8xoFbZCRrl0sxsoIRrsrg05YSIPADZ2VAQXp776EsqIk
 S8WVcnMFKnj6xlmGV4QDdDX09Ilv8VM=
X-Google-Smtp-Source: ABdhPJy1srfveRWp4BYfglPPpBm74kwqzlVLximCdMgSDXaasUTut93LWwDHx66jJr980f8hMOkJoA==
X-Received: by 2002:a17:906:1f09:: with SMTP id
 w9mr530482ejj.508.1590490067469; 
 Tue, 26 May 2020 03:47:47 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c27sm3342597ejd.19.2020.05.26.03.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 03:47:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/14] hw/mips/mips_int: De-duplicate KVM interrupt delivery
Date: Tue, 26 May 2020 12:47:25 +0200
Message-Id: <20200526104726.11273-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526104726.11273-1-f4bug@amsat.org>
References: <20200526104726.11273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Refactor duplicated code in a single place.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200429082916.10669-2-f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_int.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 796730b11d..4a1bf846da 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -47,17 +47,12 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
 
     if (level) {
         env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
-
-        if (kvm_enabled() && irq == 2) {
-            kvm_mips_set_interrupt(cpu, irq, level);
-        }
-
     } else {
         env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
+    }
 
-        if (kvm_enabled() && irq == 2) {
-            kvm_mips_set_interrupt(cpu, irq, level);
-        }
+    if (kvm_enabled() && irq == 2) {
+        kvm_mips_set_interrupt(cpu, irq, level);
     }
 
     if (env->CP0_Cause & CP0Ca_IP_mask) {
-- 
2.21.3


