Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D4BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23CA20836
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jehXDHGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23CA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3ae-0001fQ-TV
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jo3Yi-0006jC-6t
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:27:16 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jo3Yg-000769-FC
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:27:15 -0400
Received: by mail-lf1-x141.google.com with SMTP id u25so1092578lfm.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 04:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BAeSGl1wtUV2bgf5JPD0BJDHcmlodz8SVwPxsOzMRHc=;
 b=jehXDHGHMq11GHr2PO+lTcoZv9Q56gkk82ZMxNx1YtrDQ8niyHFuFkBfF6zx9Mywra
 dTk0wvasfo3IH+VDl5nOJ4uiq8ip3oCKPDuwCBzvBSfCauxL1o5TusErG+LA6WUaPZSG
 MPaQUEnDYXW71f/BvhUrwIqF2VZ2k5gk7APcBs9yU3a3orF6hfg6pzXgmYGfJxzHPmWn
 876MFClASv5gQgnVeenOZvn6m76/0pSESDCNW8hkgsaXUVtwziIVZg8E2RySAztjF7Fn
 NFTdV13u0Ri/f08fubdkmHlWRWeKEbs+TdbaXIEdpEg6WR6wKjq0TSfmVLZKE1QeXi1F
 UX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BAeSGl1wtUV2bgf5JPD0BJDHcmlodz8SVwPxsOzMRHc=;
 b=mxhKMp83VWiVyQ7+T+jaqi8WAyvb40Ch9mqlIdiK1UOTlmn86M/ovvitIIPMbmoZH3
 i7/73AQjUBY5LArNqAR5hJ90ebcu/byflQ8RrD08wwcdz7PNdYGaZh1Ex/YlqzafnVJj
 Woq46BrySjV9oZxbVeLzc66nYYZBtYVIJlUWtSL/fiwJ2SCNh0J/Y0XBLRF+pDh0F+31
 GCXsqmFLEA4WPnr50q/f3N2Q0RoGGGdq4AV0vkVkMRW6EJ2H8cuzQx+gWRrstYoIJvXR
 OCIDB+qbSCObpbNfKo3GV6WmPjahj1aYc7P7QuRRwdkE23tpBfOVMWi1GZT+OXfGbGaY
 Rr0g==
X-Gm-Message-State: AOAM533ej00ShWMD52Aiph0mgnso9SL7I0gKGoRgZF2KJKm0g8UAg3xi
 ft/BXcSTK7OfswlOIcqWLhBvGBRcc3Q6Ug==
X-Google-Smtp-Source: ABdhPJyEGOW1mTkWeQRXEHGuDLsa348Ai+v6YelZ67o7zBE1JBKscm/49RtMq8LP+wL/egMpNSqdjQ==
X-Received: by 2002:ac2:5691:: with SMTP id 17mr6961101lfr.209.1592998032680; 
 Wed, 24 Jun 2020 04:27:12 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id d6sm1202635lja.77.2020.06.24.04.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 04:27:12 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] char-stdio: add support for the terminal size
Date: Wed, 24 Jun 2020 13:26:38 +0200
Message-Id: <20200624112640.82673-5-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624112640.82673-1-noh4hss@gmail.com>
References: <20200624112640.82673-1-noh4hss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=noh4hss@gmail.com; helo=mail-lf1-x141.google.com
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
Cc: lvivier@redhat.com, amit@kernel.org, mst@redhat.com,
 Szymon Lukasz <noh4hss@gmail.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement chr_get_winsize for the stdio backend
and trigger CHR_EVENT_RESIZE upon SIGWINCH delivery.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
---
 chardev/char-stdio.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 82eaebc1db..1edc82fc6e 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -34,7 +34,9 @@
 #include "chardev/char-win-stdio.h"
 #else
 #include <termios.h>
+#include <sys/ioctl.h>
 #include "chardev/char-fd.h"
+#include "qemu/main-loop.h"
 #endif
 
 #ifndef _WIN32
@@ -45,6 +47,13 @@ static bool stdio_in_use;
 static bool stdio_allow_signal;
 static bool stdio_echo_state;
 
+typedef struct {
+    FDChardev parent;
+    Notifier resize_notifier;
+} StdioChardev;
+
+#define STDIO_CHARDEV(obj) OBJECT_CHECK(StdioChardev, (obj), TYPE_CHARDEV_STDIO)
+
 static void term_exit(void)
 {
     if (stdio_in_use) {
@@ -82,11 +91,32 @@ static void term_stdio_handler(int sig)
     qemu_chr_set_echo_stdio(NULL, stdio_echo_state);
 }
 
+static int qemu_chr_get_winsize_stdio(Chardev *chr, uint16_t *cols,
+                                      uint16_t *rows)
+{
+    struct winsize ws;
+
+    if (ioctl(1, TIOCGWINSZ, &ws) < 0) {
+        return -1;
+    }
+
+    *cols = ws.ws_col;
+    *rows = ws.ws_row;
+    return 0;
+}
+
+static void term_resize_notify(Notifier *n, void *data)
+{
+    StdioChardev *s = container_of(n, StdioChardev, resize_notifier);
+    qemu_chr_be_event(CHARDEV(s), CHR_EVENT_RESIZE);
+}
+
 static void qemu_chr_open_stdio(Chardev *chr,
                                 ChardevBackend *backend,
                                 bool *be_opened,
                                 Error **errp)
 {
+    StdioChardev *s = STDIO_CHARDEV(chr);
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
 
@@ -116,6 +146,9 @@ static void qemu_chr_open_stdio(Chardev *chr,
         stdio_allow_signal = opts->signal;
     }
     qemu_chr_set_echo_stdio(chr, false);
+
+    s->resize_notifier.notify = term_resize_notify;
+    sigwinch_add_notifier(&s->resize_notifier);
 }
 #endif
 
@@ -139,6 +172,7 @@ static void char_stdio_class_init(ObjectClass *oc, void *data)
 #ifndef _WIN32
     cc->open = qemu_chr_open_stdio;
     cc->chr_set_echo = qemu_chr_set_echo_stdio;
+    cc->chr_get_winsize = qemu_chr_get_winsize_stdio;
 #endif
 }
 
@@ -155,6 +189,7 @@ static const TypeInfo char_stdio_type_info = {
     .parent = TYPE_CHARDEV_WIN_STDIO,
 #else
     .parent = TYPE_CHARDEV_FD,
+    .instance_size = sizeof(StdioChardev),
 #endif
     .instance_finalize = char_stdio_finalize,
     .class_init = char_stdio_class_init,
-- 
2.27.0


