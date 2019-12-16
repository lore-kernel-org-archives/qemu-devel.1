Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC1CC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08751206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4Sxo5E0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08751206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igu7m-0001EF-BK
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFk-0005zY-Oe
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFj-0000dj-EO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:48 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:35078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFi-0000ZF-T2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:47 -0500
Received: by mail-wr1-x430.google.com with SMTP id g17so8055670wro.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r5/ahDGycmBC2HKaQApweAbQRGj/Zbq759doBFgj9aU=;
 b=n4Sxo5E0kIJMUcgArRNPV5sb3ghi+VsNaFvnC0ZcUkhLX9My0VKc4Nonf0Pyjjv7no
 T41Rb9T8xWYmwSq5DiRwrDOD7nX/lNAtp9HVIMSYqzxxYjHDK/vjCZ1LgYsjOeyRTTDI
 uM8OEOeBl6c9rmwNsfEhDdmFOTCzdurAckDrP4rgRmyrbkvroBel3FXxs9DO/D+gUevy
 bHlwqLyri1nGk87ZstSedRH3/KhFyAPtr2Tg6Cvb8MOA5xauI73AIu9zi127q+IZ6GU2
 FrXNYBV+J+s+BEUUEYI2o8sO2MFuc1ZbUu2QuzkuqXIrmzucY3vAcXDpMNQ8Vxe3h0U+
 cvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=r5/ahDGycmBC2HKaQApweAbQRGj/Zbq759doBFgj9aU=;
 b=QEOO4zKZCFQ6aDfzHOchgUBtqbQQrpYYMTpn441RchKHJmp+8gUszyLGvvVytLyD6+
 mbL5ujg/i9lSZFvdlDQtF35E/JnsDbcNL9vbswH5lhQJYq5Bn5ffVKu5p6vnBlbkFPpG
 IXcpRaxrGVQbMAjedp4WODWcA/OxxB8apkMLBtJQdIHcxjEjwRlWkd0QsTdzj12II0+a
 8bRkPDkaGQ8W/oCQR7F8o2JStble8sOibWchOllwlEawcoYt+CWYDtvVL/n+wiWwYW2K
 Ev4b0Vl91/vSz73a/aV2o+K8pimX/04xS7sUk0NyHBrjobhmQ1o0XwLQxjS6kzIur6rg
 Q0Hw==
X-Gm-Message-State: APjAAAW6E4C8QsxTukX/YicJyAqHOupS2y/wQPNwZmDMocQJ9Nk79km9
 1tLFT+UEdBNscKA4fm5PMIYJiAZS
X-Google-Smtp-Source: APXvYqxsdF0lPan4MpsQ8zFWwYIt0B9hgubvbDVO2bOfxDxO73LGC2M/8NkBSQCdAlNgO09FYS9Pfg==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr31119255wrp.322.1576513784651; 
 Mon, 16 Dec 2019 08:29:44 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 57/62] hw/i386/pc: Inline port92_init()
Date: Mon, 16 Dec 2019 17:28:41 +0100
Message-Id: <1576513726-53700-58-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This one-line function is not very helpful, so remove it
by inlining the call to qdev_connect_gpio_out_named().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8752840..963eff4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -707,11 +707,6 @@ static uint64_t port92_read(void *opaque, hwaddr addr,
     return ret;
 }
 
-static void port92_init(ISADevice *dev, qemu_irq a20_out)
-{
-    qdev_connect_gpio_out_named(DEVICE(dev), PORT92_A20_LINE, 0, a20_out);
-}
-
 static const VMStateDescription vmstate_port92_isa = {
     .name = "port92",
     .version_id = 1,
@@ -767,8 +762,8 @@ static void port92_class_initfn(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_port92_isa;
     /*
      * Reason: unlike ordinary ISA devices, this one needs additional
-     * wiring: its A20 output line needs to be wired up by
-     * port92_init().
+     * wiring: its A20 output line needs to be wired up with
+     * qdev_connect_gpio_out_named().
      */
     dc->user_creatable = false;
 }
@@ -1279,7 +1274,8 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
 
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
     i8042_setup_a20_line(i8042, a20_line[0]);
-    port92_init(port92, a20_line[1]);
+    qdev_connect_gpio_out_named(DEVICE(port92),
+                                PORT92_A20_LINE, 0, a20_line[1]);
     g_free(a20_line);
 }
 
-- 
1.8.3.1



