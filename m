Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD928C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C2120848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C2120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53942 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFYP-0003a0-Ry
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:32:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFMh-00013h-9z
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFMe-0002Hm-9J
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFMe-0002Hd-6L
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:20:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id t1so3510042qtc.12
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=EBhBqzmf7dvCSZtcFzIQFoj7mET0nH0WKBXoVmSjL3Q=;
	b=jDLsQKUuiKwPXsQNX5rkMgpbq7VBwlzZ30+Tz4wl53A8n7lOH9SrDfQt0HvpRsgFez
	2W7O0Mzxc1jJrHx8Tv+VGCSWls8uE4iPLy+qPFXPsn33UkmYYtQ/26VSmqaDFzguuKFV
	IvkD/9AM3EcwC/HZG7F0UB5ZKsL10ZK1NjShpKr1MrDwrWaaw5fn2fY86bkJrVLEQzm7
	hW0GwY38ok19aVise4CypheCltDi0gqhOJKHfA45daR/jf91dyndy8Ceqi/pZHU5hxm1
	gQPFPGeEmPb3v7NXt9DwRrdADMrtVou/18vW2KVdWhDK2phraklbbUPlkDPmvHOaIi8a
	RG5g==
X-Gm-Message-State: APjAAAXCxdABR6DBZmLQmk28B0B2HWv97H5flmQpIhjij7CBbG7T/ood
	Q+DpqGLenN5mjs2GYybY7/BwGNF9EPI=
X-Google-Smtp-Source: APXvYqxdsANop/CbkY43Paxq84cQJ8WyrMRFG8AtmrhLRcMzJAcEUDnklJgA8KOvd5W4T58Pw1ruTg==
X-Received: by 2002:a0c:c16c:: with SMTP id i41mr39979638qvh.183.1558009199539;
	Thu, 16 May 2019 05:19:59 -0700 (PDT)
Received: from redhat.com ([185.54.206.10]) by smtp.gmail.com with ESMTPSA id
	l16sm2311804qtj.60.2019.05.16.05.19.57
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:19:58 -0700 (PDT)
Date: Thu, 16 May 2019 08:19:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190424041959.4087-2-david@gibson.dropbear.id.au>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
Subject: [Qemu-devel] [PULL 21/37] pcie: Remove redundant test in
 pcie_mmcfg_data_{read, write}()
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516121956.SwGm4mCxJFB_NS5n6Oiol4yXYVWPUrw3qeZosX5VOSA@z>

From: David Gibson <david@gibson.dropbear.id.au>

These functions have an explicit test for accesses above the device's
config size.  But pci_host_config_{read,write}_common() which they're
about to call already have checks against the config space limit and
do the right thing.  So, remove the redundant tests.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190424041959.4087-2-david@gibson.dropbear.id.au>
---
 hw/pci/pcie_host.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index 553db56778..1ee4945a6d 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -47,11 +47,6 @@ static void pcie_mmcfg_data_write(void *opaque, hwaddr mmcfg_addr,
     }
     addr = PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
     limit = pci_config_size(pci_dev);
-    if (limit <= addr) {
-        /* conventional pci device can be behind pcie-to-pci bridge.
-           256 <= addr < 4K has no effects. */
-        return;
-    }
     pci_host_config_write_common(pci_dev, addr, limit, val, len);
 }
 
@@ -70,11 +65,6 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
     }
     addr = PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
     limit = pci_config_size(pci_dev);
-    if (limit <= addr) {
-        /* conventional pci device can be behind pcie-to-pci bridge.
-           256 <= addr < 4K has no effects. */
-        return ~0x0;
-    }
     return pci_host_config_read_common(pci_dev, addr, limit, len);
 }
 
-- 
MST


