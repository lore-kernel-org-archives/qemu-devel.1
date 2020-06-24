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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20148C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC132088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtwXG4ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC132088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3fz-0002Pw-Tx
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jo3Yo-0006wk-Ct
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:27:22 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jo3Ym-00077R-Gj
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:27:22 -0400
Received: by mail-lj1-x243.google.com with SMTP id h19so2089270ljg.13
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 04:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9gdYmHKQollDgqMy022aRxiAZpeq1ES9ZENq0OBDOxo=;
 b=dtwXG4ml3afbwCJkZEmuWBn6Mny+IhgGCUvQA9X/iqL8dsZSGQ72aojqJryX3DY6hP
 ZpOyQZfoPXH3jeIt6sSiFvIWlO1kFnao2U5vaW3elWKB8oORBeFrsTKwExGWq4wQkW62
 NiV8v6MxuF9pf4/CrbFnhoXd142k6s8Hz3WFeyaU0DYvjshby78Xpb6K6uHEE2l8p9F9
 XgKTmM4/hVXv/gppYDBjhZIZxb7TSRz7DmvCVK9q9g2kJLKJtjh19g5ZKXmVsSTMnXcc
 EtS1Ex8FdNhyhsaatI2AFMoWYgrQSF1EV9lkTAKZSwxrWwR1UdzE7CX0v611IIraEXCw
 kR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9gdYmHKQollDgqMy022aRxiAZpeq1ES9ZENq0OBDOxo=;
 b=TiiILNEhtq3rAvARX1zvyubxbdWFxg6y84izdOHA+/q+mA9xeEYxcBSRjYBTB9rQZi
 ES0Zjg/ttkBqXKpRYwDhtJVHDJsSO9VeAkwAviCxBugY2ENuLcDvDI/ud4LtJzLRqWW4
 oLEyyumjkqwCFJL63bySO3eDKv+yZlL7BXLCkODySxSadgv/OTpHQXm+9ej+r0/Fp2zU
 aWSFIEhU6uDweUIIoAvn8xFZLJprIpRJzk0ay7QIg26sYwE+YdDlfEYTi+WVOUgKVAh9
 2V3gXc5+46ME4uQL//Jd4kZSSHIX6BFS1ZcB56vADsS12trlSgjIuXrhtdEfC0Kfgq6r
 LBng==
X-Gm-Message-State: AOAM532Ow93WYkiIMqaZ5wXP4r03lLgHDbVj37I4pKbJQ4LG33fURjCH
 WJkaevK2aFNn98B9WxTY/xN07JrK1ys9yw==
X-Google-Smtp-Source: ABdhPJzw8tOKy2PfYDye0AyRmpS8qZeka+0KUMEXYj/XEQ3q3zQDCrrTq2epymhElEFi2E6nvbelXA==
X-Received: by 2002:a2e:958c:: with SMTP id w12mr10268851ljh.457.1592998033681; 
 Wed, 24 Jun 2020 04:27:13 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id d6sm1202635lja.77.2020.06.24.04.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 04:27:13 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] virtio-serial-bus: add terminal resize messages
Date: Wed, 24 Jun 2020 13:26:39 +0200
Message-Id: <20200624112640.82673-6-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200624112640.82673-1-noh4hss@gmail.com>
References: <20200624112640.82673-1-noh4hss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=noh4hss@gmail.com; helo=mail-lj1-x243.google.com
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

Implement the part of the virtio spec that allows to notify the virtio
driver about terminal resizes. The virtio spec contains two methods to
achieve that:

For legacy drivers, we have only one port and we put the terminal size
in the config space and inject the config changed interrupt.

For multiport devices, we use the control virtqueue to send a packet
containing the terminal size. Note that the Linux kernel expects
the fields indicating the number of rows and columns in a packet to be
in a different order than the one specified in the current version of
the virtio spec. We follow the Linux implementation, so hopefully there
is no implementation of this functionality conforming to the spec.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
---
 hw/char/trace-events              |  1 +
 hw/char/virtio-serial-bus.c       | 42 +++++++++++++++++++++++++++++--
 hw/core/machine.c                 |  1 +
 include/hw/virtio/virtio-serial.h |  5 ++++
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/hw/char/trace-events b/hw/char/trace-events
index d20eafd56f..be40df47ea 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -10,6 +10,7 @@ serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
 
 # virtio-serial-bus.c
 virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
+virtio_serial_send_console_resize(unsigned int port, uint16_t cols, uint16_t rows) "port %u, cols %u, rows %u"
 virtio_serial_throttle_port(unsigned int port, bool throttle) "port %u, throttle %d"
 virtio_serial_handle_control_message(uint16_t event, uint16_t value) "event %u, value %u"
 virtio_serial_handle_control_message_port(unsigned int port) "port %u"
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 262089c0c9..6d9e94a64e 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -261,6 +261,42 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
     return send_control_msg(vser, &cpkt, sizeof(cpkt));
 }
 
+/*
+ * This struct should be added to the Linux kernel uapi headers
+ * and later imported to standard-headers/linux/virtio_console.h
+ */
+struct virtio_console_resize {
+    __virtio16 rows;
+    __virtio16 cols;
+};
+
+void virtio_serial_send_console_resize(VirtIOSerialPort *port,
+                                       uint16_t cols, uint16_t rows)
+{
+    VirtIOSerial *vser = port->vser;
+    VirtIODevice *vdev = VIRTIO_DEVICE(vser);
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
+        struct {
+            struct virtio_console_control control;
+            struct virtio_console_resize resize;
+        } buffer;
+
+        virtio_stl_p(vdev, &buffer.control.id, port->id);
+        virtio_stw_p(vdev, &buffer.control.event, VIRTIO_CONSOLE_RESIZE);
+        virtio_stw_p(vdev, &buffer.resize.cols, cols);
+        virtio_stw_p(vdev, &buffer.resize.rows, rows);
+
+        trace_virtio_serial_send_console_resize(port->id, cols, rows);
+        send_control_msg(vser, &buffer, sizeof(buffer));
+
+    } else if (virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)) {
+        vser->port0_cols = cols;
+        vser->port0_rows = rows;
+        virtio_notify_config(vdev);
+    }
+}
+
 /* Functions for use inside qemu to open and read from/write to ports */
 int virtio_serial_open(VirtIOSerialPort *port)
 {
@@ -572,8 +608,8 @@ static void get_config(VirtIODevice *vdev, uint8_t *config_data)
     struct virtio_console_config *config =
         (struct virtio_console_config *)config_data;
 
-    config->cols = 0;
-    config->rows = 0;
+    config->cols = virtio_tswap16(vdev, vser->port0_cols);
+    config->rows = virtio_tswap16(vdev, vser->port0_rows);
     config->max_nr_ports = virtio_tswap32(vdev,
                                           vser->serial.max_virtserial_ports);
 }
@@ -1168,6 +1204,8 @@ static Property virtio_serial_properties[] = {
                                                   31),
     DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
                       VIRTIO_CONSOLE_F_EMERG_WRITE, true),
+    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
+                      VIRTIO_CONSOLE_F_SIZE, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1d80ab0e1d..c370c220f0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,6 +30,7 @@
 
 GlobalProperty hw_compat_5_0[] = {
     { "virtio-balloon-device", "page-poison", "false" },
+    { "virtio-serial-device", "console-size", "off" },
 };
 const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
 
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index ed3e916b68..1d6436c0b1 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -188,6 +188,8 @@ struct VirtIOSerial {
     virtio_serial_conf serial;
 
     uint64_t host_features;
+
+    uint16_t port0_cols, port0_rows;
 };
 
 /* Interface to the virtio-serial bus */
@@ -222,6 +224,9 @@ size_t virtio_serial_guest_ready(VirtIOSerialPort *port);
  */
 void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle);
 
+void virtio_serial_send_console_resize(VirtIOSerialPort *port,
+                                       uint16_t cols, uint16_t rows);
+
 #define TYPE_VIRTIO_SERIAL "virtio-serial-device"
 #define VIRTIO_SERIAL(obj) \
         OBJECT_CHECK(VirtIOSerial, (obj), TYPE_VIRTIO_SERIAL)
-- 
2.27.0


