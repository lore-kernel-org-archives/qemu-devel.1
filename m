Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4CCC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A69208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DORwoTJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A69208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXJo-0006OJ-FL
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4U-0002Zy-HY
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4T-0004X4-Bq
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:46 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:44907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4T-0004Wp-8I; Mon, 06 Jan 2020 13:25:45 -0500
Received: by mail-qt1-x843.google.com with SMTP id t3so43183563qtr.11;
 Mon, 06 Jan 2020 10:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MbtlCtBPgzqoGr8mUx8uII1CR9SSU0AvNsp1PJ3n1Aw=;
 b=DORwoTJXuE+VEhA22rmb5ertrcQheAF+szdeA/wGUNHxxKnamMDt8mRrrsJ6mJkiT3
 wKSx8+Cq/3PnnQRHKclMoXRz17zvGcyNRUqLba3lQvEjdeEQjjvf1ulcnsODh4TRz+Yx
 N1mYIlPx7eHSnxvSCFecSThkdRGuw/7ayXB47wtZabqFVF1BNi/VBPJO9XmaFAZ3xsbF
 Ay5OApQh/ce0NN1xHJkSDew0ldGnQluXbMJbE4S04iP7oYYUFY8l0DX7y2b3oS3tAdjC
 Lpws/XX14RY2vG++zCmrt4t9zaRYlIS/VHmIAIYzAsKpP62XCDMHjvmHKPS+g4dkoNDU
 CObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MbtlCtBPgzqoGr8mUx8uII1CR9SSU0AvNsp1PJ3n1Aw=;
 b=mxnwQ8T6xo4unOVnLOYjkzMpvRPIk3FpzPnhWONZ3JAz63TbR2l1ASLLb8SWY5eytG
 buHwZLftMH4EAVgk2c9eKL3vHLzgNZ9++llgoZ0x4OB0u3MONqgCmMYFKm5Yo3lF0a7J
 IicbYVNi89WwLHLNXYjMMM/30nl+MLnyn8gVE5CB+RbS/ZhC9gSJKpUn4nHSE/pEMMv5
 emDqItYSgH7AGt5uxipi9bGxpOPdadHCizrbWGNGDbHQvVt3W1nr65SUGLlF8iH93pa5
 7pXhqZ+p2zw6MxDZQgdar2CC2oFGDdgeuBKWqh6FxiPZDxLh6lp/Yce+gp7E8mWp92py
 Nhtw==
X-Gm-Message-State: APjAAAUfhdDkvxklY3DFgzCNWksC7IP3rUuuDSqrHNgspZi3bp4l+W3y
 KNvKXueeKHIuGzmvF7OarMteg/uq
X-Google-Smtp-Source: APXvYqxj7atGmegCHcM6OKfS6yo7/T+5qulOAvhmTYb6RVIuOMkEHi/QvaWyslbN1EGCvIi+61xJBw==
X-Received: by 2002:aed:2be4:: with SMTP id e91mr77978661qtd.148.1578335144732; 
 Mon, 06 Jan 2020 10:25:44 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:44 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 29/59] cryptodev-vhost.c: remove unneeded 'err' label in
 cryptodev_vhost_start
Date: Mon,  6 Jan 2020 15:23:55 -0300
Message-Id: <20200106182425.20312-30-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Gonglei <arei.gonglei@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'err' can be replaced by 'return r'.

CC: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 backends/cryptodev-vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 8337c9a495..907ca21fa7 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -201,7 +201,7 @@ int cryptodev_vhost_start(VirtIODevice *dev, int total_queues)
     r = k->set_guest_notifiers(qbus->parent, total_queues, true);
     if (r < 0) {
         error_report("error binding guest notifier: %d", -r);
-        goto err;
+        return r;
     }
 
     for (i = 0; i < total_queues; i++) {
@@ -236,7 +236,7 @@ err_start:
     if (e < 0) {
         error_report("vhost guest notifier cleanup failed: %d", e);
     }
-err:
+
     return r;
 }
 
-- 
2.24.1


