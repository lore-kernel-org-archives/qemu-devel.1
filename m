Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C06C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AC2206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKFd9LqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AC2206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolJU-0003tv-BT
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jolHG-000122-Rv; Fri, 26 Jun 2020 06:08:10 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:34901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jolHF-0005uM-BR; Fri, 26 Jun 2020 06:08:10 -0400
Received: by mail-ed1-x534.google.com with SMTP id e15so6480974edr.2;
 Fri, 26 Jun 2020 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=rX57mMIvQKzA8vdxqEO9lhOZZcsX/HGJMLpi1/ra/CU=;
 b=VKFd9LqIbGI8DNwYmQOgzLAIcQhqZCVO2iYiOo66kPXNlwjMavySnAk+Y3IspVG6Ms
 6TQKxJFTnZXEnbVvNuYCelmmNauwcRwxSJ9EE6vozbJoEkcZKZM0fCHoD7MT8oXFarRV
 3BBl4bD1AsqdTImljyLa2EqMaQ7EjbPXY8kBKH7td6KTOB5w5sXyMm8SWyDnd65Rya7D
 /JdieGQ9Eg0wbUDi9LGblW7s1nfMjSCVOgsdjLvCA0OQRh4M1hPzV3qlIJL7bH2FFRGF
 rpd25g93Axxj1oUBVr83wPp3/RLH2fgRV3OMZEQwn85OMgFxFZ4D950hPjmvqnpsGNLb
 h6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=rX57mMIvQKzA8vdxqEO9lhOZZcsX/HGJMLpi1/ra/CU=;
 b=aaywXwpMLqmUWiFgNA0odQIn/jd+WeT4m8yWeAaq07vTK8Xx8mVdL3yRF/lsfgECvy
 IZjF0OdS2JjqxZ+WSz236LGm46iVn9v2UmLt0Ry1iSsfK5zZV+3J2kIa7Z71+xt/r6BR
 0vvzN0gDXsAaVZpQZX2trcexgBZp4FLPUVUG34Q1DFQn5zBRM6h+vq/V7PrCcbYF5hWy
 55O3NW5NbZfKzxrfa+LYq7hKeOl3HkCC4ErpCpBoPKLFQQRHgdHzpNhcKnlxCkK5Opmk
 oglII0asK5ui0Iscm+L1YY+aeW2iQBUKE18QDiA1jdQ9ZKlCK3tA4K5WFFhUlitpEXE7
 7nXQ==
X-Gm-Message-State: AOAM531HWZV+ql+jN9SxN7yT6UmVZKCehZ10aVci2SsPsVi5oCWsU5wl
 TC0UNq+tNHRssy/5zIvHqKXpHFncX2gc13mThEAHX/ys
X-Google-Smtp-Source: ABdhPJyCn9EokLBUkTMiVMaMesePbnAXOX0Q9+2VyFm4JA82aN+hSkG6wq5c4sPEDaBuhyP6+jBap4VoGDDML0ww0Bk=
X-Received: by 2002:a05:6402:1597:: with SMTP id
 c23mr2419416edv.243.1593166087521; 
 Fri, 26 Jun 2020 03:08:07 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 11:07:57 +0100
Message-ID: <CA+XhMqwft10MnY5nOc7L+q59kOY3BAejjrOS09R5QD2H7AH-Cg@mail.gmail.com>
Subject: [PATCH 5/5] haiku build fix
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x534.google.com
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

From 68d4d4312eccd212b4d2484e09425816ebd2346a Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 11:01:54 +0000
Subject: [PATCH 5/5] Last chunk of build fix

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 include/qemu/bswap.h | 2 ++
 util/Makefile.objs   | 2 +-
 util/compatfd.c      | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 2a9f3fe783..1d3e4c24e4 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -8,6 +8,8 @@
 # include <machine/bswap.h>
 #elif defined(__FreeBSD__)
 # include <sys/endian.h>
+#elif defined(__HAIKU__)
+# include <endian.h>
 #elif defined(CONFIG_BYTESWAP_H)
 # include <byteswap.h>

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
diff --git a/util/compatfd.c b/util/compatfd.c
index c296f55d14..ee47dd8089 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -16,7 +16,9 @@
 #include "qemu/osdep.h"
 #include "qemu/thread.h"

+#if defined(CONFIG_SIGNALFD)
 #include <sys/syscall.h>
+#endif

 struct sigfd_compat_info
 {
--
2.26.0

