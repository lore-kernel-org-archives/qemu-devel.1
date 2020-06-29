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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0452C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF40625598
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk67TDwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF40625598
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwrK-00026A-Qm
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqI-0000I6-OZ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:14 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqG-0007ua-HR
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:14 -0400
Received: by mail-lj1-x242.google.com with SMTP id h22so11602146lji.9
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pryqk9SMxJXWHDnBZcX/YYEDZmnhq7KMCQOp0n6/WTc=;
 b=hk67TDwP7/gDiWXaKmau2wsYSDAvhScNlRRGVI1hczkd4Ryk1Kq2CfSoQBIyD6p9YE
 sE9fIV39kA3FHPu3ebQCRl12ydE7vIIBsW8aBiFLhhzeGjud6TaJJleRtJSu9aD46Vgs
 Av5TUZ+qaVArxKWnxYIOK3u98MczMRSzlzkvILhIRzsASbhYUTq9oUdwcg+vkHA7wTXW
 zD6hB/eB/Ad69yaoytVLRrRuc6sDfs+DAgZFdAYXak2Y8IBU+UVyqQOoJ+GISrOXzLpY
 dZSqxbEJSZ1zgTGpz02lydf3ZEYdh7bcRbJ3Pq8DqLQOFk9UnAEj5malb3c4gctulhvg
 itPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Pryqk9SMxJXWHDnBZcX/YYEDZmnhq7KMCQOp0n6/WTc=;
 b=FEtretC3AUZ86iVB3UY0JG3b0UIGBAxBl2o1+iTzHEeBQNA2aYwIpK0RE5irtRFnto
 dJjr6IHKh3uYQV3qDPFMHCU+pAX4p4T1274zahcOXtjZB/po/1RicYKic8V5sH7RbG9b
 WRaQiJhbV0qPLXlNd19gW//uGtrCOnokGY5wb2wbk2tZ13G+f9McLI5fhNF4JodsK+Lu
 k8AzZe2l95aBPhErmrjkRYjQ+g+0Jc2eqJHBzZcwmCSyybD73ps4HvXT+Zt0jzHlOe9e
 9iQCq9IewkjfYe81EaivRIbxAdPYKm04lvGDINCfidiaFtoPG/x2+LtEsZMUieTG2dQP
 8zzQ==
X-Gm-Message-State: AOAM531jy+XHk6+S/AO1gRmIAQjOo9DqjHxutmZBwJCDJ0VYUlN+dZjd
 L6WYklGq0GelfzD+PBLQmYvvD2YyYmKMkw==
X-Google-Smtp-Source: ABdhPJyWoDGWH6afojnoBqQzf5AsKkngJXaaCPLINY0MlqBhqUd0WsLzGqOAdi/bmDIBLtSTbg+YtQ==
X-Received: by 2002:a2e:b55c:: with SMTP id a28mr3933324ljn.42.1593448869100; 
 Mon, 29 Jun 2020 09:41:09 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id o1sm37641lfi.92.2020.06.29.09.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 09:41:08 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/9] chardev: add cols, rows fields
Date: Mon, 29 Jun 2020 18:40:33 +0200
Message-Id: <20200629164041.472528-2-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629164041.472528-1-noh4hss@gmail.com>
References: <20200629164041.472528-1-noh4hss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=noh4hss@gmail.com; helo=mail-lj1-x242.google.com
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

These fields should be interpreted as the size of the terminal connected
to a given chardev.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
---
 chardev/char-fe.c         | 13 +++++++++++++
 include/chardev/char-fe.h | 10 ++++++++++
 include/chardev/char.h    |  1 +
 3 files changed, 24 insertions(+)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index f3530a90e6..27f95bfcdf 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -336,6 +336,19 @@ void qemu_chr_fe_set_echo(CharBackend *be, bool echo)
     }
 }
 
+void qemu_chr_fe_get_winsize(CharBackend *be, uint16_t *cols, uint16_t *rows)
+{
+    Chardev *chr = be->chr;
+
+    if (chr) {
+        *cols = chr->cols;
+        *rows = chr->rows;
+    } else {
+        *cols = 0;
+        *rows = 0;
+    }
+}
+
 void qemu_chr_fe_set_open(CharBackend *be, int fe_open)
 {
     Chardev *chr = be->chr;
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index a553843364..3672b0d97d 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -154,6 +154,16 @@ int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
  */
 void qemu_chr_fe_set_echo(CharBackend *be, bool echo);
 
+/**
+ * qemu_chr_fe_get_winsize:
+ * @cols: the address for storing columns
+ * @rows: the address for storing rows
+ *
+ * Get the size of the terminal connected to the chardev backend.
+ * Returns *cols = *rows = 0, if no associated Chardev.
+ */
+void qemu_chr_fe_get_winsize(CharBackend *be, uint16_t *cols, uint16_t *rows);
+
 /**
  * qemu_chr_fe_set_open:
  *
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 00589a6025..0cea33cb9a 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -65,6 +65,7 @@ struct Chardev {
     char *filename;
     int logfd;
     int be_open;
+    uint16_t cols, rows;
     GSource *gsource;
     GMainContext *gcontext;
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
-- 
2.27.0


