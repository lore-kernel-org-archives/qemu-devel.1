Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4024FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093E720787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hURhiBRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093E720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxXi-0003Jl-9M
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxST-0001mX-GN
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdxSS-00087h-80
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:55:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id r15so3312204wmh.5
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9HZ1EFz6RskQjzpAroacy545o4e5LlawaS4/URLolBY=;
 b=hURhiBRMam1thRAmzjVBDkG12amfK2VF8G0+QUzB3y7v/NLGOwZ3Gv28hyEa4hXQMn
 Sjscj0Cy4f6pkL7bWhOdngviRCDqk6feSQv/+ajPmH3vWz95L+Tn2s0UnMJAcA3qK0Yg
 jAfyIcNZuVUdXZdJHbcuHKFHUjd9WAMCtN9cTAPNqVmYn5vPCRbXK0SfAcFTJdRC0lf8
 yIvpF/4zPM/vmy5EM7KnsCBNEzIikQRBW5Hy1+Msz10T2k7/XeovnoG7Py933ivaxFuB
 uxVR5M/Oqlzt/RcLmY7TRDkA9dJEF9ZRd6WoAt1we2x8pPf2MiqDDls1162+O/j8w//z
 v15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9HZ1EFz6RskQjzpAroacy545o4e5LlawaS4/URLolBY=;
 b=A5HC+IxhXPnFvQlhMQsPq64esTVlIemWO/kNZ+uikd+7dhGAntGuyfGdPgm1ts+y43
 AgvTP4OCjuLb4++VGjydQIGsJIrEck8/7fMpkLb6MOndH9WhpGkv9S/sMYGPvbCKVSuT
 W0uXCWI63yZWMDcckZqvJS/Kq70qFm9DHCYdupcV6bkRajzkpxeaFV6RMDxGbDyfHlM0
 O09G3Sjx/P/RRQAAad7nw7ZmoYvAxfleYwvD9WOXyGTp58Bm5pN184fkRD9f7v4+7FrN
 MYQaIql9gdzdV3A8GJ/CSu6GAJQxxK7L7lA53NUQuv0WSNo5ZNSGhMZ5QDVxCKtPdIZc
 5tXA==
X-Gm-Message-State: AOAM531dBh+tJ9CgjC/XTd01ajqLweMM4j7vPPdcBgkDMm6+alXaaaAh
 yL9UHUMa3ctY5KR8ef5+rE7lcA==
X-Google-Smtp-Source: ABdhPJyWI2hvyq+gKhb/bpuahYmAW7OWmLMvtZCpYSzeghb2aeq0zrRbyndE9cNQjeuOKS9VuJeZkQ==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr4555090wme.0.1590591302345;
 Wed, 27 May 2020 07:55:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w15sm3053551wmi.35.2020.05.27.07.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:54:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6D4081FF90;
 Wed, 27 May 2020 15:54:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/12] tests/tcg: fix invocation of the memory record/replay
 tests
Date: Wed, 27 May 2020 15:54:47 +0100
Message-Id: <20200527145455.2550-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527145455.2550-1-alex.bennee@linaro.org>
References: <20200527145455.2550-1-alex.bennee@linaro.org>
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm not sure when this broke but we should use EXTRA_RUNS for
"virtual" tests which are not generated from the binary names.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Message-Id: <20200520140541.30256-5-alex.bennee@linaro.org>

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


