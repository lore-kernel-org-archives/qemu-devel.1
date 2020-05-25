Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB885C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B70F20787
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWtk1o+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B70F20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBE5-0002aH-IT
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBD9-0000qe-KV; Mon, 25 May 2020 07:24:03 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBD8-0000pw-Tr; Mon, 25 May 2020 07:24:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id s8so16722138wrt.9;
 Mon, 25 May 2020 04:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T2fFw/3ecGdUBJpHTI/rjWpVW7MRtnqzt7F58rWYdgA=;
 b=fWtk1o+sZqyNBzm6LFIIfkZOaAz9pm2D5LIGFDda7OJzZ/A5GzFnFTCjpXkLw72yPP
 WXmclKnXy4DUzT0/R5aFbmLIqyNs22Lf1/DFFFN+06I1jLO7ySU08fZ2+ijqkplGQ3Wk
 ZgVy7Q7a5iKwXdZsml1ftEBja6JaMvnabnIA5NISQLd5pDKEuVpvijS7ei009ayeJLeE
 z32iYXj/UlcDJn9YZHMqljoysiCU0Dt/yxwtVYGMXDa3P6MTcIVn7s1zSEyqexs0Uza/
 DpWCqBgUwrDVqqQECk1iHOjHcDqzw4z+u3G00Y0fjbwvfYljYpK6JpqAKfsEF41Kb9de
 I7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=T2fFw/3ecGdUBJpHTI/rjWpVW7MRtnqzt7F58rWYdgA=;
 b=g2RIcDaCAnQcu/BiWHnZJNJltiwHaRC0HmpVHm9Bikm9BLZ53TCr+6pywwQZllZipY
 gE7Thh4VRF2EU5iPfEXx4uWtiCeYZJBWvdhnwQxZWe6/ufnp8ky0kfUgCUwdIC0MX8mA
 fCyCsW99EqlXWg8YyZLexhqfYeskO1Hb5URtZ7hMeBoV0cYI/Vj0Qh+Ol3ovzPrY0QrW
 AcnlYvn6WTADj+8wd9lN32AKsbFQRtc1aJbGpkKYPVvBPD5p90DYIJ3cKn/AkYQXv1jc
 mG6PIxE42NPLvEEtoxduI9NbrnxeAttjzFVbl0A0RAlnI6t5vOo51EH4VUbKzk3/568U
 dDsg==
X-Gm-Message-State: AOAM533Fd92hJ/V0jpAVKj2Ebbo9zbbO1j6v5ZlVb2x/1jJ2+HYyS+Zt
 4cmoBVqPnTrAdDa1rW+F1WLwZzPekOQ=
X-Google-Smtp-Source: ABdhPJwHFbDJddx3JhGgAkJIbabXkEDdSaTnrDZ4W+ZIzlMGKsSS/yXYPBxx08QA0Q8/fqvRvJjs6w==
X-Received: by 2002:a5d:6444:: with SMTP id d4mr13369464wrw.239.1590405841073; 
 Mon, 25 May 2020 04:24:01 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id h196sm10715635wme.22.2020.05.25.04.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 04:24:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] hw/display/vmware_vga: Let the PCI device own its I/O
 MemoryRegion
Date: Mon, 25 May 2020 13:23:54 +0200
Message-Id: <20200525112354.10445-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525112354.10445-1-f4bug@amsat.org>
References: <20200525112354.10445-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid the orphan I/O memory region being added in the /unattached
QOM container, register the PCI device as its owner.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC: This might break migration
---
 hw/display/vmware_vga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 5c0fc49d9d..2579f6b218 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1306,7 +1306,7 @@ static void pci_vmsvga_realize(PCIDevice *dev, Error **errp)
     dev->config[PCI_LATENCY_TIMER] = 0x40;
     dev->config[PCI_INTERRUPT_LINE] = 0xff;          /* End */
 
-    memory_region_init_io(&s->io_bar, NULL, &vmsvga_io_ops, &s->chip,
+    memory_region_init_io(&s->io_bar, OBJECT(dev), &vmsvga_io_ops, &s->chip,
                           "vmsvga-io", 0x10);
     memory_region_set_flush_coalesced(&s->io_bar);
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io_bar);
-- 
2.21.3


