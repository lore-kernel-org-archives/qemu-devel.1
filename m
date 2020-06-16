Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBB4C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:35:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A330D20776
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3L+sAVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A330D20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCgU-0006QQ-Nl
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPu-0002PV-9V; Tue, 16 Jun 2020 10:18:22 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPs-0006ir-LR; Tue, 16 Jun 2020 10:18:21 -0400
Received: by mail-ot1-x343.google.com with SMTP id k15so16042591otp.8;
 Tue, 16 Jun 2020 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4eY61f4yjJnpy1o5y9J5QRfvOfW6Yv9szrM/jozGATU=;
 b=Q3L+sAVN7rB8isPHP471ZTgUlBPifOiFj9HBkCUn32lPupNgCaTHjb3Ycb9ug7RBza
 WtPOsWYxNXGU3V3/w84+Z19oTZ+n7yyFDnfJ0nGaTeSl5sDVlvtQHf+STW9oSEKfxoad
 H3+pzOy1BXUv+63u5PT3fbX/pmQIHQSytBp3B6SZ2Xgc2xsyGKGq1We+7fhoUgIoPzDu
 eE0QiJvbbzjIcDt4FPL/LGJAlrnS3YSqTvlFkO86RNpr1qPpBGPRLsgFzf61/kZbMGPw
 2HhdEXZ7D7qsG7OzKYsM+4JQI6GWs7BFxzrCzks8gRwjnYtB7RmIKUTnZ3s/kq0SwgTK
 Fk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4eY61f4yjJnpy1o5y9J5QRfvOfW6Yv9szrM/jozGATU=;
 b=TNztWQRlRc0mgCNAztNogs8KrG58x7w4fPjnIiVs/Pu8PaOPcNqHytWQsisN7l1i62
 WWi+Z4v0yaqGgvfbZhDHfRxfcSTteGjOdJpWNkiH8UwdOkD+hl5O3FGYPwd9BJmEz6Do
 KjrpGPPGTpe2mR1xl5B1EjwnpYBOUlF/1oS4IHnrhatVdegFpg7u1cTrl3vCd0KjIYQD
 RRFv7Xl6b9J3VdcwZMuxt8Gu0vRRNTwWQIYxc+37mqC6WLDfuoLG3rVHszA6o6+UOMx4
 PAYGNI4MTzlDUnfZtfdpyRqJchU9c7EeHxZpG+hgvQAqSWftHRCgKBTlNn11aH64uToW
 HhLQ==
X-Gm-Message-State: AOAM533OocN+5xXq06Px2/EmcwrWHU8bHYwVLu0DVFhUiMoWDi7i+XLp
 geu5sLIm4e08NV9J7drtxjSBbyPj
X-Google-Smtp-Source: ABdhPJwU8N677Qc/swHP829IaFWmlbZ5qBeR6H1XdJP4PSFxSOfp4PUYhxz12rxgRC/e1CZKSG0Bgw==
X-Received: by 2002:a9d:2965:: with SMTP id d92mr2585153otb.350.1592317098333; 
 Tue, 16 Jun 2020 07:18:18 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g4sm4077411otp.5.2020.06.16.07.18.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:17 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/78] dp8393x: Use long-word-aligned RRA pointers in 32-bit
 mode
Date: Tue, 16 Jun 2020 09:15:04 -0500
Message-Id: <20200616141547.24664-36-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x343.google.com
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

Section 3.4.1 of the datasheet says,

    The alignment of the RRA is confined to either word or long word
    boundaries, depending upon the data width mode. In 16-bit mode,
    the RRA must be aligned to a word boundary (A0 is always zero)
    and in 32-bit mode, the RRA is aligned to a long word boundary
    (A0 and A1 are always zero).

This constraint has been implemented for 16-bit mode; implement it
for 32-bit mode too.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit ea2270279bc2e1635cb6e909e22e17e630198773)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 315b4ad844..40e3a029b6 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -663,12 +663,16 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
                 qemu_flush_queued_packets(qemu_get_queue(s->nic));
             }
             break;
-        /* Ignore least significant bit */
+        /* The guest is required to store aligned pointers here */
         case SONIC_RSA:
         case SONIC_REA:
         case SONIC_RRP:
         case SONIC_RWP:
-            s->regs[reg] = val & 0xfffe;
+            if (s->regs[SONIC_DCR] & SONIC_DCR_DW) {
+                s->regs[reg] = val & 0xfffc;
+            } else {
+                s->regs[reg] = val & 0xfffe;
+            }
             break;
         /* Invert written value for some registers */
         case SONIC_CRCT:
-- 
2.17.1


