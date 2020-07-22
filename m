Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22075C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC1F20771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ic/Kpffp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC1F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDbR-00017M-50
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDZ8-0006El-H7
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26712
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDZ6-0006cD-3I
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zJUEiAuh/w0ZZykpZGg+27nY/rwRTIsctuEMd8wdLQg=;
 b=ic/Kpffp8cchdWG9ZtHyK7Xo9FjaGZFuuIY19MCIsAqWZMnY3ay5gkE5S4aPng+UVagnXC
 VDKrwNYvN81T29YgKxzQ7VdoIja4q3ckuHRrBrhchR0PdEScDDli/LHIyfDio4+z2WwFAX
 U9kOI/GHcKrqPRaAMZzm1h9TVmkezZ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-eHtGRuo_MWmZvR0KB1OS7Q-1; Wed, 22 Jul 2020 08:09:35 -0400
X-MC-Unique: eHtGRuo_MWmZvR0KB1OS7Q-1
Received: by mail-wr1-f70.google.com with SMTP id a18so548328wrm.14
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zJUEiAuh/w0ZZykpZGg+27nY/rwRTIsctuEMd8wdLQg=;
 b=nFz/+zbAvvDex3VLOj129+MDCUXAI1ipjETiB7+nL5YYzOyyYSKooaV9Hz8A37vfrn
 OhKYWwxBuSjCxXHvEofKTM1FCvbhtiaq+1k1Isqlm2W+mlkQZDij42xvwVMDPrlph6GG
 NIjkzMqbSr9DLn4HceO/wh/wBRNKyEVu31Tvku7gnyPlZ6Rlb1f/jVsRSbMpQ9xw+0Ku
 S/TQCVSXUK86UIn5+Ir5R0e7M6ntaSVGsVawfLXvKymE79zBM0Chh9KUUUfu0pL1NDxZ
 5yuSDfUXeb7s9KljqTkTjnnrFvSZh+PtQFjpMDtDFdPDOtPpb1i2BaDTKFBxa6wk4dOF
 jauw==
X-Gm-Message-State: AOAM532VGFA+jRAaYFp9mP+DpjKpuIAcdVWxHNPYA14Xe1aNnLzuOhIP
 t46hat50nT/7kXIuXIWuCnJ321mO+LG4zSsfcYeBk1SKPcD/R11t0DwoDEi1e0cTF+AZvnQD6ai
 me93n/BBOAqyTFpM=
X-Received: by 2002:adf:de07:: with SMTP id b7mr33042586wrm.302.1595419773970; 
 Wed, 22 Jul 2020 05:09:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwChp1o5boBbHmbfF2ipGhhGhnTkDBfTg1D8qRCAGKUDHbPGSqs+g7m/OgYBJfGe1IiAQSiBQ==
X-Received: by 2002:adf:de07:: with SMTP id b7mr33042570wrm.302.1595419773809; 
 Wed, 22 Jul 2020 05:09:33 -0700 (PDT)
Received: from redhat.com (bzq-79-182-82-99.red.bezeqint.net. [79.182.82.99])
 by smtp.gmail.com with ESMTPSA id
 o9sm41165104wrs.1.2020.07.22.05.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:09:33 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:09:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] virtio: verify that legacy support is not accidentally on
Message-ID: <20200722120853.9144-8-mst@redhat.com>
References: <20200722120853.9144-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200722120853.9144-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-stable@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
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
---
 hw/s390x/virtio-ccw.c  | 6 ++++++
 hw/virtio/virtio-pci.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 3c988a000b..0e60270297 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1121,6 +1121,12 @@ static void virtio_ccw_device_plugged(DeviceState *d, Error **errp)
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
index 8554cf2a03..db8b711b35 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1581,6 +1581,10 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
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
MST


