Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9D2C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890C9206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csaxUOVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890C9206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOFxO-0002GC-It
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 03:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOFwT-0001eb-MI
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOFwR-0006gx-3j
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601625442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GUZ3nahLtsN6ysOXUaTD5/IBM8hbjZ2M6e1FnNyYS/s=;
 b=csaxUOVskfS9eCJ9PeJYDvrbo0uBTQgRmFXGj+cq1ngBVzaPrCjJt5P2siBiAGY0kGsFCi
 Zzv0GdpvQ57ykO0Cb2qP5cg6J0aKMuT34aNMqqcWVZE/dqR/pjUOUV3UIDR/ztzfoRcFdD
 Lwlin61W9sOWHdrB5JCCijR7TfGncWA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-nFOxIYsFNAix5IGDNPr4qw-1; Fri, 02 Oct 2020 03:57:20 -0400
X-MC-Unique: nFOxIYsFNAix5IGDNPr4qw-1
Received: by mail-wr1-f72.google.com with SMTP id w7so257565wrp.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 00:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GUZ3nahLtsN6ysOXUaTD5/IBM8hbjZ2M6e1FnNyYS/s=;
 b=giVH3HK/s7nanMhHylPuQ96sc5pwYyCTtMBojH5ka/KseD2s/znBUyGj73MBvUTw+r
 fQX69STTOHTTZjQbolNbtNwwMM+smTHyw8mGs0SMh/9wZ6bNhNLUHHmWLg/0SwewSKj4
 Kcw1nfMBF+NzSUCG1Bd8QEMvoRxuyzmzHauT8BofK5exzXzD7mlr6qepKRooniN7Vd38
 DFtI0Xmr6fVN7t7PVdSda9CgIauGOjOUTG65ACyWRnwwXQB25cfbRZlN6aS3pNU6gGas
 03TLd3nVQZi23lqvVwXOE7LpNCY0Ie4Jy+S5gadb+qFMlBZ6holGNUzkSeiGfR5pr6j1
 JgJg==
X-Gm-Message-State: AOAM532vwWRoxYBVFOagFUQ8B6PdUpKZeYxiNhybHuHakJVXufkBfKHJ
 cYMrBQkfOR+8ee1JkHHj6rj2ak7EVkJVTg6LCVmGEyoN7HLd3eklWq69HNXgVM2poR1IIb4qHNX
 G+/4YhJdrsnnXfic=
X-Received: by 2002:adf:e690:: with SMTP id r16mr1484181wrm.15.1601625439428; 
 Fri, 02 Oct 2020 00:57:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkCX3qCe54u1P+ctBCOUhXnodSBAE5w3a9lLFpCTlRGMggsdzPcKIlXvdsYjWUyoKNcccwFA==
X-Received: by 2002:adf:e690:: with SMTP id r16mr1484163wrm.15.1601625439195; 
 Fri, 02 Oct 2020 00:57:19 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id g14sm802943wrv.25.2020.10.02.00.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 00:57:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/block/nvme: Simplify timestamp sum
Date: Fri,  2 Oct 2020 09:57:16 +0200
Message-Id: <20201002075716.1657849-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As the 'timestamp' variable is declared as a 48-bit bitfield,
we do not need to wrap the sum result.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/block/nvme.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 63078f6009..44fa5b9076 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1280,12 +1280,7 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
 
     union nvme_timestamp ts;
     ts.all = 0;
-
-    /*
-     * If the sum of the Timestamp value set by the host and the elapsed
-     * time exceeds 2^48, the value returned should be reduced modulo 2^48.
-     */
-    ts.timestamp = (n->host_timestamp + elapsed_time) & 0xffffffffffff;
+    ts.timestamp = n->host_timestamp + elapsed_time;
 
     /* If the host timestamp is non-zero, set the timestamp origin */
     ts.origin = n->host_timestamp ? 0x01 : 0x00;
-- 
2.26.2


