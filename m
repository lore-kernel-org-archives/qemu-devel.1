Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A643C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628DD20674
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="izRfbO1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628DD20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jygqc-0003TC-N1
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 15:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jygpz-0002pD-IG
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:25:03 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jygpx-0000HI-Vw
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 15:25:03 -0400
Received: by mail-wm1-x341.google.com with SMTP id g10so7119000wmc.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 12:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=diP0Ikbvho+I6Mms1spyyg4KYwxa5PP0ZncvtRg8lU8=;
 b=izRfbO1b8saZDwL3JHNMqQMJSGAQ3EiXsvagvx/NfYBgtrv7KPXlAZKPKC4Wudx6gJ
 J0Ozu8BztdaDAofkBJvtOIiCQB74Jovl/Btm5COIPk0ooQWQAHZWahLRFv08FLq3oyOg
 FVaoE4n6Gpd9FiLSYE8WxsP3GWmfUpBfmIidYgFW79SY2nudQ6EldaK5WtYr+D7ABKIS
 ABfNnqjNFLULAtw+u/9x3GeIWOGVavRJK7SOOxw+GW5Qzlolhj4gPk6uhi5wz7ZFol3I
 sLDlDzj/sYtRAf6dPXXU/XIKYmj2wGKKIbw3PPg/0xp9R9zGZ4tk6Mjb0K/joyuW7ZfC
 TScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=diP0Ikbvho+I6Mms1spyyg4KYwxa5PP0ZncvtRg8lU8=;
 b=l31Kt6Qg5SaAloAuPbwoSgts9dwni1caXpGvGz9roonLTc4DzkNYyxdXze8BRqRkLV
 pao25evNSM/xa389yeWAWTFx1Z0/iJJjXZUBFG6uG6oTbav0wwSeMKVzUyJ9BoQo3kij
 AdVVA/M+j5u2g7yLsFQujHrofp/Kdk55RG+o0KZ12pyUXkRE5Cpp9aWzHoM0bd9wA+bx
 rJacSmXkdaDJsZP0LLaP13SrDxocyZ2Byk9+XaYjVvLtqoeMEWRBAcnuE9XFmlL9ML01
 HAilBq31joRRk4HbSehgsyHhICjb7eRucO614lENdGEmEDSzRV0RCxW1D0YVtMfbK2gZ
 u98w==
X-Gm-Message-State: AOAM530i15y+btrB+7kZdgpGEPqhCeoUzhYzBu47GzKAqqgDYuzVZ1QX
 EBRkNDDehDbAhJMTbAcEKT8+LkwT4piEjQ==
X-Google-Smtp-Source: ABdhPJxuZZO+/LM9FVhlNPTMa5Amj+CtdSuce1frOZ0os/FV9KkfzVAby7BDEqNZNmU3K3YgLjFPwA==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr5413817wml.170.1595532300030; 
 Thu, 23 Jul 2020 12:25:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h5sm5375544wrc.97.2020.07.23.12.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 12:24:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/input/virtio-input-hid.c: Don't undef CONFIG_CURSES
Date: Thu, 23 Jul 2020 20:24:57 +0100
Message-Id: <20200723192457.28136-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

virtio-input-hid.c undefines CONFIG_CURSES before including
ui/console.h. However since commits e2f82e924d057935 and b0766612d16da18
that header does not have behaviour dependent on CONFIG_CURSES.
Remove the now-unneeded undef.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
NB: tested with 'make check' only.

 hw/input/virtio-input-hid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 09cf2609854..a7a244a95db 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -12,7 +12,6 @@
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio-input.h"
 
-#undef CONFIG_CURSES
 #include "ui/console.h"
 
 #include "standard-headers/linux/input.h"
-- 
2.20.1


