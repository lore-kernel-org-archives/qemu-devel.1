Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B38C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D562070D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 21:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxTQtk6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D562070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF3Rt-000421-9m
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 17:11:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3Nc-0000UU-Qv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hF3Na-000596-Fs
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:06:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
	id 1hF3Na-00058G-8c; Fri, 12 Apr 2019 17:06:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id h4so13592131wre.7;
	Fri, 12 Apr 2019 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=L3x/kH3COhh33wRKsD9DVr6ImO/OtH6bjTjff3YGWgE=;
	b=VxTQtk6ty5qfO8/g/4eAWEcCI/9KuDZPE+G48fVkC8QQMhKJb7dzi0ab3tyOxuG9Fr
	p7ZFm2RPo/8ms2zRSQqTiK2Dlpcx0w8JZn+FlnsrEcLJWqNZasONzrFpnT9Y+kP1uZev
	vgpWwsX/N/xUxP693y5LMom1shijd31dTHpl7wj/vReEQR4QgfeApIOYZb+BZ85DKlb8
	KSC7REtBJVFXxZ1IKUZER10I4Bh/0IjyKMOow3eG9TOl6JbYZBlEQ7z8uieoPe+feN1o
	SW/be2IsardicyYrHi+tEGMqH+IpGDL0orPUdPsvWDUZTTubNSM6qEOW2l7gDLlU/JsF
	tFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=L3x/kH3COhh33wRKsD9DVr6ImO/OtH6bjTjff3YGWgE=;
	b=n916psRGe4eboswq6BMb6b3tcgiap/y5pQQJeJOHRThb2lfS2G1a3kb11kl5KMB0De
	vrKkv8dk+R/6/qYLLb1gU4KrkyPOKQaj/exvk+zdJZQNWStSlni0g+KfBbGa0H6C2Aa1
	BSx0txYPzvk6morc2i48xY9rrxWy5MsDq+2EVStKAtxolYhj/3cuoyJbNeaJPnTUQKt2
	tDw0MzrLGkhnYkGiC6Ad1QJxNoSWGPZDYWC4hA8Svc5PuyTiHOajKb78vUltK9pbaa3k
	D2oDxRIw7XhBLJ1N1JwzPV2LknoJXWblZBtEWTBORzvyJXsmeHMXl1SO396Z8dEcIyC/
	T23w==
X-Gm-Message-State: APjAAAXwajr6aj7AeKjKkvMBGmSUO7wPFFSHC6EkOkzBwrWTnJEWojZE
	wVdmspGC11tkoRXPnhTvspjdxcJv
X-Google-Smtp-Source: APXvYqxxjlpYqfK+JVf4DgbaqDpUDPK5iPaOO2fZpecOEWxU6cLkUhaB/Sv9eEbos/J/nZCbDcxcSQ==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr38388536wrj.249.1555103192226;
	Fri, 12 Apr 2019 14:06:32 -0700 (PDT)
Received: from localhost (x4d0c5397.dyn.telefonica.de. [77.12.83.151])
	by smtp.gmail.com with ESMTPSA id 4sm7104563wmg.12.2019.04.12.14.06.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 14:06:31 -0700 (PDT)
From: Artyom Tarasenko <atar4qemu@gmail.com>
To: qemu-devel@nongnu.org,
	hpoussin@reactos.org
Date: Fri, 12 Apr 2019 23:06:18 +0200
Message-Id: <1555103178-21894-5-git-send-email-atar4qemu@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 4/4] hw/isa/i82378.c: use 1900 as a base year
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412210618.Uc8-x3elEkb-R4GyERT16t-3kEA4ErSPDX2c0Ve2PjY@z>

AIX 5.1 expects the base year to be 1900. Adjust accordingly.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 hw/isa/i82378.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index a5d67bc..546c928 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error **errp)
     isa = isa_create_simple(isabus, "i82374");
 
     /* timer */
-    isa_create_simple(isabus, TYPE_MC146818_RTC);
+    isa = isa_create(isabus, TYPE_MC146818_RTC);
+    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
+    qdev_init_nofail(DEVICE(isa));
 }
 
 static void i82378_init(Object *obj)
-- 
2.7.2


