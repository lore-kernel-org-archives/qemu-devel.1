Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ED4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5115D2080D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLmqPT8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5115D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCef-000316-FK
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPx-0002Z0-EJ; Tue, 16 Jun 2020 10:18:25 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPv-0006jb-V0; Tue, 16 Jun 2020 10:18:25 -0400
Received: by mail-oi1-x243.google.com with SMTP id s21so19368499oic.9;
 Tue, 16 Jun 2020 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dTLxU2WphGsAkX/EAfyglA2CaOp+hp5RtsgwmTF7ppQ=;
 b=uLmqPT8MFophSmrrJHadzvQ4THpjdquzqrjyBYMBdGK4Jm6Ogx9o6XHsJoOrED91Cz
 C5YQcmTEwzLOKeiAxqfVD7/GUUgZsLQm4VCmv4KN1Rg0UP17fbhakEJYeHQrBKY8syJT
 X3H92rO4Mvun5wRC2F/l5a1IiTkNZ1E7qged98NbtMCMVRigS6UhVaBGlScYQpjBFzv5
 TY13FLyXHOcxM8oMDGV3wqz6ci72s9Ulu/BHELDdWpOyREChrPM852xdVDtdMxaRBvh8
 3AMOMrlfGjQA2KUkVYuI4RNbcSI71mOeqaGP/NjsH65O/R3416lpEGzrZpkgPtxxyQj/
 Rr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=dTLxU2WphGsAkX/EAfyglA2CaOp+hp5RtsgwmTF7ppQ=;
 b=jCSPmHViD0Wk4UjC9wEcAc05cb5i57hkJ4c/AXgIGXheKiHyZ0+EWp6b0dSf37TRfm
 6O0O8AGxeC1O9WO7aCZguj6KubpMbmR7lNPBgAnMLXUdMMjudDD7uklUQ94x7eFJdypV
 oFCr+ayXttmkc6KPDlGssmGgRB3oFH2E5jYxsSbzkhxQ1U0oegxPWZKHP2+uacP+J723
 2lMn6QqkG3Tw/1ilvLhAdn27L0Vlsy8JUIRuK660xP5xbks1yfIcaorFpsjyCqTOxxy/
 SGuwKNBdtqd4ZIfVtB2QTL3LtaY4CqKf3kbJo/5Y0g1b0f3UtPkPKWgih0UEMWFGupJ4
 dvEw==
X-Gm-Message-State: AOAM531Zw8SznmutY+EL2je2jyTWtC2DZhsZ/0cnOtFcAEC3QRH/ygSt
 ibnLZ4PrvoLa0VTbbK8YbzU6SM8D
X-Google-Smtp-Source: ABdhPJyZlAfOzOqoWytmCP25vqItL9AenOZsLx5ZRFNYBDT2Jk++s/uDBcMta7VGI2ggac/GEiUpcQ==
X-Received: by 2002:aca:d515:: with SMTP id m21mr3335373oig.7.1592317102169;
 Tue, 16 Jun 2020 07:18:22 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id s15sm4324530oic.54.2020.06.16.07.18.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:21 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/78] dp8393x: Clear descriptor in_use field to release packet
Date: Tue, 16 Jun 2020 09:15:06 -0500
Message-Id: <20200616141547.24664-38-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

When the SONIC receives a packet into the last available descriptor, it
retains ownership of that descriptor for as long as necessary.

Section 3.4.7 of the datasheet says,

    When the system appends more descriptors, the SONIC releases ownership
    of the descriptor after writing 0000h to the RXpkt.in_use field.

The packet can now be processed by the host, so raise a PKTRX interrupt,
just like the normal case.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit d9fae13196a31716f45dcddcdd958fbb8e59b35a)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 0e9061d831..4ce2ef818b 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -809,7 +809,17 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
             return -1;
         }
         /* Link has been updated by host */
+
+        /* Clear in_use */
+        size = sizeof(uint16_t) * width;
+        address = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
+        dp8393x_put(s, width, 0, 0);
+        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                         (uint8_t *)s->data, size, 1);
+
+        /* Move to next descriptor */
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
+        s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
     }
 
     /* Save current position */
-- 
2.17.1


