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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1B4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C062559A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="psZD/KCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C062559A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwtG-0005cM-SN
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqO-0000TU-MG
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:20 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqM-0007vz-Hq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:20 -0400
Received: by mail-lj1-x244.google.com with SMTP id f5so2872540ljj.10
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lxRZU+ONjViNlnT9aeawgp2hWsb4PWJp8EM9YziKpEc=;
 b=psZD/KCrAxEwzTi6rVTwzyiJHNDg6NSFsnHzCsPBrcmp765C1ef2RNv1zNGY6FFclV
 qJ8owjNWHQ7VbjKSFuLlnuHZhehIedW4JVotmmXpAX0aD8pT9txQZtlaqERa7iE+Z9yy
 TcEXh+sXIiThs3xAmL+zro7tQkpNhbwYL9SuofwtAWKZwspx7DcVF/a0EhWC6hFeem7H
 zOaPRY/ncDq4gnEHwunk50TsAwQ9dZ0b63KI6pNjiyGtcwKcUonlGH5v4tQiI6fhPnwR
 Lg4vnJVvJ3W7Y9RqojT0WgSnC99JVmwf+5YEsP0quxdZfqXwqZ4EcM1tmvyO1j7UEeYt
 V3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lxRZU+ONjViNlnT9aeawgp2hWsb4PWJp8EM9YziKpEc=;
 b=FUWwxEvuSdfB2QQJkL1Ta5evEzB7jAFvSnUDiHUCwC80eealfqsWrtIttpK+cdV1nX
 lIdKK1D14PGWnnixwW154UdtL5Mv3/snYfqIMFCc4L+jhDqgEBAhZ3nnPUh19owo7qGL
 3GOeJiuFEFE8Tj5WKq9HCl7RaExEnQEPhhESNjFcyI1CfXj0bBeT+cQ81lUkXugaro65
 O/hP6gmwSpjyomy1F9XukjGvSHvSp37essKcOb+d7JHYhkoPY7SSJU1+XLg0SEbVmlA/
 M1MrTF6CBsyPCT2iKb7rPGW8J2FKQA0IGFPmntANBIlnvQ0pJHC4vI16rAQ/PcYC56Ee
 dAYQ==
X-Gm-Message-State: AOAM532jI6S2OreTWe1s6jlWOxeAeO/btORktB/6wnr+D07zdeQ6tpd6
 ThEIBZsGudXmUBVrqFnrouCTUwBXVn0h8Q==
X-Google-Smtp-Source: ABdhPJx4JZyHB5X7x4LBUxKub8f+FBsV3RuP4OqpI2RxrTGRp/UhRm+OLNS30h4VBpyZAibhFjUZPQ==
X-Received: by 2002:a2e:8ed3:: with SMTP id e19mr8852615ljl.72.1593448876595; 
 Mon, 29 Jun 2020 09:41:16 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id o1sm37641lfi.92.2020.06.29.09.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 09:41:16 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 9/9] virtio-console: notify the guest about terminal resizes
Date: Mon, 29 Jun 2020 18:40:41 +0200
Message-Id: <20200629164041.472528-10-noh4hss@gmail.com>
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

If a virtio serial port is a console port forward terminal resize
messages from the chardev backend to the guest.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
---
 hw/char/virtio-console.c | 62 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 97b9240ef5..c4c2c7a844 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -29,6 +29,7 @@ typedef struct VirtConsole {
 
     CharBackend chr;
     guint watch;
+    uint16_t cols, rows;
 } VirtConsole;
 
 /*
@@ -104,6 +105,33 @@ static ssize_t flush_buf(VirtIOSerialPort *port,
     return ret;
 }
 
+static void virtconsole_send_resize(VirtIOSerialPort *port)
+{
+    uint16_t cols, rows;
+    VirtConsole *vcon = VIRTIO_CONSOLE(port);
+
+    /*
+     * We probably shouldn't send these messages before
+     * we told the guest it is a console port (which we do
+     * by sending VIRTIO_CONSOLE_CONSOLE_PORT message).
+     * Instead of adding a new field to the device state
+     * lets just use the guest_connected field for that purpose
+     * since the guest should not care about the terminal size
+     * before opening the port.
+     */
+    if (!port->guest_connected) {
+        return;
+    }
+
+    qemu_chr_fe_get_winsize(&vcon->chr, &cols, &rows);
+
+    if (cols != vcon->cols || rows != vcon->rows) {
+        vcon->cols = cols;
+        vcon->rows = rows;
+        virtio_serial_send_console_resize(port, cols, rows);
+    }
+}
+
 /* Callback function that's called when the guest opens/closes the port */
 static void set_guest_connected(VirtIOSerialPort *port, int guest_connected)
 {
@@ -111,7 +139,9 @@ static void set_guest_connected(VirtIOSerialPort *port, int guest_connected)
     DeviceState *dev = DEVICE(port);
     VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
 
-    if (!k->is_console) {
+    if (k->is_console) {
+        virtconsole_send_resize(port);
+    } else {
         qemu_chr_fe_set_open(&vcon->chr, guest_connected);
     }
 
@@ -171,6 +201,23 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     }
 }
 
+static void chr_event_console(void *opaque, QEMUChrEvent event)
+{
+    VirtConsole *vcon = opaque;
+    VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(vcon);
+
+    trace_virtio_console_chr_event(port->id, event);
+    switch (event) {
+    case CHR_EVENT_OPENED:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_RESIZE:
+        virtconsole_send_resize(port);
+        break;
+    default:
+        break;
+    }
+}
+
 static int chr_be_change(void *opaque)
 {
     VirtConsole *vcon = opaque;
@@ -179,7 +226,9 @@ static int chr_be_change(void *opaque)
 
     if (k->is_console) {
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                 NULL, chr_be_change, vcon, NULL, true);
+                                 chr_event_console, chr_be_change,
+                                 vcon, NULL, true);
+        virtconsole_send_resize(port);
     } else {
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
                                  chr_event, chr_be_change, vcon, NULL, false);
@@ -207,7 +256,7 @@ static void virtconsole_enable_backend(VirtIOSerialPort *port, bool enable)
         VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
 
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                 k->is_console ? NULL : chr_event,
+                                 k->is_console ? chr_event_console : chr_event,
                                  chr_be_change, vcon, NULL, false);
     } else {
         qemu_chr_fe_set_handlers(&vcon->chr, NULL, NULL, NULL,
@@ -227,6 +276,11 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (k->is_console) {
+        vcon->cols = (uint16_t) -1;
+        vcon->rows = (uint16_t) -1;
+    }
+
     if (qemu_chr_fe_backend_connected(&vcon->chr)) {
         /*
          * For consoles we don't block guest data transfer just
@@ -239,7 +293,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
          */
         if (k->is_console) {
             qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                     NULL, chr_be_change,
+                                     chr_event_console, chr_be_change,
                                      vcon, NULL, true);
             virtio_serial_open(port);
         } else {
-- 
2.27.0


