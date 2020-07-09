Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519C2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCA42073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ksr2N1SW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCA42073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXOp-0000hY-Bg
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXJ4-0000TG-K2
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:46 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXIz-0001LO-8S
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:46 -0400
Received: by mail-wm1-x342.google.com with SMTP id l17so1998207wmj.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mZEQudYxycdsCekYrXoDMWM3xvLuUrer9RYi3OSY87E=;
 b=Ksr2N1SWhwFnSa6MU822KNhRaHMq0Z3HbBzkbMYpgY3zt3cPXSN8Lw6msB2dDeyHGs
 qWol9Gi2vfG1DITEtcIhR8yyog1T99/TIZ76qUL5OYELox/tR9JJe7VtHK1uaDk6A3y2
 rGPMmymrmIwxBgd0hl8enlKDHuqZwmmIGXwOcgWDguq9Wil/P99j1K17QR8KR4KZq8jK
 rnmiPTjb9ovyjVKpzfF+IDL18NYtj83OFA4U970d0FFHZJYoUGDi1JeCe+jeo2p6l5Rx
 0pI6sbA5D+vkWYkBAwFrbxchmUl74h7URGO04ot0olKUhoyCIVZvQlELUlwcjLP7xGEp
 M3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mZEQudYxycdsCekYrXoDMWM3xvLuUrer9RYi3OSY87E=;
 b=SFvfeujiF0gcDo1IcqOWYokJVwyCDKCIOwXq5hNcj50LSJzZ6w9Dwwm15MVQPZamd0
 lb+WQXrTcCFI//MVUA1X3eHdZ34tCy5aLDFJfCxN8EJcrOIaRTfXSskyXxzi7T85XFzS
 kKYUQFNeAw1m3idaDV+73Bs69yPawoQlv6b7iVunRdd4E7ORrMeVOv1reebnmI7eyPe7
 jII1+6xuFCs1Z/QnWWD7ezTkOwTqmdzDNCWazYBkLXdKmUD33bVaTVjajZAukf6KlKfR
 rzOLKDV5xGzG7v6SQZYB1Itu6EP/QKmefg2OX2ec3NWPVFeS+csWGSMCJCwJX27oJDpg
 8wkQ==
X-Gm-Message-State: AOAM533j0JbJdK0AfYslZIBB4zprgk5exdtq4DI1K8ZRy+QG9RoMQwJr
 tJCDVrFvqtJ6MaGF2gkszh25Rw==
X-Google-Smtp-Source: ABdhPJx0CTpGikZgMvbXFw9mf7xgvHOFrekqWVWWrfaPOTAfxskFMNObsEi+lts0ZEeoranrp9oIPw==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr188617wme.177.1594304019899; 
 Thu, 09 Jul 2020 07:13:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k126sm5520788wme.17.2020.07.09.07.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:13:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 57ED91FF99;
 Thu,  9 Jul 2020 15:13:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 10/13] tests/plugins: add -Wno-unknown-warning-option to
 handle -Wpsabi
Date: Thu,  9 Jul 2020 15:13:24 +0100
Message-Id: <20200709141327.14631-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709141327.14631-1-alex.bennee@linaro.org>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all compilers support the -Wpsabi (clang-9 in my case).

Fixes: bac8d222a
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/plugin/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index 0cb8e35ae407..dcfbd99b15b8 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -18,7 +18,7 @@ NAMES += hwprofile
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
-QEMU_CFLAGS += -fPIC -Wpsabi
+QEMU_CFLAGS += -fPIC -Wno-unknown-warning-option -Wpsabi
 QEMU_CFLAGS += -I$(SRC_PATH)/include/qemu
 
 all: $(SONAMES)
-- 
2.20.1


