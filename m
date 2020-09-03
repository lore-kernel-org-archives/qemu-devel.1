Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC8EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF28120665
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeQO4TV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF28120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwuH-0005md-5H
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLQ-00041t-9M; Thu, 03 Sep 2020 17:00:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLI-0007e4-IK; Thu, 03 Sep 2020 17:00:28 -0400
Received: by mail-oi1-x242.google.com with SMTP id w16so4536242oia.2;
 Thu, 03 Sep 2020 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RzeduguMkjJ25jQpgkKJueFeI/WMC3SutpUz7EZNeBA=;
 b=aeQO4TV8bN1PkAZJSM9mKjt8QIm1131tI00Up90H0yNKutKUFPYyhR5pZt64+QKVnO
 UqpEdTOJ7oiBPkkDsFitCSeSRMeBKnGst/GFOhQnc9puZo+lxVyaCpKAdGVknhDMQUtU
 nyZdDoFb1Oz4bLk+9pWUw790CKSt3OCFiyZNYFL0hdjWs/SUmIsRgGql0Qype+BNH7KA
 R/r6EhvMSDW+bozssylUuzOiSoSSI/p1xlY1zSUERpTlxuHleYPqRIKo6ot/YDNAAWZU
 s94/jNj7E3e8yveQEmJN1jGGzmulrTWPZDAuqBcxxg5VEamUBPg9WLYOM+Qc+f/8f1V8
 JeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RzeduguMkjJ25jQpgkKJueFeI/WMC3SutpUz7EZNeBA=;
 b=VRhX2HyWB4Kf1jgI3ID+ckw14AyBMPgR3CTUvWt7rKwAbdfb51d9QZ1diF8cMVk2Km
 DymYFZcFmRrgbMTUhLXE3TM/8jhSF09XHhiJjIyFYSMs4RTYC0nS8NcETztpUssEjjMG
 u046Obd0bZKfLjypxEfk3N8T0ElUPK5X0ebpHKo2JDHQ7XUMhWOAVUhEUbMFL3rHXuUl
 wqgwA94NDzzgo+JcFiUZCjPlhIP5WR7W808Nutp5Wpi8NDMErW/yxAPtAhQ047NrEVhp
 m1pPc0Bi+L3oMxWsMVNJZdUVXcn/CD26v3rJoaKjIBCAX2lae6U3eIG4CZ8JnDytDUbA
 TVjA==
X-Gm-Message-State: AOAM532S5/X9ovZ8EXTHdA17U6MIkWJZCsXf8BGmk6OR29AULoHqeB3g
 EoDgFGs4NqWpAcLWd36AdnPlK/q/B9Q=
X-Google-Smtp-Source: ABdhPJxE2iGtbT04/YrSqCZV4NB951udik43UfKfeFEIoNqXmz2FAPwMV5hH/A2BkwkQISbIcG0ayA==
X-Received: by 2002:a05:6808:8e4:: with SMTP id
 d4mr3193629oic.132.1599166820386; 
 Thu, 03 Sep 2020 14:00:20 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id t84sm294254oif.32.2020.09.03.14.00.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:19 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/77] xhci: fix valid.max_access_size to access address
 registers
Date: Thu,  3 Sep 2020 15:58:49 -0500
Message-Id: <20200903205935.27832-32-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x242.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

QEMU XHCI advertises AC64 (64-bit addressing) but doesn't allow
64-bit mode access in "runtime" and "operational" MemoryRegionOps.

Set the max_access_size based on sizeof(dma_addr_t) as AC64 is set.

XHCI specs:
"If the xHC supports 64-bit addressing (AC64 = ‘1’), then software
should write 64-bit registers using only Qword accesses.  If a
system is incapable of issuing Qword accesses, then writes to the
64-bit address fields shall be performed using 2 Dword accesses;
low Dword-first, high-Dword second.  If the xHC supports 32-bit
addressing (AC64 = ‘0’), then the high Dword of registers containing
64-bit address fields are unused and software should write addresses
using only Dword accesses"

The problem has been detected with SLOF, as linux kernel always accesses
registers using 32-bit access even if AC64 is set and revealed by
5d971f9e6725 ("memory: Revert "memory: accept mismatching sizes in memory_region_access_valid"")

Suggested-by: Alexey Kardashevskiy <aik@au1.ibm.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-id: 20200721083322.90651-1-lvivier@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 8e67fda2dd6202ccec093fda561107ba14830a17)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/usb/hcd-xhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b330e36fe6..67a18fe2b6 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3184,7 +3184,7 @@ static const MemoryRegionOps xhci_oper_ops = {
     .read = xhci_oper_read,
     .write = xhci_oper_write,
     .valid.min_access_size = 4,
-    .valid.max_access_size = 4,
+    .valid.max_access_size = sizeof(dma_addr_t),
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
@@ -3200,7 +3200,7 @@ static const MemoryRegionOps xhci_runtime_ops = {
     .read = xhci_runtime_read,
     .write = xhci_runtime_write,
     .valid.min_access_size = 4,
-    .valid.max_access_size = 4,
+    .valid.max_access_size = sizeof(dma_addr_t),
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-- 
2.17.1


