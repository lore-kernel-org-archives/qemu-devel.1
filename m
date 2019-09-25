Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8DEC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062642146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062642146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD8N6-00032j-4L
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 10:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iD8JI-0000pB-Dk
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iD8JH-00079j-Ca
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64205)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iD8JH-00079E-7D
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 10:30:27 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 642E63CA16
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 14:30:26 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id s14so6096517qtn.4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 07:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uAGWvwzL46HoQu7U/Lqqmx3jnRSuW2YUf+t36wOCjwQ=;
 b=tq2qUgLxaxFY7c1IGaqiUFfCa/iPmCsVLVR0RCleayEV++GmOG0sRngnYKlE7q1WWj
 oBe9picgKX8S1AjJ7aVrXviilBROCqHQUJkCMB8ZTKsP3hTaktESl86s7U3Y8Oo67lpx
 hvMYyPLQajpY/xhaxHdLCERtUgXKZ2xB4al76YT8GdckV28VohlahfxcC0EPbvWXMt10
 y5YHBXS0oiUUwhAtfzg23lFEQ45QBancJCHTOEUlQOJZ3ZgFD3+QnWyt+2MKV09dux1K
 /Xw00JdDTfqc77O7rPiOQVzPQDp0xhqaAaPgHGKM/VzRtO3utMSieCT5ce06i3aokBgd
 s2uQ==
X-Gm-Message-State: APjAAAWO4CL6F+QtYMkHGSHOAwcz2lAUAEPZHU2i2ytoG9B/5BFA1nUc
 4eSHWqjekZI0iwT8E5wrBFYpWGFvDhscp78OIozQghXzuTI5QYoSRjJDsj99cMnXAe8zKzj1865
 NY9WgXzmEFV8VIIk=
X-Received: by 2002:ae9:eb93:: with SMTP id b141mr3937255qkg.36.1569421825129; 
 Wed, 25 Sep 2019 07:30:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4U9gYng4oRZOTCoyWYgFdpd1/h0Zv3jm2GT3fYZ4puUPe5fRfi+jPDnWP7ZsXZJ4qsyA1wA==
X-Received: by 2002:ae9:eb93:: with SMTP id b141mr3937230qkg.36.1569421824907; 
 Wed, 25 Sep 2019 07:30:24 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id c185sm3082503qkg.74.2019.09.25.07.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 07:30:24 -0700 (PDT)
Date: Wed, 25 Sep 2019 10:30:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] vhost: Fix memory region section comparison
Message-ID: <20190814175535.2023-4-dgilbert@redhat.com>
References: <20190925142910.26529-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190925142910.26529-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190925143020.B9J6AcO-Qejkfhp4cS9ej138GeEC4B4NAzupWCgLtC0@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Using memcmp to compare structures wasn't safe,
as I found out on ARM when I was getting falce miscompares.

Use the helper function for comparing the MRSs.

Fixes: ade6d081fc33948e56e6 ("vhost: Regenerate region list from changed sections list")
Cc: qemu-stable@nongnu.org
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190814175535.2023-4-dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 34accdf615..2386b511f3 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -451,8 +451,13 @@ static void vhost_commit(MemoryListener *listener)
         changed = true;
     } else {
         /* Same size, lets check the contents */
-        changed = n_old_sections && memcmp(dev->mem_sections, old_sections,
-                         n_old_sections * sizeof(old_sections[0])) != 0;
+        for (int i = 0; i < n_old_sections; i++) {
+            if (!MemoryRegionSection_eq(&old_sections[i],
+                                        &dev->mem_sections[i])) {
+                changed = true;
+                break;
+            }
+        }
     }
 
     trace_vhost_commit(dev->started, changed);
-- 
MST


