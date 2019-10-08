Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B2C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F80A20673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F80A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHnBw-0006Q2-7A
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 06:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iHn7P-0001sL-AR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iHn7N-0003kz-Nj
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:53:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iHn7N-0003kI-Hx
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:53:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C89E5300CA4B;
 Tue,  8 Oct 2019 10:53:24 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-109.rdu2.redhat.com
 [10.10.120.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 062DA5D9C9;
 Tue,  8 Oct 2019 10:53:22 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 1/4] fw_cfg: bump file slots to 40
Date: Tue,  8 Oct 2019 12:52:56 +0200
Message-Id: <20191008105259.5378-2-lersek@redhat.com>
In-Reply-To: <20191008105259.5378-1-lersek@redhat.com>
References: <20191008105259.5378-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 08 Oct 2019 10:53:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I count approximately 30 additions of named fw_cfg files, with
fw_cfg_add_file() / fw_cfg_add_file_callback() / fw_cfg_modify_file(). On
top of those, vgaroms/* and genroms/* files are added with invocations of
rom_add_vga() and rom_add_option().

While it's pretty unlikely that a QEMU cmdline causes all of those named
files to be added simultaneously, it now seems prudent to bump
FW_CFG_FILE_SLOTS_DFLT from 32 to a higher value. Increment it by 8.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Ref: https://bugzilla.tianocore.org/show_bug.cgi?id=3D1515
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/core/machine.c | 2 ++
 hw/nvram/fw_cfg.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3bf8af..fefc9e1f0dd0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -29,6 +29,8 @@
=20
 GlobalProperty hw_compat_4_1[] =3D {
     { "virtio-pci", "x-pcie-flr-init", "off" },
+    { "fw_cfg_mem", "x-file-slots", "0x20" },
+    { "fw_cfg_io", "x-file-slots", "0x20" },
 };
 const size_t hw_compat_4_1_len =3D G_N_ELEMENTS(hw_compat_4_1);
=20
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 7dc3ac378ee0..cd785fad93b1 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -40,7 +40,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
=20
-#define FW_CFG_FILE_SLOTS_DFLT 0x20
+#define FW_CFG_FILE_SLOTS_DFLT 0x28
=20
 /* FW_CFG_VERSION bits */
 #define FW_CFG_VERSION      0x01
--=20
2.19.1.3.g30247aa5d201



