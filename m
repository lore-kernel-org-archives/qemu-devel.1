Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827A0C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53652222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uu/CHPKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53652222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXix-0006Oo-Pf
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg5-0004Ee-3K
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXg3-0002i2-OW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXfz-0002dh-VS; Thu, 26 Sep 2019 13:35:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so3712987wrj.6;
 Thu, 26 Sep 2019 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=voiG7DWCSdFTStaEL19HrjsIseLBzBfq9/zOs+pAh+4=;
 b=uu/CHPKKHr5AgZc+QvoM46VVMKRFdKrFQYddb7i+3Ff/325da3M2zOhOOypeXbLKcs
 zo1M0UojOM6gk/UkIfLNoifogrWd10rlDHYeJXOVVi29NshhibQjImApnHj2B/u9kxzh
 oJDFyEYbSdD/XBGbsK3Ixq9dAlPBmMjiIsqz4C4StLd4DWOdkI2HAIGeXKcdyBzhW47z
 83v9xrGxuNAg9vkF1PTvih2fumZXmjB4qDPaWv17347MjpmYt3ztNnd8oASnosazSYr8
 51JmXrUwojq2l9AbdLQY1L7pElnKk7iw7huyVthKcwNZKXXOlAbiqrqtFN6hIc4XqCzM
 Vfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=voiG7DWCSdFTStaEL19HrjsIseLBzBfq9/zOs+pAh+4=;
 b=cLe093rgP1LfkTBE3uQRMsxqz0EklHM6hWRyXgKRJXIWf4d4X+qDk6h/hP1IbmJs3c
 jOnUTT7M6p7sC/AU020mK/L/3ywtNB+41gixBI/QhYVOkTQUsIaHJTrQemXePJOSEs7J
 Qe1pPCTSDZmnynawwdaKJQW+IMvMpMK6oc64fvwnQlrPGwCsf33EydIq9SIAzpdKZBHh
 Fmveh+NuYXZGG3i1Uc/EXXm0vgr/wroVaqkQO7eu/0ab0VKOLi6kFuqhx9CWYVooRMej
 DzqxrMYzLh1pB1r2agIi0C3/bL0OdZUCGAm3w8uliRfJZLhQZnqnVdubsub2t31zHFja
 jIJQ==
X-Gm-Message-State: APjAAAUoxvBicI6w5CVLfY0X4oFjIU7pmcbGImRwDtN4mqGYZRwHq+3h
 mBZatpesaI1hTd3RYaNe6ZuP6g/FZWg=
X-Google-Smtp-Source: APXvYqxw43EJJW3k6tDZQEtl/syOr4bzsuF/Swg0aA+DzdvvUQcoeNKvKADOavyhR/cItlQXqbjynw==
X-Received: by 2002:adf:904f:: with SMTP id h73mr3943294wrh.128.1569519273793; 
 Thu, 26 Sep 2019 10:34:33 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:34:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/19] hw/arm/raspi: Use the IEC binary prefix definitions
Date: Thu, 26 Sep 2019 19:34:09 +0200
Message-Id: <20190926173428.10713-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IEC binary prefixes ease code review: the unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/raspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 74c062d05e..615d755879 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -230,7 +230,7 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1024 * 1024 * 1024;
+    mc->default_ram_size = 1 * GiB;
     mc->ignore_memory_transaction_failures = true;
 };
 DEFINE_MACHINE("raspi2", raspi2_machine_init)
@@ -252,7 +252,7 @@ static void raspi3_machine_init(MachineClass *mc)
     mc->max_cpus = BCM283X_NCPUS;
     mc->min_cpus = BCM283X_NCPUS;
     mc->default_cpus = BCM283X_NCPUS;
-    mc->default_ram_size = 1024 * 1024 * 1024;
+    mc->default_ram_size = 1 * GiB;
 }
 DEFINE_MACHINE("raspi3", raspi3_machine_init)
 #endif
-- 
2.20.1


