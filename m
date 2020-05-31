Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC00C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 18:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2476A20723
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 18:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Khbp+GoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2476A20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfSGT-0003TA-DR
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 14:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAP-0003jM-GT; Sun, 31 May 2020 13:54:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfSAO-0007fm-Lg; Sun, 31 May 2020 13:54:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id p5so3278603wrw.9;
 Sun, 31 May 2020 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RxLw4QcKrYbunBKOIFiXjKfQ22xYQIVcbponl1x6BVE=;
 b=Khbp+GoBcISHb5ous2OLktoshnUtyXO/ouTWpf/PhYqSW0AtUiYvKIzqIdaug01Cxg
 fTpFIwHFS6evRAuvnZ27wTkYQnQ3Q0OqV8+FPc4ug494g4jC2Rp7mROG/cFWw6Kl3nCK
 kbUtdrZASaOx5EU7mVZObufiIVd2Wu+s7v4BKmUnP1Za1CGghP4qzeaeVMsPwIQUs154
 d6L4QoK4LOKQFOxbhtlY0TLzcJOh3C8wNTlNvSRVK20adYtNnyUxdNqbYjmVO3cERhT0
 NJ5Wx8DP6pcJXzfjRpowbkQUfV7hyoX2EdXSGOm3ACVpwDFLhrlhKTPRYSrohjIavf/l
 PPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RxLw4QcKrYbunBKOIFiXjKfQ22xYQIVcbponl1x6BVE=;
 b=VynKJoefzWUemcwXH3XPa8X+8Rt5hG2SAoczOlygBsa7oj5+eGm7ZOidMuHdxNS+kI
 QaYiHulTszcCvs4GKJSNehDwW5I7L7rps3GWCXJLtiEXSvPg/cu6adngSJe7sHyvJVU3
 TCKCDDiKi5QM134UiHx0+h+XAL/vru56XsoSQ8Nbmpzu8DwAMxYn2dGySrjMYbNZ2Cs+
 e+XFeRVlfcZmkCwrsVMwhsfNvCfz1zE3W2z2qSKlUApR6Ndk18VZqj/Q5aZmuRgIh9F8
 R45IYRWh2Qum6qWB2uZ1Gg6IlCoCzEbrxa8Cugz0iqQGlNta/FeEgKgQ1FGVIg8uOzyt
 +ZEA==
X-Gm-Message-State: AOAM532t/XupDdfQyOK1dwKe9vKjXdBalq31rxoDTwdkZlp8IcVdQ+og
 7ZxL1oljziNhWua6OAlUFp6bhjAk
X-Google-Smtp-Source: ABdhPJxl1aJq3cAYSE4P6/JdRm/0LgJ/b8rKZ5O2K5msI/CQp2WAN7YjBCpYwlMQJu79VOyByRsOFQ==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr10524769wrr.240.1590947674465; 
 Sun, 31 May 2020 10:54:34 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id z7sm17862531wrt.6.2020.05.31.10.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 10:54:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] exec: Restrict 32-bit CPUs to 32-bit address space
Date: Sun, 31 May 2020 19:54:24 +0200
Message-Id: <20200531175425.10329-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531175425.10329-1-f4bug@amsat.org>
References: <20200531175425.10329-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is pointless to have 32-bit CPUs see a 64-bit address
space, when they can only address the 32 lower bits.

Only create CPU address space with a size it can address.
This makes HMP 'info mtree' command easier to understand
(on 32-bit CPUs).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
This is particularly helpful with the AVR cores.
---
 exec.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 5162f0d12f..d6809a9447 100644
--- a/exec.c
+++ b/exec.c
@@ -2962,9 +2962,17 @@ static void tcg_commit(MemoryListener *listener)
 
 static void memory_map_init(void)
 {
+    uint64_t system_memory_size;
+
+#if TARGET_LONG_BITS >= 64
+    system_memory_size = UINT64_MAX;
+#else
+    system_memory_size = 1ULL << TARGET_LONG_BITS;
+#endif
+
     system_memory = g_malloc(sizeof(*system_memory));
 
-    memory_region_init(system_memory, NULL, "system", UINT64_MAX);
+    memory_region_init(system_memory, NULL, "system", system_memory_size);
     address_space_init(&address_space_memory, system_memory, "memory");
 
     system_io = g_malloc(sizeof(*system_io));
-- 
2.21.3


