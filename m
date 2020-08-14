Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D80C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D3E2087D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agL5RyD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D3E2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6V6Q-0006JZ-Hw
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 04:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V54-0003Z9-0S; Fri, 14 Aug 2020 04:28:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V52-0004Mg-DW; Fri, 14 Aug 2020 04:28:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id a15so7579617wrh.10;
 Fri, 14 Aug 2020 01:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h98y0GZ9oBKT9+HT3S78Zkh8zS/hG43uNb/8d1WCmb4=;
 b=agL5RyD3B5RKHtua7k8mphgl+uyS4aSxW3jFgGqAsF9A3hz8WynkJrwZTmpeKuhLKo
 LmqbI3a0OZJej2vKM+UB/rHU1mCgBJ+xnUh+yCuq+Mz/N2EgCiu8yTVtBxvnczXQAOSf
 2r5QbosILrhBXPNifdei4TqWFY26AiSOdkn8dIgWHMiHffBB5C7tUa89agxdjGHcSwJI
 MB2eG5hX5A26ZSgwF9UAcwAHw4zXGwE0PBXFaQ1QWBba8AVTvIJz+76t3JtCTG5fZtYW
 HsjXZZ4m9+jtN5fzEX7ZtLijYQaCgxEuQZqYgim/sGMP8Qydcj/piFqsjFZY0T4EzXnK
 wFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=h98y0GZ9oBKT9+HT3S78Zkh8zS/hG43uNb/8d1WCmb4=;
 b=ulpdN5DEvtl0D/+tBuUsZdxl8LsAc8KwCUfXHmISxjxsoLigYckrHU4Ru5N7mpFMG7
 mQR4Fq0OmVS5Dx+J6u0DLAVFg0zXG0yyFE9NEIMxl7X/rp11G3ZKrJbQX9lmG7LVZdKU
 HdBTElr8jCKlcE/yubWkGVYlyQIoorHXW5iUJAc6ubIZvD4O2hJVxghiNKY+EfCVvSzH
 cd9UGxICpe0AzSJ3RliUMSD6Gm5ihlEG/qPfVI6Gb08hwAu9nASgu+Pq6dMvLO8BZryk
 LGFThpxk9iThvimzsw8XJ2Dxv7SLlq2jhQ47axxnaxgcMbrSCLaql6BYhDDw4ztnQlbO
 YmdA==
X-Gm-Message-State: AOAM531Riu6xzEGppSl+F54nLRcPLBpix8R3JSi/dy53GwO4D3Y/LXNy
 q2lTDsvf3ZhAr5ZsmabdA6CXHpevvys=
X-Google-Smtp-Source: ABdhPJyqUHRXbTjgYIcejArh90LLSHiqaC6dVOeMFts9Tr4fDdG6T46mXoo4vZmRIAv79XbADQ1R0g==
X-Received: by 2002:adf:ed85:: with SMTP id c5mr1670129wro.307.1597393730132; 
 Fri, 14 Aug 2020 01:28:50 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d14sm14668107wre.44.2020.08.14.01.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 01:28:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] hw/ide/atapi: Replace magic '512' value by
 BDRV_SECTOR_SIZE
Date: Fri, 14 Aug 2020 10:28:39 +0200
Message-Id: <20200814082841.27000-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814082841.27000-1-f4bug@amsat.org>
References: <20200814082841.27000-1-f4bug@amsat.org>
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use self-explicit definitions instead of magic '512' value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ide/atapi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index 17a9d635d8..14a2b0bb2f 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -824,9 +824,9 @@ static void cmd_get_configuration(IDEState *s, uint8_t *buf)
      *
      *      Only a problem if the feature/profiles grow.
      */
-    if (max_len > 512) {
+    if (max_len > BDRV_SECTOR_SIZE) {
         /* XXX: assume 1 sector */
-        max_len = 512;
+        max_len = BDRV_SECTOR_SIZE;
     }
 
     memset(buf, 0, max_len);
@@ -1186,8 +1186,8 @@ static void cmd_read_dvd_structure(IDEState *s, uint8_t* buf)
         }
     }
 
-    memset(buf, 0, max_len > IDE_DMA_BUF_SECTORS * 512 + 4 ?
-           IDE_DMA_BUF_SECTORS * 512 + 4 : max_len);
+    memset(buf, 0, max_len > IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 ?
+           IDE_DMA_BUF_SECTORS * BDRV_SECTOR_SIZE + 4 : max_len);
 
     switch (format) {
         case 0x00 ... 0x7f:
-- 
2.21.3


