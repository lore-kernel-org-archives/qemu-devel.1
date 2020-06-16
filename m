Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A4AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384DF20786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvU2m+LT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384DF20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCaH-0003ti-DG
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPq-0002EW-8r; Tue, 16 Jun 2020 10:18:18 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:35818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPo-0006gt-I9; Tue, 16 Jun 2020 10:18:17 -0400
Received: by mail-oo1-xc43.google.com with SMTP id e12so4121124oou.2;
 Tue, 16 Jun 2020 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZaCFlRve5uOasUm5bS0A0GsaW+2gRHGt4EL3FN/Sr9k=;
 b=LvU2m+LTDjKlTEtIm8ZuktPhpFlAwYMRaByHDK9uPzGlUcY10UOzpBM75Xa0FavPWI
 1kVyVD5pMEjET8naXeJMPBtsBZpQt6sFGWESIAKnfqBAGuH25s+uA703poqOA0K/KnHa
 fIoCjoZ5FEVFp/n5dK3wz+9bmm3MqsdTojjy+8X8ZWMe2NTamh7jwfE65bqa5W9EEfZX
 ZbqvEt7fbtahXe6k+w3P6L2N0uIvv2PLuS4nqZVWf4VVDGvFdZMDrEMgCRz5v6EUwtNN
 DovKES3lM+tNNR6nEmSWgIzS1GEyHggR2z7FGTMtWLcnomKB8xJAXbAEVdBduCz48wvL
 XEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=ZaCFlRve5uOasUm5bS0A0GsaW+2gRHGt4EL3FN/Sr9k=;
 b=S3Nw1SFaY8M7K95xz/pbG9emMxVR2IBPWAR4KgEHaDXWMKM/NhwSXVxh2vtPErRpRd
 eNTb38xoIuzcN445g3r5b+l8tqvRye22Y76gSGp+LBkJGgVnbBcRsidh1R6/BksOB4UG
 xV0m9prg2b4iqfcg3q/bfgxv2YA2adr0nO17IsVffDx0lj5P+4g6ruNuzD+4yhdShNbZ
 tq4UggLN3bCTimXU25Ae9B/dMz3M4Y2KzfvRqXwdlNVocEhQXUoRUQqJ7cKMl24o2Iru
 6jQmxOTjnp179l2AfCh8IFRQ+xlZR5UB4SwvIimLQsW+nBFf0fm5Cot1OWA3I1abnkjn
 5WOg==
X-Gm-Message-State: AOAM531oD3JkXS8HgMzVtWc8eKYvmaA8qVzTGV2Pr/+XbipQ4pfnBQ6X
 gEzEB6fAOeFtXkvQggg1bS1Orb01
X-Google-Smtp-Source: ABdhPJxH9Tb4OXUP05m6O+BnSklcInwsuTSk9SoLzYaY8euiOe1tiGhpKUP5EnA/Pso0WfGxm6rMmw==
X-Received: by 2002:a4a:5ac3:: with SMTP id v186mr2540670ooa.2.1592317094352; 
 Tue, 16 Jun 2020 07:18:14 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id p13sm4073089otp.58.2020.06.16.07.18.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:13 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/78] dp8393x: Implement packet size limit and RBAE interrupt
Date: Tue, 16 Jun 2020 09:15:02 -0500
Message-Id: <20200616141547.24664-34-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc43.google.com
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

Add a bounds check to prevent a large packet from causing a buffer
overflow. This is defensive programming -- I haven't actually tried
sending an oversized packet or a jumbo ethernet frame.

The SONIC handles packets that are too big for the buffer by raising
the RBAE interrupt and dropping them. Linux uses that interrupt to
count dropped packets.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit ada74315270d1dcabf4c9d4fece19df7ef5b9577)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 04f58ee4e1..ca8088c839 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -137,6 +137,7 @@ do { printf("sonic ERROR: %s: " fmt, __func__ , ## __VA_ARGS__); } while (0)
 #define SONIC_TCR_CRCI   0x2000
 #define SONIC_TCR_PINT   0x8000
 
+#define SONIC_ISR_RBAE   0x0010
 #define SONIC_ISR_RBE    0x0020
 #define SONIC_ISR_RDE    0x0040
 #define SONIC_ISR_TC     0x0080
@@ -770,6 +771,14 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     s->regs[SONIC_RCR] &= ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FAER |
         SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
 
+    if (pkt_size + 4 > dp8393x_rbwc(s) * 2) {
+        DPRINTF("oversize packet, pkt_size is %d\n", pkt_size);
+        s->regs[SONIC_ISR] |= SONIC_ISR_RBAE;
+        dp8393x_update_irq(s);
+        dp8393x_do_read_rra(s);
+        return pkt_size;
+    }
+
     packet_type = dp8393x_receive_filter(s, buf, pkt_size);
     if (packet_type < 0) {
         DPRINTF("packet not for netcard\n");
-- 
2.17.1


