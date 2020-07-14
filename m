Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE6CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE43206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 20:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1pnhJ8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE43206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvRS6-0006KL-7i
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 16:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvRQB-0003DU-6s
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:20:59 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:42636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvRQ9-0006UA-Ej
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 16:20:58 -0400
Received: by mail-wr1-x434.google.com with SMTP id o11so9057wrv.9
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DkF/9wd+ad82T0QmLB+VeX5sFi2tBHhmif5Rzh6VSls=;
 b=m1pnhJ8Js7VezUe6KXDfY7rwCcJqidigQKoWkEz9lljXdUeItq4jNSa5uf6l0otUWh
 efEK66R0204rp2WImk0nqB0iXSunj6PDOLADa1ESCifUNKSeZ4sNzoaPbxmb9SaBj5O4
 PNl5m03N2hkyaw9/cv9e/vARI652bYmmWHTu8O7K0VZs1hLc4X7rayAYBaQYAu5PNuTk
 gg67AVfNd61Md4iJvAcgm2yKbEZMJA8t17j7KVY19aeD2hhqE32mAoN9BoG8VH0Dtf3G
 BQ0eWuHE4d09sa0WP6sUqnF0LCxk8o1u1LvSS0Tbx5ug3kuuoMly7HoNluvphwjvDvxW
 V6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DkF/9wd+ad82T0QmLB+VeX5sFi2tBHhmif5Rzh6VSls=;
 b=eFNTU3GeQi3Bbl3VGX6tJSUtKPwQ+2GuespdLgT2rcS/Kqpy7y7FK8MTQ7DqY+g7yr
 5iupuU673xdRQezEZCzp3gr5wVpzYoUIExtxkyAZZ0289qrp21ZLd06iwyTeq3yC8meK
 ORhj/O0tGzdpF0/vFeba4gJvAJdMIhrdHOQ4PLy3rJFRzCCfDg1OXjTHonesWs5GvmO9
 Wx3CMxmWyzJSd37g1G9YejQMSumbBLHLJQlm925pmmRMRlnVUN0QZOBi/1ZYb9dHWJVD
 UITDwldcF1+gdLdvfy2ikx56JzTmr80y35ZyR98wDt3Skiyc3lFnxjsXz+Kznoeqcg5v
 Kznw==
X-Gm-Message-State: AOAM533b2RrngMMLdIRiB7DNIcL4ZSZ9Vy000qZK5vgXat3F4xbRWT3V
 w02CeEqksLxfNrtjlGR1sEGK3FN7lhc=
X-Google-Smtp-Source: ABdhPJwLDLjoeClkbdqNwH0zhXeQy5q7ZDvecEo3SQmCXhF6G+1cuDMWJvlAguJlJx3PNl99r0USEg==
X-Received: by 2002:a5d:650e:: with SMTP id x14mr8061161wru.187.1594758055674; 
 Tue, 14 Jul 2020 13:20:55 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 138sm7245217wmb.1.2020.07.14.13.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 13:20:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] target/mips: Fix ADD.S FPU instruction
Date: Tue, 14 Jul 2020 22:20:50 +0200
Message-Id: <20200714202051.13549-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714202051.13549-1-f4bug@amsat.org>
References: <20200714202051.13549-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>

After merging latest QEMU upstream into our CHERI fork,
I noticed that some of the FPU tests in our MIPS baremetal
testsuite [*] started failing.
It turns out commit 1ace099f2a accidentally changed add.s
into a subtract.

[*] https://github.com/CTSRD-CHERI/cheritest

Fixes: 1ace099f2a ("target/mips: fpu: Demacro ADD.<D|S|PS>")
Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200703161515.25966-1-Alexander.Richardson@cl.cam.ac.uk>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 7a3a61cab3..56beda49d8 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1221,7 +1221,7 @@ uint32_t helper_float_add_s(CPUMIPSState *env,
 {
     uint32_t wt2;
 
-    wt2 = float32_sub(fst0, fst1, &env->active_fpu.fp_status);
+    wt2 = float32_add(fst0, fst1, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
     return wt2;
 }
-- 
2.21.3


