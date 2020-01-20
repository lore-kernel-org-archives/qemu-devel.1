Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6128BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:18:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA15217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXYyYkKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA15217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itahC-00012s-Uk
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1itaWV-0005rI-Nl
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1itaWU-0001hJ-Nb
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:35 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:41607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1itaWU-0001gg-Iq
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:34 -0500
Received: by mail-oi1-x22e.google.com with SMTP id i1so29069056oie.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 09:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1wu5g7+p7wcL2vh9OtQFkZ0v1XFmjPDGg3VgD4d9f2E=;
 b=gXYyYkKYM4Ro4tfDWsEMoeRtlRXxmGC/cHIGiQJm4L1YTyPBWJPhQzszNtLr8svF3N
 9CHMyDvvQaa7Oe4t2zwr/yl/wTZB4C3rKf2in8F2S9X6RxqjqDIsrKqprBSjvDLDfvXP
 yL88rIE3rgdNewX+OazOQ/SXLCd+g9AqX6AIha/1Fs/psleebJWDFtwtgao8FoD9SOvD
 ZjFcf4E3UujAxSSWK2jB2DXlcn3e2U0vcaJsIe0eqbtFvodnkstikh3SFRis4bKLmi14
 jzHds1iHhZnBv/bQeeBlUVrC4WrgLXwOxLdD7hWnUvu1T4GyRdrHZQ1tAL2Xowkwk08p
 pe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1wu5g7+p7wcL2vh9OtQFkZ0v1XFmjPDGg3VgD4d9f2E=;
 b=cm7B1KCFh899scrJXMhrVtOet599Uy7YImjEsABaROhIcggHTO31YfEFP4x8FyGXqj
 CXK+CT4MY/+00j6SwZESoIg/MDoTyR7Xk2SW9vCghupIBmvauOvcYoQDwSiHbXSXdkVf
 dMd9AyXt6wJ/7YMijmQFROhQqC5AKPa2KPm7uQ9rQgUwoPzR+Xi0ljX5Ack2SURUcjzU
 VeAFc5M/C8O1kl8CHDD/CZeLAIB+l8+Hc2GDV81b9a/0MH32v+cAScPN+9+09PqKRNmr
 4bcSqs0j0MfoXMTuXogsjjj9plc1wYHasm2n5LoVEvs7GjJgbfCVxnKXwGLx/0TbFCH0
 aCzw==
X-Gm-Message-State: APjAAAUYYE8kLKYvBkNcPmOTTLS76IJGQnN/seNyPgBZ7BcmQQukqLgK
 1XrqcqU7QSHphTHCpVnDuzjP12U=
X-Google-Smtp-Source: APXvYqzixw4J4jlcIoZuMErwT0C/7Xu0GYp8YXkHTyQDviEaB/kX55myIAMziU5sST32V9OxNA2PQQ==
X-Received: by 2002:a54:4501:: with SMTP id l1mr186599oil.101.1579540053675;
 Mon, 20 Jan 2020 09:07:33 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id y13sm12461746otk.40.2020.01.20.09.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 09:07:33 -0800 (PST)
Received: from t560.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:9c9c:d583:ce3d:f87a])
 by serve.minyard.net (Postfix) with ESMTPA id 94F77180054;
 Mon, 20 Jan 2020 17:07:31 +0000 (UTC)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [PATCH 4/5] hw/i2c/Kconfig: Add an entry for the SMBus
Date: Mon, 20 Jan 2020 11:07:24 -0600
Message-Id: <20200120170725.24935-5-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120170725.24935-1-minyard@acm.org>
References: <20200120170725.24935-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The System Management Bus is more or less a derivative of the I2C
bus, thus the Kconfig entry depends of I2C.
Not all boards providing an I2C bus support SMBus.
Use two different Kconfig entries to be able to select I2C without
selecting SMBus.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191231183216.6781-6-philmd@redhat.com>
---
 hw/i2c/Kconfig       | 8 ++++++--
 hw/i2c/Makefile.objs | 3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 2bbd395813..09642a6dcb 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -1,9 +1,13 @@
 config I2C
     bool
 
+config SMBUS
+    bool
+    select I2C
+
 config SMBUS_EEPROM
     bool
-    depends on I2C
+    select SMBUS
 
 config VERSATILE_I2C
     bool
@@ -11,7 +15,7 @@ config VERSATILE_I2C
 
 config ACPI_SMBUS
     bool
-    select I2C
+    select SMBUS
 
 config BITBANG_I2C
     bool
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index d7073a401f..cbbc8507a3 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -1,4 +1,5 @@
-common-obj-$(CONFIG_I2C) += core.o smbus_slave.o smbus_master.o
+common-obj-$(CONFIG_I2C) += core.o
+common-obj-$(CONFIG_SMBUS) += smbus_slave.o smbus_master.o
 common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
 common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
 common-obj-$(CONFIG_ACPI_X86_ICH) += smbus_ich9.o
-- 
2.17.1


