Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC4EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E8320644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYBtQb3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E8320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCj2-0002kQ-Jp
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPo-0002Ar-VJ; Tue, 16 Jun 2020 10:18:16 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPn-0006ga-Al; Tue, 16 Jun 2020 10:18:16 -0400
Received: by mail-oi1-x243.google.com with SMTP id k4so19384129oik.2;
 Tue, 16 Jun 2020 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j5JadjYITwuc3PbQFYYnCy+d7Me2080KB/yC+x/1sXg=;
 b=QYBtQb3qv5JrOYveG1CHpjtIi8E4eGda2+ymh+28Pe4Jslu6mvGNzqskv4eEQCPA8n
 8BR1q7abwCfSm7+y/Nf71JA6VUlMDs70/uxS7l0eqQYtRVaJKidcy23GTuzmnee3Lqa2
 z2GMH73UHlwmQp6RhHWRx1ZdDS3fti8CZlsjnpuGpdkAGr+b1+ChTQEYk8M/9klFKu6Y
 zUAHPmuxwWP3ll3yvabAnnlv064sNmJe+W+ywecxmfMux1eOlTHpBZx8drqdB4DR1GWY
 jGgzQgxKQTEizIh10eT2Hama9GNje+NcTWlJ/yY5/3UWTJ1n5uoikwwqcrtji2byM74F
 R8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=j5JadjYITwuc3PbQFYYnCy+d7Me2080KB/yC+x/1sXg=;
 b=ihVsnRbwK1jFN4AcpklyhyDU+i+ur6GamUNJv6F9c1I6lVUW+XIcbpVmswcg7kbakw
 viue7mofRHqcX2q79Cj3E0rU0mgxS+NrjpxywCO5VvhW5xCnlfdhSbaTEowhW5RlGf3a
 4cWtnLlW/VFuISw0rjkTIuU549VtIpSb5DSYnNUUDVOT/BKR6+RkH6A8InMUh/qgYOV6
 jbAudAlS+O8+PcjVkFoijPewDfDOqWqSAZJesC7Bz9hpX2yA7hTFUEmJujkipIx3AKk2
 gAgD3sIRzaqM2TI4wMFNWfhDBN5Scw02yofCAmIyE/zeT1dUdhArjAfYFbcxb12RSpUZ
 YQfA==
X-Gm-Message-State: AOAM5323v6A3VI25TgW7TRWV+7wkEO6lEd8SVBXHG78OaVQBoJi6Y57/
 1zvEN9iDWEN+mRnHvI5UzV96yqU2
X-Google-Smtp-Source: ABdhPJwZZUyt2mPpDUaiuo9qZigT3HqodRbWAqEJHNDjrz9SFLzeJIRgjXMzTuIQenvtbna1E1jwtw==
X-Received: by 2002:aca:ec4d:: with SMTP id k74mr3364583oih.160.1592317092226; 
 Tue, 16 Jun 2020 07:18:12 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id s20sm4078575otd.62.2020.06.16.07.18.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:11 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/78] dp8393x: Clear RRRA command register bit only when
 appropriate
Date: Tue, 16 Jun 2020 09:15:01 -0500
Message-Id: <20200616141547.24664-33-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

It doesn't make sense to clear the command register bit unless the
command was actually issued.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit a3cce2825a0b12bb717a5106daaca245557cc9ae)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 8dd6bf032c..04f58ee4e1 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -352,9 +352,6 @@ static void dp8393x_do_read_rra(dp8393xState *s)
         s->regs[SONIC_ISR] |= SONIC_ISR_RBE;
         dp8393x_update_irq(s);
     }
-
-    /* Done */
-    s->regs[SONIC_CR] &= ~SONIC_CR_RRRA;
 }
 
 static void dp8393x_do_software_reset(dp8393xState *s)
@@ -563,8 +560,10 @@ static void dp8393x_do_command(dp8393xState *s, uint16_t command)
         dp8393x_do_start_timer(s);
     if (command & SONIC_CR_RST)
         dp8393x_do_software_reset(s);
-    if (command & SONIC_CR_RRRA)
+    if (command & SONIC_CR_RRRA) {
         dp8393x_do_read_rra(s);
+        s->regs[SONIC_CR] &= ~SONIC_CR_RRRA;
+    }
     if (command & SONIC_CR_LCAM)
         dp8393x_do_load_cam(s);
 }
-- 
2.17.1


