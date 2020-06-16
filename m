Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBACC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7F820644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egvrO6sx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7F820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCiK-0001Za-CT
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQ7-0002mX-Gf; Tue, 16 Jun 2020 10:18:35 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQ5-0006o5-W5; Tue, 16 Jun 2020 10:18:35 -0400
Received: by mail-oi1-x242.google.com with SMTP id s21so19368963oic.9;
 Tue, 16 Jun 2020 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S1Y8wTl2wCcrU0k1huUV064vToavb00IavIF6/ytSuo=;
 b=egvrO6sxPb+D0QMA9T0goti0IZLSwGLO6qtgnHooIPaRx3UUquEMkeAp9FBtqKX+Rm
 gr6lvDXX2UM453GgurFJvTHe0lYnwRsTZA2ObcdVUrU7rvrM9ml+vHdnd9DFf8tFFYUJ
 D9c44u+G+tKRqqa+o1QsBbPwzAkPAjp/vp5AhiLoEtSX+WzehTMAsAB1uA6ovDZ0BqtW
 RyB28VI+jYFMgWkGzKcEIGvqeZo+ONcy4K5odVmLpSYC8E+2V2111od809enCvIAlUwf
 movRSE6GuTAS7XzDArjLRAdNIlt16US/yEV4+LeINGqO6AMoRe0s/oVE+l44DPO2zvZj
 m3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=S1Y8wTl2wCcrU0k1huUV064vToavb00IavIF6/ytSuo=;
 b=q8RLjGquzKE2pHKr1mwdUSB5Vg1FYeijbCVCG51LTJqOyuut4XAT2ukkDDm83oRcV0
 DXS+2xLHelXwsOUI6u57B4gHmzkILLC93LSNsAkR3OAIil4+rFyaxeOfoX7fncBK3gIb
 WAQWOKNhv+e/s4hC2ihx0uvYdc0whf71uclvHR8QYdRB0KQeJQ185FdzcwFKc8tVDfal
 eLhLrqZndKcjeP9JY60kgQG9LIlBTXwtnj7hFR/iu/uPgjfP90cu/6QuFOd0DeMYs68R
 tQkRd/UZVn/yYxadC2Q/CLCbSR9E8BfbNgO15YYDMrezYx607xIpgswz7yyKbKtJPSj0
 LLqQ==
X-Gm-Message-State: AOAM531G/aPI0GQ3jPm+FqA/AIGWOCeUq+DFalINqpkhyy0jPAFv4wYr
 gZ/Qsu/qF+yFaQLLlXo+1kekV8Ni
X-Google-Smtp-Source: ABdhPJzM5qytx3NA8RfbC/NPu+QdDN/Qh5Wn16zz7n9vuIUCBKm+2BQAQy1rikzTzte3HdPfHR3t7g==
X-Received: by 2002:a05:6808:6ca:: with SMTP id
 m10mr3477886oih.27.1592317111283; 
 Tue, 16 Jun 2020 07:18:31 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id u15sm275579oie.29.2020.06.16.07.18.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:30 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 42/78] plugins/core: add missing break in cb_to_tcg_flags
Date: Tue, 16 Jun 2020 09:15:11 -0500
Message-Id: <20200616141547.24664-43-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Fixes: 54cb65d8588
Reported-by: Robert Henry <robhenry@microsoft.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200105072940.32204-1-cota@braap.org>
Cc: qemu-stable@nongnu.org
Message-Id: <20200225124710.14152-12-alex.bennee@linaro.org>
(cherry picked from commit dcc474c69e6a59044b9bb54624bd636cbfd98aa9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 plugins/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/core.c b/plugins/core.c
index 9e1b9e7a91..ed863011ba 100644
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
2.17.1


