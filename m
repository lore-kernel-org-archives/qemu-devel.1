Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D00C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5337520707
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSjZm+k9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5337520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idELR-0006DL-17
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npes87184@gmail.com>) id 1idEIw-000432-0j
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npes87184@gmail.com>) id 1idEIt-0002cs-TX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:09:57 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:34539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npes87184@gmail.com>) id 1idEIt-0002aj-NK
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:09:55 -0500
Received: by mail-pl1-x630.google.com with SMTP id h13so2792185plr.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=RvnU/SQxUNMf5RtxCNw8BUby2qEi7s0g4GKkxCbZrLk=;
 b=LSjZm+k9lN9LAzjbaRvbRgGk9unSiMz2r4FKNumZpULVv1NJkukyt5wrOy9knFZ1FD
 9dsUnhT+hO5Fe8zXKpL4XGGxP64umCl3Jzk5CC3DJ6fo35NrfbJcPkyH0R1AILVT9Ikr
 2dxSryHAbYBwVOzzYp49jZU0Oz8df1QvSu5MI1hhCDprwVfTLHv5dp+gkxyeJMuoJlrB
 bFxJd5UEn2YXBFzZxU2zD0KY7eoI1UUPFcNpUdJXhpcPCxi0IwBEmxhWLSFr2tAKeqYS
 QLB+4GLxn1MnSgaYMx+ZP9z6eW3FWIvCuKGriXyP8yFsY44tVe8V7M8Igs7uMJEog+Y+
 8ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=RvnU/SQxUNMf5RtxCNw8BUby2qEi7s0g4GKkxCbZrLk=;
 b=fwBJ7zqAYMKMrCeVMIoVlgMuBkSFTfDmpV+QVyNZgaRNLZAp6x9ikn5KWauJAKslpi
 Gn+Shcwy9DmUKgTddRYL+5bw7iYcrQzqlpgpUhn+gARYb2YK8WIjU/WgLYv7Oj0q+dEY
 115gK+e3fX9fQ6QPPG7iGh+aSmHgS7tpkM1sJ36FMTmFaU4VFWYwMNVMS5pzGgFaGpQz
 szYlxDFpdHhXZSEmfKYTx+Fg+nnoGrmKQ4BaHxjjhr/RgZ9Hec1jfWBJIbWh0d+vAJOo
 3QURRMKq0ZuHPUJ3cuUsQlnEZUTFzmIHW3M7cwf6k7cA4+VSQEJ/HPpV2dhvq3ehfFXl
 AvuQ==
X-Gm-Message-State: APjAAAXJJcor8/CQtCTEuUkUObP/Tr2BMp7n2MS1irljTDSaHp3u/oYO
 RSvlgguqzAzQUtN2oCA96yLX1tcBuZ4=
X-Google-Smtp-Source: APXvYqyC1maSwT6WPzslQr0HdARVS+3r868c4dYfOpLw11gaZjjLLxwVN8kr0s7rg0dAr9oTRfuQ2w==
X-Received: by 2002:a17:90b:252:: with SMTP id
 fz18mr15931727pjb.49.1575641393357; 
 Fri, 06 Dec 2019 06:09:53 -0800 (PST)
Received: from localhost.localdomain (223-137-37-118.emome-ip.hinet.net.
 [223.137.37.118])
 by smtp.googlemail.com with ESMTPSA id f5sm5509072pjp.1.2019.12.06.06.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2019 06:09:52 -0800 (PST)
From: Yu-Chen Lin <npes87184@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] mailmap: Add entry about me
Date: Fri,  6 Dec 2019 22:09:31 +0800
Message-Id: <20191206140931.14133-1-npes87184@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::630
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
Cc: Yu-Chen Lin <npes87184@gmail.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have two mail address, add entries for
showing author and email correctly.

Signed-off-by: Yu-Chen Lin <npes87184@gmail.com>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 3816e4effe..3fbf3902a3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -151,7 +151,8 @@ Xiaoqiang Zhao <zxq_yx_007@163.com>
 Xinhua Cao <caoxinhua@huawei.com>
 Xiong Zhang <xiong.y.zhang@intel.com>
 Yin Yin <yin.yin@cs2c.com.cn>
-yuchenlin <npes87184@gmail.com>
+Yu-Chen Lin <npes87184@gmail.com>
+Yu-Chen Lin <npes87184@gmail.com> <yuchenlin@synology.com>
 YunQiang Su <syq@debian.org>
 YunQiang Su <ysu@wavecomp.com>
 Yuri Pudgorodskiy <yur@virtuozzo.com>
-- 
2.17.1


