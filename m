Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 18:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26938206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 18:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZYwBps8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26938206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxweU-0004zy-98
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 14:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxwaJ-0000c0-5P
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 14:01:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxwaH-0003v9-B7
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 14:01:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id f2so22034777wrp.7
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zEMRo8te83NUGt40sJx+NazqtYzYQf05FrJyvrG948Y=;
 b=sZYwBps8b/LtZWO8+sYkq3qR+HOurIu0jtzqKe6XEt56EkVxZrq8JoECbVH+paNR74
 gf7TbW/kdfM9a//8imSkAjQS0y0HRZoScBVVbwjAg0xFgjOUabpoQpEqkp9tBQ9n7esG
 jm2q/BGQSuJ6sHyy7DPdZds7J7hukykgFzQdW8vsvvzCD14kWlTUeyv6AqfnE2rdu/dK
 4c1q7tkvIX11/EQeLSAHgggNKrgfG9ANi++m5bd5ucHHV9p7gOxizo/rzOyoCAjCfNk4
 RX5/oyoT6mHWFbj+rPxgHWoT4+uva0/8PYyW1vU13lApR4qGDPvE/VOEOfXPIR2ASz1Q
 65aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zEMRo8te83NUGt40sJx+NazqtYzYQf05FrJyvrG948Y=;
 b=eIfDFWw9lJcLlfU3EQV+7A0FfvNZd2hTPWFPphn0iaq8W4zV+kzUzeW1RxrYQ4UBMr
 HPTxJcvJ2bYDYW+XJzHL8EW0VpckVTVwn12gzFUKYk+s6Am9qL5ysy1ddmLSqB6CqrsO
 0rMqDkpD7/E3JMYtWs54buXp+m7dSTDFfitjddsLZS2YaLEAXHis8XcoHi/OsXdnyAB5
 1794GXUGn6EHQJkvUj1fHz080mhw+M5BN9Bte+D+txA9YuKovW8ARRh9wyL9z4sRwjtg
 VxctuDazCcGu1Oz+7XtU9/e+IS0zV6+IJeajoMf8fWydwmV4pY7R6GjVq0HktFS+pgOg
 prDw==
X-Gm-Message-State: AOAM531OIbQyKI3cI3cgOhRG7Fb7wH4ccKIZlYbxm7pOK8J/JWs5w7qb
 mPfa3Noo9UiHgVGR+0EXg00JSuvzCf4=
X-Google-Smtp-Source: ABdhPJxbXlMNujAC2hiHXEpPhXMssKW3WtBTjgzjbKnkot3uHqqs9XBDE8dzjr7TbtAs6XY6SBO9eQ==
X-Received: by 2002:adf:a3d0:: with SMTP id m16mr26289978wrb.232.1595354503725; 
 Tue, 21 Jul 2020 11:01:43 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t2sm3557249wmb.25.2020.07.21.11.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 11:01:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] hw/avr/boot: Fix memory leak in avr_load_firmware()
Date: Tue, 21 Jul 2020 20:01:37 +0200
Message-Id: <20200721180137.11136-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200721180137.11136-1-f4bug@amsat.org>
References: <20200721180137.11136-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The value returned by qemu_find_file() must be freed.

This fixes Coverity issue CID 1430449, which points out
that the memory returned by qemu_find_file() is leaked.

Fixes: Coverity CID 1430449 (RESOURCE_LEAK)
Fixes: 7dd8f6fde4 ('hw/avr: Add support for loading ELF/raw binaries')
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Michael Rolnik <mrolnik@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200714164257.23330-5-f4bug@amsat.org>
---
 hw/avr/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/avr/boot.c b/hw/avr/boot.c
index 6fbcde4061..d16bb3dbe1 100644
--- a/hw/avr/boot.c
+++ b/hw/avr/boot.c
@@ -60,7 +60,7 @@ static const char *avr_elf_e_flags_to_cpu_type(uint32_t flags)
 bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
                        MemoryRegion *program_mr, const char *firmware)
 {
-    const char *filename;
+    g_autofree char *filename = NULL;
     int bytes_loaded;
     uint64_t entry;
     uint32_t e_flags;
-- 
2.21.3


