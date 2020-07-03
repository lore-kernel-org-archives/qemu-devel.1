Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C25C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED7B20870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGvfkj7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED7B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP5i-0002eD-R0
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxQ-0005Kg-PA
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:36 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxP-0005iT-47
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:36 -0400
Received: by mail-wr1-x42a.google.com with SMTP id z15so22144974wrl.8
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CWWHX7OpcHVkiC1DN/wEDJR4y3nHHglCvW2K0gYh1/s=;
 b=jGvfkj7sQJBLzl5pbaYpKSCanbmROjtq3Mfu+3vZ8Ca71mmo5JYGI0iGeovL+Tu/8u
 YjqsJ1HzNx/g+bqe7ZZDWy94TUkYy1/BXgHsGlQnHsS8YiC9yXWi/rkUVKGHRqm0PN8t
 RRWEQ5lirou+l/6ziyRugj6hq0mUdG7nIt+/6S+D80chVCiFY2bEsUnExhDT81XgYMjU
 FWCOLim/wJrkp+8+A0magqiFCrPQImOsFonnNqk6gz+2BEL61HAnXDW8kNL6uTgSibM4
 YIL3VwOFA6CuTuacADZQkRl1uBPHRvG9BvI0Y/3tdelI0MGxYAQuexeN93CjtQS9kVSw
 8hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CWWHX7OpcHVkiC1DN/wEDJR4y3nHHglCvW2K0gYh1/s=;
 b=jIAYJupQTs+pq7CP7czN4XIvhzXwJXW4vuZRNxV2dXGWXqXUY85CmZsc3Uj4oG1GOA
 ennM9l9VFJ4R+0n6MX0cm7OceFNo9yDCAnjJ58Dh/TrAV2N44GHCm+xwZ+bDTEVxrQYu
 7pydYB0XM3EXhYKJTyVovs6o3LdfGYhWlyt3sedJ0Na5vI6RcwdGnMqUuyBdd5dMm34/
 Q5Z8vsvz8Xgh2pv8O0AoZ7ZQjjCQz+tTQC+OQbLGR3Kair4y3rakODhaN+7nA7xl6BFN
 1/u9fvlvKTViEZrGXQ/LTDeCLSTmFfrpSWg4rPMQlgqm0Wb+H+tkV6KGznyv50pKZDE7
 TKTw==
X-Gm-Message-State: AOAM53221/w/eZ3yhx/ELnY7jl6Iec/OfHONIlq34oM36L4fWExg/nzy
 EZTa5rdrdkPS7imfR4q7b7igf0Q7Ty/bGQ==
X-Google-Smtp-Source: ABdhPJxtlFZaO+KtHj+RszEhvXhHh/b+qqQXUhOkMyrNq8DB+dTRwBqiM3Vy0pYgzrdXqaiuQ62uRg==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr40035224wrm.40.1593795273486; 
 Fri, 03 Jul 2020 09:54:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/34] hw/misc/max111x: Don't use vmstate_register()
Date: Fri,  3 Jul 2020 17:53:54 +0100
Message-Id: <20200703165405.17672-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The max111x is a proper qdev device; we can use dc->vmsd rather than
directly calling vmstate_register().

It's possible that this is a migration compat break, but the only
boards that use this device are the spitz-family ('akita', 'borzoi',
'spitz', 'terrier').

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200628142429.17111-8-peter.maydell@linaro.org
---
 hw/misc/max111x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index d0e5534e4f5..abddfa3c660 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -140,8 +140,6 @@ static int max111x_init(SSISlave *d, int inputs)
 
     s->inputs = inputs;
 
-    vmstate_register(VMSTATE_IF(dev), VMSTATE_INSTANCE_ID_ANY,
-                     &vmstate_max111x, s);
     return 0;
 }
 
@@ -206,6 +204,7 @@ static void max111x_class_init(ObjectClass *klass, void *data)
 
     k->transfer = max111x_transfer;
     dc->reset = max111x_reset;
+    dc->vmsd = &vmstate_max111x;
 }
 
 static const TypeInfo max111x_info = {
-- 
2.20.1


