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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F3FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743CF2559C
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So5lf5af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743CF2559C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwtK-0005bv-Ng
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqI-0000Hy-1Z
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:14 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <noh4hss@gmail.com>) id 1jpwqG-0007uq-5L
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:41:13 -0400
Received: by mail-lj1-x243.google.com with SMTP id d17so4080076ljl.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FzqnRuMT+XuVpao3SBx7aexWUtl8wLkCabLBdf8t04I=;
 b=So5lf5afJ5W8x7xKTGXkrHCWcEQCr8GROvR+s6W26BNjRfb1eepoI1h1fAbcKwNWpY
 6pE6U4PGvh8lZtHZGn21Z3PRn2Z92Y6fH1kRBvmRJCh4IfFb2SyVazaCePIx12WbVF5v
 OgklT7AYPMxyPEJlI5JOXntqeYjNE83+91zfGFQYvqreG4grBig0DCZACxgdVZn2nFLO
 Jc8dHpR5BM8NlNM/UJSHMb/9aW7KiQD5Bc7zbEe8o2ESfPWebXHqloie2cv0goPlFhH/
 sNhEA8r8UMvIDmC5dNoVCcFqWpDqZJTJ8UzBD/61lRUPI9xslxU213+m/nPhIazp5saU
 Zbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FzqnRuMT+XuVpao3SBx7aexWUtl8wLkCabLBdf8t04I=;
 b=SZDETOMM9PTyc3GvirE4hAh97ilXRfNAWLmhgwPND8d0PEatPE2DLx/UykDCpbzsFx
 DRWrCSwfCYjdz15VZ2QuqmtyGhRk+9qobzXM2K/1WQ+U0HZCNvPkhtqPAF1yXXA8y+Lz
 b7vR0aheFzL+YBqLvAOKLTB8De/TAoCWqhmMrEsggqxREr08D2ffFZ8nsnD0N3AW84gA
 suBuO4EwKSqL6Lk+qVcZjTlaAnrqax8dq9lfXU3EaYjU/sxPpfL8PXTXB2UtT46KtUDy
 IgtkePrqArlExOSrUIbX5Fqjv2PVss0c9vogzFMGYCMKx+g1Sv94yv9L9ovkimD8pAjF
 SnaQ==
X-Gm-Message-State: AOAM530SkD7WBZ9fyZEAP4StH/9UDemDmSXoZR144N6QICRS6Xsqk3JK
 a2HRQHjqVPJRbtopp3lNqEq+rw4sW/g/aw==
X-Google-Smtp-Source: ABdhPJxTAVIplwOhtdvRrkIMTarq8D2efEMYZcdrdKVWaELkTi+QB1KiRvZ2DpCPXOfzf1LrFAX6Bw==
X-Received: by 2002:a2e:9857:: with SMTP id e23mr4450018ljj.411.1593448870151; 
 Mon, 29 Jun 2020 09:41:10 -0700 (PDT)
Received: from localhost.localdomain (193-239-39-51.ksi-system.net.
 [193.239.39.51])
 by smtp.gmail.com with ESMTPSA id o1sm37641lfi.92.2020.06.29.09.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 09:41:09 -0700 (PDT)
From: Szymon Lukasz <noh4hss@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/9] chardev: add CHR_EVENT_RESIZE
Date: Mon, 29 Jun 2020 18:40:34 +0200
Message-Id: <20200629164041.472528-3-noh4hss@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629164041.472528-1-noh4hss@gmail.com>
References: <20200629164041.472528-1-noh4hss@gmail.com>
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
Cc: lvivier@redhat.com, berrange@redhat.com, amit@kernel.org, mst@redhat.com,
 Szymon Lukasz <noh4hss@gmail.com>, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new chardev event, CHR_EVENT_RESIZE, which a backend should
trigger if detects the size of the connected terminal changed.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
---
 backends/cryptodev-vhost-user.c | 1 +
 chardev/char.c                  | 1 +
 hw/block/vhost-user-blk.c       | 1 +
 hw/char/terminal3270.c          | 1 +
 hw/char/virtio-console.c        | 1 +
 hw/ipmi/ipmi_bmc_extern.c       | 1 +
 hw/usb/ccid-card-passthru.c     | 1 +
 hw/usb/dev-serial.c             | 1 +
 hw/usb/redirect.c               | 1 +
 include/chardev/char.h          | 4 ++++
 monitor/hmp.c                   | 1 +
 monitor/qmp.c                   | 1 +
 net/vhost-user.c                | 1 +
 13 files changed, 16 insertions(+)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 8b8cbc4223..bbf8ad426a 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -174,6 +174,7 @@ static void cryptodev_vhost_user_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/chardev/char.c b/chardev/char.c
index e3051295ac..904f8bf6e3 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -74,6 +74,7 @@ void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index a00b854736..1a656a27c3 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -403,6 +403,7 @@ static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 2c47ebf007..eadccbb617 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -169,6 +169,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 4f46753ea3..97b9240ef5 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -165,6 +165,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index f9a13e0a44..9562584309 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -439,6 +439,7 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index bb325dbc4a..3c26b16ed0 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -321,6 +321,7 @@ static void ccid_card_vscard_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
     case CHR_EVENT_CLOSED:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 7e50e3ba47..e8e960d0e6 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -507,6 +507,7 @@ static void usb_serial_event(void *opaque, QEMUChrEvent event)
             break;
         case CHR_EVENT_MUX_IN:
         case CHR_EVENT_MUX_OUT:
+        case CHR_EVENT_RESIZE:
             /* Ignore */
             break;
     }
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 417a60a2e6..b716c4fdd7 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1383,6 +1383,7 @@ static void usbredir_chardev_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 0cea33cb9a..42203e9fa4 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -22,6 +22,10 @@ typedef enum {
     CHR_EVENT_OPENED, /* new connection established */
     CHR_EVENT_MUX_IN, /* mux-focus was set to this terminal */
     CHR_EVENT_MUX_OUT, /* mux-focus will move on */
+    CHR_EVENT_RESIZE, /*
+                       * the size of the terminal connected to
+                       * the chardev changed
+                       */
     CHR_EVENT_CLOSED /* connection closed.  NOTE: currently this event
                       * is only bound to the read port of the chardev.
                       * Normally the read port and write port of a
diff --git a/monitor/hmp.c b/monitor/hmp.c
index d598dd02bb..020be03d61 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1373,6 +1373,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
         break;
 
     case CHR_EVENT_BREAK:
+    case CHR_EVENT_RESIZE:
         /* Ignored */
         break;
     }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index d433ceae5b..58aecb475b 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -371,6 +371,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 17532daaf3..e30cbe74bd 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -297,6 +297,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
     case CHR_EVENT_MUX_OUT:
+    case CHR_EVENT_RESIZE:
         /* Ignore */
         break;
     }
-- 
2.27.0


