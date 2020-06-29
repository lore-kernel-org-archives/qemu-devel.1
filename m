Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099DAC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD57E2559A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVw45NZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD57E2559A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwtO-0005fG-GI
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqL-0000NA-Pw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:17 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:41941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqJ-0007vO-Fh
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:17 -0400
Received: by mail-lj1-x244.google.com with SMTP id 9so18759546ljc.8
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 09:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lQ2x+wGNqZFyEYsLtUvst9mktUqtofO85Tme5j5B6as=;
 b=YVw45NZ2mFx1uIEkTe4QiMsoXyFGciqC9tx00vXwXDbFGbt+/VF5QtdRfXLKEkgqmY
 WcVrMNTKfHchIz9wukjVhWXJJuEpdvuWRhplZV7wbRCeLTw0BCb1gHY30cccKyvAsrZ/
 gc7K6wP3JFi9SwKeYbJkgh4MibtyxBxmecnsu983aFeWS+bRa9qXnK6AGZkuaPB7VpjY
 mX2E6iW3smCjsoyrp0bOhbdrJl3e/71T3qtWH0qBKiP9EaWew6SxdhwqZ/C9+1JDMbYQ
 fysC7ypTwuCv5PkJTwDO1DHr5AMiSQIYuqHcjOlU3TcK0/TSib9myR4dMh3oE+/QPiKC
 wLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lQ2x+wGNqZFyEYsLtUvst9mktUqtofO85Tme5j5B6as=;
 b=t4ZxI4tt+vLiptkWnpNxoCIPf2n6orw/g567IAtL+Xeu6FTFdnlrVeES2jxzHzvViv
 eifICIGRTFPcTJd0PRziLmZ+p5By/kx+Tuys50WbhaNacN91JZUxn2YX0Kxm5gwC+IFs
 mMn0Lj/zHft6G4Xr4/dxsUU+nWpipVUW+h2fUpEcTqTRilHYExOl48ELMfZX81fkxegU
 1zuraQlNnN0UtXpFYmxBUNRZ7zt2LE2itfJjW1ybFlKPkJBtghqqPqB/ChxUJC985Zk8
 /L0NCCQZ8NVqYTyeQnBXm1LKPXkIbTyzIeXduP99mIrpNlXsJLbqQIkN9TeMPggqtUNa
 B5dg==
X-Gm-Message-State: AOAM531i1LDyfSC1It5SaIkYL+7KMytJ3O/74Mu+asBsLO8wgkwnJl3u
 KMukmQjK9HIg2AaywIb1ehlmAFels8FwEw==
X-Google-Smtp-Source: ABdhPJyAhTaGq4g8RGsII+/wbVFPYJomW6XUviSmPu/ADD9eHOd+kItTJb7qAHjyDh/cmFgsABW4nA==
X-Received: by 2002:a2e:7006:: with SMTP id l6mr9000783ljc.453.1593448873702; 
 Mon, 29 Jun 2020 09:41:13 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id o1sm37641lfi.92.2020.06.29.09.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 09:41:13 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/9] char-stdio: add support for the terminal size
Date: Mon, 29 Jun 2020 18:40:38 +0200
Message-Id: <20200629164041.472528-7-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629164041.472528-1-noh4hss@gmail.com>
References: <20200629164041.472528-1-noh4hss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=noh4hss@gmail.com; helo=mail-lj1-x244.google.com
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
Cc: lvivier@redhat.com, berrange@redhat.com, amit@kernel.org, mst@redhat.com,
 Szymon Lukasz <noh4hss@gmail.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the terminal size upon SIGWINCH delivery.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
---
 chardev/char-stdio.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 82eaebc1db..4c3c8a80b6 100644
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
@@ -82,11 +91,26 @@ static void term_stdio_handler(int sig)
     qemu_chr_set_echo_stdio(NULL, stdio_echo_state);
 }
 
+static void qemu_chr_resize_stdio(Chardev *chr)
+{
+    struct winsize ws;
+    if (ioctl(1, TIOCGWINSZ, &ws) != -1) {
+        qemu_chr_resize(chr, ws.ws_col, ws.ws_row);
+    }
+}
+
+static void term_resize_notify(Notifier *n, void *data)
+{
+    StdioChardev *s = container_of(n, StdioChardev, resize_notifier);
+    qemu_chr_resize_stdio(CHARDEV(s));
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
 
@@ -116,6 +140,10 @@ static void qemu_chr_open_stdio(Chardev *chr,
         stdio_allow_signal = opts->signal;
     }
     qemu_chr_set_echo_stdio(chr, false);
+
+    qemu_chr_resize_stdio(chr);
+    s->resize_notifier.notify = term_resize_notify;
+    sigwinch_add_notifier(&s->resize_notifier);
 }
 #endif
 
@@ -155,6 +183,7 @@ static const TypeInfo char_stdio_type_info = {
     .parent = TYPE_CHARDEV_WIN_STDIO,
 #else
     .parent = TYPE_CHARDEV_FD,
+    .instance_size = sizeof(StdioChardev),
 #endif
     .instance_finalize = char_stdio_finalize,
     .class_init = char_stdio_class_init,
-- 
2.27.0


