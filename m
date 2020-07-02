Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A071FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 699B220675
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P79sEnMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699B220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxNw-0005q2-Lf
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <riku.voipio@linaro.org>)
 id 1jqxCv-0002jc-Kd
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:16:45 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <riku.voipio@linaro.org>)
 id 1jqxCq-0004Bt-G1
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:16:45 -0400
Received: by mail-lj1-x242.google.com with SMTP id b25so27835591ljp.6
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 04:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JrNeompWDwNp8Z5Ja7J55uX8CFz38zDaSbG6Gnq0KtQ=;
 b=P79sEnMhOEk5PpYThGPDws2kVSPOMK9AXCNJ5XFL4sGAHY6QiJPW6FRVSlM2X/1YtU
 TI7/9kS9WnGqwYc9PEE2l9QQK7mqimlr4ppsN+GnL1HlhPZWvLOCQzhnZtiG4uKmvQ8S
 drxqNL05En2FWEL9t+SMFxe5Ecn1JC6yvlZHbHAsA6BV7Zj0vKw6Y/xZNAR95LWDgvB1
 tanM2c1//YwJhoJ3azSl/ZBQeK+iqALnKbrDK8TvcT6P8GB+TcU2FgAvaGq+iY7vu+bj
 HLr2hBt6mvbxqaTGq2u3qtaW2ExCs1kkAizKprjyA1iLrlIJ/gxEwesbGVW6zSFGtBUF
 zIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JrNeompWDwNp8Z5Ja7J55uX8CFz38zDaSbG6Gnq0KtQ=;
 b=bEw5Zc5v1DOyEl567RPeKXj6XGXiYOAy+ZPH+u3Q6WfWt0bqlrx8Hzu6JwvY8WkhMf
 OWM5DSo0QFeeZUjGZHojC+9bAddF+gxUu4KWmDhu6lXbj2C/o7K9pkkD6B50pKLl4w/6
 wQKLEV0huXzQiIs+KZnMqIirtSrS+2hEfZTpX8MsyndXZInpI2pPnRX66pcWVNHEkyIo
 xdq2JTjvXn4mbvdHs8VfrA8PrIiWP/s4gCBH700m8efMdYmxpNzg04Mn5X4UW9xB+ZBR
 aGeY0xlezVwCapOzFKCkYegL3XksZEAPdadCxjnMI9dQR1z3MJ8Gv0VWQ6c4g3R5hAws
 1fUQ==
X-Gm-Message-State: AOAM532I6uR9OKvcejKz0EVFhLYQ+KlZmfnGeYGP69oBnHAvaGm9SEll
 ZTgRYcNyTb5zqbvjeHlUsmXI1V05j11JZA==
X-Google-Smtp-Source: ABdhPJytdnQlc3F+BuWAx6yDQ805hHhUZ3VeH/tH68BRFQdzNl9hOIMzVRHj6SRagiBNm0KSAXzDUw==
X-Received: by 2002:a2e:8954:: with SMTP id b20mr13183900ljk.262.1593688597577; 
 Thu, 02 Jul 2020 04:16:37 -0700 (PDT)
Received: from berserk.kos.to (81-197-129-36.elisa-laajakaista.fi.
 [81.197.129.36])
 by smtp.gmail.com with ESMTPSA id k7sm3251758lfd.67.2020.07.02.04.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 04:16:36 -0700 (PDT)
From: riku.voipio@linaro.org
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: update linux-user maintainer
Date: Thu,  2 Jul 2020 14:16:36 +0300
Message-Id: <20200702111636.25792-1-riku.voipio@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=riku.voipio@linaro.org; helo=mail-lj1-x242.google.com
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
Cc: peter.maydell@linaro.org, Riku Voipio <riku.voipio@linaro.org>,
 philmd@redhat.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Riku Voipio <riku.voipio@linaro.org>

I haven't been active for a while. Pass the maintainer hat
forward to Laurent, who has done a stellar job filling in.

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git MAINTAINERS MAINTAINERS
index dec252f38b..29a23b6d3a 100644
--- MAINTAINERS
+++ MAINTAINERS
@@ -2629,8 +2629,7 @@ F: bsd-user/
 F: default-configs/*-bsd-user.mak
 
 Linux user
-M: Riku Voipio <riku.voipio@iki.fi>
-R: Laurent Vivier <laurent@vivier.eu>
+M: Laurent Vivier <laurent@vivier.eu>
 S: Maintained
 F: linux-user/
 F: default-configs/*-linux-user.mak
-- 
2.20.1


