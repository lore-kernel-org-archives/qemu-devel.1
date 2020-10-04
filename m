Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69DBC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0821206DD
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOeQi4Y+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0821206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPAvA-0004dv-0x
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 16:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAtl-0004CE-DQ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 16:46:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAti-0000dr-JV
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 16:46:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id k10so7332169wru.6
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9W7QqLxCDxQ0VUYDuTg/fuTwoAI3pI8zkbI64r1Nyao=;
 b=gOeQi4Y+C+kRuemypejyYWMj61qfgekPNPLCcxpzcTuo59xO8b1roR9vyub3Ij3kZh
 LInYHFLN+wQO5fWzCJj/bSQnRuWzCxYGphOwSVIJjZ9gI3C5cNd8po7xS6BWiu7ICiwS
 7Q9liUi9+zWOj2UTtAllDzCIw2jIX/2WgtcWCH6/kFaIkPDh/cIWIkLqdLIDdqdIGJxw
 1AsJUM/TDtrMFxBuu2At0UB+rRDILs+TKO3PxBWa5sYze8CaZuv8LWezBArE6wNs2F+S
 +17qMBfYfvC4mPHh1ItFO8sVlwFzYw5enZo9IJbe/8L1iCvBUuLkMtD6XxL3UGfIq4sh
 7nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9W7QqLxCDxQ0VUYDuTg/fuTwoAI3pI8zkbI64r1Nyao=;
 b=TmkeUISjBm6EI2kY3EjtvnilDwtNwCitOu2BTBP7WcTK5Fi++BAGSyGAFcdHq0Iy8X
 CFnNWAVDSo4Dk8EJH7v5yLyAu4bkaPWTs8pd86+Jee22m/AWYNARdWVL8eJ6HEj5hD73
 gRDpb6cdFX7pjFFhTaVe0EXbK1I3HC0xa+dogvr4kGm/XbTdX9B1vLN6z/HWmNVCo0BU
 0UBz7omAcPq0KYFTF+8wrcgjiCTtVHIcBE6hARtbCvx9p0zVpIE+durwMHi2Qvof07Pd
 qBI4raeeXJTMEv7/m0wfS8lWQVunnWvwLZ+P1BD7GsCMkJEUA96S5I5uRg7uvKy1RYGs
 Rvmw==
X-Gm-Message-State: AOAM531gxLBLRO8I9sfj+hLvNWdhX+8aSylgytmTtlJL409HTdXDoEzD
 AC//Hnb9vPnLETdyxrZOIIVlJj6VJx1x1Q==
X-Google-Smtp-Source: ABdhPJwPgmmLkkJgyQv0pcy/BY9aJbleGtUodmtsMkPPsPNm8UGEJzDOUMTRaQ7Qsiru8bpC7gdLGg==
X-Received: by 2002:adf:dbc3:: with SMTP id e3mr7943630wrj.1.1601844379795;
 Sun, 04 Oct 2020 13:46:19 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v2sm10391962wme.19.2020.10.04.13.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 13:46:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/2] .mailmap: Correct Yuval Shaia email address
Date: Sun,  4 Oct 2020 22:46:18 +0200
Message-Id: <20201004204618.2049548-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004172644.2027440-1-f4bug@amsat.org>
References: <20201004172644.2027440-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Yuval Shaia email in commits f93cfdc583 and 1d2695ef02
to avoid gid-dm warnings.

Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index dea358ea7d..b86359bd10 100644
--- a/.mailmap
+++ b/.mailmap
@@ -173,6 +173,7 @@ Yu-Chen Lin <npes87184@gmail.com> <yuchenlin@synology.com>
 YunQiang Su <syq@debian.org>
 YunQiang Su <ysu@wavecomp.com>
 Yuri Pudgorodskiy <yur@virtuozzo.com>
+Yuval Shaia <yuval.shaia.ml@gmail.com> <yuval.shaia.ml.gmail.com>
 Zhengui Li <lizhengui@huawei.com>
 Zhenwei Pi <pizhenwei@bytedance.com>
 Zhenwei Pi <zhenwei.pi@youruncloud.com>
-- 
2.26.2


