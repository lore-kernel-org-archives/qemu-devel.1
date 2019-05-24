Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206E1C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A088220851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VNxD/h6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A088220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54168 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9Zw-0000j1-NY
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:45:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU9XC-0007IG-Ba
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hU9XB-0006LK-Bd
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:42:54 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hU9XB-0006Kl-5Y
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:42:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id v19so1129481wmh.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=yMurcUMIFdpnP3p1to7MzM4fFIbcq3+mh+iTljVeSgE=;
	b=VNxD/h6nAE/YTUxcjWCj8jvSyhmCtE0GUjChyIYc1sIhZthl2+bk+B1nHta5I+S14m
	Qf9iE03/esogHzaNdbtm5R+0w93kojpcUTxJj6ucey/6tXcS7cBvc+cpU/Ur102kV+nN
	Uqn7beFzcfn7Yf6uzUnaiRAssQ/lV5rjg5OwTwJP1eLktwgkUJmqrN6rVM+1Vxz3PB60
	TKYls+541b5IRHI7kYMfbNHQnjYnOVtxBhJHBnQPdCj55zsMfcV0OS7T4aRaoIfXMmIz
	U8ud3Fb6naYRUmZuyNP7/unO+hUMp5LpgwZSAZu5iXnH909SrQaR3C8sx0JqcZ+l8lJ0
	m8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=yMurcUMIFdpnP3p1to7MzM4fFIbcq3+mh+iTljVeSgE=;
	b=RIybMmHkA0lO1tsOwfvR+FCG/SbupxMgoAKmAqbF1al1m9cLtueFahulcrOZQEV3dE
	LufFjL/c+f943FJgSlz3mZ9TN1+Po6GDjS7ux1FZBZrJlUGUYhh5pWk3EMPXEdhfyXft
	kdoH5G/fYNkXg0iTRMB/bWXyNwvZeu/8O5SVqQrop1zq4OX+ICtCI4Pfv+svRgngE7zf
	g2ooDbpYyPlBDhHG/Gpf7xg4lJ78o1Lfwqy35t7AnQezjoGSLT2PmLVkvYeRPerQd/1y
	vvVJWSrvFiP+rh0lmYgDsaw4F5LCuAXhxtPK0D9Cx++cNoraWOAfj7NzHYDaQ1eK/P00
	z4Uw==
X-Gm-Message-State: APjAAAVpzclkJN0nGnx4zfOKaUeujUTW/FZ789hsMNXDInujq97jT+sE
	ubfpgJ9EJ5LEuUwftn83U936YjxoqoIVbQ==
X-Google-Smtp-Source: APXvYqy1vTilmX7BKhgTRGkICUgYtEkeIXKpXK19DxChmNm42c3ZwvITzhlmYRmHG60dA9CEYbw4GQ==
X-Received: by 2002:a1c:be0b:: with SMTP id o11mr16583199wmf.63.1558701772160; 
	Fri, 24 May 2019 05:42:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id t12sm2969854wro.2.2019.05.24.05.42.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 05:42:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 24 May 2019 13:42:47 +0100
Message-Id: <20190524124248.28394-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524124248.28394-1-peter.maydell@linaro.org>
References: <20190524124248.28394-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v2 1/2] hw/intc/arm_gicv3: Fix decoding of ID
 register range
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The GIC ID registers cover an area 0x30 bytes in size
(12 registers, 4 bytes each). We were incorrectly decoding
only the first 0x20 bytes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_dist.c   | 4 ++--
 hw/intc/arm_gicv3_redist.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 53c55c57291..e6fe4905fd3 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -533,7 +533,7 @@ static MemTxResult gicd_readl(GICv3State *s, hwaddr offset,
         }
         return MEMTX_OK;
     }
-    case GICD_IDREGS ... GICD_IDREGS + 0x1f:
+    case GICD_IDREGS ... GICD_IDREGS + 0x2f:
         /* ID registers */
         *data = gicv3_idreg(offset - GICD_IDREGS);
         return MEMTX_OK;
@@ -744,7 +744,7 @@ static MemTxResult gicd_writel(GICv3State *s, hwaddr offset,
         gicd_write_irouter(s, attrs, irq, r);
         return MEMTX_OK;
     }
-    case GICD_IDREGS ... GICD_IDREGS + 0x1f:
+    case GICD_IDREGS ... GICD_IDREGS + 0x2f:
     case GICD_TYPER:
     case GICD_IIDR:
         /* RO registers, ignore the write */
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 3b0ba6de1ab..8645220d618 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -233,7 +233,7 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
         }
         *data = cs->gicr_nsacr;
         return MEMTX_OK;
-    case GICR_IDREGS ... GICR_IDREGS + 0x1f:
+    case GICR_IDREGS ... GICR_IDREGS + 0x2f:
         *data = gicv3_idreg(offset - GICR_IDREGS);
         return MEMTX_OK;
     default:
@@ -363,7 +363,7 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
         return MEMTX_OK;
     case GICR_IIDR:
     case GICR_TYPER:
-    case GICR_IDREGS ... GICR_IDREGS + 0x1f:
+    case GICR_IDREGS ... GICR_IDREGS + 0x2f:
         /* RO registers, ignore the write */
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: invalid guest write to RO register at offset "
-- 
2.20.1


