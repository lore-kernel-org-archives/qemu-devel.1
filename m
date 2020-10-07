Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC016C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3110B206FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="WePvgcq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3110B206FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCbM-00060R-5s
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kQC5s-0000sL-VE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:15:09 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kQC5r-0004Kj-39
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:15:08 -0400
Received: by mail-pj1-x1043.google.com with SMTP id h4so1289043pjk.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=DG2nrlvatmFFRKoNdt2NAWFpJu3wf9C7KKq+Fb3UDB8=;
 b=WePvgcq9GSF1PTApteE+tsDsYI2C2g6shs548u6ADIgnULczIIrqA9wZdeQ9jF+zSf
 m6JG0tWN6XcxH62nRRT+AzlCi8FEGqxRnbXlmVOGGo6MfrUXe2b2aYC3UWMC0CPi/NaW
 GR2if4iKJpUV1dKrDgwzBhhQz89r7yJRWsSy471PZpvhCvX6nJ3F7yyg+1FJzeMlcpPu
 ADPnybigpEyYrsm+ab7peK6Q50rg8aCxuaisL/79CPfngVvJqyl108KWmHZXj37Cqnkt
 FyAjjCaaJcwUeLoJNjyV2asLyEHTJXuSbrV0N2mDkWLCM5d3XdoHX0g0GoT1XMfHiXxE
 PBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=DG2nrlvatmFFRKoNdt2NAWFpJu3wf9C7KKq+Fb3UDB8=;
 b=ttX5+LzBYEmZJ+dgytiNghRXdEaOWfnQq6RX58hk6Hm1TNzlAxKiNRhhWiDMg+HTju
 oB3XVN2Mx6A8j9vax0+YAU77MKW0dtjEwlKyQsjNPYNcX3N9hCCHjg0GwoPad4srud3h
 h82gK545tqqkhcRgjtmj0qxih2NtcspnbtL7VRw7VM6ia8DAPg7Hgb6GmO+dLR919vm0
 DqVnpQvAFEUmKuBSY+BshZ8ttpYVUOO6nXzq9cWa2jpwvFzHm8xig3H93F9yGmZ+QNXI
 PxR3aJgVveW5UBRdF+ulTs73yRRjEeN2x+UCOeaIEGwEbcEF/rnQOCwFK4x9eyUqcmPF
 vV6w==
X-Gm-Message-State: AOAM530u5FIDGIpYgM7NXQ6hgdCT+imqmKP0EtiQuVQ6KUpLtiOYO67S
 r+ARikGnZxJOqQjXiRh4iX/uWHCkTy8coSes
X-Google-Smtp-Source: ABdhPJzlcUkAtuzRv2rSeCaIPTgW7qDIoS6yNodQ0I7fR9U43N4fzJ/sagtS18G3sVZ/49E1651ZwQ==
X-Received: by 2002:a17:90a:8e82:: with SMTP id
 f2mr3476492pjo.142.1602087304049; 
 Wed, 07 Oct 2020 09:15:04 -0700 (PDT)
Received: from localhost.localdomain ([115.96.123.22])
 by smtp.googlemail.com with ESMTPSA id g126sm3783452pfb.32.2020.10.07.09.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:15:02 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH] Adding ani's email as an individual contributor
Date: Wed,  7 Oct 2020 21:44:46 +0530
Message-Id: <20201007161446.1327-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::1043;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1043.google.com
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
 capstone                            | 2 +-
 contrib/gitdm/group-map-individuals | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/capstone b/capstone
index f8b1b83301..22ead3e0bf 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit f8b1b833015a4ae47110ed068e0deb7106ced66d
+Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
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


