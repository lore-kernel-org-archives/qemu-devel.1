Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23073C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C4620760
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTQvgvVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C4620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4Mx-0008UU-73
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 20:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1dp-0007dy-Qx; Mon, 29 Jun 2020 17:48:41 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:42871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1do-00087V-5w; Mon, 29 Jun 2020 17:48:41 -0400
Received: by mail-ed1-x531.google.com with SMTP id z17so14316641edr.9;
 Mon, 29 Jun 2020 14:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=f5RanH9zq7dtLaGBYZRKWZh3DJKJJzVJqKalIINzzcQ=;
 b=oTQvgvVieFZVtwNZfM9tX/gERr9IlNPOSMHQg5fw2bZnctomk67Xp7TqShxaAuFaQu
 FLAfXqmbxZqxABVTyMK1vS0kMoS7on8bzcg43Mb3LzGwSm2ktvNyeGhEXFP5SyIQn5dc
 kgZGkXcgnm2F9PhdaPiF8YcwQ1jyMf1KEA1kjAQG1BAdKtj+6VAMKjthQnTmp6i+yito
 b0l23ZPN2ylOB5BSN7te7EJ9kEs0HJGYe8CGc0n3pUQjZn+2BwijnEalTWys52eyhLYo
 S5X6k19IoPUddGJekSumskzLnmm1j+use5QFAZIj100cK3+5alE3TybK38zlYaXT7ioc
 XNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=f5RanH9zq7dtLaGBYZRKWZh3DJKJJzVJqKalIINzzcQ=;
 b=b1EZWfvRYBbpvTH3imGSLyv7wk7ZKVr1p+eXkflGpUhXLYI/nc4nqUX2FMTamYFUuz
 RnBLW26jyk4AlBIkX7m8jnDOTj37eX1SbeTwDCaNzP1pdCfwocHjHpnoozbHCVqXtirS
 JpNWuKwy72OI15A9byeFIKTUlao+z5rY3cI4wTMrPWa2lZUzyLb8yyMUiDo8OWKbhhnN
 /2bxKIAaGfxoiZ/at8O0jT7vBHf7M3HYxtNdgEp4zB4zR2sRZS+S7aPrJjFn4haBnXou
 L5eLgVJNwuzB66aBn3U/onqfWOnw7Kh0MbYTGHea/JkuNBMRADuUBFICUUAor8b+9Jie
 SX/Q==
X-Gm-Message-State: AOAM533TDGLfZFlfHCDLmxxsxOTS/EEu+8CLX8Xx7srPIgFCad9WcaBB
 f33E7Uu6nSfzR3eWYSEYIgGP2faXw1e7jlKhP0yvwGqQRew=
X-Google-Smtp-Source: ABdhPJxEWSrszet9RbwL+IucQ5tiCdbKq0ExxtBKr0KDn4hjFun9J2sIWjuUBxaDln52DMWt3lTrizvU/SfhBWGsjjU=
X-Received: by 2002:aa7:d297:: with SMTP id w23mr18971688edq.49.1593467318297; 
 Mon, 29 Jun 2020 14:48:38 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:48:27 +0100
Message-ID: <CA+XhMqzjjrfxXeSENBQuHzTe4TRMWV5GOdqPkD3bo17T3ufR1A@mail.gmail.com>
Subject: [PATC 7/9] Skipping drm build, unsupported
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x531.google.com
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
X-Mailman-Approved-At: Mon, 29 Jun 2020 20:42:18 -0400
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

From 157a0374093371719de42e99364352d64190f52a Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:20:06 +0000
Subject: [PATCH 7/9] Skipping drm build, unsupported.

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

