Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8160C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C3D2068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciuIefHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C3D2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZsA-0006wx-Q8
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhf-0006i8-A2
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:11 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:33866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhe-0005qS-Kj
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:33:10 -0400
Received: by mail-ed1-x531.google.com with SMTP id i16so17662816edv.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SzMnP+v0boOKzPS/hAbB4oxH7IK6D4Ae63ekoZyVIXc=;
 b=ciuIefHL31taUGw39VgRPDV3fOx4cXNqKZ0nVm7Q0MO/i1UwdbtJT1/RGVVXlPMrzO
 JInRIfcNo6GwpyJlX/NfqIadpHtJ/sWCQyjjYTc6kPNC7AbDFtithfrxtswkzdYdo4dI
 a9oxLniLraEdtA1iGAzLlGJ0K0foSMi2QWqdYQMM2NEfOG0FLN0z+iLl1U5YqCGY00HU
 sVQ3vScHhkZ37AK10k13mP14vCsnl0Q2ozvdgDgHrOHs74DMuaKgsvCSMk5ZpnEfvtPX
 /hmGf6kuCPdmWUC0lHhL378WFyKHXwW82xIBtvMD3fqHdvokoum2F7QkR0XZk4xHC2Nr
 ZnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SzMnP+v0boOKzPS/hAbB4oxH7IK6D4Ae63ekoZyVIXc=;
 b=BzxydQTKxfqM5z9MrnRS9j7jT1F8kN10YfNEgV4/nXY7iPGeVIUG6zWXKE48ZTMVVy
 gYYTrxCXfa8o3aIG1LN/rYhSZA0XNBvSVe+YXrg3PSWthcI1dEMGAkn+E1ZKD71jJXy3
 uRI2/Fy27pDMyTqYVJTmJSTHL/GZssubEyKBkg93ON6huZsw9C0RGcUbgxTNG1oEW8hW
 eeZCuqF8XuLvUiRNo4hQhpruXNNV6ILh55H0zYdOClkyjVaHKsYPPRrTmGG3O+7TJc3e
 zSR4m5LPvOIkUX7r+P8RqKOj/pBCFwnkaNPHoEi3r935smdesO8bJLF4ddUzFqsONb57
 I9gg==
X-Gm-Message-State: AOAM531MB9kFFIcrmKxNmC9UxoiknyQh9FUu1yphOIul6LNj2Wa4kXAx
 yZygVQK+PaMZA2qnFai7gPWHN5BsmLs=
X-Google-Smtp-Source: ABdhPJyhe8NpcMddqxli+7/P7ZF4MbpIJ2/9Jo4E7uADaHqbr/LsGsvWVSz60OKuxbSdJVyVpp4SvA==
X-Received: by 2002:aa7:c444:: with SMTP id n4mr19858176edr.308.1590499989149; 
 Tue, 26 May 2020 06:33:09 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:33:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/14] hw/mips/mips_int: De-duplicate KVM interrupt delivery
Date: Tue, 26 May 2020 15:32:46 +0200
Message-Id: <20200526133247.13066-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
References: <20200526133247.13066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x531.google.com
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


