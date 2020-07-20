Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32F6C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DF222B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWSP1wPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DF222B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVMJ-00040t-Kf
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 08:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLL-0002JG-Sh
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLK-0007IV-Aq
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id 22so22179888wmg.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8DHK7n8boT1yEvYZmR1ZTOA6F3ocx/EmfVnNFwz0uCw=;
 b=hWSP1wPqdV3014Z/4f5laDJKphYuW23U3s4067+XuJSIwTRpyxT7rUVOJ5SezDdb3H
 4w6go3U6NR9xnsu/g/tw0pY0uKA34ByzYnRWv0c13e8knDLApX/eJypZHJB4fz6P/GOM
 stmVIzEp5j/tvkXokP73YuABhMe2hB+yCOi/eBqCdsfc4Eqi1hbFQvhFmv0wA4r+aP76
 jpoDUoqBEke+YbQTeyAWuZm50R6RDfaMSAWpfMyV8cMjlKSbSyQTtE4ZLNmfXKCpQJGY
 2BfFXM0avZ84PuU2DGVYAX/ZjujB3qsuc2m6HP6Qfj+C5uEl/5cJfhrKOayFydJiHuIn
 w9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8DHK7n8boT1yEvYZmR1ZTOA6F3ocx/EmfVnNFwz0uCw=;
 b=K6fI968Fq5CfPSq9NMmKNXsFrCc8H2H6gBxezJcpGtl6ydL2u3K5/FaCW9ERynTLqf
 0FAnmdxXWo9ackdySd869T/eFZvSg978+2SP3+7BiZQwFKtclB2JW3liIpZmRsv5KQON
 8k/ERnHMu2FjFGW9LAf6mZWti7gLbBetffmvhkiTxVIwdDv/TvuMWKDxCzklpwJxk2Fc
 Kie7P1ohTNpucz6STi6Vo3Gistc6tRls9UctpLHZbS/KufkPzA552+2epSlChiGOo8fd
 r6adP0iVs3kwDB+PDLUF20S+uPpTT57A7KMB3OdwwNgqqkmay74WHPCPL6EabHU0CYQf
 qNew==
X-Gm-Message-State: AOAM531ffeJfIDASApYMD2TvhyucN87iZRS6IytqWCKTv7ApFp8xW9si
 uzv6ddxoWs4gEh8muX4QDzKPdCVlEjFy6g==
X-Google-Smtp-Source: ABdhPJzaOhWfY+IvSFWXftVWy1QAGmvLopASHEfxtS2KczVjZiIZO+eXJIrLIOWaQZji8/YzCPE0fQ==
X-Received: by 2002:a1c:2392:: with SMTP id j140mr21081532wmj.6.1595249788625; 
 Mon, 20 Jul 2020 05:56:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] util: Implement qemu_get_thread_id() for OpenBSD
Date: Mon, 20 Jul 2020 13:56:13 +0100
Message-Id: <20200720125621.13460-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720125621.13460-1-peter.maydell@linaro.org>
References: <20200720125621.13460-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David CARLIER <devnexen@gmail.com>

Implement qemu_get_thread_id() for OpenBSD hosts, using
getthrid().

Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Brad Smith <brad@comstyle.com>
Message-id: CA+XhMqxD6gQDBaj8tX0CMEj3si7qYKsM8u1km47e_-U7MC37Pg@mail.gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tidied up commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 util/oslib-posix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 36bf8593f8c..d9236746248 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -100,6 +100,8 @@ int qemu_get_thread_id(void)
     return (int)tid;
 #elif defined(__NetBSD__)
     return _lwp_self();
+#elif defined(__OpenBSD__)
+    return getthrid();
 #else
     return getpid();
 #endif
-- 
2.20.1


