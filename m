Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F2AC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93AE205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9gpQuDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93AE205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtlh-0004VH-5w
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRH-0000Vu-H1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRF-0007rf-Dk
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:54989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRF-0007Wy-3H
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id n8so18569638wmc.4
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ckXsB/S4+Zc7QwguSZl38+7FV9JObasmn6KmK05PN2I=;
 b=U9gpQuDZSoHiMSNkIob/UcNE23sofRmo+WyVlwbLSOVSLYPY9cpES5F6+xWwGU8qPs
 Dcs2ErAoEw/BR0vxStXnSGqT6UOfFqU+RyTwblpCIPDIGTzwt0iiXvs3+/4f1Rxb/Qay
 NpogoGBs71Ufxjxgsn75czGSNLVdhr8x0zceSaM9j7ieN+UBqVcLVOrERNZKftxMh1dw
 UYA90OY8xI9GspDApS35WsavYN/MuDmHijjYTx8FkuBVBm+LecnoccmI/uJtFLclm3hN
 nH8D4WbgPdIJwHIBPGY6ZgO2SWDeg6MteFy1HRmlS9jfk9uWDXmMu11bSdrZZATskgNp
 Cr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ckXsB/S4+Zc7QwguSZl38+7FV9JObasmn6KmK05PN2I=;
 b=PRlbKvVHHmFiSek99yqCqdykhoynuJua4P0VHJ21iR6vcdq9mZj5BXcBJwSQV1Mv9X
 +7+S8Yo6ktWMu3EHNHc0HP5oNfIfgxOaFrjhu7lIpbbb5ZOGlhWDQFxGOhS3Y43WQAaV
 4F8lhPDfNEgDqUONoQ8BfDh3kJiO0jUF5EpgPVfS/Z20xCxcyVMOa9tgwfdn1Z5j6M7q
 /SduJ/IEae30gDJA4jK+9r64TivhKJKniaE1lRi2zeiKmO6qW/YnpPVIMUcwfQIY859m
 g5X5IEyQAX5weRBR0R//YIoi96frUkKzeA9zKfZhlKYqFP86QLn+ZPVM8q7bio4xaQOi
 IDPg==
X-Gm-Message-State: ANhLgQ2KNL/IEcnmJGeWpumRuFHAj3vMoeObb+VN2WDQm9CR45pthxME
 N8lMIqGc/uRMZRVEZBoKuOfFUw==
X-Google-Smtp-Source: ADFU+vvVQNMq458oCnF5U/MZF8V++Aa5oKgQluweiGAFQpme5y1g9ANkk+0N2ahyGaX4b8RrjhsODg==
X-Received: by 2002:a1c:2045:: with SMTP id g66mr152066wmg.15.1584379319199;
 Mon, 16 Mar 2020 10:21:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y11sm795781wrd.65.2020.03.16.10.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:21:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6A8831FF8F;
 Mon, 16 Mar 2020 17:21:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 03/28] tests/docker: Remove obsolete VirGL --with-glx
 configure option
Date: Mon, 16 Mar 2020 17:21:30 +0000
Message-Id: <20200316172155.971-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The GLX configure option has been removed in 71c75f201d [*].
We missed that when updating to v0.7.0 in commit fab3220f97.

This silents:

  configure: creating ./config.status
  config.status: creating virglrenderer.pc
  ...
  configure: WARNING: unrecognized options: --with-glx

[*] https://gitlab.freedesktop.org/virgl/virglrenderer/commit/71c75f201d

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200212202709.12665-3-philmd@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
index b67fad54cb7..a1d40a56fa1 100644
--- a/tests/docker/dockerfiles/debian-amd64.docker
+++ b/tests/docker/dockerfiles/debian-amd64.docker
@@ -29,7 +29,7 @@ RUN apt update && \
         libgbm-dev
 RUN git clone https://gitlab.freedesktop.org/virgl/virglrenderer.git /usr/src/virglrenderer && \
     cd /usr/src/virglrenderer && git checkout virglrenderer-0.7.0
-RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx --disable-tests && make install
+RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --disable-tests && make install
 
 # netmap
 RUN apt update && \
-- 
2.20.1


