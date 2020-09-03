Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B607BC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73817206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUBuaUQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73817206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwqN-0006go-Il
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLC-0003tt-7f; Thu, 03 Sep 2020 17:00:18 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLA-0007X5-JY; Thu, 03 Sep 2020 17:00:17 -0400
Received: by mail-oi1-x242.google.com with SMTP id w16so4535978oia.2;
 Thu, 03 Sep 2020 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LtPU/nN6c9RiqgRTDpf9K4Svqu3AQC8vbJJ7asRl6KM=;
 b=eUBuaUQ4ES92C0W8OsgW0STGVdEb5kXK6SXRNGJywTCk6hM2RcJh6ei1VO52wh49ou
 YmKKnL+AWFhzFy2AeY5VOZxSsM/GF6l/YeBRm8DL4tYcYg/YwdNgZhgTOcsxTDYLh5QG
 7R0/WJu7xGNUH3a6e6GiszTPL6uFE/66EzGjqeA/as4FDtUCxGFCvlrnTs5pusXOV24V
 1YUnl0NXNP7FNH+18WLcBtBphK7gNw13y84PH7N4YdVOdcB0VVwGKPX9thewZaxLPgoz
 5CaN2W7LVgHk/IL4EbTsGb5kc4z9fxVWj/2GaMytL7BakqHxl0Ra9NnD/s7C5Se3169I
 7t2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=LtPU/nN6c9RiqgRTDpf9K4Svqu3AQC8vbJJ7asRl6KM=;
 b=rGgBHSHE0GWBNwZCXwnW2HkzmOO0YuDKRElN/uMTilsQMkz7Xq2P0J4o3Br3yINLnL
 JPaEpjU/rG/pJHXgcypisgOW2MvNRnloCacY4HG5JmDkz+6nw6wpNK1cNMyE8hdEVOjn
 yvWqPFtRgXIborVnA9MuOAYdovxVW/JAuRWQsgeSv/KwMvJdGlHz1UjvUVDWf1pvizCp
 KPbeRC+a6ISSruG8/rZFbUCEWAMrizOTZu+d+vdg6xJUY6AgXAimi0QpWZ1OUVSJE1uu
 C4yHmJVqqYHmadYvYE2r8KYNgxk+x193yL88jyu9V9tCU6F9f1eTjAb2pn5/bp+w5HWe
 Nwxg==
X-Gm-Message-State: AOAM530ARn9aGgw3XusZj/49L1PBSFtrtVv58qJ3a30kAYAwqXULs4XZ
 lXNEDykVZRgk/clee59OD70R740kAtw=
X-Google-Smtp-Source: ABdhPJwtlCZWf9x5sxWZHDVmVDI0++NbnrC3/5hquFSzgWe/SKJ+n3PQLM3wd/5pg06xeqAW466f6g==
X-Received: by 2002:aca:f103:: with SMTP id p3mr3367677oih.45.1599166814856;
 Thu, 03 Sep 2020 14:00:14 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id o204sm719770oib.34.2020.09.03.14.00.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:14 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/77] libqos: usb-hcd-ehci: use 32-bit write for config
 register
Date: Thu,  3 Sep 2020 15:58:45 -0500
Message-Id: <20200903205935.27832-28-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

The memory region ops have min_access_size == 4 so obey it.

Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 89ed83d8b23c11d250c290593cad3ca839d5b053)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qtest/usb-hcd-ehci-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/usb-hcd-ehci-test.c b/tests/qtest/usb-hcd-ehci-test.c
index 5251d539e9..c51e8bb223 100644
--- a/tests/qtest/usb-hcd-ehci-test.c
+++ b/tests/qtest/usb-hcd-ehci-test.c
@@ -96,7 +96,7 @@ static void pci_ehci_port_1(void)
 static void pci_ehci_config(void)
 {
     /* hands over all ports from companion uhci to ehci */
-    qpci_io_writew(ehci1.dev, ehci1.bar, 0x60, 1);
+    qpci_io_writel(ehci1.dev, ehci1.bar, 0x60, 1);
 }
 
 static void pci_uhci_port_2(void)
-- 
2.17.1


