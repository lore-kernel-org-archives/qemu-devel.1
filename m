Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B2FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E782053B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5yOAHES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E782053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuKf-0006yu-FW
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGS-0002Ie-PI
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGN-0001AU-Qw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGN-0001A9-Kt
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id r1so8296786wrs.9
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RtZ6eDxdSnhFwcSQva9Dw3k0dUzdlcR17D7YwApDOzk=;
 b=Q5yOAHESFi/+2tpWoVFf1kKsk/j5mTzwL/GivZQCeaR7PneZez9LJhKxDRC3fgCPlO
 rB/zQaL71aTCyMa5bS9fyX3ETD8ukOGSjBO+MeF9g34Gi/bw+2LmM4nYiCjIhfrEylBR
 NoOBqm3D030JuaECNjxEi3zp52RoSCZTxgbs2xcweVib1Eijo4b6KXQ+pLdl9Sl88M7g
 mUFo2pzM/Ssjiu+AR0k3VJaZP5J0Cwt4d2ycbxLTFJp8cDdQIncUmS9jFOQwb9voIImO
 WJxV5D1sKYG5YaAuVor6v3OLQsnnPd4mbchKUw2JqAYR6IRvg3x5Ozd8dZhFLr8YpIbL
 7U9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RtZ6eDxdSnhFwcSQva9Dw3k0dUzdlcR17D7YwApDOzk=;
 b=U99EkRLUQdhaeOrvBdPMjoOFNgPVuWaC9HB/CxWJQrhtG93eV1kLjt9ZsKbI9YaA0z
 E7k0VKGA29bqrybS4bE9L/qNihbKNBKSQrKSFtuoYnGSKS0AfTOjiwfIYtK1XTrjXIiz
 oETPuCfin9Hplv99weSq60iLgOaSAiajd6a458oK0QNnzD2olPmU2N0wl5+VytvjHP3J
 iZZ3/2JTXj/lv4KAHE0sfE4PyTYGlMSOJ5ZATLspPVzyUPbRg5HAUCabsCeFBjuJe0CP
 CjPVoCFFL1H+Vqapyr9Ib64zb0MPoFo9nNArBAIgEYfelmSsGgDwpc64VcDvB9hu7djU
 Z4xw==
X-Gm-Message-State: APjAAAX2kY4RLMxNQL9ih5+Y4TyIPkHqU6IV6ilBnhndK+Lz6Y3P9+K3
 lM5SmctkG2Yq96KQlr30D6QtR8sd6hg=
X-Google-Smtp-Source: APXvYqyWlgqKmiaoKvJdb72RL1RtN5rWKMWz38fLvqTjE5eYGdKyRHt2AP2wSuIJ+L/hVFiXcpj2TQ==
X-Received: by 2002:a5d:4ace:: with SMTP id y14mr3654128wrs.131.1571751109762; 
 Tue, 22 Oct 2019 06:31:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.31.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:31:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/41] hw/timer/arm_mptimer.c: Undo accidental rename of
 arm_mptimer_init()
Date: Tue, 22 Oct 2019 14:30:57 +0100
Message-Id: <20191022133134.14487-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

In commit b01422622b we did an automated rename of the ptimer_init()
function to ptimer_init_with_bh().  Unfortunately this caught the
unrelated arm_mptimer_init() function.  Undo that accidental
renaming.

Fixes: b01422622b7c7293196fdaf1dbb4f495af44ecf9
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20191017133331.5901-1-peter.maydell@linaro.org
---
 hw/timer/arm_mptimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index fdf97d1800f..2bf11f788c3 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -237,7 +237,7 @@ static void arm_mptimer_reset(DeviceState *dev)
     }
 }
 
-static void arm_mptimer_init_with_bh(Object *obj)
+static void arm_mptimer_init(Object *obj)
 {
     ARMMPTimerState *s = ARM_MPTIMER(obj);
 
@@ -319,7 +319,7 @@ static const TypeInfo arm_mptimer_info = {
     .name          = TYPE_ARM_MPTIMER,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ARMMPTimerState),
-    .instance_init = arm_mptimer_init_with_bh,
+    .instance_init = arm_mptimer_init,
     .class_init    = arm_mptimer_class_init,
 };
 
-- 
2.20.1


