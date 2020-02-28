Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADECC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB09B246A3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbpE7AC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB09B246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7fAQ-0006Pa-V2
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7f9V-0004xD-MD
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7f9U-0002nR-O0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31880
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7f9U-0002nF-LG
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582894440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCU51xFXYmUd1xKOruip+g6P/RBBcNpYeEW6REUohy8=;
 b=WbpE7AC8HEHpMaktFAnWGHPIcy3C+xdp4CLUl3WifWcmSRSXYt89cyfYnt8CBeXEgOWmEJ
 kbaDOxgdwV2f2lcbXStm5fZoq5mKH0ed7zepBrGYj9LqLTaQyXI+sS96pp1X4dFQ+KxgFH
 /Rgp0TpcxG4ih5riPq7g7ArRmC1+6u4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-MmkjTIsIMF2wfRPl10hgxA-1; Fri, 28 Feb 2020 07:53:58 -0500
X-MC-Unique: MmkjTIsIMF2wfRPl10hgxA-1
Received: by mail-wm1-f72.google.com with SMTP id v21so456913wml.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 04:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=om0orcuUNcgbjYJFBk5NZd23kX2WFadmaS0vRzXLejY=;
 b=U1x1oBXhUVikAg/PYXJvDof3tzQ5jhXkyNtV3p8fgGpV5XyGt0CLl58B9LSHxhC5Qy
 9OpXm/HO5Jv2hw1cxtjwiWbjSM+q6mvwJqSSE1WaMY5wM5BqL1yCwLpDN+/PWwQoHXsX
 IbowDBmoVBpKEFUr7JBeEYmMIXbtNO4jMvGWZxq2aBaePdDkYWN6hjRO4qkpwZCV8wnK
 2GKmyXk6Uj67rARwQlIV1N+QPg4snvdScmST+fa4dj4oaD326ZPUuImTI4IaCtMPtTSp
 buefM96HvVUbzCYhbgLYJrQaUl5rGdSXhHD+AO84TUemAdWICYg+lq2v+IU7qbFV2Xac
 cUdQ==
X-Gm-Message-State: APjAAAWdNPEp9B8vMaYv2DSUQK5+IY+5qwVLtgO8XdmG9edmeJYLG2MN
 WqcKVGPttr+wO3ZQNukjOFxarjdvtt1yGDEjn8VeeHGDAH86aWUaY6VT82veArcRe/qAt15Voov
 hmO1ZguK/l64VA4M=
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr4981722wrt.403.1582894437407; 
 Fri, 28 Feb 2020 04:53:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzM/sxlv8YE5kDTiVHAvqAw/act89mDCgky2Xq6c5uz/7/BLXjqxyOoAdXff593ZcPROP5Hkw==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr4981711wrt.403.1582894437156; 
 Fri, 28 Feb 2020 04:53:57 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id d9sm12398979wrx.94.2020.02.28.04.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 04:53:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/arm/gumstix: Simplify since the machines are
 little-endian only
Date: Fri, 28 Feb 2020 13:53:47 +0100
Message-Id: <20200228125351.29482-2-philmd@redhat.com>
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
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

As the Connex and Verdex machines only boot in little-endian,
we can simplify the code.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
v2: Do not use target_words_bigendian(), arm-softmmu is only
    little endian (Peter Maydell)
---
 hw/arm/gumstix.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index f26a0e8010..3a4bc332c4 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -51,7 +51,6 @@ static void connex_init(MachineState *machine)
 {
     PXA2xxState *cpu;
     DriveInfo *dinfo;
-    int be;
     MemoryRegion *address_space_mem =3D get_system_memory();
=20
     uint32_t connex_rom =3D 0x01000000;
@@ -66,14 +65,9 @@ static void connex_init(MachineState *machine)
         exit(1);
     }
=20
-#ifdef TARGET_WORDS_BIGENDIAN
-    be =3D 1;
-#else
-    be =3D 0;
-#endif
     if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                               sector_len, 2, 0, 0, 0, 0, be)) {
+                               sector_len, 2, 0, 0, 0, 0, 0)) {
         error_report("Error registering flash memory");
         exit(1);
     }
@@ -87,7 +81,6 @@ static void verdex_init(MachineState *machine)
 {
     PXA2xxState *cpu;
     DriveInfo *dinfo;
-    int be;
     MemoryRegion *address_space_mem =3D get_system_memory();
=20
     uint32_t verdex_rom =3D 0x02000000;
@@ -102,14 +95,9 @@ static void verdex_init(MachineState *machine)
         exit(1);
     }
=20
-#ifdef TARGET_WORDS_BIGENDIAN
-    be =3D 1;
-#else
-    be =3D 0;
-#endif
     if (!pflash_cfi01_register(0x00000000, "verdex.rom", verdex_rom,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                               sector_len, 2, 0, 0, 0, 0, be)) {
+                               sector_len, 2, 0, 0, 0, 0, 0)) {
         error_report("Error registering flash memory");
         exit(1);
     }
--=20
2.21.1


