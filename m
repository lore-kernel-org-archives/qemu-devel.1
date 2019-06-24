Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46DEC48BE8
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69C6208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 13:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqnUV4HN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69C6208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfPLq-0000Wq-Sd
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 09:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41523)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGH-0006hj-IN
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfPGG-0007fL-Az
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:57 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfPGE-0007Oi-DS
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 09:43:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id d18so13994189wrs.5
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c6RTlncvKEOxdPzqDtthTA6vXD5pXgd87E8kJP9158o=;
 b=WqnUV4HNKo4DS2e2EQXp0afedkA08ZF6h1AXyr+FJCgdB36To9Bc1Cbtdu6jRCDaWx
 OHSPEW8ZRl3fW5F++mopm5ynQelzWU/Lv7NzRjIMEA1Oc85pqOI0mzWnElu0gOuPrnO9
 TkhQBX3npI5PBer5YBHSrpvkmbFFd3cYGUR4WZr1GNUw4bwAcdC4AGjNHyyzdHfrGe+U
 0Yrj/PONaqedOFmw+6N/Wp37kWu557MdBIywL9SktRrrlQFqOnEvul7d6uWEYOVQtRh+
 8jtybw25h63b5QKm3go8wKxSoEBJ5+U4yLX4hwBjnerYQjA+tNqQWl0zdgD1+SQfmrbf
 oHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c6RTlncvKEOxdPzqDtthTA6vXD5pXgd87E8kJP9158o=;
 b=MoSqBv5iOlA3v5zvsCQ8xSgXQLYRv+brx2DXnBK1d9F5oOvT+RnlJxwarMQ4ppK53O
 F4fqMEXUcYFCIIfZ4ZcfGa5VNUm8r3Q1P50nKK43KfVDdvGhBdavypOirPEKU5ojrtyT
 xAPlGIscJ7B29sA5dTs+zapTOvqYsS+z3r+2JOvPH8OtEufHFLZXWoutkvvdSuM6vhaJ
 v37Rpxjsol/hkVolditdshcQPOtKf4Tsk4/HakXFRuD1Ce1l5gmLKRnlwRqsgE4c7eKC
 jA+AYCCHs2B54Asn9hNyDplK2S81zZA/c8t6KwyXGlplcozNBXsVG2FiEXsl3sClEkVF
 /+aA==
X-Gm-Message-State: APjAAAU0wx4Q1DhVANrZRQcw3IcG1uX5nL6v6eQsaBdbW3SKqnT8f+YG
 wn079cdJY2nKWNCtqHznpSBTnw==
X-Google-Smtp-Source: APXvYqycduhhLupneyF6DwiALAvNx9yrAK7UN37lIFMifF0/3TT0yyCzcjNEZG5krUdfMm3Om4kTXQ==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr18321554wrs.97.1561383823469; 
 Mon, 24 Jun 2019 06:43:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s7sm11584wmc.2.2019.06.24.06.43.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 06:43:41 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1ECFD1FF96;
 Mon, 24 Jun 2019 14:43:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 24 Jun 2019 14:43:25 +0100
Message-Id: <20190624134337.10532-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624134337.10532-1-alex.bennee@linaro.org>
References: <20190624134337.10532-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 07/19] tests/vm: run test builds on snapshot
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

The build script doesn't shutdown the guest VMs properly,
which results in filesystem corruption and guest boot
failures sooner or later.

Use the --snapshot to run builds on a snapshot,
That way killing the VM doesn't corrupt the base image.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Acked-by: Ed Maste <emaste@freebsd.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190617043858.8290-4-kraxel@redhat.com>
[AJB: added tags]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index c59411bee0..276b870216 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -57,6 +57,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(V),--verbose) \
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
+		--snapshot \
 		--build-qemu $(SRC_PATH) -- \
 		$(if $(TARGET_LIST),--target-list=$(TARGET_LIST)) \
 		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
-- 
2.20.1


