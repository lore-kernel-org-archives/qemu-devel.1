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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB12DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1B925598
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq56aqrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1B925598
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwrL-00025J-R7
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqJ-0000IY-Ck
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:15 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:45937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqH-0007v3-PF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:15 -0400
Received: by mail-lj1-x244.google.com with SMTP id t25so14187343lji.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qIOYbuvilU4Digqleh4xnQWueJUIUIR9yScgMm3N+yw=;
 b=Qq56aqrgJSwHYHolUoT6MMfPYS41rRSJ5G8D7yc77fTOszfh6lmmoCfu2KwpwyIURY
 eQmFG69KEOcxGPerD93wrOK87WTJGa1nH2SkOfdEDO+Igzm/JpGo42kbUzlv5PIyjG/w
 guF+PtU2LuBsYp7eb6TCcweaJ515J9CxFbg/VaEfWTNgBydM88eI6sapsLx5TpJ5FlxM
 T9FZSxjClZrptJfxpWz4bqVX80W42uVvTCx3OmTVCdk3rx5y7ZF4A95W/MZtUdx9VICq
 Qi2t8i4dhQphn9PDvq6/swdDY7B7t67TUnhzTAS8Ac4fFJkMrkuEvq9ox0RG7NiSoh7q
 jKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qIOYbuvilU4Digqleh4xnQWueJUIUIR9yScgMm3N+yw=;
 b=hCgThAjYV9tI+gW9buU4sK+Lb7YMyQkxfr+smBXvt5VsS06GxnuCYoOSoaASd5eGfY
 rrHi/W44ek0BkW2dqtoir0q1sA+p1fp0I2UvbXaWm+xFyPOElIxAunjKd2s6RO42Y18P
 +oncFCLwCPHLRvNXbDzuyAwiOHuFyYMTrXuGRj0rCyMwnw6Ans2VUyi21Az8HIAmzFuu
 guDOoNxRdtTRXtvQLcc7zMjz4tioLoNvlKBQdoB515sKky1cpy7sBSL0nHq0+T92HiRl
 jfRxCfnIRQ0AZ6p/ni5JtEDiqpwLRKmG7HJkhujVCiV+iMD2YZ3ukXsYgvsfJb64zsht
 nfKA==
X-Gm-Message-State: AOAM53086mi21kILOLpXGtPFlrjtOojB/y+B7QQ+sfqX29AoLz2Zo+sP
 t7M4KfcPar3/b1PyEpWuLUQXrON9HiUYnw==
X-Google-Smtp-Source: ABdhPJxIcoI6+rjA6UE46chYve5jNzwvXR8SibuIldCU5D3T/7ssoa6o4tZ5qzKuQxnNFCrVnVShHg==
X-Received: by 2002:a2e:b0fa:: with SMTP id h26mr8076038ljl.148.1593448871855; 
 Mon, 29 Jun 2020 09:41:11 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id o1sm37641lfi.92.2020.06.29.09.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 09:41:11 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] char-mux: add support for the terminal size
Date: Mon, 29 Jun 2020 18:40:36 +0200
Message-Id: <20200629164041.472528-5-noh4hss@gmail.com>
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

The terminal size of a mux chardev should be the same as the real
chardev, so listen for CHR_EVENT_RESIZE to be up to date.

We forward CHR_EVENT_RESIZE only to the focused frontend. This means
frontends should probably update their view of the terminal size on
receiving CHR_EVENT_MUX_IN.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
---
 chardev/char-mux.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 46c44af67c..fa81f8341e 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -247,9 +247,24 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
     }
 }
 
+static void mux_update_winsize(Chardev *chr)
+{
+    MuxChardev *d = MUX_CHARDEV(chr);
+    uint16_t cols, rows;
+
+    qemu_chr_fe_get_winsize(&d->chr, &cols, &rows);
+    qemu_chr_resize(chr, cols, rows);
+}
+
 static void mux_chr_event(void *opaque, QEMUChrEvent event)
 {
-    mux_chr_send_all_event(CHARDEV(opaque), event);
+    Chardev *chr = CHARDEV(opaque);
+
+    if (event == CHR_EVENT_RESIZE) {
+        mux_update_winsize(chr);
+    } else {
+        mux_chr_send_all_event(chr, event);
+    }
 }
 
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
@@ -330,6 +345,7 @@ static void qemu_chr_open_mux(Chardev *chr,
      */
     *be_opened = machine_init_done;
     qemu_chr_fe_init(&d->chr, drv, errp);
+    mux_update_winsize(chr);
 }
 
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
-- 
2.27.0


