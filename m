Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225AFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF80022BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="quSitfKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF80022BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DpR-0001m6-0A
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoU-0008TC-FI
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:33976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoS-0004j1-NA
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id c19so656837wmd.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=69oUenAIXTnbx7cTfT5bBPqb6C7oBsuKzHVSA9VIsO8=;
 b=quSitfKlkbwyewrc37F9wnUld5ennQHGHWvjbbdhBBPnI+N+3tj/m60zG9NIbO2f83
 F9xoWf/mFEo6uuYpZGSF6NM9z6VNdYVkdbhuIWNA4VqhcC3CxG5yOrX+vNv+0d/lEFaU
 rNO9IZUUoxFPHTqcFRY0+dXR93Uw3rdTnYyuNIUFALq4V5WQSz2l+HQRpE+MN6Sw185n
 NFntNKgLNZqhlgNbJAiwYgPA85RXOm2wIORfkgcfKjK7FGIWHLensvpPC5m88GHhxbQn
 oO5HxS6NNtRh69ToDaNSsnGRvifjzgIigxJ7rVMWkqlIV1hplaEf9Xdzn1fK4ZfFgwv9
 488A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=69oUenAIXTnbx7cTfT5bBPqb6C7oBsuKzHVSA9VIsO8=;
 b=SbchTg3BQrpc9gLSfx+7ofWdcMoVt3rMlkUvPIMhjMfjXZeFpvzfjmmIWsOBljhYyj
 6BcISZlYwLGpMCYjXZMXAmIzFr9lAfBQJq21MF5JMRSdfQ2KaxHjmCCk5UEIh8n4jKS4
 cxUgPHt4bqpAU5WbldG02sCB3vIzvr4PcXalG7C1VDsH/Tben72kCXVjUHDnXl9z/ixr
 da0gU1DXTr69kX8tKXBXdmbA6v65enPuaoTeVlU5M/4z1sbVD8tkZoqXbEo3pq/nmLPK
 tHEDYd4Lh8HdqPtZRwtAonxFtmMeBhjmWPsLK/NhX59gWpCdIrXAE6gnP/Fb/JhrMdPK
 RQSQ==
X-Gm-Message-State: AOAM531UHVhVZlpeeA/bCYAtqPWCLHHr06MLEumKoVRmARy134eYs3TH
 HYcFG1TxESQrDS5ehgJsBJJS/MZqKzcnVw==
X-Google-Smtp-Source: ABdhPJzzwqanvn7JT3NdQDXjuRCuPnGgSztQf76dzjCqAm8cIQ2zrp7xlWJHo25dbKDleeOcexr1SA==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr748807wmi.183.1597089026363; 
 Mon, 10 Aug 2020 12:50:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 03/20] qapi/block-core.json: Fix nbd-server-start docs
Date: Mon, 10 Aug 2020 20:50:02 +0100
Message-Id: <20200810195019.25427-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit eed8b6917832 added some new text to the nbd-server-start
documentation in the wrong place.  Since this is after the 'Returns:'
line it's parsed as if it were part of the documentation of the
"Returns:' information.  Move it up to join the rest of the
"documentation of the type as a whole" doc text.

This doesn't look odd in the current HTML rendering, but the
new QAPI-to-rST handling will complain about the indent level
of the lines not matching up with the 'Returns:' line.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/block-core.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index f04bb3f0dd5..535b2b2e7bf 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5206,6 +5206,9 @@
 # server will present them as named exports; for example, another
 # QEMU instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
 #
+# Keep this type consistent with the NbdServerOptions type. The only intended
+# difference is using SocketAddressLegacy instead of SocketAddress.
+#
 # @addr: Address on which to listen.
 # @tls-creds: ID of the TLS credentials object (since 2.6).
 # @tls-authz: ID of the QAuthZ authorization object used to validate
@@ -5216,9 +5219,6 @@
 #
 # Returns: error if the server is already running.
 #
-# Keep this type consistent with the NbdServerOptions type. The only intended
-# difference is using SocketAddressLegacy instead of SocketAddress.
-#
 # Since: 1.3.0
 ##
 { 'command': 'nbd-server-start',
-- 
2.20.1


