Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601E6C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB5920651
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkT290T2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB5920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufWq-0006ZQ-FX
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58466)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPg-0000Wz-3J
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPf-0002vp-1M
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:44 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPe-0002vN-R7; Mon, 05 Aug 2019 12:00:42 -0400
Received: by mail-pf1-x442.google.com with SMTP id q10so39857884pff.9;
 Mon, 05 Aug 2019 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=2MH7twmDJfeZRj3jUDtzUjwhHh0CGkZ/MkdqWVYWSCk=;
 b=YkT290T2q3RvuBJ0Z7qI2GlKYk5/YpRjrDAZJh6xeEbrIktmwrwvR4Bw1tLeXXfhnQ
 SWmJ4I1pgxElDSBQqI90YBeuN3mGAwE2TFJh1X1Mc7/1ZPT8YtdD6h6Ej1KehgD+AkGe
 kKSQ5jlDOKh5Mr1Ft3b8RXwnYXYzkr5UUrlgRPXih22WFrEE3FAbxC7EPQcYaeuoLQnY
 gZHZ/qTiTeMB/VrMZ7gZqoqEU45lmTie6npo8+MOFn3TP2D+mDQyrXbb2o/R6Fyy7KZ/
 IOD59y3lXH9JxU3gM0viOhbSaD62yO2eXFFsvv4Lmt0vEgcxIi8FVEBllkmdkLii8pqy
 uwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=2MH7twmDJfeZRj3jUDtzUjwhHh0CGkZ/MkdqWVYWSCk=;
 b=mJEaoE/v1QGNEPAz/aw0UPA0ZB4MVqADIkGQDUJrTpaShjtKUHqXaEGlE27lptH95K
 SwFbD/eVEBjTJ+7nmg2dV8htlDLRhRM1edsws30DlUbOXDz9Fhc+Bjv2nJv/3vR3fZTy
 zlytWWo+ov0sUZM23ZoPk9yGsum2mKRbuEDqMhV4fryMG5Jz7RgBgAZJbxx86Afx2uSK
 GVPBHN7nH8j0ilqPTLnmOZe6i724B7m9/sl7LyP/B7PN1NZYwtZEtpsS83QIE53D7AgI
 xD0eJWvekh9DKc42a76vH+AZBuEuG8FcA+YGoGY3fNQV4N7KI82o0aTXYVycz5CjDjTl
 ykJQ==
X-Gm-Message-State: APjAAAW5J4Q0Uw/BWgtHqkgecTIVxYUINtYlhm/43wUmM2GBVNCMw707
 bBLCyk/YsjfJVAQ6Zjv8re4=
X-Google-Smtp-Source: APXvYqzLAlbXmRq6+RKapxCcfKnpTpATB3orDKl8rPmPdXLfzjaBEGJRkfmpQYft+L7BQKbqsX83jg==
X-Received: by 2002:a62:79c2:: with SMTP id
 u185mr74960737pfc.237.1565020841964; 
 Mon, 05 Aug 2019 09:00:41 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.41
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:41 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:08 -0700
Message-Id: <1565020823-24223-14-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 13/28] riscv: sifive_e: prci: Update the PRCI
 register block size
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the PRCI register block size is set to 0x8000, but in fact
0x1000 is enough, which is also what the manual says.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_e_prci.c         | 2 +-
 include/hw/riscv/sifive_e_prci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_e_prci.c b/hw/riscv/sifive_e_prci.c
index c906f11..4cbce48 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/riscv/sifive_e_prci.c
@@ -85,7 +85,7 @@ static void sifive_prci_init(Object *obj)
     SiFivePRCIState *s = SIFIVE_E_PRCI(obj);
 
     memory_region_init_io(&s->mmio, obj, &sifive_prci_ops, s,
-                          TYPE_SIFIVE_E_PRCI, 0x8000);
+                          TYPE_SIFIVE_E_PRCI, SIFIVE_E_PRCI_REG_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
     s->hfrosccfg = (SIFIVE_PRCI_HFROSCCFG_RDY | SIFIVE_PRCI_HFROSCCFG_EN);
diff --git a/include/hw/riscv/sifive_e_prci.h b/include/hw/riscv/sifive_e_prci.h
index 7932fe7..81e506b 100644
--- a/include/hw/riscv/sifive_e_prci.h
+++ b/include/hw/riscv/sifive_e_prci.h
@@ -47,6 +47,8 @@ enum {
     SIFIVE_PRCI_PLLOUTDIV_DIV1  = (1 << 8)
 };
 
+#define SIFIVE_E_PRCI_REG_SIZE  0x1000
+
 #define TYPE_SIFIVE_E_PRCI      "riscv.sifive.e.prci"
 
 #define SIFIVE_E_PRCI(obj) \
-- 
2.7.4


