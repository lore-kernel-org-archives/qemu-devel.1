Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6DDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBC32080D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXZSIRPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBC32080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCcV-0007SN-HR
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPr-0002JJ-Tz; Tue, 16 Jun 2020 10:18:19 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPq-0006hu-FE; Tue, 16 Jun 2020 10:18:19 -0400
Received: by mail-oi1-x241.google.com with SMTP id k4so19384320oik.2;
 Tue, 16 Jun 2020 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MYqD5kUyAFJe68fqslPuojGp+B170xLbwwM5A3xgweA=;
 b=bXZSIRPq8d7FWdJW6c9yaexTnz15i66GYNJJJgwtHgd7/A6P8slTYFX4pmIcSwaCW9
 EpJkA2kFHt8rmCOyYZpzDsd7pcr0iZp9HVcHzNpGykaODPOdoxcxuW7HjB9RR90NXBDK
 GjEhngJmTlwZKoaFbTfTNklY1NJgr69NzpoBjKPu3umT83tFT8E74TXOrSmHBf4XesQ8
 PCTmQe1BmZcRkkUTMm6I2BDVMtptg5EFh59v2gSk021hzJngv+BFqpDOWYDEwl+z+lfS
 HRAIx8PD+4ehb1nxUTbOYVLIh8G+G+fuQhB+/g2pv2W+EmvqwLuJeFVoVG40vWxRZ3gF
 /uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MYqD5kUyAFJe68fqslPuojGp+B170xLbwwM5A3xgweA=;
 b=YVaGmstdyKEAU9H1/aq7n1j7jc7UyWoNuaewr4wj9ClX5OllUJCRmTdc/gHUYZi02z
 sIr6gkr/hDE+WtxxHVLDgyhFtM42TgzsJ0D1lt1gjh631VC2Hc9dBY1ISrQ8ikFaD4RP
 zQolEB610w1NKZnv5If/wD5i/j2IrMQIifYeKfN+wP7/fJ6BGK1QWYZ4PF5C3LGTRrS2
 1r+oEQ3wRaVCyh2UCbw35GmJHkLUpiC11eTcgcH8L2dCLWINnjDWLBKjj/f+EsC4DZuD
 xAW5cjp2BAUpgaX0Wld8u1GyKoV5lewbnqJULWzUZvJ/Let8Vi4IX9p9tXolEH/vA9iC
 mo9Q==
X-Gm-Message-State: AOAM533FuxKGYhd59Mr1kPviHRK1SswaDCZpBeCcmyexfjMBjXnqCdTJ
 LcMN1RgoQi6cTjY2Ue/pH42c0OWx
X-Google-Smtp-Source: ABdhPJzyBxEjEU4YsHol5tsSt9TvVUlg+UWN+/he2OZ1RB8D6sSbg0h/Kzv3bi3zLZHMl/vGtzFYkg==
X-Received: by 2002:aca:438a:: with SMTP id q132mr3382644oia.44.1592317096410; 
 Tue, 16 Jun 2020 07:18:16 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g5sm4072195otb.20.2020.06.16.07.18.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:14 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/78] dp8393x: Don't clobber packet checksum
Date: Tue, 16 Jun 2020 09:15:03 -0500
Message-Id: <20200616141547.24664-35-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x241.google.com
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

A received packet consumes pkt_size bytes in the buffer and the frame
checksum that's appended to it consumes another 4 bytes. The Receive
Buffer Address register takes the former quantity into account but
not the latter. So the next packet written to the buffer overwrites
the frame checksum. Fix this.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit bae112b80c9c42cea21ee7623c283668c3451c2e)
*drop context dep. on 19f70347731
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index ca8088c839..315b4ad844 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -816,6 +816,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     address += rx_len;
     address_space_rw(&s->as, address,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)&checksum, 4, 1);
+    address += 4;
     rx_len += 4;
     s->regs[SONIC_CRBA1] = address >> 16;
     s->regs[SONIC_CRBA0] = address & 0xffff;
-- 
2.17.1


