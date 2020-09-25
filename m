Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA940C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A2D221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO2Y590j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A2D221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLl2e-0001bB-A9
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLksY-0000At-HM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:23:02 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:45527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kLksW-00084J-Ux
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:23:02 -0400
Received: by mail-ed1-x542.google.com with SMTP id l17so1911526edq.12
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BNH32WpIB3BHjwbBfQ9O8Ky7gKSFN5qvos5tTlr8vDM=;
 b=SO2Y590jYV22Nvt3P2DnGE4A6zzhsfNy9sz63Jlv5fkECOv1EJ8wQzA2MlXtgUAgj1
 86ltt91Vmj4+7gemlV1zMlccEXvCeJuoaXjvsud+41Wmgscb0Bo3V+/dDQ0mZXSiSRe8
 ++YyH/kVoiuLu+Mt8aA2HwGZc69GY/YD2WOFBVjAIH4XI4BQ+lbqqadb+TC0x9ZgxAIX
 MBw2yhVO6fy5UoTeRgA+E15ZCNZkcLn2xAg7GwFkJebmq3qSxhvwU7kLBGRn78iBjbsw
 N/wh32ibMU4Z1nZMf3QMU+VKzoeNZ+Kc+w2mFDwGzx7nZSjxwbeUVmazEHKd4P2thL+0
 c8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BNH32WpIB3BHjwbBfQ9O8Ky7gKSFN5qvos5tTlr8vDM=;
 b=FSGz9XPzVfXXZVrDwJWzwY064N4FpQrGbEHX3TrIpVyVsNRmFV2URcWa2MtJACirNo
 SCltk+ClR9xGRg5n+Cm7UYH4cRhktWCZY9SD50GMjmkQfsB1YrVVwm4MkF7CabTRyZMR
 ZHBUKm2cR0dn4IguZ1i55OrOCJG7BQZIdDdzp4kSmkxnBCVIVDHf8T4rwAM2GkCeg5Oa
 aKJEZPSZBl9SXrJal97zSEyUVy+RZgy3Qq/0eMrRVA19qfP/R5el7oG/30k1Ncc44cFm
 dNxk8YW4s68snVyY26A+MNMmAvhImkk97I0gnbS2dTRBd/B0H+TMNTLcqLU1YJacm5e/
 SdQQ==
X-Gm-Message-State: AOAM5307GqvXRM6v/pwrXPQw/3qGR4fRgsxcKSMjJrIndGAI8Z9JfnY/
 bhZaZgPG4kvWTed62FCDTy4=
X-Google-Smtp-Source: ABdhPJxHt0V7c0r8jMqnyyGslXvvVUzgy3mNS9C6u850MIUFooQHfo3ikyvAG13h4tyv0o9/EH2h7g==
X-Received: by 2002:a50:f28b:: with SMTP id f11mr516866edm.44.1601029379438;
 Fri, 25 Sep 2020 03:22:59 -0700 (PDT)
Received: from lb01399.pb.local ([2001:1438:4010:2558:5c17:67ff:fe35:747b])
 by smtp.gmail.com with ESMTPSA id s30sm1504223edc.8.2020.09.25.03.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 03:22:58 -0700 (PDT)
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To: mst@redhat.com,
	david@redhat.com
Subject: [PATCH] virtio-pmem-pci: force virtio version 1
Date: Fri, 25 Sep 2020 12:22:51 +0200
Message-Id: <20200925102251.7216-1-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-ed1-x542.google.com
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Qemu fails with below error when trying to run with virtio pmem:

 (qemu) qemu-system-x86_64: -device virtio-pmem-pci,memdev=mem1,id=nv1:
  device is modern-only, use disable-legacy=on
 
 This patch fixes this by forcing virtio 1 with virtio-pmem.

fixes: adf0748a49 ("virtio-pci: Proxy for virtio-pmem")
Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
 hw/virtio/virtio-pmem-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
index 21a457d151..2b2a0b1eae 100644
--- a/hw/virtio/virtio-pmem-pci.c
+++ b/hw/virtio/virtio-pmem-pci.c
@@ -22,6 +22,7 @@ static void virtio_pmem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOPMEMPCI *pmem_pci = VIRTIO_PMEM_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&pmem_pci->vdev);
 
+    virtio_pci_force_virtio_1(vpci_dev);
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
-- 
2.20.1


