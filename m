Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51164C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CADF207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME2Ad7Tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CADF207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jop2p-0005c6-Dg
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jop1Q-0003RK-Jm; Fri, 26 Jun 2020 10:08:04 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:40350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jop1P-0006do-1E; Fri, 26 Jun 2020 10:08:04 -0400
Received: by mail-ed1-x52f.google.com with SMTP id b15so7035828edy.7;
 Fri, 26 Jun 2020 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=+LJEOKxiY+rlBRL2d3e3qAL3DIgyLYq2ScPrVfPLxJo=;
 b=ME2Ad7TtdCSp9tpf7w8d8rLlGHTJQoy/is31JVgxKFnHHRwvMiELarwxMo2OXnTLXf
 hr4Y9iNqjAD76YU0rOrHjWGjHgeqdP/FwhK3DR45984IAuicJvyAPXlbJx4UM/y58scl
 G8qWJlTY6gBBrYgO9Jg0eLKz7U4uNf4WN1w02HzUrkQxT94kKIe22/r4Yv2MCu0akfAP
 V/ut0A0ztcfwjv3y6ijp28vOPslgSXsmqm7CSW4EdHTwIFelb3U2D4CoMZVCATeYwd3l
 epHTqFtaOcgWpsr1f/MaLZvXsR7OgJ2cvk6qJmKicxaYP6Wn/3py38Tg8sUZpYSM9UWD
 tmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=+LJEOKxiY+rlBRL2d3e3qAL3DIgyLYq2ScPrVfPLxJo=;
 b=ucRQumbrJMqSQJECeazqLdgMWHPmoSEcUDDW4kP71LLPnBxYNAtzWlLJVAULHDZTXz
 loPclRctqhQZNAwwytZ4x3YdGq9xE9E+NooxpH7BTDeB/wkif+EUxJI9EnHte032TNJC
 u0zNJ2Oq9VTk6I6erIQVaBrrz4Bwr6nqX+kOE5Qu5v7GS4XJOV36jEw72ab59FVau+is
 pnV+JIP1W7WF+Uxk31mROFuLl9YOk8Fin0pwWpI0bYleY+/+Ar+rL2tqEcgtZmvq7U+i
 sRET/PA8pcKMq+9GYQTOBgXqHpCY6URbgVm5xhjn4bHbFNl+B+Lq5dQTMcIeIjtBucu6
 bkIg==
X-Gm-Message-State: AOAM530J4hfjDh3d7yYxm8UCazBx2SPT6S96pcrMWuGyX2YJXBbzQJYd
 7GwyJvpAhLqiNx1PFfC49DeHrOsupvC970JxIPX4QDWXul/L7A==
X-Google-Smtp-Source: ABdhPJx8ZhIR9EERhjSVxJOvPFoQl/HAG5/Bc6/eeXf3JTF+zX8lGf8D3baTE/7EXFz05DRiDUWLB5Bx9qzeIdCBVlU=
X-Received: by 2002:a50:cf05:: with SMTP id c5mr3702130edk.232.1593180480937; 
 Fri, 26 Jun 2020 07:08:00 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 15:07:50 +0100
Message-ID: <CA+XhMqxWiXK=7TbbdKFDMe_Jeh--Z6fcckQn7y=vg+NQ_Pbo7w@mail.gmail.com>
Subject: [PATCH 2/3] drm build ignored for Haiku.
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x52f.google.com
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

