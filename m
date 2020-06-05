Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6A6C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1C4206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzzTtGZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1C4206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEea-0000L8-04
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbC-0003TK-Nh
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbB-0004JM-Qz
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id p5so10241487wrw.9
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QSCo20FpmcSa9pqRC9AwXDY8+utkLNtj0/ksS5sWNSA=;
 b=MzzTtGZ5RIJ6uclgh5F6NE/NN/hB7pyA8R7Y9LOOM7zTj4AjDPn6WuyEx7nWfhArOu
 0v/+cwLQ9rTw0ypXJc5esWkG9VsKPa8neHZ11XpSN1oRIpGUx8ptAqIpS7mw5QyhoTZo
 PmqLdZ45HHRg7Nad2Cl1dwniFikL+/DUL5xrv68JnTeLrUdxeEiGo8o+u4MDtky98+Hj
 0hW/SLNIOmbgJjnuuh8N4SjXH4+xRTX1o47yvuRPedGJP35ddF3V9K25BtEXhVFcWYNL
 TEyDDaOC09F+R0Wyg+O2PgMlobWOGWGPkyvJV9hJww2Ze0GEnnaG7LEvjanhM6/3x5P+
 TlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QSCo20FpmcSa9pqRC9AwXDY8+utkLNtj0/ksS5sWNSA=;
 b=GGzfDiq+wcyU1nCeLVoL+UUdW27B6/67UFlI0yg77EZhXFKI6rJfTj60CJTyTwhlx0
 QRgIl9MoUbYAZkf1SPfV/nr6Yt7Knh4ooGE3P0Pwfae12HfrUQREXgppRxF54qQWeReu
 yguCtlkQxlGxU8Wxml0OzP2PorAuFaI5E5B+HVZGn0ORwUXyI/Vu5eVdKnfBVK3aLSGs
 s94TmtpKIWW9bkUJIVdtkIqnRkHKEyKayd8ecs/GxU+3PlisEgMLXShm+r0w2MpyjsnS
 hWhBuN6LC1PXkjye7KwlXAP/0ned3ElVb0ll7IKEX1q8dTT9sX9kKtPwJZG5Pb8wri37
 gVmw==
X-Gm-Message-State: AOAM532TbWG/c9M/IA53yS0Eq1x05LFW9fjsD6PnedHX+vs1AO+nuIgG
 lxTioS5AwVektXAg5SSm0JMq2J0bzMI=
X-Google-Smtp-Source: ABdhPJwXDlhWsBNTA/82kQxOsKDK6ekrYWWoZdBln1fsp4q6VHrMi/Wmj/J8QyofGj0olVVYiUI6OQ==
X-Received: by 2002:adf:e744:: with SMTP id c4mr11056827wrn.71.1591372176294; 
 Fri, 05 Jun 2020 08:49:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g82sm11775933wmf.1.2020.06.05.08.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:49:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 484381FF8C;
 Fri,  5 Jun 2020 16:49:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 02/14] scripts/clean-includes: Mark 'qemu/qemu-plugin.h' as
 special header
Date: Fri,  5 Jun 2020 16:49:17 +0100
Message-Id: <20200605154929.26910-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
References: <20200605154929.26910-1-alex.bennee@linaro.org>
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
Cc: "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

"qemu/qemu-plugin.h" isn't meant to be include by QEMU codebase,
but by 3rd party plugins that QEMU can use. These plugins can be
built out of QEMU and don't include "qemu/osdep.h".
Mark "qemu/qemu-plugin.h" as a special header that doesn't need
to be cleaned for "qemu/osdep.h".

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200524215654.13256-1-f4bug@amsat.org>
---
 scripts/clean-includes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index dd938daa3ec..795b3bea318 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -123,6 +123,7 @@ for f in "$@"; do
       ;;
     *include/qemu/osdep.h | \
     *include/qemu/compiler.h | \
+    *include/qemu/qemu-plugin.h | \
     *include/glib-compat.h | \
     *include/sysemu/os-posix.h | \
     *include/sysemu/os-win32.h | \
-- 
2.20.1


