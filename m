Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D83C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6ED8246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmqD9rVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ED8246A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7fBj-0000MK-19
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7f9Z-00053H-Vb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7f9Z-0002p2-19
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49158
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7f9Y-0002on-U9
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582894444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGU4cckMOQBBSno3d5GnmeEO95k4ubXtwQS7BoucsBw=;
 b=OmqD9rVS1HM96Yh1mLzDv0AoAbfAjlXh7QBQWQ/mTBXuWQvojMgBdkCj5HqNxdJ54d7gOE
 xHr/JRUxfkWOiRh4R+tJpjSpoBXq53Gj82lV+gTshT6xJXduWZrwzLmsIznaCXUqW4tpkS
 bc/xp5w8TbtaDXjsBruDrnIPNgXHb6o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-qUzZ9cFTMduF2i3JS8Xo1A-1; Fri, 28 Feb 2020 07:54:02 -0500
X-MC-Unique: qUzZ9cFTMduF2i3JS8Xo1A-1
Received: by mail-wr1-f71.google.com with SMTP id z1so1289020wrs.9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 04:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/dnD18K5Rg50i85S9IuEqrMYly3TKELwfFapxO4Kdxw=;
 b=m5L9Jn0fyDb1CbKeRSUaRkGA663HpWr7jIW6pHJZrpt8K/04SN3vKhX/ANtbhOxWB+
 mll6vmOS4YgxRXIyD2hPtG66h8VKQLTu3IAfngGf6Y2LsXQmDn/W7c01Bg2sBbSYsg30
 +wUGdUXvY3ScQXovK15VUNIwBFZtQc7hOM6MoQEA7wHprxkjh2UEOvO6PVyrD1oGTv5C
 FBEKTxYXy+yMbQON2uKTgg5RLe/oaEyf2yQXkx+2XkeN8yMTqfPS/Qv0g8HndVBkDeBC
 o3dPQlh4Vviga7RBFXrIhLe8ZZ/y1u+gRIGBYOaY4rhOSXAEziYO5r7cqL65ez59b0cp
 KLmg==
X-Gm-Message-State: APjAAAUmbGX7OOrPGE2SfEJvS6m4utMzUys16fFApplPjdZCmoKbG4l1
 3zD/zbDNC88KyTyW6kYymOcaGyQUzS7nlVm0SpMZbRViePTzR7E+KsphmtTHZeXFoaOKwBmn5jk
 /fegMlrgOvqDJGs8=
X-Received: by 2002:a7b:c119:: with SMTP id w25mr4905043wmi.112.1582894441010; 
 Fri, 28 Feb 2020 04:54:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxOP4q9x5AyxNWEnf4sfeDn+4jd1+qHdoJpX9ZlWtegtCL1nCs2OEOMz+gvVSiFqM5gmmEcFg==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr4905028wmi.112.1582894440828; 
 Fri, 28 Feb 2020 04:54:00 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id d9sm12398979wrx.94.2020.02.28.04.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 04:54:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/arm/omap_sx1: Simplify since the machines are
 little-endian only
Date: Fri, 28 Feb 2020 13:53:49 +0100
Message-Id: <20200228125351.29482-4-philmd@redhat.com>
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
X-Received-From: 205.139.110.120
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
 hw/arm/omap_sx1.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 2bebab4171..de5ff447dc 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -114,7 +114,6 @@ static void sx1_init(MachineState *machine, const int v=
ersion)
     DriveInfo *dinfo;
     int fl_idx;
     uint32_t flash_size =3D flash0_size;
-    int be;
=20
     if (machine->ram_size !=3D mc->default_ram_size) {
         char *sz =3D size_to_str(mc->default_ram_size);
@@ -154,17 +153,11 @@ static void sx1_init(MachineState *machine, const int=
 version)
                                 OMAP_CS2_BASE, &cs[3]);
=20
     fl_idx =3D 0;
-#ifdef TARGET_WORDS_BIGENDIAN
-    be =3D 1;
-#else
-    be =3D 0;
-#endif
-
     if ((dinfo =3D drive_get(IF_PFLASH, 0, fl_idx)) !=3D NULL) {
         if (!pflash_cfi01_register(OMAP_CS0_BASE,
                                    "omap_sx1.flash0-1", flash_size,
                                    blk_by_legacy_dinfo(dinfo),
-                                   sector_size, 4, 0, 0, 0, 0, be)) {
+                                   sector_size, 4, 0, 0, 0, 0, 0)) {
             fprintf(stderr, "qemu: Error registering flash memory %d.\n",
                            fl_idx);
         }
@@ -187,7 +180,7 @@ static void sx1_init(MachineState *machine, const int v=
ersion)
         if (!pflash_cfi01_register(OMAP_CS1_BASE,
                                    "omap_sx1.flash1-1", flash1_size,
                                    blk_by_legacy_dinfo(dinfo),
-                                   sector_size, 4, 0, 0, 0, 0, be)) {
+                                   sector_size, 4, 0, 0, 0, 0, 0)) {
             fprintf(stderr, "qemu: Error registering flash memory %d.\n",
                            fl_idx);
         }
--=20
2.21.1


