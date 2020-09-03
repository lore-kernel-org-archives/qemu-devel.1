Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256EDC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D058B206EF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUB4EqqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D058B206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx5s-0002tH-29
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLz-0004zS-5E; Thu, 03 Sep 2020 17:01:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLx-0007rD-I7; Thu, 03 Sep 2020 17:01:06 -0400
Received: by mail-ot1-x343.google.com with SMTP id u25so4011160otq.6;
 Thu, 03 Sep 2020 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+zLfmnBFP/TeeGYdGSH1pa11E0h2MWm5y03tUduxidk=;
 b=PUB4EqqTypNgzUzN5URL9J7mB3WKH4hJB4uWdqshHaGw64dfMHaQLBgtXek2SyIYqj
 yqKFNbrft9aKaQMfGP6AkqsI/LQO0sKW9fLE46J4B1pnURzSE05QOwJPDKmhe0zkBU0k
 v3TQmqq1kPA9aXjtj55bZI3ASj+OSD2ELUMZPimO2G/sqTBobztQEB+B0H/70jaRRW6N
 UNEBtD5tHqmeHCu88cvxo8B4LA3igdbemY03mGwbw7TBEcj9diG7Z0/piqofa/qNefvT
 Z/J2exSQRhlbBKWdBk2XTU8oFJ/fdTDyWjrrf0oo/x8wrPd3CM3VS4PyFoa/96n+8vq/
 VjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=+zLfmnBFP/TeeGYdGSH1pa11E0h2MWm5y03tUduxidk=;
 b=e/k77FUX+WdxMMZoNxDDC/+vME8clmvIdV2IA6Fya0j7vcOZnh0nFG/NWZysUWXAX1
 KwA6QGce90hTOgPOojVykKZux3Qt+OKLs/HJ9cWrjaN1nkJQP1cWakbWsFLvnVVorFkt
 3mssm1VcLulnFqkjlQsgucNkYnfSoroDd3X/mzY9mZFZq+UX86QsHJxsOpmt6sOyi7MG
 M7MgBvEy597Nmg4Zt3ki3D+LtWw+S6m7xQ6W9Sae+N1CvgLQUeUbMp5Bwk6Sd0jHFf2R
 Ch3qh8FXMPy6zFCaPLhjuYMxqaHG4Blh5MGQrw/pfSUq2dwRQOGuiMpUvtg88ZbLbhXm
 WT4A==
X-Gm-Message-State: AOAM530RPmNlmZ0cxTD4uspbQ/FAnd6p2+l92c8l/4Z1knzNUmqajJC4
 uyEAD2zfg3wlSe8YdsK50Q1SK0RM2xcFRA==
X-Google-Smtp-Source: ABdhPJxXZT59Cwq7J9KCk365RRx4jaW/UHgqMF12aBI000tGNpMuIQL44oqULfMHyRfPEkLJqcMmew==
X-Received: by 2002:a05:6830:4bb:: with SMTP id
 l27mr2956902otd.372.1599166863841; 
 Thu, 03 Sep 2020 14:01:03 -0700 (PDT)
Received: from localhost ([2600:1700:70:e488:ed8a:a712:8057:9526])
 by smtp.gmail.com with ESMTPSA id g26sm775698otn.77.2020.09.03.14.01.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:03 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 61/77] virtio-balloon: Add locking to prevent possible race
 when starting hinting
Date: Thu,  3 Sep 2020 15:59:19 -0500
Message-Id: <20200903205935.27832-62-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
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
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

There is already locking in place when we are stopping free page hinting
but there is not similar protections in place when we start. I can only
assume this was overlooked as in most cases the page hinting should not be
occurring when we are starting the hinting, however there is still a chance
we could be processing hints by the time we get back around to restarting
the hinting so we are better off making sure to protect the state with the
mutex lock rather than just updating the value with no protections.

Based on feedback from Peter Maydell this issue had also been spotted by
Coverity: CID 1430269

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-Id: <20200720175122.21935.78013.stgit@localhost.localdomain>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 1a83e0b9c492a0eaeacd6fbb858fc81d04ab9c3e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a30a0c7bfa..d6e31de1d9 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -532,6 +532,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
+    qemu_mutex_lock(&s->free_page_lock);
+
     if (s->free_page_report_cmd_id == UINT_MAX) {
         s->free_page_report_cmd_id =
                        VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
@@ -540,6 +542,8 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
     }
 
     s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
+    qemu_mutex_unlock(&s->free_page_lock);
+
     virtio_notify_config(vdev);
 }
 
-- 
2.17.1


