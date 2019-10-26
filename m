Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80964CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA10214DA
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA10214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUjq-000509-Fw
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOTzm-0008RB-94
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOTzl-0003h2-6j
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOTzk-0003gq-V1
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:53:13 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D68783295
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 21:53:11 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id s3so6351921qkd.6
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Xs7aefSNbLgfG/5UYZ9oajory7qsQOFIkuB64YN2neI=;
 b=GnTbd90vRpnfLm4D6suBAcXC5T4YZ/BHjRiuQ9c2LK4W4pX6O0SP+pq/iS2aGfH4z5
 ImzJH5uA690qCSpVfJqJDhpNYIh6RHtjCQ7jADCmewuC1nNinU8s4vJyCQtL+AyC3/yG
 hYW+1RuTkKdLzcRDl+pfAyzHeAHZsI+VJ9RGYHUB+91N11wpJkios5hIfsmNJPl3Rn5b
 K1nXfbU78GnZwdsApQ3EEZLlFJaFxfThDDQS/2YMYxAW7A3hSGFhCEOS5EJrBR69l3q6
 AONWcPAEuD/Y6dUN4CGDK4Wr7bmSDDpxWb7YuglbwTbh5Ic2htZytCp7OGfVEFzWaqAo
 0maw==
X-Gm-Message-State: APjAAAXUVrC/s13UskGhCKLuqG3m8KB4g30GPj2hOqihditghU4du533
 uXNepXJoZaz5m79jUn28bDajgpyB6Hg/yGvLO/ycEtcveRPfL8mnxypNfHuhlqbw3lPX51n2+Sz
 yI1+grRgmPzIX06E=
X-Received: by 2002:ac8:33fb:: with SMTP id d56mr10713436qtb.377.1572126790403; 
 Sat, 26 Oct 2019 14:53:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwFEm2L0eXtzk7O7Dtbmla/q2HIyVIaDLL2/xMKgVRQaTIBcUftoGUFbgRZ8zfKg7DIP8f4eA==
X-Received: by 2002:ac8:33fb:: with SMTP id d56mr10713428qtb.377.1572126790238; 
 Sat, 26 Oct 2019 14:53:10 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 a18sm3962480qkc.2.2019.10.26.14.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 14:53:09 -0700 (PDT)
Date: Sat, 26 Oct 2019 17:53:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/25] libqos: make the virtio-pci BAR index configurable
Message-ID: <20191026193824.11926-23-mst@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The Legacy virtio-pci interface always uses BAR 0.  VIRTIO 1.0 may need
to use a different BAR index, so make it configurable.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191023100425.12168-15-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/libqos/virtio-pci.c | 3 ++-
 tests/libqos/virtio-pci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/libqos/virtio-pci.c b/tests/libqos/virtio-pci.c
index c900742f96..e9595603f5 100644
--- a/tests/libqos/virtio-pci.c
+++ b/tests/libqos/virtio-pci.c
@@ -310,7 +310,7 @@ static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops_l=
egacy =3D {
 void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
 {
     qpci_device_enable(d->pdev);
-    d->bar =3D qpci_iomap(d->pdev, 0, NULL);
+    d->bar =3D qpci_iomap(d->pdev, d->bar_idx, NULL);
 }
=20
 void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
@@ -400,6 +400,7 @@ static void qvirtio_pci_init_from_pcidev(QVirtioPCIDe=
vice *dev, QPCIDevice *pci_
 {
     dev->pdev =3D pci_dev;
     dev->vdev.device_type =3D qpci_config_readw(pci_dev, PCI_SUBSYSTEM_I=
D);
+    dev->bar_idx =3D 0;
=20
     dev->config_msix_entry =3D -1;
     dev->msix_ops =3D &qvirtio_pci_msix_ops_legacy;
diff --git a/tests/libqos/virtio-pci.h b/tests/libqos/virtio-pci.h
index 0e4a8b7b00..78a1c15c2a 100644
--- a/tests/libqos/virtio-pci.h
+++ b/tests/libqos/virtio-pci.h
@@ -25,6 +25,8 @@ typedef struct QVirtioPCIDevice {
     uint16_t config_msix_entry;
     uint64_t config_msix_addr;
     uint32_t config_msix_data;
+
+    int bar_idx;
 } QVirtioPCIDevice;
=20
 struct QVirtioPCIMSIXOps {
--=20
MST


