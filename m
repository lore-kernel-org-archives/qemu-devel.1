Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38615C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BBC20756
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bgt/shIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BBC20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPMo-0001PU-3f
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPLw-0008Mh-Fo
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:48 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:33093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPLv-0001pM-Ju
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:48 -0400
Received: by mail-ej1-x633.google.com with SMTP id n24so3987196ejd.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6y8fucjPdtyjNnMKl8OrXnEZUIzt60LCNpIsgO/fm5g=;
 b=Bgt/shIFfwALhzWWD+GbalBr99hky/pdn82uT3CgjYg+1rojxpQAaSnA8uJQj7vKku
 AalpZfJRXFnNoypYWHlOnBUk2pdxgiPDgK3z9q4tUTd4q4fOOxWIYMy134Tn0QDta+XV
 lxD3i6whrWtMz0Z2TQ4s6f925K50y+tvNITn8AxOpaoa5i5dDJ93hyP3+SKDGeQrBKkw
 Aa4NWDwdq9bg1AVB6yb+BYnLFbQeFyrBKiqlL9sMdTrpuzvwzwrSwMk8+Opz65wmUm3I
 uKG/fveaiCjVrpGfLBZm0ONG6cvNCh1xFULPZLPj8MgMmJKoe9nRrKHTpvNrJibebzR4
 L9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6y8fucjPdtyjNnMKl8OrXnEZUIzt60LCNpIsgO/fm5g=;
 b=AULDAG85vwG+cK7Tas8hJzY6rmHoxahVz/pOIcvm/XUmg8CTXzDx4HuW7IKlYiZaOx
 o+75MtVlZOU1kDp6ewXhG3PjdShjjOlmdx46mM6AvFpzJUsGgA9gapx91fk/ZIXSFsqe
 NJQ4XHV8RqIdOYu+Y8xCm6tDhmg6VwhuFDaxaObzC77ZMRf7MCv+3ruYClEafbmEvgkv
 9vy0HOFL6Q2D3Ka82hyj1AxmUoNwhA7Gk++JmN29hnXlSlhtJ6fza1RC8n192Kn9MCQa
 s6tRWADJOoTkjce1RXJ1e8+fdwB+DMfdQVmUOxVq5eqDA6TVXletMKxc2nZSuYU00hOB
 X7NA==
X-Gm-Message-State: AOAM530v1e9w+rM6HvaEJNc7TZe1TV2BBhGhKtmshIlFQOmFKt8ZtlTD
 nOLwwUZT6HwMNJsiYkzjfyqC4g==
X-Google-Smtp-Source: ABdhPJyLoMQpNF6JgrCLauCcMWRDJr6/JSgsofyRZmNHp/Ls9GDvKX59bMZ1acLM4loEgqChmMoXiA==
X-Received: by 2002:a17:906:dbef:: with SMTP id
 yd15mr3761002ejb.5.1589983546008; 
 Wed, 20 May 2020 07:05:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g20sm2001567ejx.85.2020.05.20.07.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 902471FF90;
 Wed, 20 May 2020 15:05:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 04/15] tests/tcg: fix invocation of the memory
 record/replay tests
Date: Wed, 20 May 2020 15:05:30 +0100
Message-Id: <20200520140541.30256-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm not sure when this broke but we should use EXTRA_RUNS for
"virtual" tests which are not generated from the binary names.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - keep the PHONY's for the benefit of output
---
 tests/tcg/aarch64/Makefile.softmmu-target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 71f72cfbe34..1057a8ac498 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -61,7 +61,7 @@ run-memory-replay: memory-replay run-memory-record
 	   	  $(QEMU_OPTS) memory, \
 	  "$< on $(TARGET_NAME)")
 
-EXTRA_TESTS+=memory-record memory-replay
+EXTRA_RUNS+=run-memory-replay
 
 ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_ARMV8_3),)
 pauth-3: CFLAGS += -march=armv8.3-a
-- 
2.20.1


