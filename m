Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA57BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890E220706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="colkzIor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890E220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqWz-0005D5-RC
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4q-0003lG-Jk
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4n-0006nV-MO
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:40 -0400
Received: by mail-wr1-x442.google.com with SMTP id s10so9825365wrw.12
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uTu7OHovsUuRycqX60tPTOf1KxCYgUCqmiTf0JQrhhE=;
 b=colkzIorq2oOsFQbS+gxoXgnDw0KuD3gCQI5SgWoj3LD1r6nBUFjLf4YdKsjnsS6YW
 JlE4+0EgreKWXcimb1LN3CFwOBFnIbCW99+6ByD18f6IG/yyv8CZsTHPCEq8cFwpI9V+
 dMeZ1C0RuB5i7sNwRJyQRzm5D3h84gqWMyDhfc5SzJRRAUICufJO1vDPi3FeqSHqqjac
 um3+U6xDcTANHvtBhk59KuiPsHeTTzWT/rT6XDREqETaSoLc/yQjW68btc6e20hmVjvh
 JcxKpv8izdoAOyBa5oqM2FQW2D9I/V1rmc66dtUkNDsuXhvmUDxnF01VvGZ/VGTuhqfZ
 2Afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uTu7OHovsUuRycqX60tPTOf1KxCYgUCqmiTf0JQrhhE=;
 b=JA+IIIgMdAq0lYBSxSMZ8cXUfCU2P5EXoG/cGZ1kHT/DT43nwCIbAP1loewQByPR5t
 gqrNtVRSlNwSmuP7alydZolnUcYtla/Hser9CQyFxWTv6Z9JG4L2809VAepDldT1fPZ+
 NluXib6jZ4Nb01Zxbu4EWgC//DeVUbOXHY1Np9jaxhBM2dlg9gmuf/boYYZkhxQZK6Q7
 HmDyOfG+KPZtbiUivGGLq8UoBSNO/UBBh99Jazr1MK7uDGWxcoM6lCGmQE5WPzpmMU1I
 68iNBGO4XaToS0AVVovlIrox2HpKwaeLNX30SJKy+XURM+w4MRAOYJaM9SeRMDDsxZrl
 2gOw==
X-Gm-Message-State: AOAM5323VFEG+Z2j8jla3BM58GWAuuVBsSQsCBwp/7so7qwDKXw+zlJm
 zzXe6tpzMFWOyGjGCu80zTLLiGJK0ZeQcA==
X-Google-Smtp-Source: ABdhPJzP9Wz11R466OpgQIj+Twe84ndMwp38eWxzz+tZBSdy3rGUaD7D+rkBFx6M5GxEy1NATLu0GA==
X-Received: by 2002:adf:f885:: with SMTP id u5mr4225800wrp.402.1593184536129; 
 Fri, 26 Jun 2020 08:15:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/57] target/arm: Enable MTE
Date: Fri, 26 Jun 2020 16:14:24 +0100
Message-Id: <20200626151424.30117-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We now implement all of the components of MTE, without actually
supporting any tagged memory.  All MTE instructions will work,
trivially, so we can enable support.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-46-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a0c1d8894b7..a2f4733eed6 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -654,6 +654,11 @@ static void aarch64_max_initfn(Object *obj)
 
         t = cpu->isar.id_aa64pfr1;
         t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
+        /*
+         * Begin with full support for MTE; will be downgraded to MTE=1
+         * during realize if the board provides no tag memory.
+         */
+        t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
         cpu->isar.id_aa64pfr1 = t;
 
         t = cpu->isar.id_aa64mmfr1;
-- 
2.20.1


