Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A791C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BE1206FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="bdfEMKRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BE1206FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCUS-0005FG-Dc
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kQCAU-0007d2-P2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:19:54 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kQCAS-00051O-Sy
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:19:54 -0400
Received: by mail-pf1-x442.google.com with SMTP id a200so1587377pfa.10
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=hcRAOCfuF8XPx2+9nsCqvwz545nb6aVskVQEO7EWm7M=;
 b=bdfEMKRAt5YAw2Ag/Eoc1UTE3MBTm8El0cKEeFRIPV1NpDJBW8uAO8blIXparIIbQV
 2lGb2LV3UIHU5cB75onn5EoEKeyDjevTqyntgsyLJGXeLoiCRYbH85YzOW0ZjzNeuk0T
 rmJAHT9uPt0TfhWu+6TaqWBHXrx5lWTyKOix3ZcLq0PhATq9dS+5xaMUBB83Gdq02K5u
 Fq18US3SUhyYliX2iT3Kx0GFHvTLoM2B34y8PUTao2+zcBhBzw01xnpT8LO0I8kbr1DY
 JlxG9LrSQJh5cjeXmRO8+VjBiflkpL2Ue3PNUS+NuOb/1lXgySsiSYIoomaU79idtGL+
 Ow/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=hcRAOCfuF8XPx2+9nsCqvwz545nb6aVskVQEO7EWm7M=;
 b=AR0OB8tMX6biGk8SAIDg+sA87UWgeTo03GWG9uIh56Bz10AOQ/9Bqlbyv1PXVRgPi4
 2D/LHsNzCBlpP0qgUGmKevyO4rZMdTUGWiw0n+qoknjC96r5qNSft8Syb7KSpAINr2bp
 sFFb4vf3j/0tA1yKWZY3vOxHYjpcP8WuDnLUTG6jt5cNfWvAKvAYfRi11nUW+kdGfyas
 gXiKGrA/59Kw8Gtev5UCkmxRLgbA5RVTxgo4Ns2rwP6yx0NcHh4EXuoXfQFJ60Ct+Gvf
 VkQLhhzsTGnROQj0/0GIyxt7a5PHywAiq7wFJ4Yx0lfR+kTjqu/LK0fg+pWhE+mSJIDw
 cztA==
X-Gm-Message-State: AOAM533EAQMcsUkoKl6NRgzCruZ7C7hVC0lolUpMxTz3W8ptX3h9DiaI
 ZHOWeqM1iUUbGZ2wubxOLrYNNPEnsanV89L0
X-Google-Smtp-Source: ABdhPJxIZBGpKb+LZ6U9Xv1Cj2D6ux35fO7hBsYwBIANRCl0URWeleZOZd07eXRyyzQ3bgj4Fe0qzg==
X-Received: by 2002:a65:5b09:: with SMTP id y9mr3550531pgq.155.1602087590951; 
 Wed, 07 Oct 2020 09:19:50 -0700 (PDT)
Received: from localhost.localdomain ([115.96.123.22])
 by smtp.googlemail.com with ESMTPSA id 78sm3718892pfz.211.2020.10.07.09.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:19:49 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] Adding ani's email as an individual contributor
Date: Wed,  7 Oct 2020 21:49:40 +0530
Message-Id: <20201007161940.1478-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Ani Sinha <ani@anisinha.ca>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ani is an individual contributor into qemu project. Adding my email into the
correct file to reflect so.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 contrib/gitdm/group-map-individuals | 1 +
 1 file changed, 1 insertion(+)

changelog:
v2: removed accidentally added submodule update into this commit
v1: initial patch

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index cf8a2ce367..64cb859193 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -16,3 +16,4 @@ aurelien@aurel32.net
 balaton@eik.bme.hu
 e.emanuelegiuseppe@gmail.com
 andrew.smirnov@gmail.com
+ani@anisinha.ca
-- 
2.17.1


