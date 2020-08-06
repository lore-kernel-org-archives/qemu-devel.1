Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E448C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D356422D0B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBIqgLBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D356422D0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3axv-0003xi-32
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3awz-0002GZ-8M; Thu, 06 Aug 2020 04:08:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3awx-0005g1-NO; Thu, 06 Aug 2020 04:08:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id 88so43044772wrh.3;
 Thu, 06 Aug 2020 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4+aXm2ggWfq1Fly1rmq/Lj+bQKm9iyQ1C1siDyh5+3o=;
 b=vBIqgLBL2GNNUoliO1+45+XjA00P0+68zsF6XGyQV6irjsbG0+pF3A8i+4AJpF8911
 hqYyNeTbUjnauH/vE+HyFZnMyWEdyCOiFEnEsn5SmG7fmG65uCsg4yEHAVyHrjjunwNC
 k5m/XbXEonFRdztED73Y2XmR5Tdy9RRBPEscDwN410wqfjkh37igJPEl7ZOXmG6Uh69D
 /hRMhZGMx3b7v2TzhsguyD2fci82sqETGIZTCjERzsxNSoxz/tW14M1vuE6hdcrgr+nG
 WDiOtafb0hOHp6r9T7jj4ALHUHUE0A8MjRdKiqOWrC/Jh1fgYoyxkOiOai+j+ddPA+hU
 Qhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4+aXm2ggWfq1Fly1rmq/Lj+bQKm9iyQ1C1siDyh5+3o=;
 b=uc2XUo7Ttiq1iqAAAGSRUVETQ0aEUW15Y79sw4T+qj1D/1HAtmi6waj3DCkFtqRaIK
 atVmZOjyxoFXV83VRv6+8DC3gujFvTe/L6b2zMSRUNsAfhtOwT9EOZzEPlooJCiWwM2W
 E94byvTkFSUWvTe28bB5j13Oo8TfTeGM9gB3UxFmgVQk+ivJ28/BhQO/gzpPXdOOJVYg
 6sfUlDolfPgsqziCS+cGhB84IKGywYzfqgS9bDiJU88ZG/pO1tPMIV0CHd9wmlooAW4V
 4CJSHU8xwKSeyZDi9yH0L1D3zT15qG6GU9H9y/oZL5x4WkaeWaP+UhdxQFVVCr/NYCe5
 rs+A==
X-Gm-Message-State: AOAM531RG76uHpmuZYEjj7tnk/OsrgpVnaxYb3CUcUI9HboQOhtPltLE
 dZp63kMxW0Cqhzbz4hjLElg6bzEh
X-Google-Smtp-Source: ABdhPJzupK0w6Pw7Yv3JZ9t//wVtZZTftWvR1hHu7uKTk88NmVL83zwitQ5FW2WzZkaPUh2Vk174og==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr6340324wrv.104.1596701309639; 
 Thu, 06 Aug 2020 01:08:29 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w2sm6039587wre.5.2020.08.06.01.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 01:08:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 2/7] hw/block/fdc: Let sector offset be unsigned
Date: Thu,  6 Aug 2020 10:08:19 +0200
Message-Id: <20200806080824.21567-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806080824.21567-1-f4bug@amsat.org>
References: <20200806080824.21567-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sector offset can not be negative, make it unsigned.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/block/fdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2cec7568c1..c91ed7ee2d 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -259,7 +259,7 @@ static uint32_t fd_sector(FDrive *drv)
 }
 
 /* Returns current position, in bytes, for given drive */
-static int fd_offset(FDrive *drv)
+static uint64_t fd_offset(FDrive *drv)
 {
     g_assert(fd_sector(drv) < INT_MAX >> BDRV_SECTOR_BITS);
     return fd_sector(drv) << BDRV_SECTOR_BITS;
-- 
2.21.3


