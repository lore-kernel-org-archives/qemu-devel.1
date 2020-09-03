Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA671C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B0E6206CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+Bw11oB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0E6206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwwD-0001zJ-W2
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLT-00047Y-IH; Thu, 03 Sep 2020 17:00:35 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLR-0007fx-Ax; Thu, 03 Sep 2020 17:00:35 -0400
Received: by mail-oi1-x244.google.com with SMTP id e6so4528435oii.4;
 Thu, 03 Sep 2020 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HbS47WUaBPPEuio8+cvg8pxNjw1ZKqWkDcR3X6WFFTw=;
 b=r+Bw11oB7WI5MhRV+Z5dEdiKCXNlWcc+dC/9HH/7jaDsOVwLTuGQU2KLHgqdgqzwxN
 kpVHwkGzeZql599jVO1ughlAX3IPQ/5IaKEqmbIN/oQ1MXFESGwfVZww+6SL+XdSJlez
 /jKqOZa/V6K2wjWDWyoT9HY2wky4j6YK9zoMiL2amwpSAenSfMsDKQ2QMdrsoMSHw7ct
 udSGeCQMTy0EZXbpc3LYjl7HtKg3KJBwgFyfan6SMvmoEAoyz27NTMkrhrDzpz1rP9qh
 Lqs3hugFEv2s9bobvIepIuGuUI9f/9CligwyBDfqeJmADaXRt03NPj0A6xp4k/EBUBBS
 b51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HbS47WUaBPPEuio8+cvg8pxNjw1ZKqWkDcR3X6WFFTw=;
 b=IQKleItYMAh4tJ1AUzl2emP3lhJRppBUceOk+j1inc2/fmHlAohC2qMWGSDxIjPaao
 rIKqXZynOyoOEz5AeSHpJ8FN9uMEMocFqbyY7FYb+dJywaKg/rONKK5Znr+4UpZFeGpA
 oIXgJiTY0K72CnfDHfVl54kbCXk0Rq8HCdTLBrmNCGRAaFayBXE6v9MbUcdrcIWfvsWP
 etetSbczZ34LCNUiS3l+4MAFzJS7V2O4XoFIGrhcbLlDFo/LYOgW4x7Hjxzo6m2CUNPY
 venRCmzSwlN8JZUcys+jniKk48vjNYAe0oXOS9+110mxf+Nt6Yi0wxXUejXJtBvSJLp0
 mxrw==
X-Gm-Message-State: AOAM531TVguPIXGNvn/YgAvRVcY+gTJK19MkA4WCZ6d0D6+ebi13Z4TK
 UvaoldQSpCyGcdeZGlwMTbIWkhQOFLw=
X-Google-Smtp-Source: ABdhPJwmI0ezm+PloNz/xyzsTTmPzD2K527tKEou5niUMlTIg83L6wmUXk3eYAyo0jWY9CoCMt3dIw==
X-Received: by 2002:aca:1716:: with SMTP id j22mr3442432oii.44.1599166828689; 
 Thu, 03 Sep 2020 14:00:28 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id v35sm763455otb.32.2020.09.03.14.00.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:28 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/77] error: Use error_reportf_err() where appropriate
Date: Thu,  3 Sep 2020 15:58:56 -0500
Message-Id: <20200903205935.27832-39-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Replace

    error_report("...: %s", ..., error_get_pretty(err));

by

    error_reportf_err(err, "...: ", ...);

One of the replaced messages lacked a colon.  Add it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200505101908.6207-6-armbru@redhat.com>
(cherry picked from commit 5217f1887a8041c51495fbd5d3f767d96a242000)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 chardev/char-socket.c | 5 +++--
 hw/sd/pxa2xx_mmci.c   | 4 ++--
 hw/sd/sd.c            | 4 ++--
 hw/usb/dev-mtp.c      | 9 +++++----
 qemu-nbd.c            | 7 +++----
 scsi/qemu-pr-helper.c | 4 ++--
 6 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38dda..e5ee685f8c 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -138,8 +138,9 @@ static void check_report_connect_error(Chardev *chr,
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
     if (!s->connect_err_reported) {
-        error_report("Unable to connect character device %s: %s",
-                     chr->label, error_get_pretty(err));
+        error_reportf_err(err,
+                          "Unable to connect character device %s: ",
+                          chr->label);
         s->connect_err_reported = true;
     }
     qemu_chr_socket_restart_timer(chr);
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 8f9ab0ec16..f9c50ddda5 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -497,12 +497,12 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
     carddev = qdev_create(qdev_get_child_bus(dev, "sd-bus"), TYPE_SD_CARD);
     qdev_prop_set_drive(carddev, "drive", blk, &err);
     if (err) {
-        error_report("failed to init SD card: %s", error_get_pretty(err));
+        error_reportf_err(err, "failed to init SD card: ");
         return NULL;
     }
     object_property_set_bool(OBJECT(carddev), true, "realized", &err);
     if (err) {
-        error_report("failed to init SD card: %s", error_get_pretty(err));
+        error_reportf_err(err, "failed to init SD card: ");
         return NULL;
     }
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 71a9af09ab..3c06a0ac6d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -703,13 +703,13 @@ SDState *sd_init(BlockBackend *blk, bool is_spi)
     dev = DEVICE(obj);
     qdev_prop_set_drive(dev, "drive", blk, &err);
     if (err) {
-        error_report("sd_init failed: %s", error_get_pretty(err));
+        error_reportf_err(err, "sd_init failed: ");
         return NULL;
     }
     qdev_prop_set_bit(dev, "spi", is_spi);
     object_property_set_bool(obj, true, "realized", &err);
     if (err) {
-        error_report("sd_init failed: %s", error_get_pretty(err));
+        error_reportf_err(err, "sd_init failed: ");
         return NULL;
     }
 
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 20717f026b..168428156b 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -631,8 +631,9 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
         int64_t id = qemu_file_monitor_add_watch(s->file_monitor, o->path, NULL,
                                                  file_monitor_event, s, &err);
         if (id == -1) {
-            error_report("usb-mtp: failed to add watch for %s: %s", o->path,
-                         error_get_pretty(err));
+            error_reportf_err(err,
+                              "usb-mtp: failed to add watch for %s: ",
+                              o->path);
             error_free(err);
         } else {
             trace_usb_mtp_file_monitor_event(s->dev.addr, o->path,
@@ -1276,8 +1277,8 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
 
         s->file_monitor = qemu_file_monitor_new(&err);
         if (err) {
-            error_report("usb-mtp: file monitoring init failed: %s",
-                         error_get_pretty(err));
+            error_reportf_err(err,
+                              "usb-mtp: file monitoring init failed: ");
             error_free(err);
         } else {
             QTAILQ_INIT(&s->events);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 306e44fb0a..d2657b8db5 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -856,8 +856,7 @@ int main(int argc, char **argv)
         }
         tlscreds = nbd_get_tls_creds(tlscredsid, list, &local_err);
         if (local_err) {
-            error_report("Failed to get TLS creds %s",
-                         error_get_pretty(local_err));
+            error_reportf_err(local_err, "Failed to get TLS creds: ");
             exit(EXIT_FAILURE);
         }
     } else {
@@ -983,8 +982,8 @@ int main(int argc, char **argv)
                                              &local_err);
             if (sioc == NULL) {
                 object_unref(OBJECT(server));
-                error_report("Failed to use socket activation: %s",
-                             error_get_pretty(local_err));
+                error_reportf_err(local_err,
+                                  "Failed to use socket activation: ");
                 exit(EXIT_FAILURE);
             }
             qio_net_listener_add(server, sioc);
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 181ed4a186..57ad830d54 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -1030,8 +1030,8 @@ int main(int argc, char **argv)
         server_ioc = qio_channel_socket_new_fd(FIRST_SOCKET_ACTIVATION_FD,
                                                &local_err);
         if (server_ioc == NULL) {
-            error_report("Failed to use socket activation: %s",
-                         error_get_pretty(local_err));
+            error_reportf_err(local_err,
+                              "Failed to use socket activation: ");
             exit(EXIT_FAILURE);
         }
     }
-- 
2.17.1


