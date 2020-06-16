Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B24C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B44C2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUj7ZqUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B44C2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCgY-0006XY-Av
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPz-0002de-6l; Tue, 16 Jun 2020 10:18:27 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPx-0006k6-Ig; Tue, 16 Jun 2020 10:18:26 -0400
Received: by mail-oi1-x244.google.com with SMTP id i74so19411005oib.0;
 Tue, 16 Jun 2020 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=LGDLxuflCPrnNSt/lCPZmy+cvNfPql2oqSYzLa/L3U4=;
 b=hUj7ZqUtkaiVg/DCkImFuNsH3AH/qCvU9l8Z7ib3iqu1w/+iQek4gutshN0oGO4uFX
 xJozFDcTq2ZBK8Ou0Eo9feiWSC10WFPDKRZ4wsYfYr3RtVWx3OePjcnw3ho3BOIqZmTl
 /lskfCdkkkhSAobskfsH8IQvCldzLKiAHThcRgLAZqdLMQSbZof+h39MyMSi8YOLnG21
 9ldrLhPn8nLh96esd1l7j2Kx3hOBoSgteXCgV7x82bAGDil+bTHFeyB4XrBHNewK9i2Z
 bpbIS8JaLo6wyGtbhkTJ5GHh5RdBzeIHK923GpUOo1UpHnPcKpQjklMwTSzAlrqUnEL5
 3fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=LGDLxuflCPrnNSt/lCPZmy+cvNfPql2oqSYzLa/L3U4=;
 b=uXe4+aQH4Vq/yFw6n423nA06hGvixAj08x957QlfZqtis/62LexvRyOcj9MACkCD2q
 APFrpvS/MEAzcVmtdRmX5YqsjBCEu/n8T13hHmm8vmJ+lqMSvurl8KCJMlnSvBiAIWp8
 HQLbpNOfyXbThqp92ictH7QQAbD0wVZBtnyzerw7NwupXpPM0GiRlTL0bHi8ZyWAOO99
 6Trc8A87+lVBfUiByCKuzEN/u5dVAx4S+8Upu4s9I3ZOVMDR1r4zciI6gbdpCS1lDhy9
 jEpxYUXHDu5vqfXnTOfn/w2Nd03+evDW2THc6eNP0o+ATeD+aTh93RARCFpVn12g+x9F
 Qgsg==
X-Gm-Message-State: AOAM5326yHN3DvXuBGK9Tjogwrdzi1aj0qxDL2gdyNQW/j3X+9Ohq+jj
 bjMDTMQBJlJuu5oshtY5uN2liXEk
X-Google-Smtp-Source: ABdhPJxIoVFvseDQ6UXW/1WTBBDwJDRbaXyENkY7XG1aldoslAxZHMA/ZYHz6CIsJIlNReLoD52YkA==
X-Received: by 2002:a05:6808:3:: with SMTP id u3mr3513503oic.21.1592317103865; 
 Tue, 16 Jun 2020 07:18:23 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id f1sm4092909ool.16.2020.06.16.07.18.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:22 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/78] dp8393x: Always update RRA pointers and sequence numbers
Date: Tue, 16 Jun 2020 09:15:07 -0500
Message-Id: <20200616141547.24664-39-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
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

These operations need to take place regardless of whether or not
rx descriptors have been used up (that is, EOL flag was observed).

The algorithm is now the same for a packet that was withheld as for
a packet that was not.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 80b60673ea598869050c66d95d8339480e4cefd0)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 4ce2ef818b..aa7bd785f3 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -897,12 +897,14 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         /* Move to next descriptor */
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
-        s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
+    }
 
-        if (s->regs[SONIC_RCR] & SONIC_RCR_LPKT) {
-            /* Read next RRA */
-            dp8393x_do_read_rra(s);
-        }
+    s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) |
+                         ((s->regs[SONIC_RSC] + 1) & 0x00ff);
+
+    if (s->regs[SONIC_RCR] & SONIC_RCR_LPKT) {
+        /* Read next RRA */
+        dp8393x_do_read_rra(s);
     }
 
     /* Done */
-- 
2.17.1


