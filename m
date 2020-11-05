Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A04C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A192078E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boXTXj6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A192078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaeWR-0004eH-TH
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kaeQf-00056e-MB; Thu, 05 Nov 2020 07:31:49 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:33523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kaeQZ-0005XA-4w; Thu, 05 Nov 2020 07:31:49 -0500
Received: by mail-pf1-x433.google.com with SMTP id q10so785900pfn.0;
 Thu, 05 Nov 2020 04:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PJS7oGCcqz7pb4dQLFQlOPOs9s6TE2XwP4RwUlSKWNg=;
 b=boXTXj6CbbMyCekKPLjd8r+95PdoEkk4Wijo3edr5w/gK5LpDPxp5MQgMB/IIdD2NY
 rbIQU5eThiCve9vxEMSK1SLJaKMWXCuxrIg1UFXrfRP0DlZGZpxLrVnTK71ox6X3g9mj
 uA+Wo4tmnHRW8rG4Rlq9IflfqSJEJ8XIGI0e0QQhQM59z6dJOifvxqgtWGc2GZceMvE8
 pTKza5kZ1EohoRGPZdI/jB8mZZfFfFoDbNriDJljp8eWbY+UBbeDbTT9b+QH3YxkS6Kd
 Y+ys5XUxjfMPzWivUfLlmEKzhEC4LoSB082ED4sThEO4fy2V9XLYuT4TP7PDCOS5GAnk
 4yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PJS7oGCcqz7pb4dQLFQlOPOs9s6TE2XwP4RwUlSKWNg=;
 b=jCR9EQhgpL25u+CXP2Z4AkBB18jM1PFJ/JXMaFSmvPAIzz3W8VZDAzw+OYmQZbsE6u
 0CqpPM/32pQiawh/bG7NdWXJH03X1MbUa6y2GBtxjB6tWBcwDsfd3/zk+81Sq1p1S3rK
 CurCS563TKImjmPRVQ+x/ZO7uA0p3Cd74ZUb9cv6N4JaiwilAWtMO5rhcp5XxHUlN1EU
 04UEEwa0OYdo3pYODVjkyU6ZhQQOBNG3XswPRf19QGUgKtBGjjkbI2BBjUtfEVJtINK6
 AYfWDFUU4Hpsaez78tDp7OBq/50OHc1TwA8N/jFm9aJI3L0Vg1TTedQOQlXrXSy8kyj6
 9tYA==
X-Gm-Message-State: AOAM533U2/0vzIxGRSrOtU9yWifDUtbjCI3yoI4ZlPZRD5myd4B/wzVw
 tmPBOL+vJJcTFuGjtL7MiFRe3UfYu6B81Lju
X-Google-Smtp-Source: ABdhPJz042gWPuIUbJXgYjWnGNmioYA+us0tEm+WcYC8r2dbVyD1duQ/D+ZN66G+O6I8XL8qTna0rg==
X-Received: by 2002:a63:1748:: with SMTP id 8mr2309229pgx.168.1604579500537;
 Thu, 05 Nov 2020 04:31:40 -0800 (PST)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id hi10sm2987008pjb.0.2020.11.05.04.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 04:31:39 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] block: enable libnfs on msys2/mingw in cirrus.yml
Date: Thu,  5 Nov 2020 20:31:16 +0800
Message-Id: <20201105123116.674-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201105123116.674-1-luoyonggang@gmail.com>
References: <20201105123116.674-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>, Peter Lieven <pl@kamp.de>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initially, libnfs has not been enabled, and now it's fixed, so enable it
on cirrus.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index 900437dd2a..f0209b7a3e 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -109,6 +109,7 @@ windows_msys2_task:
           mingw-w64-x86_64-cyrus-sasl \
           mingw-w64-x86_64-curl \
           mingw-w64-x86_64-gnutls \
+          mingw-w64-x86_64-libnfs \
           "
         bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND `
           https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz `
-- 
2.28.0.windows.1


