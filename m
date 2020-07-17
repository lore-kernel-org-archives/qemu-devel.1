Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A5DC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64ADC206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpUHfQbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64ADC206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUxM-0003gU-Kh
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 14:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwUvP-0001RJ-4H; Fri, 17 Jul 2020 14:17:36 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:46432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwUvJ-0003bF-JV; Fri, 17 Jul 2020 14:17:30 -0400
Received: by mail-ej1-x642.google.com with SMTP id p20so11778702ejd.13;
 Fri, 17 Jul 2020 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nzFhmkSqGf1oDZl+jiwOY4DloBjzpiJ1wUhX47KxMdg=;
 b=MpUHfQbP9F/HU7jGj3mjoUAH+iTne0UD+Je7BN5TO2tQeWuXsDLhZV7sU2OYW7ypdw
 9JClB19B84ELTTb7e9PWFf8JaDtp1TOo9ZmuVKDisuRA9OwbIxigVdSFAO9Ol3S7ezxU
 hJBEWjH4EB6PsFyM9EmOgnQke8PK8nY5XP0A+uIi0J2qMvl80hFMFpd1Vxfla2C7umir
 89yNz68i9kobKUF4QLx7Guaeeyg5/7mbjlIw1BZjkLigfFoZ6pzw1MPDSNyUkoymhTpa
 7i62qmktP+gtWmxI06t+6AJ5vbf0j+5irhWCwVn5JmPF6XWhkwbs7Re9YCzP4LwzYWtj
 Dytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=nzFhmkSqGf1oDZl+jiwOY4DloBjzpiJ1wUhX47KxMdg=;
 b=bmfpSfT8jwMwO1/uqeUtp1N+aITLQokTED3bV48vyMA0Hbx+btKLprKk+mb86VR33N
 pPTgUe2hQDugCMwj2I3iuo4DUITB2lnUBjXEz3Xlsh/MVVMtpjO61ckU9s/E5o4JLuwO
 1qu/ITGCLKD6TmCcOQB8rtlF4I38Abo28MgbSn5S68XMBCwJXQi3R3ozBvicxDKnFV2f
 l+wU20zBSVPgAigdAS7SOi7K01RpkDyOBeZH8P7N5EyoCdyOQXzkcVTyP9W1fgbsJ68O
 73YvcFaunIZPbzLL7yJy/Fxpj/5NA96+j2dBBXcs/GDQbskjiMr7gnd1sQl7t6eko7jh
 K6FA==
X-Gm-Message-State: AOAM531gCa81jA+3wqKBfiTGJ186nVrRAW/yIDRFzS22/vNC/lm6w1Ef
 oe+RhxDPwwvNtNNY2LtVHn/uU/8Sth0=
X-Google-Smtp-Source: ABdhPJxF72H7y7WYTHPH/ORKA0MGIkRbLfwlrapbxX2SEeEfqzw0xCEyoFZdWNM7FSjCxI3RcGEvsQ==
X-Received: by 2002:a17:906:53d4:: with SMTP id
 p20mr9658940ejo.472.1595009846845; 
 Fri, 17 Jul 2020 11:17:26 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t25sm8432269ejc.34.2020.07.17.11.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 11:17:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.1] hw/pci-host/q35: Ignore write of reserved
 PCIEXBAR LENGTH field
Date: Fri, 17 Jul 2020 20:17:24 +0200
Message-Id: <20200717181724.27493-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libFuzzer triggered the following assertion:

  cat << EOF | qemu-system-i386 -M pc-q35-5.0 \
    -nographic -monitor none -serial none \
    -qtest stdio -d guest_errors -trace pci\*
  outl 0xcf8 0xf2000060
  outl 0xcfc 0x8400056e
  EOF
  pci_cfg_write mch 00:0 @0x60 <- 0x8400056e
  Aborted (core dumped)

This is because guest wrote MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD
(reserved value) to the PCIE XBAR register.

There is no indication on the datasheet about what occurs when
this value is written. Simply ignore it on QEMU (and report an
guest error):

  pci_cfg_write mch 00:0 @0x60 <- 0x8400056e
  Q35: Reserved PCIEXBAR LENGTH
  pci_cfg_read mch 00:0 @0x0 -> 0x8086
  pci_cfg_read mch 00:0 @0x0 -> 0x29c08086
  ...

Cc: qemu-stable@nongnu.org
Reported-by: Alexander Bulekov <alxndr@bu.edu>
BugLink: https://bugs.launchpad.net/qemu/+bug/1878641
Fixes: df2d8b3ed4 ("q35: Introduce q35 pc based chipset emulator")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because I have no idea how to propagate the error.
---
 hw/pci-host/q35.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index b67cb9c29f..a3f839570d 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/i386/pc.h"
 #include "hw/pci-host/q35.h"
 #include "hw/qdev-properties.h"
@@ -318,8 +319,8 @@ static void mch_update_pciexbar(MCHPCIState *mch)
         addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
         break;
     case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD:
-    default:
-        abort();
+        qemu_log_mask(LOG_GUEST_ERROR, "Q35: Reserved PCIEXBAR LENGTH\n");
+        return;
     }
     addr = pciexbar & addr_mask;
     pcie_host_mmcfg_update(pehb, enable, addr, length);
-- 
2.21.3


