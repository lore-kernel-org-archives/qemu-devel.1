Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A5BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29AB2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxzSwRy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29AB2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj8vs-0007Xe-0i
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uF-0005Vh-ME; Wed, 10 Jun 2020 18:09:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36267)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uF-0008H7-0k; Wed, 10 Jun 2020 18:09:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id d128so3249818wmc.1;
 Wed, 10 Jun 2020 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4yC7yHQKz+xaxyB4JgWKHlHlwJW75Aq9W20uuS1StJw=;
 b=sxzSwRy/vLjGYFyX1N6MxytB/T7Rbql2Xjyw5lEDD83Ndrtw2OLnSI5/9mf1Gwg1d4
 8tuaxSJ3iixo5vlh//vfASvZtAxDm8kNz0T9Z3FM4lzr4VgGFynCzsBcC3BR2POYI/AJ
 LaGqTo62pO5DrWdQ+yra3WsDm1YufCiNCYlNVR2LKfmCYJN+qIGlNNfnee2QsRFhyZT/
 bW+i/jrvpjJ837HykgYSmAXhiLhHenRRWIxsT6h+ifHVJz+Et+45rDEekPU/I/3rDRWu
 otW4AgsJK5TlSKf9/KaZ0cjs77UBVy12GSL/4qz8n5zEtfjew/E0ciAaTDkLcUDiIk0H
 61/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4yC7yHQKz+xaxyB4JgWKHlHlwJW75Aq9W20uuS1StJw=;
 b=FPGbMNctAOphP+SobHIzD5Dn7pmO4svqgKWYGIVPfTImRRyRP5d9/2Ens8tUh7E+KY
 MbY4glHYMTlMwBYHF0Zp77m6c4K6eb12BwNpj1lF2bcGHbzlgW8wQA7te4060DFnp/8W
 CkriISZHMyU7RGOlcwgx+gPfmsyIPOMkWrROCAF8/gTkiF2Z9PzSapysxmAS6Hl4GUzD
 Mr4xpvbBkhZyoVVuNKTm3qC+amQ5PWjLACe31YwT90V5HXtxiZEnEeNcnFkW8a2VQ23p
 AhDzuF7/oTNT5kFldMWAJ8PmmxjiUw5RjCFNJmcVe+2ofkUYHJnDPIa+hMMRtr7w+aNr
 ZalQ==
X-Gm-Message-State: AOAM532n5jtPnPBXY0Lnjqj0JwQKZbG+4daNBu5k0PwRxdjC8HkK82zk
 9W9InqUFgKSaPQgwV2qG3VwzMxGm
X-Google-Smtp-Source: ABdhPJwtdYXH6IBDiojgcTAJjWnJlJAj79YIyr4gVX4hk0IInjqyfK2+StTAtFpZGO5gXcCPnoPBag==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr4950550wml.24.1591826937384; 
 Wed, 10 Jun 2020 15:08:57 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 40sm1819354wrc.15.2020.06.10.15.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 15:08:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/11] MAINTAINERS: Mark SH4 section orphan
Date: Thu, 11 Jun 2020 00:08:43 +0200
Message-Id: <20200610220853.8558-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610220853.8558-1-f4bug@amsat.org>
References: <20200610220853.8558-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aurelien Jarno expressed his desire to orphan the SH4 section [*]:

  I don't mind being [...] removed from there.
  I do not really have time to work on that.

Mark the SH4 section orphan.

Many thanks to Aurelien for his substantial contributions to QEMU,
and for maintaining the SH4 emulation for various years!

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.html

Message-Id: <20200601214125.GA1924990@aurel32.net>
Acked-by: Aurelien Jarno <aurelien@aurel32.net>
Suggested-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3abe3faa4e..129517cfb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -296,8 +296,7 @@ F: tests/tcg/s390x/
 L: qemu-s390x@nongnu.org
 
 SH4 TCG CPUs
-M: Aurelien Jarno <aurelien@aurel32.net>
-S: Odd Fixes
+S: Orphan
 F: target/sh4/
 F: hw/sh4/
 F: disas/sh4.c
-- 
2.21.3


