Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B76C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC40C2085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vhs6ZsVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC40C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2Mi-00067C-MG
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2HR-00009F-1T
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:22:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:52343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kO2HL-0003lC-V9
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:22:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id q9so3719182wmj.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kDqdtq58pQ4zoZVkr3FaloUPfNhxdNZfP/qYUQHcHb8=;
 b=Vhs6ZsVHXkgiTL/gA6uzAoHzPB8+ToNsdRBEXq9O3VZ7w0p/EFUmBaHTNYl6RVztgh
 31a94BhkEuiUnEKJ/vvAide5m35GHr8dqiDpZOc0iiSlKf4UVnLrRxHTIX7dHfEcVuJJ
 jQxzQ6JjdZJF5LJV0Nx29RK+6MMmhMx+kUc47wbKka4snI7mLY5Nb/liDosIx0P53mGs
 IUOO1VUDVI494QKbA1Vm4S05PktrCCD5qW0jIgyQI0U3QTx9vHvEGMu8XL0svGeCE/at
 G+mMJdxGHoCUm+YgJrEcPJmC47faBXt3o8vtj+t0nEKJy4FFNjz/iZSwILZ57LPpS7az
 Kl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kDqdtq58pQ4zoZVkr3FaloUPfNhxdNZfP/qYUQHcHb8=;
 b=ZG9YYjFluKDg5S5NAlbQTcDpB8QPHUHpcJFEJn3/16ypDs+vHQfLuHxeANJnjX89mu
 Z+6a0nWq7H5bPYRGXbl/gSna3uXFpnZxE3ltBmVonHit8iVU7WD0C12W8n7QqQCnIDNO
 uibowfhW4CfukLhq9hGB3IXJaJap1sNgUE7WhZOEWsNf1cUDpmeRo5WmPa4AXVW1t10Z
 uW1qquRNpEOEKvqwiM0W48sMspeNtGQVb/8pqVN+BgXaw1CD5rHso6SCL3zuop1uKgeO
 xBHnixkxYJSOo6KrH1sOyqCd/pioo0MhbFoOjPzxdkIrSyGguBaVUKadSjHW7uVN6z6s
 MXXQ==
X-Gm-Message-State: AOAM532Tgec0jLakHxKVgn3vg2s6KfXZYjzYm0sYa1mlvstBWOTL91bP
 dvBDTsiiACwoeopUjWr3M0Fl1D/JpWY=
X-Google-Smtp-Source: ABdhPJwRXWkLxB5yGFcYjfcTdhHvZ4non+ldeJpKxlmsLPjHZZyqPb2u6XMVfoz8vdTAxl70WAdwoQ==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr998857wmf.47.1601572921754;
 Thu, 01 Oct 2020 10:22:01 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h8sm9719625wrw.68.2020.10.01.10.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:22:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/16] pci: pass along the return value of dma_memory_rw
Date: Thu,  1 Oct 2020 19:21:44 +0200
Message-Id: <20201001172159.1619456-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001172159.1619456-1-f4bug@amsat.org>
References: <20201001172159.1619456-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Some might actually care about the return value of dma_memory_rw. So
let us pass it along instead of ignoring it.

There are no existing users of the return value, so this patch should be
safe.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Message-Id: <20191011070141.188713-2-its@irrelevant.dk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 0a59a06b14..f19ffe6b4f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -783,8 +783,7 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
 static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                              void *buf, dma_addr_t len, DMADirection dir)
 {
-    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
-    return 0;
+    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
 }
 
 static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
-- 
2.26.2


