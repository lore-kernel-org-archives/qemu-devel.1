Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B043C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B0820724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMir91bZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B0820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9DA9-0003sZ-Vx
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:57:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7S-00071n-Ab
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24932
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7Q-0002he-Hy
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598039671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/x+WG0TFgHIJ/8pW+jPELPjejq1PPY2g5C0FRtawW8=;
 b=RMir91bZ1PKl3GzHNk6FzrpE7Fiw9T0yRBsPt4oBAFpjhGGwwBTLOY/GEYvNBPuLjJic/T
 c+prloTuq7qkOgX2N9dW2HjsbSd4kT8TiHyZisWmuwAqoJzPehYR1sMBKzl2ikn97cktEj
 x9PnMS+ud/2se2ZACnyMfr4s7hy5rOQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-hQpC7rsQN1y0EkmAAeGzHg-1; Fri, 21 Aug 2020 15:54:29 -0400
X-MC-Unique: hQpC7rsQN1y0EkmAAeGzHg-1
Received: by mail-wm1-f69.google.com with SMTP id v8so1369611wma.6
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E/x+WG0TFgHIJ/8pW+jPELPjejq1PPY2g5C0FRtawW8=;
 b=snznbagTd9szEuhJHEHUTDwucylSb8ApAyVQL9QAcE3ZY2NuM0js/vPe5s27CdiucV
 lYe7ZRobm7KoeWnMyQaSc4o8pCNOdh3YNMAYCaoHhikApww1FxrpxGuTZUk/bRfATTfz
 U2IUfUQjHrtuP0J4hdTySCW9tJRylJ4Al77a1Ay8LMUkl4klWyl8BwXqcsCQoK/G0Ycb
 4mLy2loUJu++qofQ1HceevLWLBAmbeIbLZDMeRjTz5S0wU5if/6OVF455RwFgw10aOlq
 HObs2h9fAmbh1JRibF0c1zMdBru5hg5Zj6nBIGuVvty+duM7Kmpd6EcvSYOyF6sBkKRK
 q61w==
X-Gm-Message-State: AOAM533gEtWmrgo8ApNk8W4PpEa68YceR2qFcAr+TNv0WAF3HLE2k/H8
 WeXiCRDydvvEA6bc9vtuWkF8GH2wQe79fEWIBOdiKkcxNqLEUFxDp6vY/7BX0iWCVzBSnU/H9pU
 zWA8CNEfw9DEDD80=
X-Received: by 2002:adf:ee51:: with SMTP id w17mr4216373wro.239.1598039668600; 
 Fri, 21 Aug 2020 12:54:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgzb1gelRXox5cdld7Hsuf6Xx5+55NqkKhJ3cBrKqbZbDHZ56IU/4fjARcnOf6gbNDPPah9A==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr4216356wro.239.1598039668458; 
 Fri, 21 Aug 2020 12:54:28 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y142sm7577171wmd.3.2020.08.21.12.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 12:54:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/15] block/nvme: Improve error message when IO queue
 creation failed
Date: Fri, 21 Aug 2020 21:53:49 +0200
Message-Id: <20200821195359.1285345-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821195359.1285345-1-philmd@redhat.com>
References: <20200821195359.1285345-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not use the same error message for different failures.
Display a different error whether it is the CQ or the SQ.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index b4c1a6690e4..c63629d3b45 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -648,7 +648,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x3),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create io queue [%d]", n);
+        error_setg(errp, "Failed to create CQ io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
     }
@@ -659,7 +659,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x1 | (n << 16)),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create io queue [%d]", n);
+        error_setg(errp, "Failed to create SQ io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
     }
-- 
2.26.2


