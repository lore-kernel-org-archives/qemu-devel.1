Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3200C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6329B206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHVARZzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6329B206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx0o-0002yc-GI
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwM6-00051r-Hn; Thu, 03 Sep 2020 17:01:15 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:34068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwM4-0007st-V3; Thu, 03 Sep 2020 17:01:14 -0400
Received: by mail-ot1-x332.google.com with SMTP id h17so3210601otr.1;
 Thu, 03 Sep 2020 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MEvZmvR0w7xE2ynIxcSs7eM6zvrUrLkOXOPrCdnExrc=;
 b=EHVARZzruu/KPlIDrWXmbEK8SzjPDoBPrP213Sw4vVEv/ETNSwQ3+J09utdOCOdXLy
 v8hQl1dqYprtIYFzi2DDV1ELfl+KRdt181DF8t6VoFK+eACIxgfXlRDFFXw02MCqesWH
 1axD5HMUfUjK6Sw/1m02UG2WoQay81nK/+mjDhbMKjT0fkB9yHOCYmkj1ALpfpTZRjFG
 ZNFai0xXGHza5azi9zy/n56NmM13u8RUPCugiroW3ZOK0Xb/h5ykXVHuflWNAqsIYdbr
 MBQftpqJXW6BrMMurehpUkEHRStJxGYE0uFbEfH7ULbjA9iA44MNYt35kfXNyCQZGLm3
 nhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=MEvZmvR0w7xE2ynIxcSs7eM6zvrUrLkOXOPrCdnExrc=;
 b=fx/o2ktpeCQqcH3JVsSDkim63q3en/X5Z48LUM9A13TdPRiJ/nC+iW6yhMYsepEl3X
 /9U9gdTOFSaK1lJYLx3g/Y+c9oeHcl0aHDh7J8kDaKhPjIq8eY5fLGCuMkhXOR3Jrp/x
 jAtMEx7zSZ8kDPPhQj+miSb8ntAkxrRlR20ywh+RHTEU6IQueyO/2B50pdvlqXyC7DDf
 Pc62neJOwx9a8OE10Vfuevwf3C+Ld0zVVADcDkG573WNzgp5xVQvo/sJVXALJf9XVhPN
 20ri9bxFQD8qQSmGWV5wiJ5tuOwlm4YNogYH+2vDuEXtB2xCxXneGtx37ILNrHDwyjpB
 9aYQ==
X-Gm-Message-State: AOAM530eYwd/E1o4KFu6fAxChtozO4XWI7hxKMxjJw1bruduudnhYPKI
 g5VbmnEn1Zd8112x6SFX4BIhim3mw2H7zQ==
X-Google-Smtp-Source: ABdhPJyJyLCTANyduaYarkhhRlhGRzO9m/cVeMwLioY1o2bStwQnmnE/dWD7V12NTVv+J6PlTctxgw==
X-Received: by 2002:a9d:621a:: with SMTP id g26mr3233188otj.209.1599166870579; 
 Thu, 03 Sep 2020 14:01:10 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 3sm767533otu.46.2020.09.03.14.01.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:10 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 66/77] virtio: verify that legacy support is not accidentally
 on
Date: Thu,  3 Sep 2020 15:59:24 -0500
Message-Id: <20200903205935.27832-67-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x332.google.com
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cornelia Huck <cohuck@redhat.com>

If a virtio device does not have legacy support, make sure that
it is actually off, and bail out if not.

For virtio-pci, this means that any device without legacy support
that has been specified to modern-only (or that has been forced
to it) will work.

For virtio-ccw, this duplicates the check that is currently done
prior to realization for any device that explicitly specified no
support for legacy.

This catches devices that have not been fenced properly.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200707105446.677966-3-cohuck@redhat.com>
Cc: qemu-stable@nongnu.org
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 9b3a35ec8236933ab958a4c3ad883163f1ca66e7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/s390x/virtio-ccw.c  | 6 ++++++
 hw/virtio/virtio-pci.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 64f928fc7d..c069719429 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1119,6 +1119,12 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
         dev->max_rev = 0;
     }
 
+    if (!virtio_ccw_rev_max(dev) && !virtio_legacy_allowed(vdev)) {
+        error_setg(errp, "Invalid value of property max_rev "
+                   "(is %d expected >= 1)", virtio_ccw_rev_max(dev));
+        return;
+    }
+
     if (virtio_get_num_queues(vdev) > VIRTIO_QUEUE_MAX) {
         error_setg(errp, "The number of virtqueues %d "
                    "exceeds virtio limit %d", n,
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4cb784389c..2ca266e1cb 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1565,6 +1565,10 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
     }
 
     if (legacy) {
+        if (!virtio_legacy_allowed(vdev)) {
+            error_setg(errp, "device is modern-only, use disable-legacy=on");
+            return;
+        }
         if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
             error_setg(errp, "VIRTIO_F_IOMMU_PLATFORM was supported by"
                        " neither legacy nor transitional device");
-- 
2.17.1


