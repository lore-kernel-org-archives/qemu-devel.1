Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB306C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886542196E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="imkfMotC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886542196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUZFh-0006n5-PC
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUZDu-0004du-35
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUZDt-00009G-4V
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:40:58 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:37636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUZDs-00007W-VA
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:40:57 -0500
Received: by mail-wr1-x42d.google.com with SMTP id t1so19293547wrv.4
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b/wG1eZBz0mKbZdLSFK28hybTiG6cku9dWo4Kr3nW70=;
 b=imkfMotCsuYNtRwEUOLS+41ZHdaI9wFxGMbv+bNEImO4HqArmVLaEtT2jHlSUpzYxR
 TsaYnHk6rjnEDhbKD2MRzxgAMHWL3CqZJbDGUTUMn2P30qTZqxE6v33LbTNSM8m2ETpd
 y3IsMUDRysk35TteuuyP92w3lpjqRWW8y4thVYdEoMyffu2usXR3bzlrGmHbDdx0Wdek
 aDjw22WfNNuHWXobwIFrkXAwd/0IJrCPxGoQqyPaLIAyL3MAiDtTbsHqp0awxmnTj/Aa
 YzxvXP00m4HFPLlDXhb23JvblhwTqkSklA0pstsFPPGp7/DvV2xbuItZg+LYsDQMDcqq
 5Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b/wG1eZBz0mKbZdLSFK28hybTiG6cku9dWo4Kr3nW70=;
 b=M1mpPkKIe9nBjWeEK0JAsocx+f9fxWlyNbL8hpeRtqmtAwt8mkQOWrSC/dnv47LhCm
 Y0hqqDF3g6gSCXj+0frW2CEG1n4BNiHXImS0bKM3xlipo3pLrKUZv2p5cFGtiLuB5wMe
 ziyfVU/csHMsJvCPqrosDWalNyAB7mbX/ECGB0bIpfPNPxU6Q3XO4POTbqlJCY8GrPlg
 rLjEkeMM4mNQezUFNbG3jCQX/vZbN2VaOb71jhfJB83k4ly9DDoZNoKE2Nx/1NagDpCj
 UGc2advz4OEB855b0R7+ktdUisWGRoIJK82zbajNBnZwpr33u0F3pOUanGE1JbsXHiQq
 bq0g==
X-Gm-Message-State: APjAAAWRY2yB3n04X0SL72Rnr/AA9UDS16RfkVN/f00ZXQGOqHiAX7io
 DG0u3E9zFGTu4cNsd9uhxOtQng==
X-Google-Smtp-Source: APXvYqyohdecEK3A2et/m1pawNTIH7bYVYnrSUBFsanBXLdckQH1CRvZJyx2BtYn/WqLih35iVxASw==
X-Received: by 2002:adf:ed4b:: with SMTP id u11mr6295283wro.215.1573576855839; 
 Tue, 12 Nov 2019 08:40:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q124sm3317173wme.13.2019.11.12.08.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 08:40:52 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A078A1FF8C;
 Tue, 12 Nov 2019 16:40:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 1/2] docs/devel: rename plugins.rst to tcg-plugins.rst
Date: Tue, 12 Nov 2019 16:40:50 +0000
Message-Id: <20191112164051.16404-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112164051.16404-1-alex.bennee@linaro.org>
References: <20191112164051.16404-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes it a bit clearer what this is about.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS                                 | 1 +
 docs/devel/{plugins.rst => tcg-plugins.rst} | 0
 2 files changed, 1 insertion(+)
 rename docs/devel/{plugins.rst => tcg-plugins.rst} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff8d0d29f4b..b160d817208 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2369,6 +2369,7 @@ F: tcg/
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
 S: Maintained
+F: docs/devel/tcg-plugins.rst
 F: plugins/
 F: tests/plugin
 
diff --git a/docs/devel/plugins.rst b/docs/devel/tcg-plugins.rst
similarity index 100%
rename from docs/devel/plugins.rst
rename to docs/devel/tcg-plugins.rst
-- 
2.20.1


