Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9401FC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA5F2074B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NesUVPWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA5F2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFyJU-0005WJ-Tu
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGb-0000CI-Fk
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGZ-0006Xe-MZ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id e16so2562999wrm.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 04:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x50AKbw2C1EpufEPXDHUDVL3npAkap6GTDHFJFmIt0E=;
 b=NesUVPWhBcQDal87ZYPspetZ9Kf56iy+WtLFgil7FzV0+Dqohpz4/7J4gCX0QxWW4i
 RJ+lqNGJIycrgyUSpwm5h49XaVwyRkK28YXkTl0hIiTBQ3aCQNJq2QCPmNopbtP7BEfD
 OqLQ0E35a1VBooxIa0hc8uJlUzDjyODg745gufMl1m5dE5vMjAvuryXQUh7PqBhkzUSX
 h8l4gSnHiR5hNQAsxwd8mmt4Ih+drvPej4fvSUDvLeVnw8yV6EmgUiDTE1PDl/KoLhqQ
 eEQ93JjpoxWcwBHLGswmkDOKQpqzO3A10xBGDcxf7BZf1lhm6X7OHHSjcIukjQjVblog
 jurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x50AKbw2C1EpufEPXDHUDVL3npAkap6GTDHFJFmIt0E=;
 b=PhYZ0vt3RtItRDgtw9miR1INXZLjIunHqri69xUlm6/hL9F1zNubJ8y9iegXyUszlu
 kol/t0NiOWoZz5bKKzMQwgZ60JO0ON/d1j18/FsMc04YLfoe9UU8q/yOX1IMRySNmpXE
 NY3EhsXlMgbCxk2UO8qQEtEsHOTlVbD2VT2AlTrNEynH0Trn5PsQmhMDrwclGEJRbken
 nrdvyEisUL14tenIirX+eo1nRUixfrtWFZPVxos84Y+tmC6VDQ+mcceqccKVnRw4ZvoD
 Ct+5x6F7tfkJ0dVLPOWEz6QP/DP4K+jaPz63KET9L4YzJcPyIOkf6WHNW+/uMc74pIZP
 ehig==
X-Gm-Message-State: AOAM530f48ssbi0sjJp3rE4XcEjVxF4fB8+5+MJkWvCNwlGzxUcKmx3T
 2+hBf0uTenySRQuNi77HrPSgLg==
X-Google-Smtp-Source: ABdhPJwFKih2UFctB1MS1kH0RmHZEJ1fUJvF0PBTrLqE/5C5p7wjXUGYE8uvHLZz8jPZD9LuS0DB/g==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr3546046wrp.187.1599650874411; 
 Wed, 09 Sep 2020 04:27:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t22sm4029931wmt.1.2020.09.09.04.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 04:27:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD7B71FF93;
 Wed,  9 Sep 2020 12:27:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 07/10] hw/i386: make explicit clearing of pch_rev_id
Date: Wed,  9 Sep 2020 12:27:38 +0100
Message-Id: <20200909112742.25730-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909112742.25730-1-alex.bennee@linaro.org>
References: <20200909112742.25730-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some compilers (notably the Xenial gcc in Travis) fail to spot that
this will always be set if pch_dev_id != 0xffff. Given this is setup
code and using _Pragma to override is equally as ugly lets just remove
the doubt from the compilers mind.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 32b1453e6a8..33fa035fb7f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -930,7 +930,7 @@ void igd_passthrough_isa_bridge_create(PCIBus *bus, uint16_t gpu_dev_id)
     struct PCIDevice *bridge_dev;
     int i, num;
     uint16_t pch_dev_id = 0xffff;
-    uint8_t pch_rev_id;
+    uint8_t pch_rev_id = 0;
 
     num = ARRAY_SIZE(igd_combo_id_infos);
     for (i = 0; i < num; i++) {
-- 
2.20.1


