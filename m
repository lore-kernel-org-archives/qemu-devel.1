Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5091CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DEE2078B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 09:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fKiWkNg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DEE2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k69Mv-0006fI-Dt
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 05:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k69MG-00064a-RZ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 05:17:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33604
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1k69MD-000641-AI
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 05:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597310226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=4d326N45c3P38Xs95j13RnWNvEAC7IJ/H8+BaCHJzfU=;
 b=fKiWkNg5RIDUfpFCZQ2s9l5S6ueCNRhnfTouCSnhd9CxKgFWkhwjdhCra6Eqsxv/eutUce
 HBlXBRp8wQna/UoMHk3nNeLHW8b/+9Ogui6B4UbOWol9bbbBYILvBSyWm70ceqX9OYH706
 pASCPFNeg14m4qClwiXzcVdQdXr1x64=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-uuFJXjlBOAy-8T22sPh_gQ-1; Thu, 13 Aug 2020 05:17:05 -0400
X-MC-Unique: uuFJXjlBOAy-8T22sPh_gQ-1
Received: by mail-wm1-f70.google.com with SMTP id c184so2186116wme.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 02:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=4d326N45c3P38Xs95j13RnWNvEAC7IJ/H8+BaCHJzfU=;
 b=Kw8UQWuFzm9Bg/IFX5pnI1Rj4kPvoOCXoIqAOF6uJpt8YQrYI3ZvgwnimtAdFKEnRl
 0Xbpkxeuz+UqjOd4RJmj4kSC7U2XXlXDq4lmKd/WD8LdF1yHVIFMxiMLYj5O28e0OFGV
 ZftdAQAdb4EDwrWl5edFiYa5oXDwFt6FkkwBM7d3dgPwXyIo2dzDHZqqvXVUHf1v5A2P
 SD5D7LX6CqXPOnJGCtbzPIkq8aMrz9Go3aY72XqEC6Om/sD/vEeshPUd+Tn2T7Ehb6AE
 ldwTX4TecTQJfxKn8I0tMDmH7OLeb3jbgnGMqRI6EVnrdgWlZZfey/pMu2nC5wpovf5r
 rG+g==
X-Gm-Message-State: AOAM533+sT0erv0MYFsOloqq3UR/LFZzAJUNjqCjpw3G5UUI0xZOwNsd
 9Ryny8WCK6sc94ZuzuV/1pnHM+iEwdG2s4Hc06IgxHCmlSrtU2DMfiIRL6lwnoZldF+7PpSNpxl
 LUcXpNra1EgHgDeY=
X-Received: by 2002:a1c:1f8b:: with SMTP id f133mr3415981wmf.65.1597310224283; 
 Thu, 13 Aug 2020 02:17:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWFm9KdNHswYS/c1U1AE1rIVjetkBMw1snBQOoykzJoDmKBJlbXHTy+7DtFH6Z7QiRcxlp8w==
X-Received: by 2002:a1c:1f8b:: with SMTP id f133mr3415963wmf.65.1597310224058; 
 Thu, 13 Aug 2020 02:17:04 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
 by smtp.gmail.com with ESMTPSA id v16sm8515059wmj.14.2020.08.13.02.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 02:17:03 -0700 (PDT)
Date: Thu, 13 Aug 2020 11:16:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: virtio-vsock requires 'disable-legacy=on' in QEMU 5.1
Message-ID: <CAGxU2F7pVNWtJG2BM2bk9qtJ_UHgDw4kjVqRmL-=yme7VX83Vg@mail.gmail.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Qinghua Cheng <qcheng@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Qinghua discovered that virtio-vsock-pci requires 'disable-legacy=on' in
QEMU 5.1:
    $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
    qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
    device is modern-only, use disable-legacy=on

Bisecting I found that this behaviour starts from this commit:
9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")

IIUC virtio-vsock is modern-only, so I tried this patch and it works:

diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
index f4cf95873d..6e4cc874cd 100644
--- a/hw/virtio/vhost-user-vsock-pci.c
+++ b/hw/virtio/vhost-user-vsock-pci.c
@@ -40,6 +40,7 @@ static void vhost_user_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VHostUserVSockPCI *dev = VHOST_USER_VSOCK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);

+    virtio_pci_force_virtio_1(vpci_dev);
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }

diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
index a815278e69..f641b974e9 100644
--- a/hw/virtio/vhost-vsock-pci.c
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -44,6 +44,7 @@ static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VHostVSockPCI *dev = VHOST_VSOCK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);

+    virtio_pci_force_virtio_1(vpci_dev);
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }


Do you think this is the right approach or is there a better way to
solve this issue?

Thanks,
Stefano


