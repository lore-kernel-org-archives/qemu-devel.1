Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01DBC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197B621D24
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bru/TKrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197B621D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXLtT-0006nW-PN
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLli-0006vr-Sh
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:50641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kXLlh-0000SW-2t
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 05:59:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id 13so755279wmf.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 02:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JvXXjxCnzuVyw48/pxsXMREPw8qcCphYSqn16eRFOWw=;
 b=bru/TKrLoDy1C0WPdF8PgJFiuWrlD2cYPv33bMQPLFI6R7bRUXy/KfYDrZYFHvgcSC
 ZEivrJMW2fkXNIg+YNgrAIlY+LJhK6LSpMyCm4of6rCf4mr6bodrnpvHgILuF3CDCFQt
 2cXt/cVzG8PE3voSOvjJanAzn+6A7c4ZDzpGc5lYUdJ+ux6RH6yzccZww9ngSE1lf5E1
 1SLC+IBOWsGRbq3pPc+M2Ei/XrMEfPXn3w1KMNJJPaRI49BS2KgzyDer9JTVeph9RRBU
 vZGVS0vAYsLY/i69vpYnCbDfPPPFJXgzEGtTXKBB+MG7rI8uOzu07xSvGmX+FuE9w4Er
 w83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JvXXjxCnzuVyw48/pxsXMREPw8qcCphYSqn16eRFOWw=;
 b=J1V//tsmUFKq7u7vwbz4+a8gA5k+Atak4LR8e1eKzr3CHfYSPR3uY2fW7RCy+nzkC1
 w+dSQ0LMYB5WymU0MGlsp74ZCBRcGqO4gCx20pvLUyb0aZNbSBC5pO+T17a8myXa78lb
 tJkjVljICTUa/vERExzViYQGcndH+YO7fuE9cx9ZWn67b1xCwTHHDpbScUQyN7bzgKDv
 TtI+zyV96a9naJTibYzl2KkJapM58kDXvjHhw54caJ960WU2PvTm/dQtciMeUWKfbm8n
 B5iAfrJ++Pa3o71xqETwgf+0wNWCi2ApY66QZd0jupvNGikh8qx4gNlJB4Php/Bn0U/L
 Ejvw==
X-Gm-Message-State: AOAM5334WG/zTP8yGHCjxuvQMN/OWxxuCOPaeOpN//DAz9XBZPrxVKzc
 FTrV6pqSvjETVkd1eK+5Bw+xkQ==
X-Google-Smtp-Source: ABdhPJxEAGs36Q4O8ZxPmIeq8lHWQvpGi/dhRz5nrTSHUgB9FHCkPMu8QLjubpsdbOa0G2qYDmrJ8g==
X-Received: by 2002:a1c:56c1:: with SMTP id k184mr1781446wmb.14.1603792791742; 
 Tue, 27 Oct 2020 02:59:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x6sm1370497wmb.17.2020.10.27.02.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 02:59:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7BBC11FF96;
 Tue, 27 Oct 2020 09:59:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 8/8] makefile: handle -n / -k / -q correctly
Date: Tue, 27 Oct 2020 09:59:38 +0000
Message-Id: <20201027095938.28673-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027095938.28673-1-alex.bennee@linaro.org>
References: <20201027095938.28673-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Use $(findstring) instead of $(filter) to detect -n/-k
as different versions of MAKE fill in $(MAKEFLAGS) differently.
Do not bother running ninja at all if -nq is passed.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20201026155854.3074290-1-pbonzini@redhat.com>

diff --git a/Makefile b/Makefile
index 4d1fa8bb3d..e7c1000f5c 100644
--- a/Makefile
+++ b/Makefile
@@ -146,9 +146,12 @@ endif
 # 4. Rules to bridge to other makefiles
 
 ifneq ($(NINJA),)
-NINJAFLAGS = $(if $V,-v,) \
+MAKE.n = $(findstring n,$(firstword $(MAKEFLAGS)))
+MAKE.k = $(findstring k,$(firstword $(MAKEFLAGS)))
+MAKE.q = $(findstring q,$(firstword $(MAKEFLAGS)))
+MAKE.nq = $(if $(word 2, $(MAKE.n) $(MAKE.q)),nq)
+NINJAFLAGS = $(if $V,-v) $(if $(MAKE.n), -n) $(if $(MAKE.k), -k0) \
         $(filter-out -j, $(lastword -j1 $(filter -l% -j%, $(MAKEFLAGS)))) \
-        $(subst -k, -k0, $(filter -n -k,$(MAKEFLAGS)))
 
 ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
 ninja-cmd-goals += $(foreach t, $(.tests), $(.test.deps.$t))
@@ -165,7 +168,8 @@ $(ninja-targets): run-ninja
 # --output-sync line.
 run-ninja: config-host.mak
 ifneq ($(filter $(ninja-targets), $(ninja-cmd-goals)),)
-	+@$(NINJA) $(NINJAFLAGS) $(sort $(filter $(ninja-targets), $(ninja-cmd-goals))) | cat
+	+$(quiet-@)$(if $(MAKE.nq),@:, $(NINJA) \
+	   $(NINJAFLAGS) $(sort $(filter $(ninja-targets), $(ninja-cmd-goals))) | cat)
 endif
 endif
 
-- 
2.20.1


