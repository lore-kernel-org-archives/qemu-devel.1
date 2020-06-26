Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7A4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABA620775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOXe8qXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABA620775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joo0D-0000it-Nj
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jonyu-0007hx-KB; Fri, 26 Jun 2020 09:01:24 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:33233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jonyt-00039W-0X; Fri, 26 Jun 2020 09:01:24 -0400
Received: by mail-ej1-x630.google.com with SMTP id n24so9303898ejd.0;
 Fri, 26 Jun 2020 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=+LJEOKxiY+rlBRL2d3e3qAL3DIgyLYq2ScPrVfPLxJo=;
 b=uOXe8qXMHZQ21L9po3+BdE2Y47zrStBsGOQx+L54KSSQAhEOpKN1/k0dO4PV40KFV5
 LMCURlskPinWthfkkN829JBVoG5d7FE61+6THoedFTyFqa3npqJpHVbGsAORnK1GKqwP
 czJFbjsSacY0Aa8X3mA24uevoeV9dtN1RP34blHOsQ4ZNgf17C7lDQ/z1sKgdmNEFmlY
 JXrKMqoctWrdtgI+1BtfHSzLiF8D4FOZRRMABtrWls9JNUm6ZaysrlEtmU0pj08nB9Ar
 4JsoG9jmnVFacdXv91f1/fbFL+dake8ELPYh5kszlM6K/Rey8IkRqanOd6CJvdomZh0P
 LwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=+LJEOKxiY+rlBRL2d3e3qAL3DIgyLYq2ScPrVfPLxJo=;
 b=ND5UtVBZNRp3UL9/Lzuu5BGU7netZwMsTd14f9z2bAPHn/HIwVcY1dsirakD0JqlxY
 ZWXUBwM0fl3ZlS8XzIfTQ9iYtsCSHEW+aAzfFyWXwhOr+dUnVe3yiSt+YOJEpnA0BVYT
 0DItmwah8tPffdYer5JEJnIXxYNKpnHZMKvkbzQrB4ysQ0mOIwIlROPOSgdJG5skC/ws
 HjlkBd+QnbLOahirFvSYgCqxmLhF7x53DRJs0MZer5ZiaJ/Hj2A7ETBWEtboWFpuGZiv
 OX05h475ErBiZPiuQGAIgtIyFpmncCTwQUXFC7YZF6HdM9iQ8whbUzj3LeumweR/WMD1
 H9NQ==
X-Gm-Message-State: AOAM532DzFn8N3e6GOjOr3oAlXmgjqiQ2qocg95zcj5oA+Dzd8qQUaFz
 9dvodm+HQcFt0ycV5LkQGDFcRh10Fn0crSwy3xVOGT9pyyw=
X-Google-Smtp-Source: ABdhPJxyBB4OIBdix2LVzyE0xwd+oNkLzUuX93NUsK6/SxFzyHwc8s98zgfaJrLrl9qgDCfD+6VQDog2U4w1tSUKd0U=
X-Received: by 2002:a17:906:58c:: with SMTP id
 12mr2326552ejn.311.1593176480386; 
 Fri, 26 Jun 2020 06:01:20 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 14:01:09 +0100
Message-ID: <CA+XhMqzAifFuy81abDt=2ijd_O9BGgCLyDPsKoytdWbrM3KmWA@mail.gmail.com>
Subject: [PATCH 2/3] haiku build fix second batch
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 338a25285d945c891eb4fa34a18cb45b8b05dbb1 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 13:57:08 +0000
Subject: [PATCH 2/3] drm build ignored for Haiku.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/Makefile.objs b/util/Makefile.objs
index cc5e37177a..faebc13fac 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -39,7 +39,7 @@ util-obj-y += qsp.o
 util-obj-y += range.o
 util-obj-y += stats64.o
 util-obj-y += systemd.o
-util-obj-$(CONFIG_POSIX) += drm.o
+util-obj-$(CONFIG_LINUX) += drm.o
 util-obj-y += guest-random.o
 util-obj-$(CONFIG_GIO) += dbus.o
 dbus.o-cflags = $(GIO_CFLAGS)
-- 
2.26.0

