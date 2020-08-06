Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CE4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE3623120
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS0DO8oP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE3623120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fgw-0001yg-4s
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3feb-0007nx-Ny; Thu, 06 Aug 2020 09:09:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fea-0007oe-88; Thu, 06 Aug 2020 09:09:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id y3so43951378wrl.4;
 Thu, 06 Aug 2020 06:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z1eB1yLGjmQeAviyyU8a06QWYwG1jvRDYYTpvqI4k5k=;
 b=fS0DO8oPVH0SCuBPmNIuSTPPFOHGXqmwuX0BC+2BinK+b4Sawg4p+H9/p/YveWyX//
 E9d+tpGX97ir/AkCz9v90IP4QbRu8oAwvxfvi6s1HkfnHPzIBsA9+Fo5F3bytAecMsGw
 h2aIa6E6Q4JoaUvIgLD/XbeG9fwluWULUtTKSHJpKH+E8VzRK6kKaUlLoal7Loo98ua3
 tqVJt3luv3XVCgKf+j4/eDWmozVJgs+qVxp9Psa0i9Jr+ux0aic9H8BcBDhOHiP9ptdY
 gBVZ2trYcl8E2u4Kw0JvhzVH9iX3vpq3FK0QRV+AYFqj0dwiEbn7YjuKnktlES+pn7RL
 Lghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Z1eB1yLGjmQeAviyyU8a06QWYwG1jvRDYYTpvqI4k5k=;
 b=BVQQJFGxzvXMT54BY/8nrXfXVG/9C20zhS2DeGSeK36SCL78r0fBEZLYCOkQnHwW4z
 Y9/R1M08D9584z8czzImhh3mEJCKQs5xyFtVDTBFJ8Akf9TG8hl+HaqzpV/PYn3QUBkd
 1yvfy0NIRpnOHvsxIKn/yVXsWkW+ZLVtH7VEj9TdaF1hxdhbT8bK8l8EbHaPbaK8Ut2Q
 m1zZkm6PY+OJ2r9QXeQYxtFhmKXXFLv4FginM1fVWavmuRnSLasNPj5oIcM649VNwhyc
 yAxzRNdybXjFBJVgvd+d+Taeu424h9qP+pzzIEza7ALZZHLHgm+j2V8Hs1O0kXVALbKd
 6brg==
X-Gm-Message-State: AOAM531TLa8djqRep5jpgVUzrmR3b0ZpO0UBTCiwdXsNRwDIVOTdomy/
 GYtPYQcqvQj0kc664g9XwUTOTWWs
X-Google-Smtp-Source: ABdhPJyus1Ku4md8coyBMsaRK0fqn7RBKMj+qarsgZbIhpf7ZMCno/VuPsJLO9jrjLjtY9Kp8AMAZA==
X-Received: by 2002:adf:efcc:: with SMTP id i12mr7590787wrp.308.1596719390198; 
 Thu, 06 Aug 2020 06:09:50 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w2sm7092799wre.5.2020.08.06.06.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 06:09:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 2/2] hw/core/sysbus: Assert memory region index is in
 range
Date: Thu,  6 Aug 2020 15:09:45 +0200
Message-Id: <20200806130945.21629-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806130945.21629-1-f4bug@amsat.org>
References: <20200806130945.21629-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Devices incorrectly modelled might use invalid index while
calling sysbus_mmio_get_region(), leading to OOB access.
Help developers by asserting the index is in range.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/core/sysbus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 77ab351ce1..294f90b7de 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -199,6 +199,7 @@ void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory)
 
 MemoryRegion *sysbus_mmio_get_region(SysBusDevice *dev, int n)
 {
+    assert(n >= 0 && n < QDEV_MAX_MMIO);
     return dev->mmio[n].memory;
 }
 
-- 
2.21.3


