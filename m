Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08424CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FA5206DD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 19:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FA5206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iORvv-0002f1-5H
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 15:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iORuD-0000IW-H9
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iORuC-00007m-Ht
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iORuA-00007G-Ik
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 15:39:18 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 800924E4E6
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 19:39:16 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id y10so6351331qti.1
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 12:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=YCXv9pgk58V4PShzTuonhz/UO31YcgkrsArln+nUUE0=;
 b=gKeXKml0oY97yovaP+acnWvgSJDOGuv9fIMnm8wPpyTZ/dfmDqvFAt3HL1Ey6w8l9b
 hskv156CEhIL3o5elYE7CCJX261OQXVAWRixKHUgO73S83wPqrS3LJasNJaS5+gKuDNe
 1LHuh8gST+2Uu6ZXI7DN92ZFwafsGQoVYqqt6EjvGu8MO9D+Uaa6/UIzCJWuIJ0v7keT
 Tslbkk0ly6RerYeWfWrpqCp907dOH7ASyOMnH47+QXNuOre9oBjxd2rSbs32Cqq/+US4
 AcFY7NiJRl2Olr1WJd1JaHQAtzp21pbLzOStLr4W4fO4W39qYzCpHym2UtDrTy2TXjEg
 s/WA==
X-Gm-Message-State: APjAAAWiLoxNeLj1YZS4WyelLnnfci56Wfhyj/JQywyvnIVYiHeUTsrw
 PjjxlOVsdx1zSFuQK1/BU+pr0j43U3oZouNkxNs7FdJbx5rNcdUHfgTKJ75I+PJdprhkAPAClrd
 pCb0bamjg6OeHkS8=
X-Received: by 2002:ac8:2a83:: with SMTP id b3mr10116306qta.244.1572118755518; 
 Sat, 26 Oct 2019 12:39:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyjtDcojhYaxrdJh0jL789L5SunEhJ5xt5uB6qkIutetoy31Wk1jDYwb0PiRBj5QJS8VXak+Q==
X-Received: by 2002:ac8:2a83:: with SMTP id b3mr10116289qta.244.1572118755373; 
 Sat, 26 Oct 2019 12:39:15 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 n17sm1560141qke.53.2019.10.26.12.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 12:39:14 -0700 (PDT)
Date: Sat, 26 Oct 2019 15:39:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/25] virtio: basic structure for packed ring
Message-ID: <20191026193824.11926-2-mst@redhat.com>
References: <20191026193824.11926-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191026193824.11926-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>, Wei Xu <wexu@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Xu <wexu@redhat.com>

Define packed ring structure according to Qemu nomenclature,
field data(wrap counter, etc) are also included.

Signed-off-by: Wei Xu <wexu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com>
Message-Id: <20191025083527.30803-2-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 527df03bfd..fdac203cdf 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -43,6 +43,13 @@ typedef struct VRingDesc
     uint16_t next;
 } VRingDesc;
=20
+typedef struct VRingPackedDesc {
+    uint64_t addr;
+    uint32_t len;
+    uint16_t id;
+    uint16_t flags;
+} VRingPackedDesc;
+
 typedef struct VRingAvail
 {
     uint16_t flags;
@@ -81,17 +88,25 @@ typedef struct VRing
     VRingMemoryRegionCaches *caches;
 } VRing;
=20
+typedef struct VRingPackedDescEvent {
+    uint16_t off_wrap;
+    uint16_t flags;
+} VRingPackedDescEvent ;
+
 struct VirtQueue
 {
     VRing vring;
=20
     /* Next head to pop */
     uint16_t last_avail_idx;
+    bool last_avail_wrap_counter;
=20
     /* Last avail_idx read from VQ. */
     uint16_t shadow_avail_idx;
+    bool shadow_avail_wrap_counter;
=20
     uint16_t used_idx;
+    bool used_wrap_counter;
=20
     /* Last used index value we have signalled on */
     uint16_t signalled_used;
--=20
MST


