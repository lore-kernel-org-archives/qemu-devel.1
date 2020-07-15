Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4418CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF422064C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 08:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4ngZiYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF422064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvd2v-00044g-9m
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 04:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jvd0z-0001Yb-H9
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:43:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jvd0y-0007CS-31
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 04:43:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id z13so1532261wrw.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NplJ9FT1/r2A6AefFQ9G3CWLH2M21HnURd3t7WXauD4=;
 b=Q4ngZiYdXof9OM7rnQ4OnJsKW1AIBp6Y35BpZKQ8xfNsDPekAZQF5zH5FPfb7ow2qC
 Qs9AIuJIY+zdJI2rbjQU2s1MLSUDIkr3g3vNU4gIDWI+p8ssToVVfr6Xvr1qFG0K9/cG
 tu2BUsFEJTl7oCW4cHhfCT62HTLaqoJ90W/2Le7GB0dxQtK89p4G/lwC1SBbG03IFJ1c
 2w1sMeKxwf0XMp6mX2XfdiRVlg2dl1nf086FcTf4g3iPl739clyCLmmJsxCRiVoXNfim
 2N9E6KGR0tOPgRRzX1VYdVq+H4835ntO8jz0+TXkrEGeqSFpCdrYuN9LymiN1RKKrCLj
 qc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NplJ9FT1/r2A6AefFQ9G3CWLH2M21HnURd3t7WXauD4=;
 b=Qem2k4uoXoQCrnlVaFlNg/ahrdu1FZ+3sRb+3sn41TtAwn0axHjBwUY/EespP1ZydV
 Qxy3CRE4rQOqNLGXeZ/KEmQPuzeJ8eJIf/8jTnFHmBWKphD47ebx8AYj9QyOkHJQsV6D
 XUUwlX6/tLzhSUGKnMt59Reo+cnvmsNRxkEFqs9GJKSbLjYeXBu4dWV2fyXzFEyRDC2E
 HCF+yMEWv2XnrJy1Thr8a804u1NxYXyJ8xY6l8Hx1bqs6VPAH2hr3J6faIH33J2c87vv
 efiz9SFz1x6abw2VkLL9/DuKH1s0sqmLxyN35a/I9VyfV8arZXEMlYSUuYzXzvzrojki
 7/GA==
X-Gm-Message-State: AOAM531rXQdgs6s9j2r8ifAwFnoFz4rkAYIMcDvPnxjM5c7WYOyhFRoK
 nb6sRqUt0dCnCgkW2zQ9LaIXazP/10g=
X-Google-Smtp-Source: ABdhPJyKVtiBP+NSWQZkLItRDl1GKBd+uxq2Su1JrCnxudpaZpSv5/tS1xjOjSZcFsATfkhduAajPA==
X-Received: by 2002:a5d:634e:: with SMTP id b14mr10608385wrw.423.1594802622337; 
 Wed, 15 Jul 2020 01:43:42 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-64.inter.net.il. [84.229.155.64])
 by smtp.gmail.com with ESMTPSA id
 g195sm2369386wme.38.2020.07.15.01.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 01:43:41 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/2] hw: hyperv: vmbus: Fix 32bit compilation
Date: Wed, 15 Jul 2020 11:43:26 +0300
Message-Id: <20200715084326.678715-3-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715084326.678715-1-arilou@gmail.com>
References: <20200715084326.678715-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=arilou@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: mail@maciej.szmigiero.name, Jon Doron <arilou@gmail.com>,
 rvkagan@yandex-team.ru, imammedo@redhat.com, pbonzini@redhat.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/hyperv/vmbus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 34392e892a..c28bb4201b 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -383,7 +383,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
             }
         }
 
-        p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_page);
+        p = (void *)(uintptr_t)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
+                off_in_page);
         if (iter->dir == DMA_DIRECTION_FROM_DEVICE) {
             memcpy(p, buf, cplen);
         } else {
-- 
2.24.1


