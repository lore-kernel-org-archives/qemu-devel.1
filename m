Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEBAC4727E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6FF206FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSIgPwNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6FF206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCQd-0000UW-79
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsK-0005LF-6u
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQBsD-000153-FV
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:01:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id n15so2828148wrq.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tTtW7k3tPipBMfrWwlmuuVSybBoqSoxalQNPY/ip42Y=;
 b=dSIgPwNnl8ayZyHF9j2Bv2ajyBpo0iZ278alH+/QFpp1SJeDAXVr4D0IOpWnu2jjrD
 pWUsUqu4NT8yQ2oIa/x1lwLRylixReB2tv6cr7IyR/qUsZiLDteYMrBsQv1ejZjSwCKg
 4rcjbDKdynsZWYw8sK7+T2Cn+NtApoul1r3np15ShmT8sRydsLe5x6pK0Rt4YQlWBkLg
 oKY5GDjwxOliatRT8A7MsL9RI5Fg/X9leXJVFE51NeMqpX/Ax+MeqFIhOM1R9POkTF4f
 sHAnTiC8Zu6n3/Ydr0zkJe9MRSj2Ty0zOe86N7zujShYHBA5iQJkC1t15ZJxnxCI1psV
 U+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tTtW7k3tPipBMfrWwlmuuVSybBoqSoxalQNPY/ip42Y=;
 b=AgeUcdsGDNQF5PwYrB1lf2vcMNW3wZzRggGaAKCYtk4ZYUBW/pJq+Jf9UvyVsdQ36u
 DsTBqVBCF9RaLPyYaXIvm8z8iH5VDN2nbUMAkdldCHJxdvXWVNJiCR9JLY0aEscbKtQW
 ayupN7jlTirE9qyLJi3AieVqZEJhWaxJbbKr4VJl7JG+rHGCMDyI12B2Gg6L7Zf4sFvw
 azuN7nu1I0d7WFurjsdZMOuHZBu67fLupEy+/WRa3G7M57s09zH/YKJIZydlQi+tr85w
 Z8nRSt+pDfOleG3uelgJIdMIXe/DvBjllIKK/DoxEUIbVUtfFlwBeAI/2TACnX+hihpE
 yFtg==
X-Gm-Message-State: AOAM530+IiF3oRpW3eUJsUgB0N+K55jPB5U7f6e/1fpXNN8eXyyn6HHv
 w8sP1rBtFqih49njZj1omD+Bag==
X-Google-Smtp-Source: ABdhPJzPFcDoJWMDFWW2kVTdC7BCm/ExSiZKxzWAel4eCZ8sP6voN9NTPP2X7WLNfd1udDW/sGRa4Q==
X-Received: by 2002:adf:818b:: with SMTP id 11mr4244695wra.74.1602086458452;
 Wed, 07 Oct 2020 09:00:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w7sm3155348wmc.43.2020.10.07.09.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:00:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 11E2C1FF99;
 Wed,  7 Oct 2020 17:00:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 10/22] contrib/gitdm: Add ByteDance to the domain map
Date: Wed,  7 Oct 2020 17:00:26 +0100
Message-Id: <20201007160038.26953-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007160038.26953-1-alex.bennee@linaro.org>
References: <20201007160038.26953-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
Cc: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Message-Id: <20201006160653.2391972-5-f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index a4102154b6..ae5d149434 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -6,6 +6,7 @@
 
 amd.com         AMD
 baidu.com       Baidu
+bytedance.com   ByteDance
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 greensocs.com   GreenSocs
-- 
2.20.1


