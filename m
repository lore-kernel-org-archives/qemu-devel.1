Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83226C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A971B2224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKtrtm9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A971B2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kURr6-0002zl-II
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kURpc-0002BV-FS; Mon, 19 Oct 2020 05:51:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kURpb-0002lg-0N; Mon, 19 Oct 2020 05:51:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so10670826wrq.2;
 Mon, 19 Oct 2020 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wgZScEWYKTpXPaYbK3zydk54RFmHl/X/t15IeTCJRI8=;
 b=lKtrtm9n3lWzzlfifUOD61dnSul5OX0l+d8EiLEpBlUSICBCLBXbtbkDKQvkfsR7YI
 /ML4uNued4yo8sOLM4gqZAJQH67342v+d3NZqsLPE7W9tnvLTzhukxzWF3L4LM75uHF4
 L0Esx8CQF85NBi6lGALa0FSC+OJhsJjia2YJK8M7mK0uut7cQJIlDj/Xn++jf3A6HMsa
 56ld6A2mr48zasF6RnIJ/qjJTT1b6HDNHfCcR5DNaiJkRGbJZ+u2jFhW7tEBZY8XnbOW
 DlBvaQm3YJrDxSc8a+J8n53BohsojY2y96jKOuL3lBdxb3uqjVLETcXFaQLv5FLyh8xt
 //mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=wgZScEWYKTpXPaYbK3zydk54RFmHl/X/t15IeTCJRI8=;
 b=erFDkrtcsSDYKCuc5s6TR4BHwwXd3IIXKLMhis4Ea3RxXrN2qfF2VVob8B70jOlkmx
 CtJnbhRsdh4WF3H29UdBn9WFpjeJNsb/ZxvTs5L2Ogc8osefcQUiekFq1XhXJTq5axIJ
 Al/gWvYN1T4Rxz28JM5KhaZW5Z5vkRrpwZw+FjKci5mhlXBK2VSpXOlVMA2xRGDCNIbA
 6mWegUFAoZ4wZls9MYUOA4t7wV2Q7qNkRVEcF0uymCg66d94JJqcGOkJ0DSIIUXzd1rR
 vE3RlXO0AIjmL9nFaouyb1aIkVUiiKytK/Xb+g39f9vUkGVU3BjyVqYlUOTtNkGnrYWj
 fzxA==
X-Gm-Message-State: AOAM530mRD1kPQqVW9dJEBrgnj0LA6CxQISzB251wu8a7VtXnKZrdsJp
 yoy+kaLuQi52CHjxz6Hp4fsJqn7Gqog=
X-Google-Smtp-Source: ABdhPJxYcXq6cA525LLgHoX8hLgk8XlgOomhChZ92Pbomu8KzyjZL8ggl71xu1kyjTIeOBF4f4h/wg==
X-Received: by 2002:adf:e54b:: with SMTP id z11mr19803289wrm.128.1603101110100; 
 Mon, 19 Oct 2020 02:51:50 -0700 (PDT)
Received: from x1w.redhat.com (36.red-83-57-175.dynamicip.rima-tde.net.
 [83.57.175.36])
 by smtp.gmail.com with ESMTPSA id t19sm16560535wmi.26.2020.10.19.02.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 02:51:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/nseries: Fix loading kernel image on n8x0 machines
Date: Mon, 19 Oct 2020 11:51:48 +0200
Message-Id: <20201019095148.1602119-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 7998beb9c2e removed the ram_size initialization in the
arm_boot_info structure, however it is used by arm_load_kernel().

Initialize the field to fix:

  $ qemu-system-arm -M n800 -append 'console=ttyS1' \
    -kernel meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0
  qemu-system-arm: kernel 'meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0' is too large to fit in RAM (kernel size 1964608, RAM size 0)

Noticed while running the test introduced in commit 050a82f0c5b
("tests/acceptance: Add a test for the N800 and N810 arm machines").

Fixes: 7998beb9c2e ("arm/nseries: use memdev for RAM")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/nseries.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index e48092ca047..76fd7fe9854 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1318,6 +1318,7 @@ static void n8x0_init(MachineState *machine,
         g_free(sz);
         exit(EXIT_FAILURE);
     }
+    binfo->ram_size = machine->ram_size;
 
     memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE,
                                 machine->ram);
-- 
2.26.2


