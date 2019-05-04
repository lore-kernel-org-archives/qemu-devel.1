Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C98C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 21:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66CA820652
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 21:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7w8RtS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66CA820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hN1ro-0006Sg-Np
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 17:06:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oJ-0003tZ-Oj
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hN1oI-0004dw-PH
	for qemu-devel@nongnu.org; Sat, 04 May 2019 17:03:07 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
	id 1hN1oI-0004d8-JW; Sat, 04 May 2019 17:03:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id e28so12211776wra.0;
	Sat, 04 May 2019 14:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Yjawb15ilcgBDz3rr0CkGUbs4QxWlVrQBeuf1ek1VNA=;
	b=L7w8RtS5d1HSXcKSoAYq2jtc1aPMkU3zl4j5gPuP84F4YQBfgO3PBYqHivfmG9Cj0N
	VthgyJjKr5VXUchlNw12yBWUFfHaaQvxunweu68eITskG5pzo7K/ygVe24crBXQgMsQr
	KDPnmYlBMchIoZEHvzyvToh/JjNYznhpqAbrCBk/0V2Cr7Ek/cbha3uwwrQ31+SlR+Th
	+6Yf1CJCDA17Z/FDjjxr/OnDJEmevcYnSj/rX9bzQf4rML2vIkUNDQMhCOlhUu29e0sO
	FOuxsnEmH3iFfLeTMhLCD7bzoLnEWlTHINPyVlYxSVX7Tb/ayeVCC+gCfVRJ9qdFfQNT
	r0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Yjawb15ilcgBDz3rr0CkGUbs4QxWlVrQBeuf1ek1VNA=;
	b=qjJCn+BUONJqmX5YipHQR06k+/3Y/kydsFQpaLxsbPCsrYLpl9aKoBxIVneN8EI4RJ
	LwLXTKa9jOjiNEmwvVxW2ohFFTdIJ34fwxvMYo0/fBU0RmoLPYq337GKYLUuuJqWvcOo
	WtoApGhQIW8SGm6BsH4m+nDyEX0dF8hHjBnp9V60RSsm/9NyWzWjjx52/Pm5SAxcOeOh
	y454yvb8CQ/63lug3uWikA/oOumZh0r9J0bZ8lY2Vdk62CsD7XmcKVmbe0gO7V2WJw3k
	N02yvbuMK6h+VKArTKN9ZI0VUSpkmC//UhF4wBVmQN+ZkhE+SIQd2KEZHkKRo8+6LsHv
	Glwg==
X-Gm-Message-State: APjAAAXxoaXe8jAaDMqsCHFyFnLVbxOwJZsqXS2hEN0FdlyAOO1ygTeO
	SFlSHCbXFZ1PS0qT7X3ug7XQOrdC
X-Google-Smtp-Source: APXvYqzyaD2WuOegJroeaVNSqkzOSiGv5b6YX4R2hRTuTgjLYIrrrHEYUMJ25cKW0iNm5hhaFxGtsQ==
X-Received: by 2002:adf:f051:: with SMTP id t17mr11507304wro.73.1557003785613; 
	Sat, 04 May 2019 14:03:05 -0700 (PDT)
Received: from localhost ([46.114.6.7]) by smtp.gmail.com with ESMTPSA id
	t24sm14856936wra.58.2019.05.04.14.03.04
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 04 May 2019 14:03:04 -0700 (PDT)
From: Artyom Tarasenko <atar4qemu@gmail.com>
To: qemu-devel@nongnu.org,
	hpoussin@reactos.org
Date: Sat,  4 May 2019 23:02:34 +0200
Message-Id: <1557003754-26473-4-git-send-email-atar4qemu@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
References: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 3/3] hw/isa/i82378.c: use 1900 as a base year
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
Cc: "open list:PReP" <qemu-ppc@nongnu.org>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504210234.9SfLxcxmPXZN-_R54r0sdD3o9ceQWwM6SQscuf8mRe0@z>

AIX 5.1 expects the base year to be 1900. Adjust accordingly.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
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


