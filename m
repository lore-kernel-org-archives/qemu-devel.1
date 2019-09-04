Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1E6C41514
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A60421726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV2g+n9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A60421726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Yst-0003GY-TK
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqR-0001Ia-J8
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqQ-0006zE-Kk
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqQ-0006yr-Ec; Wed, 04 Sep 2019 13:13:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id u16so22125904wrr.0;
 Wed, 04 Sep 2019 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Re5SoK9LBlh1OETVvBHDiEijPJqBMr7rX5bmU56TmLo=;
 b=nV2g+n9zeC4s2DMuvnV4wNpvw/73bDuCwOGe3RG8IZx8f1Z9tIpvnucKfqSRJJzxnT
 gHOsRpczq2RmGpFD0ec7ngCYP8D5AiTTT4wBmqtRXXMKZMIogd7+VU01gh2Pw/OTsGhQ
 9UPaPgktdOqKDBoR13CvLjphtTt20pnr5n32HCRlA6LmxCdJVZVDfuFKwANvd6GAhFRa
 i+L7WUECBtVf0AH4yzcSleXyaMmbC/Fwfyt3BZSyasTeV/PxQybWeY3ZyHVEJu90puL4
 eobNLU7ZmwTQFWy+Rj5FtXMPmOg1OJtOC0yQlESBxBsDGRYYitGBKBTBkh4IopM++k11
 2jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Re5SoK9LBlh1OETVvBHDiEijPJqBMr7rX5bmU56TmLo=;
 b=AxafNZINv6RQeqzGn9+ZmF2xrSoCp3f+nHn+iXDkEsdHtZwoaLUEvgFQi20p8E8aQx
 TjVMtfaUnBkPsxgiqPmYMSomWZkS9i3gL0pZqE9LYp6gjmOpWUTEOfbz5croh1yrBtVH
 U/efyCGRHt35MacRYiYpN+oFOqC9jk8ZpkavRK+t3mFf/9RT+S5ay+karBYx3n5d1mux
 n2moncBE+Xx20i2LMRCoFt8h9woomMimbd4z3SYNAUbNAiGXY1/AvuRF1r1smDjCLWUp
 026uAB+MGIaaV/9AFjbOaNBDCEd2ifnluyTn3faZdBEUQgAFxy0m25qa925N64rlKQnz
 gq8g==
X-Gm-Message-State: APjAAAVkOTLpOCJPw5qX66w/GQbz2nDhd19S7v1k4zmidm2UZh+PSvUC
 yR8FsfWFZpuj22cQuRFke7k=
X-Google-Smtp-Source: APXvYqxqFsgbbB5cSLHO8aHW+LjhxGc8JcZOj/pdM62vUI87Od70LG3yV1cjZD725KRr2aAR7AbFsQ==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr1475139wrr.334.1567617201524; 
 Wed, 04 Sep 2019 10:13:21 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:03 +0200
Message-Id: <20190904171315.8354-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 02/14] hw/misc/bcm2835_property: Add FIXME
 comment for uninitialized memory
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are returning unintialized memory, this is probably unsafe.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/bcm2835_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index d86d510572..399f0d9dd5 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -57,6 +57,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         case 0x00010001: /* Get board model */
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: %x get board model NYI\n", tag);
+            /* FIXME returning uninitialized memory */
             resplen = 4;
             break;
         case 0x00010002: /* Get board revision */
@@ -70,6 +71,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         case 0x00010004: /* Get board serial */
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: %x get board serial NYI\n", tag);
+            /* FIXME returning uninitialized memory */
             resplen = 8;
             break;
         case 0x00010005: /* Get ARM memory */
-- 
2.20.1


