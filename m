Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDADC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:37:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE462414F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK/QmNWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE462414F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47441 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY40f-0002UJ-NK
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 03:37:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hY3yr-0001GU-CB
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hY3yq-0003on-Cl
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:41771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hY3yq-0003ml-7F
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:35:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id q17so12154489pfq.8
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 00:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mls9WkvxiCV9h+B5dVJf3CgBUNhcd0qcQOsSbC06TbQ=;
	b=rK/QmNWmn4e0FGHrbWzG7rRrSw+ccnnilCZesqL47xV8hz6FBF9/7pM0SQG/fBpoJi
	37BWWRz4I3M1/LgAFfDLKbkaXeg8aZDwGs0xJb6W/r5f24810+29n+a3x3/L4t61dR1O
	ChnJ+/eDuIy2kjuWfK8SIG2ekOwBfno4KQBvS7POBNC/cUR4bYyOXcBNDC0xSO/wW9nA
	K6NoXIr4U38hynsSdtR9Yio3tuR/VqzFUfsAYPNRsk+t4jJp/v4W/qxvro5G5iHGcx38
	GHtYQrr2n+dT7kKE2tDKwa0bstxQLkc6VAnuCKduExSYgWZ6K+hoJ3MYu7phQ+HJicHV
	HfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mls9WkvxiCV9h+B5dVJf3CgBUNhcd0qcQOsSbC06TbQ=;
	b=j5c21KEDXamtgUQhFur9Qi4ZUs50o9dQlg1g9Cg6YTRXq4u27uyAiOcBBRZQHcuWF4
	UWgSkk7IyA9V6EsWK0SM4V4/DUf4m+jPK0vcZPgWEc4BNlMVs9a5FoyZV3KIKS3KVc2R
	F/Qdt/Clv8v51EjpOHJ5EYyGw4zMoG8WuZfG8nhljS4ELi+31RtYZoRaHNazkSrENyqd
	W8iEYLlcPRU7X3aVyIqoD2rxxphBD4vI5Gnes+yakmYqVzz1cbsFVEZ6YWPoflXD4L66
	vJXpA+gYNTfgf0I2zn8m3Fx403eYGuDpvjO/kyQrLB69TiCgloto3WGiwDJWI14Sw9Dw
	tzEA==
X-Gm-Message-State: APjAAAVRSa89x6WE+nepmQSthAR8ZUn2VetGFpQMB03mzky0Ks7zW/Ow
	feCd2461DD83gTO+OL9mW1I=
X-Google-Smtp-Source: APXvYqw09hqw8C9PVYcNr2Qy5x3GQV9m9N6aSqHjalp+TSPeh5bmwnOttTDqsL2o37dWAKZovNgNTg==
X-Received: by 2002:a63:2706:: with SMTP id n6mr34631171pgn.238.1559633735217; 
	Tue, 04 Jun 2019 00:35:35 -0700 (PDT)
Received: from localhost ([116.247.112.152]) by smtp.gmail.com with ESMTPSA id
	v4sm21873288pff.45.2019.06.04.00.35.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 04 Jun 2019 00:35:34 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Tue,  4 Jun 2019 15:34:56 +0800
Message-Id: <20190604073459.15651-3-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604073459.15651-1-xieyongji@baidu.com>
References: <20190604073459.15651-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: [Qemu-devel] [PATCH v2 2/5] virtio: Set "start_on_kick" for legacy
 devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Xie Yongji <xieyongji@baidu.com>, dgilbert@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

Besides virtio 1.0 transitional devices, we should also
set "start_on_kick" flag for legacy devices (virtio 0.9).

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/virtio/virtio.c         | 2 --
 include/hw/virtio/virtio.h | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6508b2faad..6ec45d8f0a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2080,7 +2080,6 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
         }
 
         if (!vdev->started &&
-            virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
             !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
             vdev->start_on_kick = true;
         }
@@ -2236,7 +2235,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
 
     if (!vdev->started &&
-        virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
         !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         vdev->start_on_kick = true;
     }
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 27c0efc3d0..303242b3c2 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -106,7 +106,7 @@ struct VirtIODevice
     bool vm_running;
     bool broken; /* device in invalid state, needs reset */
     bool started;
-    bool start_on_kick; /* virtio 1.0 transitional devices support that */
+    bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
     VMChangeStateEntry *vmstate;
     char *bus_name;
     uint8_t device_endian;
-- 
2.17.1


