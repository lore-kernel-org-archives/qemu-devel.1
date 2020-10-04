Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41328C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9DA2065E
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVc8NY0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9DA2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8PC-0003pO-Re
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NQ-000215-8W
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:04:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NO-0008I6-HC
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:04:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so7080814wrw.11
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EMFcDT2HE/Yg8v4qwFysHGiLE/UAQ1O9RggAPpgJcqE=;
 b=pVc8NY0RNfF2aHZ3ZR22wx7O2Ed9aoLS4hMVRMfeW2AK6IwUecFU0ZT2wUosXZNe8O
 RGmKSkUnFp+OMOiCfAl17mrQypjn8bJx2hqGWPKDtEOPBryponJ4SlwdIfPdHEpOj+CT
 1n2TvLjtERrUNOt98otJROmfxv2Q8kl9fL77Z/6nGeYUsOMHkVN+FH3VwmPtqDeQfP7r
 KS5PnQPf2AEtjfO7PoP+VR4mg0JEZbpH7NCDKDh5dZYj7aLP+xvCZ8I057e26CEAD090
 bW1mJb92aoDTzSO2GxN4frFgwNJ3tMDFgLHIV+pRVD7XaexbhuDXzAwxq+U6XPP0tpUW
 PVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EMFcDT2HE/Yg8v4qwFysHGiLE/UAQ1O9RggAPpgJcqE=;
 b=jYijWxggmnaf/jgn4PpUTdM2PLp3rdATD1sO5LS7FW+JrK10+x5gdzUG8YHrrPf3m1
 kY765srrUpKYBhs0NP5cFxEfTvzuPJeV5TWw8V652By19jj8xtQffPzraQcvzb3FB9yd
 666cRnR4n+gqEW2DeNz7ZL9x3fq/YupMPv+Vq0i909CqC4Gh2e9e1aeOZJNeqbC4sI+Q
 BapjL6xL0GFX7jLGIrC/BCsKknJJrdoV9lUb09NhAjrchlvuqdsMxCPRtTsZ8ZCqpIoD
 aj3BHpEyVYbUjH4pdIvWMaI7ZaKr9QFDECrHvHuZLg1UndLsHMaLn6hNifOmAaYhrHuV
 zrKA==
X-Gm-Message-State: AOAM533Fyv91R/JTECKTOvK4ZtSn0WnsGD7VtEdsO/2UeMSKfYTkM5lG
 NXXWh0+GIm4L/XTo/DSvDURFUJs1l8M=
X-Google-Smtp-Source: ABdhPJxWQBaZHGd3yNTSYDGRV+235IG1uUe18d8awYthw3FJ4JlhXjZkN5+5RrWJAfxquhAG7gMZMg==
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr13914557wrw.426.1601834688826; 
 Sun, 04 Oct 2020 11:04:48 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:04:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 02/21] contrib/gitdm: Add Amazon to the domain map
Date: Sun,  4 Oct 2020 20:04:24 +0200
Message-Id: <20201004180443.2035359-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Simon Veith <sveith@amazon.de>, Craig Janeczek <jancraig@amazon.com>,
 KarimAllah Ahmed <karahmed@amazon.de>, Paul Durrant <pdurrant@amazon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Graf <graf@amazon.com>, Anthony Liguori <aliguori@amazon.com>,
 Julien Grall <jgrall@amazon.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hendrik Borghorst <hborghor@amazon.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Cc: Alexander Graf <graf@amazon.com>
Cc: Anthony Liguori <aliguori@amazon.com>
Cc: Craig Janeczek <jancraig@amazon.com>
Cc: Paul Durrant <pdurrant@amazon.com>
Cc: Hendrik Borghorst <hborghor@amazon.de>
Cc: Julien Grall <jgrall@amazon.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Simon Veith <sveith@amazon.de>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index edff91b28c..2956f9e4de 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -5,6 +5,8 @@
 #
 
 linux.alibaba.com Alibaba
+amazon.com      Amazon
+amazon.de       Amazon
 amd.com         AMD
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
-- 
2.26.2


