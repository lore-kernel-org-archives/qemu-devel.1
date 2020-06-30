Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DFEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0011B20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNvFppDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0011B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDcR-0003Nc-8m
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqDbN-00023z-UU
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:34:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqDbM-0001dL-AD
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:34:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id w3so6627994wmi.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GDR6ape9ULFXd9AXd8i0jKbRDr4t91uOPO8xiLTtEMg=;
 b=kNvFppDHSgN+hrqF2l1GkxZTfStYLb2U/LoFBsMhpFzIbcFrBCKH3tgVsuWCov29hj
 UrNWt6MJACXctTRAfuRl3MK2Vok41hBsnX1qzbc6uj0yze/TYPpVa0X/Wusq+SIQnrC0
 wOZ4WAYuduKueIIoO0KIIsQGaR09PhhjfBjjLXRAqxK9uzJeR0UZbmfO82/UZwOvUi7T
 +g1SfMwTzgtUZZCqWWFu+LdYVcOTZ+P442uEpS892qReAbL6Cx+6eg1oIiwEAPpu2Zmp
 YgG0jO7dylL21uZL4jVbBWzDZ39FmDqSWHCJ0yDmDXwy1tgSjK0WL2oJMyLTYCMY4PFj
 +gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GDR6ape9ULFXd9AXd8i0jKbRDr4t91uOPO8xiLTtEMg=;
 b=EaqVoKE2w2E64iKolB3EzFXt4K3Z80B4Hiaqo1lo9NKXzg9dC0RmgqC/f+Foat86Ti
 ia2ukHGf1lVQsX38rtAr+gCptP7cKzEvmdW66n0G58eFzK47DbEundhYDkETXAX9PlJ4
 IwzD300O9z+bOgfd/HNdLHx370N+y42hlJLNMiOxQG9kzcowfK7z7Qw30xT0xI9UA7Jq
 Iae4iQ4V/pQdjWd4cFInEyUQZ6rOPNar8o/E6ChJLlfGwUOYxf39caXWhvfVKaEYv+0V
 950AaeHWrrF/NLGwk7glvLt0rIMS8J3+W3PAnzhghqfilkw4OXq7ve9Q4USsI1wwjZnf
 R6oQ==
X-Gm-Message-State: AOAM531dQncMXixSjVsuaHpNE7/w07GmuKSt+vzgI3W3UcUXbHUA55sz
 did/mca95bJsulOuq0t0zuRSKw==
X-Google-Smtp-Source: ABdhPJzl9tkm8enEs/hDb+Gz0ucL+qakMIaH8Vab9zX4tKhKtjf534WJ/GV1cRV1Dx11AVGs6raHkw==
X-Received: by 2002:a1c:bb43:: with SMTP id l64mr21506440wmf.151.1593513294114; 
 Tue, 30 Jun 2020 03:34:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k185sm3178123wmk.47.2020.06.30.03.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:34:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3C9C21FF7E;
 Tue, 30 Jun 2020 11:34:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user/elfload: use MAP_FIXED in pgb_reserved_va
Date: Tue, 30 Jun 2020 11:34:48 +0100
Message-Id: <20200630103448.22742-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Given we assert the requested address matches what we asked we should
also make that clear in the mmap flags. Otherwise we see failures in
the GitLab environment for some currently unknown but allowable
reason.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b5cb21384a1..be8facfbcc8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2294,7 +2294,7 @@ static void pgb_dynamic(const char *image_name, long align)
 static void pgb_reserved_va(const char *image_name, abi_ulong guest_loaddr,
                             abi_ulong guest_hiaddr, long align)
 {
-    const int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
+    const int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE | MAP_FIXED;
     void *addr, *test;
 
     if (guest_hiaddr > reserved_va) {
-- 
2.20.1


