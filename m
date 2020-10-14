Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4F0C43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DD12222E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9k0gKKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DD12222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSh3u-0006nu-WF
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kSh2b-0005Ux-7E; Wed, 14 Oct 2020 09:42:06 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kSh2Y-0007OE-17; Wed, 14 Oct 2020 09:42:04 -0400
Received: by mail-pg1-x544.google.com with SMTP id o3so1969738pgr.11;
 Wed, 14 Oct 2020 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=WeRzjNLlGVXNke2jIZxyWHexyS279DaSkh8B2vo7Glo=;
 b=t9k0gKKlG/nvZcnMk61E/dbWv8FV5U5yxga0L9hzL+jkcYPqNK9c5Gf3J5ln9T3d9M
 OsUgo5r8oDY7V9mRbxb/0I9S/HSfA8fFfBk3J2qNHXXXnndrYoSTpOuMGNyxGYXNt2Rt
 O7zMcPSP9vyaozr7urfPucAPlGdEEUEvTVZ7Z3AGCj35e9UA+xJCMr/CMPIQVOkSLFg/
 9bnM2PQzaBm8qnbhejeQ5paiLK0kvEndyi3ebQsJY4vZZHHspuScuEdq0DHveylM9VGr
 t1IgfxJYBHcvMiKA8ogwkilIPpUR/QyK49OWfqSIfTVDfdkbjnlfYp+1OtfrIgJk+wrW
 JFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=WeRzjNLlGVXNke2jIZxyWHexyS279DaSkh8B2vo7Glo=;
 b=m4K10jQNAFlenX8/DUkpt5j+JDNeBcut87XDFB9aLih6gyi4GoJ1z0+hpqFRVFS+5a
 NoG5hQnRVcUyVyoAlH9nfM1FfFOdld6Xz65ZoXQIOtKA5z4oiA33bWfSzsYwsaMjggNt
 jbqOsP0BuC7nKw3X1G9UkryrVEYpEWsesEyMMxvq/6tC0QwIjsrv5rCcBD4FMUPA0j/u
 G0O+mZhgZGcLP8UhYn/CsJ15cRXvgElCHyjWxoK970GANdq+K8xP7LuqkD9eb1lN59su
 UXFpkC/ZDUa5FXQidIt5NXpL2GpgzI3oImHSdSsMTiKES5pAiPgaMfZDq21Yk7EdOyv0
 2ewA==
X-Gm-Message-State: AOAM532Wfu+fA6uHGazTv4vgNj1+tFyuwMypb9H5FYH1K8lq7bF260hw
 EfKyIxcVuvjaYVk44C2uzlGsPnk5KT2YMIHu
X-Google-Smtp-Source: ABdhPJyQEqJ9kS/B2b4evfqjQc+olWrGbHsVlm0I1nnlcf33+xECYzyi9EpJ4HSOc0Dslhuvxt3YUg==
X-Received: by 2002:aa7:9884:0:b029:156:5806:b47f with SMTP id
 r4-20020aa798840000b02901565806b47fmr4564883pfl.4.1602682919278; 
 Wed, 14 Oct 2020 06:41:59 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id 38sm3569203pgx.43.2020.10.14.06.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 06:41:58 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 2/30] io: Fix Lesser GPL version number
Date: Wed, 14 Oct 2020 13:40:33 +0000
Message-Id: <20201014134033.14095-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=chetan4windows@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 include/io/channel-buffer.h     | 2 +-
 include/io/channel-command.h    | 2 +-
 include/io/channel-file.h       | 2 +-
 include/io/channel-socket.h     | 2 +-
 include/io/channel-tls.h        | 2 +-
 include/io/channel-util.h       | 2 +-
 include/io/channel-watch.h      | 2 +-
 include/io/channel-websock.h    | 2 +-
 include/io/channel.h            | 2 +-
 include/io/dns-resolver.h       | 2 +-
 include/io/task.h               | 2 +-
 io/channel-buffer.c             | 2 +-
 io/channel-command.c            | 2 +-
 io/channel-file.c               | 2 +-
 io/channel-socket.c             | 2 +-
 io/channel-tls.c                | 2 +-
 io/channel-util.c               | 2 +-
 io/channel-watch.c              | 2 +-
 io/channel-websock.c            | 2 +-
 io/channel.c                    | 2 +-
 io/dns-resolver.c               | 2 +-
 io/task.c                       | 2 +-
 tests/test-io-channel-buffer.c  | 2 +-
 tests/test-io-channel-command.c | 2 +-
 tests/test-io-channel-file.c    | 2 +-
 tests/test-io-channel-socket.c  | 2 +-
 tests/test-io-task.c            | 2 +-
 27 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/io/channel-buffer.h b/include/io/channel-buffer.h
index 518c28f..c9463ee 100644
--- a/include/io/channel-buffer.h
+++ b/include/io/channel-buffer.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-command.h b/include/io/channel-command.h
index 5556a38..27e42bd 100644
--- a/include/io/channel-command.h
+++ b/include/io/channel-command.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index c61d6e0..50e8eb1 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index d07d67f..e747e63 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index 6dd1a3c..5672479 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-util.h b/include/io/channel-util.h
index c0b79cf..a5d720d 100644
--- a/include/io/channel-util.h
+++ b/include/io/channel-util.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-watch.h b/include/io/channel-watch.h
index 63bc4ae..a36aab8 100644
--- a/include/io/channel-watch.h
+++ b/include/io/channel-watch.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
index 9c40513..e180827 100644
--- a/include/io/channel-websock.h
+++ b/include/io/channel-websock.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/channel.h b/include/io/channel.h
index 3c04f0e..4d6fe45 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/dns-resolver.h b/include/io/dns-resolver.h
index 01d0bd7..558ea51 100644
--- a/include/io/dns-resolver.h
+++ b/include/io/dns-resolver.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/io/task.h b/include/io/task.h
index 6818dfe..beec4f5 100644
--- a/include/io/task.h
+++ b/include/io/task.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-buffer.c b/io/channel-buffer.c
index 5402e0c..baa4e2b 100644
--- a/io/channel-buffer.c
+++ b/io/channel-buffer.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-command.c b/io/channel-command.c
index 368dd62..b2a9e27 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-file.c b/io/channel-file.c
index 2ed3b75..c4bf799 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-socket.c b/io/channel-socket.c
index e1b4667..de259f7 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 7ec8cef..388f019 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-util.c b/io/channel-util.c
index 423d798..848a7a4 100644
--- a/io/channel-util.c
+++ b/io/channel-util.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-watch.c b/io/channel-watch.c
index 8640d1c..0289b36 100644
--- a/io/channel-watch.c
+++ b/io/channel-watch.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 47a0e94..bb545fa 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/channel.c b/io/channel.c
index e4376eb..93d449d 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/dns-resolver.c b/io/dns-resolver.c
index b55d8cc..743a0ef 100644
--- a/io/dns-resolver.c
+++ b/io/dns-resolver.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/io/task.c b/io/task.c
index 53c0bed..451f26f 100644
--- a/io/task.c
+++ b/io/task.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-channel-buffer.c b/tests/test-io-channel-buffer.c
index 59d6c64..9c6724d 100644
--- a/tests/test-io-channel-buffer.c
+++ b/tests/test-io-channel-buffer.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-channel-command.c b/tests/test-io-channel-command.c
index 3bc5266..99056e0 100644
--- a/tests/test-io-channel-command.c
+++ b/tests/test-io-channel-command.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-channel-file.c b/tests/test-io-channel-file.c
index 0aa0477..29038e6 100644
--- a/tests/test-io-channel-file.c
+++ b/tests/test-io-channel-file.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socket.c
index 743577d..c49eec1 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-io-task.c b/tests/test-io-task.c
index 85e7a98..953a50a 100644
--- a/tests/test-io-task.c
+++ b/tests/test-io-task.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


