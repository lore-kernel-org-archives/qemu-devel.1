Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A54C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180392100A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3tR8Jvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180392100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBXi-00088G-17
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBT5-0000nU-6F
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:10:07 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:42325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBT2-0003L5-SM
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:10:06 -0400
Received: by mail-pl1-x62b.google.com with SMTP id y6so2582319plt.9
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q6ED8Pqb2lsI90yHCr1MVM7nMQWDcI+eL8vWSv3hJzM=;
 b=a3tR8JvftmE8mDb6McQSn2QNTEfeIbXJ+yUT+EiPcPbPxekPwnI6sFoa1owBGbSvR5
 +XoN6mO2yMWa7Rzqodg5wQIkWZhBs8jI7SVt00ERmRwjrFxHLvwq5aZ2CW7Id93As+L3
 dgdFwDP6/j5uJ0PGpMb0HMyZRSpIz4SieMIyOUOAC6bE1BGxvvJou66vBOrYvr3qPu55
 4+FtUf1mAYQXCLf9dX6xNFONrDzaj6woaDKpv0vxqx2Zni4r0E6XGVaq5GYTS9p+WmFM
 S7Tad3GA9pGXiNWA7fFeI+pkvEnLk1mO6OTevop73LH8jThD3zPs0E/74OAgO8MuZkqY
 Vpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q6ED8Pqb2lsI90yHCr1MVM7nMQWDcI+eL8vWSv3hJzM=;
 b=oBXXZQAIyifD2dqsIJyGtYtvF18qjbv1VBfaOOIwbMD3a3ZlKDlS4JCG/RD8sPPJPc
 6YrfgWOkNzS0cPjKdvDp7xqgnhqkL4soBm5B7RvIY2447sRA4wtKuWduBKp6lpYlI/hX
 DUFo6zzgXp/XmEnITN6qUlHmnlMcYTqYfN5EYu53pMl/NUydGCOeos5eC1vMc2ICE4xo
 1hnaxE4wyzwn5f83dTEvyIOYyBTRXqvdP51+6MkYi7KqvA7Rz8LItRK/AlI5FzWs48KC
 xTAOtY01TpcQ9fP1i2k3br3mynpKEilxkVfAklUH/P0M0VbHVn2zLlwrE1JUYLw8W6Af
 sjMQ==
X-Gm-Message-State: AOAM531WTr8XQ5RzW4jqIE+fgbs7Rg77r83P/B3o6oZP1kpQ/QnL2QcJ
 /FC7E8MluyB5yFQA4bOSJvbj0nvi7LpbLWCR
X-Google-Smtp-Source: ABdhPJxwnc9bDzar6qBpepl1c8vboO854CUnJ84S65cJwbTvzMRATyBng1Qyv8JqgkuDSD4lNjWcOg==
X-Received: by 2002:a17:90a:67cb:: with SMTP id
 g11mr11981858pjm.56.1600416603310; 
 Fri, 18 Sep 2020 01:10:03 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id f4sm2045455pfj.147.2020.09.18.01.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:10:03 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 7/7] MAINTAINERS: Add vhost-user block device backend
 server maintainer
Date: Fri, 18 Sep 2020 16:09:12 +0800
Message-Id: <20200918080912.321299-8-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918080912.321299-1-coiby.xu@gmail.com>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x62b.google.com
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, stefanha@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d17cad19a..55ad6abe73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3039,6 +3039,14 @@ L: qemu-block@nongnu.org
 S: Supported
 F: tests/image-fuzzer/
 
+Vhost-user block device backend server
+M: Coiby Xu <Coiby.Xu@gmail.com>
+S: Maintained
+F: block/export/vhost-user-blk-server.c
+F: util/vhost-user-server.c
+F: tests/qtest/vhost-user-blk-test.c
+F: tests/qtest/libqos/vhost-user-blk.c
+
 Replication
 M: Wen Congyang <wencongyang2@huawei.com>
 M: Xie Changlong <xiechanglong.d@gmail.com>
-- 
2.28.0


