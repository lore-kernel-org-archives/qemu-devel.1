Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1856C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 301D22087E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRAvDh/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301D22087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5Ll-00084G-Vx
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:16:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5HT-0001Hx-DF
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:12:10 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5HR-0003NV-4z
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:12:07 -0500
Received: by mail-wm1-x343.google.com with SMTP id c9so2157468wml.5
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ycwc9PI+oFTz4llRPLtPfpoPPiAd/CZwBx3qyq0lMqg=;
 b=hRAvDh/GWZopBlkU8gG+DllAmis69LSZDLJkjLgrQNgCGDD8nFlgz1po7h2zPk7tMT
 a6hyWqZ7OMJTDRNIM5kJHaEP0AEZgm3M7/HWlk4XYYiL52gkQ8kfK7zEwS02K4e3cfzm
 P1lKXcfK/kvN8FmELI22gWWc5cfDu1XMoi725Iqz7Aj09MWwYoVwjSwTeXmiBQ3cMoUj
 mN0RrFTKyL5XtR9kCIs3K3GSgRTyQYbNrtCfqCqav0e5SFI9kijG7cc3JAI7E02KaMFp
 ibTziG9Q627Vy5IFh0v6H/9ROjYtpEqofUmZoAxMtRD/PHP9pIBhH89BgdQyRpqK1JsZ
 ldbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ycwc9PI+oFTz4llRPLtPfpoPPiAd/CZwBx3qyq0lMqg=;
 b=c2ze53xPwm78BiCIUCxafLpoDLa+bDDJemOrLxkgEx4w3fm9MCw7Ydr6JnfrdUHaJX
 wkf5SvP6G51Y1oZU3KRanVPHV6eF9xmfTCyjOyAJclzuFBc4P5xBTViKxG1kdEvtAebg
 z/qluomhfnvYmTK/LwiHfJZTAm94SQILopRboeeC8MoEnxM8NNnSsgsL2t1nbURBzuC5
 myze+BJX3RoXkVw6wXj6ZluXj8rs5j62RQwgrDOUhr/ollsCpDeIKXzGg5LvMeiSuphU
 bHi9ZKXa1afmwr/LDpUjoc3g+Cw40tB/EbWYDr1KEh6StzjVxIcjvs4vUDNSKmAVYosv
 mRPQ==
X-Gm-Message-State: AOAM530A+8S4hsP8QXAOg45I/lJjAKO8/VO/6+7BYzo+EDfK1X1pngRo
 fck4s/PT+ShLdlHygjD1CDbkrNBuByMYtA==
X-Google-Smtp-Source: ABdhPJw7lcV4n5Abiz/tgeyJiu4G3mp3rgJlKQLD3s4Fd/MwpTRv1M6uhgo96sZa96c97MMj2Hqjtg==
X-Received: by 2002:a1c:4ca:: with SMTP id 193mr588932wme.137.1604682720400;
 Fri, 06 Nov 2020 09:12:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l1sm3162649wrb.1.2020.11.06.09.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:11:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 3/4] hw/net/can/ctucan_core: Handle big-endian hosts
Date: Fri,  6 Nov 2020 17:11:52 +0000
Message-Id: <20201106171153.32673-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106171153.32673-1-peter.maydell@linaro.org>
References: <20201106171153.32673-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ctucan driver defines types for its registers which are a union
of a uint32_t with a struct with bitfields for the individual
fields within that register. This is a bad idea, because bitfields
aren't portable. The ctu_can_fd_regs.h header works around the
most glaring of the portability issues by defining the
fields in two different orders depending on the setting of the
__LITTLE_ENDIAN_BITFIELD define. However, in ctucan_core.h this
is unconditionally set to 1, which is wrong for big-endian hosts.

Set it only if HOST_WORDS_BIGENDIAN is not set. There is no need
for a "have we defined it already" guard, because the only place
that should set it is ctucan_core.h, which has the usual
double-inclusion guard.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Ideally all that bitfield-using code would be rewritten to use
extract32 and deposit32 instead, IMHO.
---
 hw/net/can/ctucan_core.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/net/can/ctucan_core.h b/hw/net/can/ctucan_core.h
index f21cb1c5ec3..bbc09ae0678 100644
--- a/hw/net/can/ctucan_core.h
+++ b/hw/net/can/ctucan_core.h
@@ -31,8 +31,7 @@
 #include "exec/hwaddr.h"
 #include "net/can_emu.h"
 
-
-#ifndef __LITTLE_ENDIAN_BITFIELD
+#ifndef HOST_WORDS_BIGENDIAN
 #define __LITTLE_ENDIAN_BITFIELD 1
 #endif
 
-- 
2.20.1


