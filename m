Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69B9C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BD82075F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRBKopZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BD82075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1lc-0005rZ-Du
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Xm-0005Ob-5c
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:34:58 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Xk-0004Xi-D9
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:34:57 -0400
Received: by mail-pf1-x442.google.com with SMTP id z19so5022351pfn.8
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NvLtiyHs+KiFJYMlTYLprFvkLKXdUBj8PVZZFjf+6Lo=;
 b=gRBKopZ5k7eugv/EgooL0pPA7gnLBcXcNRcYQymFzjxUPK3ds7TLyFrdg6YoO598SU
 UuIYBZX11eEDyke335iugbRRZx0QmA+VHJwoRJp+J10TFB9WG5IBMJS2Uz7WTgP+O8Tq
 cszXAi1fJh559GFenDszNZbgNz6JZMPxJXq3cPcefRKqCnRkUFG/97vf3Swr6awHA4nl
 yadk9lodPMy9YZOKW6tN47bsIYBvqzmzZdcKZAsA2g4dRM9YtL5yhcJye1OGYyVZSDsp
 4sx3+afX2BJvoY2+ZYcREPfY36Naa1kpcgLbMVJtPXxPgh3R1bKYtzaxXz2lCHEQcJTE
 iefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NvLtiyHs+KiFJYMlTYLprFvkLKXdUBj8PVZZFjf+6Lo=;
 b=IFZS2IjCx9vvI1fvhLexMgGCSjbpxGyQHQUTRySYQ6ofeeHh0svdIBO71OqbmecPkV
 Be8ohp+u8dxXmZwEIFRsrPnmy/HKCEeUK5jXMgeimA44LBXdtt5FArdioK6pyNoXg3Hi
 De07cviVisZAbEV9hUpoC2BSJ5EttfJV4rz8l52k2ZTvDVx5zgvry2HmTv4yQKuT4kHN
 WESvT39GDlfWTD6VIMcMGLLwEDu1wpQoVHGqe1h4I0ekNt4Z3VkwUQDpi5HTa9hLNyiS
 mldkEtkUJzuSl+SWBTsWUo5Yspt+mtJI67KNUU4a6hhZC5MOH9Qv2DjD5h1gC+DPRO08
 8LmQ==
X-Gm-Message-State: AOAM5321viNEncC3e+VEvnXm89EYPaR2EznsIRL/lkgAlI39csGQKEUO
 Z7Ld7VteEsw4Pd3BiSSTTI5cfL5kpy86tw==
X-Google-Smtp-Source: ABdhPJziI5C9/ud5GDMdxRx7LGgB+7Qcn8YQzlSjAY7QTUxKC42FYTz490shKXjdgH8+oN/vW+lhxA==
X-Received: by 2002:a63:5653:: with SMTP id g19mr6706615pgm.151.1601570094674; 
 Thu, 01 Oct 2020 09:34:54 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t12sm6946028pfh.73.2020.10.01.09.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:34:53 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/6] plugin: define QEMU_PLUGIN_API_IMPLEMENTATION first
Date: Fri,  2 Oct 2020 00:34:27 +0800
Message-Id: <20201001163429.1348-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201001163429.1348-1-luoyonggang@gmail.com>
References: <20201001163429.1348-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is used to distinguish from the qemu and plugin in
header qemu-plugin.h

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 plugins/api.c  | 1 +
 plugins/core.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/plugins/api.c b/plugins/api.c
index bbdc5a4eb4..f16922ca8b 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -35,6 +35,7 @@
  */
 
 #include "qemu/osdep.h"
+#define QEMU_PLUGIN_API_IMPLEMENTATION
 #include "qemu/plugin.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
diff --git a/plugins/core.c b/plugins/core.c
index 51bfc94787..7a79ea4179 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -12,6 +12,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
+#define QEMU_PLUGIN_API_IMPLEMENTATION
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
-- 
2.28.0.windows.1


