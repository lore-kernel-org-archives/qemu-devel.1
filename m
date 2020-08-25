Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4CBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC1E2068E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjTorMIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC1E2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUjv-0000GL-EV
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUQp-0008I0-8t
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:35:51 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:44890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAUQn-00012l-JZ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:35:50 -0400
Received: by mail-pg1-x536.google.com with SMTP id m34so6312824pgl.11
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 01:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OhF7DmqPnZElocDCHxwQ+SG0m4lR629MaEFLfhtxWUY=;
 b=jjTorMIylr5hvt3mAXy7m+XO00ETHIL0fggSqWJtI/gKe0lSybaGUkuJjaid15z8bV
 YSI8XVcr9PedRk9OXvbocWWSb6M1i/XBInvjezvJu8VatTQlHe4KcHMH6yiur/LF9eaT
 WvTENnW5VqkafiaOBvwstUNol0ohI9e5xMiq94bA0iKvl16t2uyhMQgQqCdFHZs5yMlE
 y2Z1SYCzZr0QG81+thOqkN7e+s4ylyWku8z46UN01sHhzS7WFAziNjUZMeeaizUKuKJv
 Rd1amAeWgFYjSd1/EaG/bWfN2ve6BBXKMpRHa1AZUEbsDayl3Q19b80MzYfmxll15wnp
 MJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OhF7DmqPnZElocDCHxwQ+SG0m4lR629MaEFLfhtxWUY=;
 b=IhwXd3mstUpY3PG8nFHd39QexaJueGc+9zAEqCV/hNi5ANrU9GHUKyyyytWqIO7l20
 UbG9Ct8KYY21RlsBMnTvKg4zq3XzKnxjFWW0FOOSY46l9EK9+RufYg/HBbnlOXkLQg4H
 vx/mfZSkNKNyX1BtIaYXpdenbMt40J1Ysl8g7E5VcVj/9/2dTNVx72oPR95GikMl+uCq
 n2kTYfO5+WsnIhBoJ1Gnb8RnajRQZt4dLWIlIuVR73EC2rplVPfbbmC8bupInovn3UTS
 YKWrkjA/OTDF6zAb1EEfxoR4+I+DB1qz1hXVfs1t616tm3PVirFlb+vpjE+qx5h7ZaYP
 EbYg==
X-Gm-Message-State: AOAM5310JfnQVBYTnm84W7Skwx2K/4SWR4YXOhG8leqBAZ1Fkx0lZlXa
 Zpyo56kZJNkx+O1/5BEm9UK42muxof72UADl
X-Google-Smtp-Source: ABdhPJwC6h1Q2mXUxxwA4Ehc6zViZA79CnpE4rLpyEqHHlWQgkhs0tPElA+Yh+s/vh+kHL4jnY1jxg==
X-Received: by 2002:a17:902:bd45:: with SMTP id
 b5mr6780810plx.22.1598344547699; 
 Tue, 25 Aug 2020 01:35:47 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id bn14sm1146683pjb.0.2020.08.25.01.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 01:35:47 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] meson: !/bin/sh are msys2 friendly.
Date: Tue, 25 Aug 2020 16:34:59 +0800
Message-Id: <20200825083500.359-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200825083500.359-1-luoyonggang@gmail.com>
References: <20200825083500.359-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x536.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

---
 scripts/undefsym.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/undefsym.sh b/scripts/undefsym.sh
index b9ec332e95..8189308b2c 100755
--- a/scripts/undefsym.sh
+++ b/scripts/undefsym.sh
@@ -1,4 +1,4 @@
-#! /usr/bin/env bash
+#!/bin/sh
 
 # Before a shared module's DSO is produced, a static library is built for it
 # and passed to this script.  The script generates -Wl,-u options to force
-- 
2.27.0.windows.1


