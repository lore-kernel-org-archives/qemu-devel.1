Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CA5C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FFA208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhZCArZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FFA208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58UF-00020G-Di
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j58Jk-00032F-4S
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j58Jj-0007RH-5i
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35685
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j58Jj-0007Oa-0x
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582291559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paBsMW5zAXDjF5puyoeLRSe8b4xNuuGDm59bJb4U3bc=;
 b=BhZCArZELnxL5NNxFJykcCsDTgONQZW+nHj79P/LNy4vqxcgDQmYyM8eshdJWpz3x4CeQu
 xnsYobzHj90eD9q42aGvNQ94Dr+EjlWPFBFGT6NUvxyvPKopgIy1EYBvx6WMf5jIdDai3r
 Z++CXNtaQwU1Jxg+YRRtLKBuIMPcFHs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-h-SMVGyhNY2VKFwkOT-6jg-1; Fri, 21 Feb 2020 08:25:55 -0500
X-MC-Unique: h-SMVGyhNY2VKFwkOT-6jg-1
Received: by mail-wr1-f70.google.com with SMTP id t6so1025459wru.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6JNTk73NjeTv3OroNAfG3ztm3tllZwoLmRJFD7uZjK0=;
 b=r42kOHdwy7uHgp20YeLoB4tk16GbGNCF8Xaqp5gr8fuMJnZLb2WFKCYznOlNGkTg9O
 PSMDlEfAT6YwNCqlLc8ZmNWwKG/RSMVCTAz0b0DZvMuX1IQrvl3CqW5sVl1T5rHjKcYw
 pWTedDGSoj0xzOldSJvY4r5CjOwURpewTcFyeBV1cYYaXZlakgNgeLZmvhr0WwqYRpgv
 leXeD8rk/swUf9s20FdmTMH9O5z3kUpkokzqGJs4qLaguZCzC0PMA0XvX30mrUHQqByT
 Iu08/7tzP8B1k1m6mhPcP31p9gwQVgAH9buYHby6IFHGIbEFNMTLWdSBd48OuiXoyMGy
 uaag==
X-Gm-Message-State: APjAAAUb/9rDq5a0ssfoIhI94Ist1xekZ1NSN7izWYNav9+977Q9D8Ri
 ds8PckWgjR/lmUrArs29UYM+PnBPFaG5hdFKmLgjEsTn8370RwmtlfKMTADLYT94+MdzDh2bZ2A
 5021zhJBfBpwOc/o=
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr4054148wmd.163.1582291553724; 
 Fri, 21 Feb 2020 05:25:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPjY8oFbGxLJLxgcK4v5NODWlpzzhdcwfRsmRXufRcVp1f1WdUGi5RdTT5vnCn6cmusuzFaA==
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr4054114wmd.163.1582291553379; 
 Fri, 21 Feb 2020 05:25:53 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t13sm3947679wrw.19.2020.02.21.05.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:25:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/dma/sparc32_dma: Make espdma_memory_[read/write] static
Date: Fri, 21 Feb 2020 14:25:48 +0100
Message-Id: <20200221132550.22156-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221132550.22156-1-philmd@redhat.com>
References: <20200221132550.22156-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No code use the espdma_memory_[read/write] functions outside
of hw/dma/sparc32_dma.c, make them static.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/sparc/sparc32_dma.h | 2 --
 hw/dma/sparc32_dma.c           | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.=
h
index ab42c5421b..b3811b617d 100644
--- a/include/hw/sparc/sparc32_dma.h
+++ b/include/hw/sparc/sparc32_dma.h
@@ -61,7 +61,5 @@ void ledma_memory_read(void *opaque, hwaddr addr,
                        uint8_t *buf, int len, int do_bswap);
 void ledma_memory_write(void *opaque, hwaddr addr,
                         uint8_t *buf, int len, int do_bswap);
-void espdma_memory_read(void *opaque, uint8_t *buf, int len);
-void espdma_memory_write(void *opaque, uint8_t *buf, int len);
=20
 #endif
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 3e4da0c47f..c9e313938c 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -142,7 +142,7 @@ static void dma_set_irq(void *opaque, int irq, int leve=
l)
     }
 }
=20
-void espdma_memory_read(void *opaque, uint8_t *buf, int len)
+static void espdma_memory_read(void *opaque, uint8_t *buf, int len)
 {
     DMADeviceState *s =3D opaque;
     IOMMUState *is =3D (IOMMUState *)s->iommu;
@@ -152,7 +152,7 @@ void espdma_memory_read(void *opaque, uint8_t *buf, int=
 len)
     s->dmaregs[1] +=3D len;
 }
=20
-void espdma_memory_write(void *opaque, uint8_t *buf, int len)
+static void espdma_memory_write(void *opaque, uint8_t *buf, int len)
 {
     DMADeviceState *s =3D opaque;
     IOMMUState *is =3D (IOMMUState *)s->iommu;
--=20
2.21.1


