Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB54C3B190
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 082D420873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nPFWXlMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 082D420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NNP-0001m8-7U
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKT-00054F-Na
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKR-00043o-Pz
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:29 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKR-000410-Je
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:27 -0500
Received: by mail-wr1-x442.google.com with SMTP id m16so8716391wrx.11
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+sU2DOJAy5PrRToddoYHzVOWw5lnsV1Rabg6J0Rymgg=;
 b=nPFWXlMiqA3G6Z05P112WIl+VveRrtQyHQN19D33o06FaBW3+VWDOZT/EhepXV5pXr
 3SJxI/XrY1GBI943dAPusxk7oAaB2myge3DyBQNJdqYLakTmfMiuOkNC53iCXvESlG7B
 Ae4U4FXuwYbECD6QiS2TjfjGFmgABkA7s0WDi6i0ZmjtwAcjS5Lx2C+3IhB8VjvLf1Iw
 yuGVoIwDA2xnyBSQBTaIZ2txCn//DH5+ldehUHHTWbOGpXwWMQiw2MtDh0HWaokM60lE
 tKhHhcnz9GXXV/KiOfRGUiQEnXacs5zno/eg+k0/QynOxmaJeIZc5grjfMUsGHVzDli2
 J8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+sU2DOJAy5PrRToddoYHzVOWw5lnsV1Rabg6J0Rymgg=;
 b=gGvbmpLgx5KGLNxfqwbUa4YuGMn6XodfvEvBShiLDOzDEwDoadrdNfYxvn291bZQUk
 +UvddNoI6wjF4i4b7luJ7FrTf5sClwqVZ+sLrNVoK2qYsE3/F+FUp4/KChrGsLAOKR5A
 +ZhxfRalGUw6vezcYQ4/PWV/QN2iJ0LOQtKzjn335N7Hzt/U3nuwlznasIv57WJlS1c1
 yB5JPR0GQNjG8b7S+rD82+DdN/Lkd1uvtCjFPtcGvoaKITUkT/WcwMjiz9+muwzo+a+F
 HX2kW/uFQB33w4ma030RsgQs8iqFRriUXJPR/tBnUhf/Zar/4a6VxY0LzfrUpK6BMyLu
 zDXw==
X-Gm-Message-State: APjAAAVUOyHX9TP2YY3zRyhdNnPLHvTXNhzaXBp0THxzfi6VaB5vYic5
 dW28yFdi0DzhEvw6Ofscx0s25A==
X-Google-Smtp-Source: APXvYqwQDutcdza2g0qp3QKKlQM3/CSA3joG8w6AcNnzc4NExvYpCPn42L1EHV5VMUXU5dJ+/uLGig==
X-Received: by 2002:a5d:5221:: with SMTP id i1mr22355745wra.44.1581634286598; 
 Thu, 13 Feb 2020 14:51:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z6sm4611285wrw.36.2020.02.13.14.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:20 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 946081FF9B;
 Thu, 13 Feb 2020 22:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 11/19] plugins/core: add missing break in cb_to_tcg_flags
Date: Thu, 13 Feb 2020 22:51:01 +0000
Message-Id: <20200213225109.13120-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 qemu-stable@nongnu.org, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reported-by: Robert Henry <robhenry@microsoft.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200105072940.32204-1-cota@braap.org>
Cc: qemu-stable@nongnu.org
---
 plugins/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/core.c b/plugins/core.c
index 9e1b9e7a915..ed863011baf 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -286,6 +286,7 @@ static inline uint32_t cb_to_tcg_flags(enum qemu_plugin_cb_flags flags)
     switch (flags) {
     case QEMU_PLUGIN_CB_RW_REGS:
         ret = 0;
+        break;
     case QEMU_PLUGIN_CB_R_REGS:
         ret = TCG_CALL_NO_WG;
         break;
-- 
2.20.1


