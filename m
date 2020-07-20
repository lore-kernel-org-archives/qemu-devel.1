Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E891CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9E820709
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URoUCuQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9E820709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxZxY-0000S0-0B
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 13:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jxZwd-0007hb-QN
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:51:19 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jxZwc-0007hx-7N
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:51:19 -0400
Received: by mail-pl1-x644.google.com with SMTP id t6so9007056plo.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=8xPqwSKZbL19VmcpEGdAEfQGyxRaLAdfuPGoNzIkPJw=;
 b=URoUCuQBXxHz36riS6Vr3Osyk/spb7yq9gyMDvRCl4embd3rcjUqJFtHjPveQvXRSa
 Z1GCJPf7AxNiY+j5ZrXz7mH6gXPlqzK+nbRL6AUsd+GmrlbrxRK9YbqN8DWXzGAmkBs6
 6ys9GcCFjsWkMOzG/S3pjq7XVMWvM0lYkHgXA/imFwaKY5g+iJzSQuxfRvp/u0KWMfB5
 RYgZ6mH3MUIQIuLsMJStKMUMnF2yi/UYC7RyMIahE5l2SNIvruEwAhMWX3E8Gz+N6NjB
 hOx6a+DGNoLcwe3/yQZT73eMY7Z5ghfkSggRkJprQXVmU63MuvbaTNxlY2EdKRF5qin9
 5Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=8xPqwSKZbL19VmcpEGdAEfQGyxRaLAdfuPGoNzIkPJw=;
 b=Qy5CkZaTDewWzRRVXMn8humgYbUFNgqH0icwRtGvIh2+sBYESI6ggyxZtAQ1PSEA6n
 EdtOKc2wFl6Co/NWuW7RnKv2neXO7GIjryW5fwZ+u4VVUlheYcehEgZJgamQO6MZLxwR
 T5rex94ji6G9e9RAYwOnPNrXS6BcHXFROIxja+DsuERoLJX52jctvdEZ5owGd/3Ovqx/
 42I8v6pBoPbiTN8qrCnjJNm8t6mhw0PuavWe6aKqf/Z6DZaWJQ8nDQsqKA6pbyIOm7g3
 thyaNBrZBqXCEnMCIjnmwpBlYphypsa1kk+THmtyprjYhPuKJhKXduwiy986K6AV0OAD
 /pRg==
X-Gm-Message-State: AOAM531AMjMOqFAXN4o4tY+0FTYFMiwF90Tjxnqm2bfAGjdgl0/O2h9R
 FXsJ/dshG5DHYLzhPjwiQD0=
X-Google-Smtp-Source: ABdhPJw3QB1td88FSdMZtdbMS0qeAFM5qMvmKDoERxIx9vZ4hzdQ0h/Pxqsk880tA49Ys1MjUBdtWg==
X-Received: by 2002:a17:90a:ce90:: with SMTP id
 g16mr551128pju.109.1595267476904; 
 Mon, 20 Jul 2020 10:51:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id cv3sm198351pjb.45.2020.07.20.10.51.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Jul 2020 10:51:16 -0700 (PDT)
Subject: [PATCH v3 QEMU 1/3] virtio-balloon: Prevent guest from starting a
 report when we didn't request one
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Mon, 20 Jul 2020 10:51:15 -0700
Message-ID: <20200720175115.21935.99563.stgit@localhost.localdomain>
In-Reply-To: <20200720175030.21935.80052.stgit@localhost.localdomain>
References: <20200720175030.21935.80052.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pl1-x644.google.com
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Based on code review it appears possible for the driver to force the device
out of a stopped state when hinting by repeating the last ID it was
provided.

Prevent this by only allowing a transition to the start state when we are
in the requested state. This way the driver is only allowed to send one
descriptor that will transition the device into the start state. All others
will leave it in the stop state once it has finished.

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e670f1e59534..ce70adcc6925 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -526,7 +526,8 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
             ret = false;
             goto out;
         }
-        if (id == dev->free_page_report_cmd_id) {
+        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED &&
+            id == dev->free_page_report_cmd_id) {
             dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
         } else {
             /*


