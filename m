Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CCAC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9116F2070E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr1DbhI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9116F2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXU1-0002Ua-7z
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX55-0003ex-Je
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX54-0005Am-Lo
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:23 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:44338)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX54-0005AX-I5; Mon, 06 Jan 2020 13:26:22 -0500
Received: by mail-qk1-x743.google.com with SMTP id w127so40269883qkb.11;
 Mon, 06 Jan 2020 10:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JP7yRAv3JFqhY7+OM2TlYk8mkn5EeN/uOmT4fxUErEA=;
 b=Vr1DbhI/ySi+nSz1J3b1Vz6TDDueqfUI5kWiNnFHtX+b77uUHqpAd02mmjG30yN1AQ
 ZxRuPfiL8EN6Uwr1kZYQU76VHMFnAlR07gdPcK91D9sXGRjgT3x292tpMES0e7iwbXYs
 wmkuamyCyCBvRSxASDKoJ+4V0wH1dtYxVE14TzYhWZzhGqPyG4JeprB32MXbULns40Ck
 xhHINx2ofieHYO9vLJGW1D0iBdOkJLHi2j/tqJqEKUb/BoIBeS8jBRFVfGcKKZvARmQG
 SCqAgUuEzNlnRT0PX7kv7tAWXVlMr7hc8lNNEpddZ36aK07TLvKXr+Dombf7XSDMz6Du
 bduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JP7yRAv3JFqhY7+OM2TlYk8mkn5EeN/uOmT4fxUErEA=;
 b=PT2WCj1aoX89TwUmDZHoTp+nGad+IcU4GE5TpJ6g/RJmO58e1kUtbxHO/LAuROSvnL
 WOhJmpfFl/fdbfemyKio75+HR9r/X7hB/EfI2xbLWXUxWv6CUIMDiUhap77kZkANu7zZ
 nXFA0DXDlkUpl6RGbD+4iIjDtLy2U/yoowlOeBuQr+7ilAHa46Av+GmMGZBMEUOF+LM0
 hEppsoN81583TOqyZuoYYNNJS3uRrYQmIe2NGXnXPZqXlC7g1dLXCdVg8PAlU4h8wdu5
 +6v7wFphUQBfHxB24nL367BAW2MoSiVu36fxVYNgaeFaP3k1hFfMS3mYdmUZRap/XyyT
 dnVQ==
X-Gm-Message-State: APjAAAUOv/G4BY7wvKR6RzwQMpGRIDkqWrQH9q2uUjYrioVdmr+25mO5
 ExAEMhstZat96krQ5txBbM2ZBZ2t
X-Google-Smtp-Source: APXvYqy7eHx3DNdyUi8FeIpvryybTYEiqNapfd+kmM0ClNOuRVHCPX1NE2URNksuTXzckQsorG3jZA==
X-Received: by 2002:a05:620a:b04:: with SMTP id
 t4mr86335470qkg.7.1578335181943; 
 Mon, 06 Jan 2020 10:26:21 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:21 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 50/59] rdma/rdma_backend.c: remove unneeded label in
 rdma_backend_init()
Date: Mon,  6 Jan 2020 15:24:16 -0300
Message-Id: <20200106182425.20312-51-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' label can be replaced by 'return -EIO' in the single
goto jump.

CC: Yuval Shaia <yuval.shaia@oracle.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/rdma/rdma_backend.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index c346407cd3..20c4c9fc3a 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -1335,8 +1335,7 @@ int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
     if (!backend_dev->context) {
         rdma_error_report("Failed to open IB device %s",
                           ibv_get_device_name(backend_dev->ib_dev));
-        ret = -EIO;
-        goto out;
+        return -EIO;
     }
 
     backend_dev->channel = ibv_create_comp_channel(backend_dev->context);
@@ -1377,7 +1376,6 @@ out_close_device:
 out_free_dev_list:
     ibv_free_device_list(dev_list);
 
-out:
     return ret;
 }
 
-- 
2.24.1


