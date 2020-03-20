Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47135C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1069C2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZePSpkPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1069C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFF6u-0004yU-7O
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1jFF68-0004La-EH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1jFF67-0005Yc-Ff
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:41:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44054)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1jFF67-0005W5-9d
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:41:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id o12so6257408wrh.11
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6OOf8rVvLuKGMJZzGbyNc2qt2ug9LX09+SOHYsiRPHc=;
 b=ZePSpkPyT4A09y5hcccsdZ/95ysWUnJBrcnAqBHMrsaynIwz61CMgH/qTGd4t5AR2m
 qQWjrFZGPoDVLeP5WDNKhNchQs3tnBESpf4N0j1lfCEv/ZS1c2LyxL1fZdXGGqs+NV6J
 jLYZFklwI6tm+RscBvieZ51nzHJIu8JcWt97YMaSGokwLtKxIn/EV7/f0TsR2TBvRm0E
 4jEGc6jIZUC5C5yFEnYi0QPQeOrj/cgTN2HjgazStJ8d5CUkU2DoVen3wr+i0JojvylN
 5uoEXZAMIp6uMedHybuu3J8T44RbNvzDSooSmude80Wn8UdXxUOFKl85Cto9+gkUyuqr
 Upog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=6OOf8rVvLuKGMJZzGbyNc2qt2ug9LX09+SOHYsiRPHc=;
 b=T9ipDhYsne/zWaWLHfZaVfAY8c1xUaR/TnJuYCkt2qZAXGa5vlY+9G+AMOLYL+kcdQ
 8Tk2PHiaeiEHruW5ta/xBcjvgbr2Dt1KvszdPc5ICaK4zLidf1NROD1s9rV+bgvYRmu5
 nqTsndxzmoqGX8Qly2orsyP7NdQAbybv5u0ZmpevJZdPelgfIeJEtX3YJHwMGYHzvKMy
 OhpoNAOlVLpH7rk9zpR4lhiw9rftgmj7AImucHeuQcB0W80oLQRWJtP8Cl+o0Y3ljSZX
 p3pZ/+erg3v+RXjna78tK/g9pqE87FdlLYuoiGk5vzq29rWzzCJwvqY/Km8UBOy6IDuJ
 No9A==
X-Gm-Message-State: ANhLgQ0GpyuAqyJi03C3CpD3daSuPqh7dA1JGwHpD+v6aTXpau4EiE9f
 rFC3ggQpnS9H/EvyQF6bdiPCnVfS
X-Google-Smtp-Source: ADFU+vsKGnjKxt9+2kXJtyZ+G+Gsf9b5tqqxvVV7k8PGzo3sFi5/W2YJ/IuoTZn2XIR5OsIfwR1hiQ==
X-Received: by 2002:adf:a490:: with SMTP id g16mr10120689wrb.42.1584700909363; 
 Fri, 20 Mar 2020 03:41:49 -0700 (PDT)
Received: from donizetti.fritz.box ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id c18sm6366121wrx.5.2020.03.20.03.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 03:41:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio-iommu: depend on PCI
Date: Fri, 20 Mar 2020 11:41:47 +0100
Message-Id: <20200320104147.643941-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: eric.auger@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtio-iommu device attaches itself to a PCI bus, so it makes
no sense to include it unless PCI is supported---and in fact
compilation fails without this change.

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index d29525b36f..83122424fa 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -12,7 +12,7 @@ config VIRTIO_RNG
 config VIRTIO_IOMMU
     bool
     default y
-    depends on VIRTIO
+    depends on PCI && VIRTIO
 
 config VIRTIO_PCI
     bool
-- 
2.24.1


