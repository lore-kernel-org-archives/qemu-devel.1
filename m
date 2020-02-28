Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010CAC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1664246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcW+qkUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1664246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7fCe-0001kK-0E
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7fA1-0005kr-Mc
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7fA0-0002vB-NY
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7fA0-0002uP-JF
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582894470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFVTFY7GEBgh7q7HWz8/cePShORRz7+aAiJuxr5/kZA=;
 b=TcW+qkUoUEku5KnqvIL1YpKS4CWkaO7VYLUWLLz723hs1CX1XJOGfVGAsVkeuozNXpxRYF
 ycovKlI5EmQ+oABcMcKn5YzMC+tpEdYXWrjoiKvQV3d5USwZ8/unpmdLpL4+5AdmaxNvY6
 9FBnB6FMnydfMBHP0DQXFKmB4ApkQL0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-3gN0aA4ZOJCIBD82HLGzfw-1; Fri, 28 Feb 2020 07:54:28 -0500
X-MC-Unique: 3gN0aA4ZOJCIBD82HLGzfw-1
Received: by mail-wm1-f71.google.com with SMTP id q20so85241wmg.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 04:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K6aC7TQ6a+95A3Kf8tkZ4l6ui47wA33c90/e4cK4bZs=;
 b=kmUW1ZA9kUWacPqDL3ieeJOHrmTndf0/d0qC4g1a9QgAtvSQCxqnufpKjVZZvsN6b0
 Iq1SAYGz49fV9Zh2ecMSsjuBji3OMUcudmnEKJWDxlxiPZJS6WnFeVYmBzqn4bSinxWz
 8G3e5yzsdUQOr9jnMnMAl2kGc+5mg1vAjHcC0fk4WXcqjVqWTds89oNSw1A1SydIeHY2
 m5Wryr8ESgIzp4TSg/zoeW4J9i81GtINJcO0619Lavp+iJ/Yb0tZsZ3WHDuOxc7Kf4tW
 5DR9Zm9uDRM6pMUSn1oxdL289XfHfh2uZL+TQaBVrnPREiSbvyc8Cdzzb+BHQFrq5qZb
 hBXw==
X-Gm-Message-State: APjAAAUvpjEhWSUE2MMyWVooy5beUUvMAvyI/H/NLNFCpE4iutnHonJw
 g7ul27XOekXH+VzAPwsSsHCe1yS74X/rQ0dTxU41UxR1+DVdlBY+RC5kF8AbSGjIqcgmCP5+A38
 +JPoS8HqTRpPeFfs=
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr4981948wrw.182.1582894466975; 
 Fri, 28 Feb 2020 04:54:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqw7z8D4EeKLFPXzjEbjIsJrYk6RlFT4N3p3BB47Ow70QZgCfP2Gtp3/SeLJ/mnkUQyXiuMgQA==
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr4981927wrw.182.1582894466774; 
 Fri, 28 Feb 2020 04:54:26 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id y7sm340988wrl.26.2020.02.28.04.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 04:54:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/arm/musicpal: Simplify since the machines are
 little-endian only
Date: Fri, 28 Feb 2020 13:53:51 +0100
Message-Id: <20200228125351.29482-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228125351.29482-1-philmd@redhat.com>
References: <20200228125351.29482-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only build the little-endian softmmu configurations. Checking
for big endian is pointless, remove the unused code.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/musicpal.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index db8b03cb83..b2d0cfdac8 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1645,22 +1645,12 @@ static void musicpal_init(MachineState *machine)
          * 0xFF800000 (if there is 8 MB flash). So remap flash access if t=
he
          * image is smaller than 32 MB.
          */
-#ifdef TARGET_WORDS_BIGENDIAN
-        pflash_cfi02_register(0x100000000ULL - MP_FLASH_SIZE_MAX,
-                              "musicpal.flash", flash_size,
-                              blk, 0x10000,
-                              MP_FLASH_SIZE_MAX / flash_size,
-                              2, 0x00BF, 0x236D, 0x0000, 0x0000,
-                              0x5555, 0x2AAA, 1);
-#else
         pflash_cfi02_register(0x100000000ULL - MP_FLASH_SIZE_MAX,
                               "musicpal.flash", flash_size,
                               blk, 0x10000,
                               MP_FLASH_SIZE_MAX / flash_size,
                               2, 0x00BF, 0x236D, 0x0000, 0x0000,
                               0x5555, 0x2AAA, 0);
-#endif
-
     }
     sysbus_create_simple(TYPE_MV88W8618_FLASHCFG, MP_FLASHCFG_BASE, NULL);
=20
--=20
2.21.1


