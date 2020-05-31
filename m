Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CC4C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488B2204EA
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvvgLC/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488B2204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRwq-0006q4-E4
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 13:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfRuo-0004An-93; Sun, 31 May 2020 13:38:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfRun-0004Fa-FC; Sun, 31 May 2020 13:38:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id v19so8627119wmj.0;
 Sun, 31 May 2020 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KsQ1BQRlJKLRUJr0jZUSVevT0fbQ9tRG4Kdv5xJn5Tg=;
 b=OvvgLC/+ddLEdgOqG9BGzOSTBcy0qN+18q9JC4/GfG3Fv91qKjhOlaWmQsPxLKfIYF
 mfaemWp0HiASJbUQUtd6QuGfRI62byfE90yIS3vCqYnsVS75yNstLw/2gw3sfw3FYXEW
 dBxgPuXkmZioeuXxlU6fZo2HcwQ/Gs8sqkvr9BuK4zsXEaFMMySi/8Cu6OqTnjoSf/SC
 sAkQG0K6/+6kfk7BDu6pdCiZg999VMnGuU5pmOk+21AWQNPNvyp6a5rTtQ9EXGp+4LkB
 kchQAzw2OdcC4MBliuOIAPwp+otTA1rZeh4VWsDHXsUsgu/jx/jTiApCJFkIF93rtgw6
 xZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KsQ1BQRlJKLRUJr0jZUSVevT0fbQ9tRG4Kdv5xJn5Tg=;
 b=qCQXqtZ39t8b51ADs3u5bORmW2WTIQv+UcikvRUG+DbZ6zkXFuqN8aZkrmBTCEmIOq
 Es2pi2LhdoOsrB6gsjytlNKkjU6vpKsxdZOCpzwC1bV3JbfC6ek6TUM1QFKUC5vNljg3
 KcrBMWGfgEmFYaHAeUPX8eMhKMb3fq/3kfHOWhj1sQqOBUo8cpQGnZLeq5LE5d2fREzv
 8Y+oGne8EHKi++lWchkDunY/Yz/oH+0LXtgJD2MwCUMK/7xNex6o2kBsk907bEJbsDdM
 eFrhO8ck9ojTCOcD0Uf217FQhV83aNurqj4Q9+ziL38mNtKgzeVyr+EamkTQJSJnmKOw
 +S8w==
X-Gm-Message-State: AOAM531h7ov0ZiEFdNmrbXJU0/lurzpHIJaE18yS26bFsGEGh+PzxZj9
 Y5dAllPqCGIY1AtqiVZKh7wC3EkO
X-Google-Smtp-Source: ABdhPJzeybcJCTXmZjvw+0M7Jmw3AwmGdkeKINOR50NTyuWnxoCKp8N0SHbRKuVp2dnjlfQ5FAFP8A==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr17521127wmd.94.1590946702340; 
 Sun, 31 May 2020 10:38:22 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id l19sm7973121wmj.14.2020.05.31.10.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 10:38:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] hw/pci/pci_bridge: Correct pci_bridge_io memory region
 size
Date: Sun, 31 May 2020 19:38:09 +0200
Message-Id: <20200531173814.8734-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531173814.8734-1-f4bug@amsat.org>
References: <20200531173814.8734-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_set_size() handle the 16 Exabytes limit by
special-casing the UINT64_MAX value. This is not a problem
for the 32-bit maximum, 4 GiB.
By using the UINT32_MAX value, the pci_bridge_io MemoryRegion
ends up missing 1 byte:

  (qemu) info mtree
  memory-region: pci_bridge_io
    0000000000000000-00000000fffffffe (prio 0, i/o): pci_bridge_io
      0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
      0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
      00000000000001ce-00000000000001d1 (prio 0, i/o): vbe
      0000000000000378-000000000000037f (prio 0, i/o): parallel
      00000000000003b4-00000000000003b5 (prio 0, i/o): vga
      ...

Fix by using the correct value. We now have:

  memory-region: pci_bridge_io
    0000000000000000-00000000ffffffff (prio 0, i/o): pci_bridge_io
      0000000000000060-0000000000000060 (prio 0, i/o): i8042-data
      0000000000000064-0000000000000064 (prio 0, i/o): i8042-cmd
      ...

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci/pci_bridge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 97967d12eb..3ba3203f72 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -30,6 +30,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "qemu/module.h"
@@ -381,7 +382,7 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
     sec_bus->address_space_io = &br->address_space_io;
     memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
-                       UINT32_MAX);
+                       4 * GiB);
     br->windows = pci_bridge_region_init(br);
     QLIST_INIT(&sec_bus->child);
     QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
-- 
2.21.3


