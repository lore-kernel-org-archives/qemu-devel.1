Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AB2C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B422064E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hz92oKRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B422064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCIU-0007JR-Tg
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsH-0005Jt-Bs
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:54268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsB-00012A-8t
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id f21so2891269wml.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BXk3pdm0RIJP32HqA97pO0L/BInNp34tjONAnTfExLs=;
 b=Hz92oKRH8pQGK704bAySEqR9JfeT2/XExFug6EiUz9KM3ywuPHxjAJZmh74yM30Gt+
 UCimVgtym7qdP9vDkaoidhu18DN8iJYsiNqwBI9pjevFVj7O0K/0t2+E1C7AqL4AmSSl
 IHL+atRYrJpPWYavDBFo2IrmPlFCoMFiu4EO3T1yRixmOfwnh2MoToBgv9INnTPisAfr
 KLrzbNDXo4oaxXQNt7oSw9mKgUENG2FXqf3SnKteXFEpdRz8dMO7TuyOrMfa6zrbts4+
 CZDuxVRxhUvDMZ0scao8JHZJc5gfD3BbLZU4pZqYK4ucP/N1ZGbRfNU5OpuZyzHAPNu2
 UI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BXk3pdm0RIJP32HqA97pO0L/BInNp34tjONAnTfExLs=;
 b=jrJQRvrI7/y1ayVvR3gmrSk4TokOagLp2ERP+wFUdcNWY3JOQsER624HdbVWLEoMKS
 JSK/YTX4C044J6oUbt08ve8KS5t6z2NMQIyk4tfkiAvjhFAZgCHNrDBpHx60QK/Cjq9j
 XZoJJUFcdSN7KmkyILOVW14vJV55ya1hkIkba5uexXNc3X+CHR0/kzgaLWmbmpwYq0TS
 jNS42qIO/lc/pysOcJbr/tg7IPkfnRI6v4PtoWo3nGLlwAf4uqakaKikbdOMMb1CL3Dq
 f6DxLPGeymKY5w1Zcp1sWNVxioYYYVwv88Buz/nNIuy4XuaH7cjwfeyH93o0IWxLPKwR
 mZiQ==
X-Gm-Message-State: AOAM531RtmJXBsBmm2vIJijogL0okMciQ2fgUPyPGNuvxOgitC4cRqby
 JHXTnqEe47ZtDDzeQXwgpVX0Vw==
X-Google-Smtp-Source: ABdhPJxw3JTOnL1+CvkcCJenhnV4lOKT4D036IOswEbSpNYXHNKefnfPc+0pVx0ukS0H/uK7ZjzyYg==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr3992069wmb.60.1602086454630; 
 Wed, 07 Oct 2020 09:00:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z1sm3291508wmk.45.2020.10.07.09.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F19171FF98;
 Wed,  7 Oct 2020 17:00:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 09/22] contrib/gitdm: Add Baidu to the domain map
Date: Wed,  7 Oct 2020 17:00:25 +0100
Message-Id: <20201007160038.26953-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Chai Wen <chaiwen@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Chai Wen <chaiwen@baidu.com>
Message-Id: <20201006160653.2391972-4-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index dd79147c76..a4102154b6 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -5,6 +5,7 @@
 #
 
 amd.com         AMD
+baidu.com       Baidu
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 greensocs.com   GreenSocs
-- 
2.20.1


