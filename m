Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439CFC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062EA2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JhZJaXLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062EA2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDeXh-0005k6-My
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 20:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRF-0006yY-BI
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRD-0008Oc-TG
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12537)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRD-0008JB-I2; Thu, 26 Sep 2019 20:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569545327; x=1601081327;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nxR0cevHPoCa6ZAoEMcVfA+4AkUT/xbUUyQ9z16k0RM=;
 b=JhZJaXLvH92lQ0NJlZw+yIpJoLOrHLXMKDKRhPm22qmzCeRiFBbWt4zw
 jUuj95D1xHGJT2SEHo46nKlHqYShEh3HFVLCn2NfrW18HZ223YimL/JOb
 Ad+/qFbigOE+aRXpD7iu6LxQ1RzrFWaTB8SMjbbLzyr9jcxUyP6uDNZ6z
 6tMBRjw4HD6gVA3y33C1hutQWywFzePxBebdz3CbBD03h/Uwv+Btc0tMd
 Xb/VrkhzPLdh+hyBZjb1VmpN760+qEPZ4sZgwKj2ElWuDcy39qBkAO91m
 bQYye8fPfRuSaTdzVMCQaDoVPDPAlp1Qdi3rce8DQwxuG0sfIEganiDnL g==;
IronPort-SDR: 8fhBed3hM0bmeo8yXJThgnUFw41FX7Jhw8CZXWauFflhHCM4iQ9sl5t20O6V5/k60RtpRfNkyA
 fXJQskrmjHX5y1Pmb23rK2Gxz0kSbRAbVC8Usz8mkYELhfB+IrAa5Suobuj1FK4yCUUp36oKko
 vJMR6n5+7hYuIH/+KCy/MC33sYbwN7XWNBUvV5qMzV/bYRGrQoXAG+9/Gs19Ut/aKZNr8OjxDZ
 TVVyS9gWVD+jI7G+HhrQPHXoh4ZPAB2K7/j1swGUcVujVyIuVPOstOjdS3xoCBer/M35UG+Vsw
 SeA=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; d="scan'208";a="119225548"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:48:47 +0800
IronPort-SDR: vouyPs3nx8JtSswKza0z3A9Izax2/uKqg+oFP2EVyvkU9yfODw1oIstU7ahWgfctjdVr18WSDO
 7VGid4ANkxQeeAQt5h5Hmb03GMAV08xnw7I7B9bbMQjFAZFCtp+78A5HYnmu7rUXHKaUKUHnzg
 99TDkZWn+bBeC2nwwISU1L0h0/3/oc9sDpN9FdHWcFBxqW16kZhNLHpEqzqEWoS0xt2RHR7E9d
 CJ8Kis6OUtj41cApEG6a2sBFTVdFfkbB5zIaE+xsy+kfU0dqNz2L3mRhjcRE8OoFi7cfNuzImk
 zRxXokvJWuomWnIHHxYtMdYu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 17:45:02 -0700
IronPort-SDR: yaymgfAkUFI9xagzkVpt6a2njHihlu3bLi3ptod/B3TkQj4Gqy55IesYp69db13Y9XZVgt/TYC
 j3ZpOmPVKehpkW7XCnTXLfIqFwLYd8AIulLcLRPSYxkOm6yD6Z9gftHrRnHpOahCydGzXBAs6/
 G0cvb45cvwQNOw/stUhNPqjC9iyQwBxH0YXMnEQgJcRC++TzYFYcX2T/3oVIBM5TuJxaoZh4A2
 JhBA0EVkoBIXnKlNr5gkZrYxBOj7NHr4BREgKGjZ0CDf55KrtxBPZ/NqOjYhEyO7jrG7e3u9yV
 SlQ=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2019 17:48:47 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 4/7] riscv/sifive_u: Add the start-in-flash property
Date: Thu, 26 Sep 2019 17:44:28 -0700
Message-Id: <a24af06cea57073f4a75381755ab05e825679445.1569545046.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569545046.git.alistair.francis@wdc.com>
References: <cover.1569545046.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a property that when set to true QEMU will jump from the ROM code to
the start of flash memory instead of DRAM which is the default
behaviour.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c         | 27 +++++++++++++++++++++++++++
 include/hw/riscv/sifive_u.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index f5741e9a38..33b55d0d5b 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -373,6 +373,10 @@ static void riscv_sifive_u_init(MachineState *machine)
                                        /* dtb: */
     };
 
+    if (s->start_in_flash) {
+        reset_vec[6] = memmap[SIFIVE_U_FLASH0].base; /* start: .dword FLASH0_BASE */
+    }
+
     /* copy in the reset vector in little_endian byte order */
     for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
         reset_vec[i] = cpu_to_le32(reset_vec[i]);
@@ -432,8 +436,31 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_CADENCE_GEM);
 }
 
+static bool virt_get_start_in_flash(Object *obj, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    return s->start_in_flash;
+}
+
+static void virt_set_start_in_flash(Object *obj, bool value, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = value;
+}
+
 static void riscv_sifive_u_machine_instance_init(Object *obj)
 {
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = false;
+    object_property_add_bool(obj, "start-in-flash", virt_get_start_in_flash,
+                             virt_set_start_in_flash, NULL);
+    object_property_set_description(obj, "start-in-flash",
+                                    "Set on to tell QEMU's ROM to jump to " \
+                                    "flash. Otherwise QEMU will jump to DRAM",
+                                    NULL);
 }
 
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index a921079fbe..2656b43c58 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -57,6 +57,8 @@ typedef struct SiFiveUState {
 
     void *fdt;
     int fdt_size;
+
+    bool start_in_flash;
 } SiFiveUState;
 
 enum {
-- 
2.23.0


