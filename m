Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED412C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6509206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a1kZ7hl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6509206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5d8a-0003V1-VE
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 18:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=485daf1e4=dmitry.fomichev@wdc.com>)
 id 1k5d7J-0001xS-Of; Tue, 11 Aug 2020 18:51:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=485daf1e4=dmitry.fomichev@wdc.com>)
 id 1k5d7G-0004Nx-RQ; Tue, 11 Aug 2020 18:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597186294; x=1628722294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ucFbWE2g3XOws9r1kF87iHZx2m/T2BIkWc3UeuAWIW0=;
 b=a1kZ7hl2ObhZdnYzwV22o9IVOXDv6bqEuBvUUsOJSwJEw1yk8QaEXOlx
 euSU0wxUIm+hYP0Knvp0S51FB94FfD/XOWo5/C7NF3yhw4TR7wCV/JUYo
 asZ1xcEduG19H//WkbF6mdNIeLUGDxzKE6d/3y7kCW2wqcbhUOyOAszfZ
 yRqjygl1NpsM0iVkhTSOLlP3cfnprqGEVeZjP4Eg7oo6AkgI/wn1hdWhy
 /EyhRWkgBDf5g0AgGsSUzncr6Qd9KIyk1Ca0xy1SaIVdkBZ6txFmIocPb
 RkLPiZrw7/Mewxq46gOoXjwh4s5k9QYBIquV7pqPNnjDiq8iTm6JhzbBU w==;
IronPort-SDR: xktr7LALH1FzUagKxUIGWNmYk/TnAGvIlwJtkb/qE0tSLj0A2hvxP4Kyxl3logs5xMSpo8o+Dh
 AWXM+5FAsjkPHcFHFNrv+PjZNJbAviboJoGiSyBQeLEqR0kDvV75UF5DKyuAqLoU4OuZmlVZ1K
 +b9W44kXRJrPEMPlXQliUufG+tleDMfuLt3VA3/smSXzD19RE65IhZS7MObDysVarEcBFdvx5H
 s34eCeVuGr/9O1pG78TackJEumd8OkO40vIq6+2ExloEtkyyqaz/epPFgq1bykAY3qmYioV4Lj
 krI=
X-IronPort-AV: E=Sophos;i="5.76,302,1592841600"; d="scan'208";a="144706611"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2020 06:51:33 +0800
IronPort-SDR: g4uEnXc4TxoX8qbVqQ0FaQumcXLm4LuZ7Nh5fNEkXl062qHqbSvunSNC91alyPAOcHIkvPdAEV
 wRLDahgHHv6w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2020 15:38:43 -0700
IronPort-SDR: 5MPKS1jip1vB1RRIKqrsSmLj0Xlh2HjWNGP5G7KSVe8POHkoApdkLYkUuhBVeT2goeoIcdfy3g
 R0GR3iW0TugA==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2020 15:51:32 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH 2/2] scsi-generic: Fix HM-zoned device scan
Date: Wed, 12 Aug 2020 07:51:22 +0900
Message-Id: <20200811225122.17342-3-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
References: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=485daf1e4=dmitry.fomichev@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 18:51:29
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Several important steps during device scan depend on SCSI type of the
device. For example, max_transfer property is only determined and
assigned if the device has the type of TYPE_DISK.

Host-managed ZBC disks retain most of the properties of regular SCSI
drives, but they have their own SCSI device type, 0x14. This prevents
the proper assignment of max_transfer property for HM-zoned devices in
scsi-generic driver leading to I/O errors if the maximum i/o size
calculated at the guest exceeds the host value.

To fix this, define TYPE_ZBC to have the standard value from SCSI ZBC
standard spec. Several scan steps that were previously done only for
TYPE_DISK devices, are now performed for the SCSI devices having
TYPE_ZBC too.

Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/scsi/scsi-generic.c   | 10 ++++++----
 include/scsi/constants.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 86ed0a3822..2cb23ca891 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -162,7 +162,8 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
         }
     }
 
-    if (s->type == TYPE_DISK && (r->req.cmd.buf[1] & 0x01)) {
+    if ((s->type == TYPE_DISK || s->type == TYPE_ZBC) &&
+        (r->req.cmd.buf[1] & 0x01)) {
         page = r->req.cmd.buf[2];
         if (page == 0xb0) {
             uint32_t max_transfer =
@@ -299,10 +300,11 @@ static void scsi_read_complete(void * opaque, int ret)
     }
     blk_set_guest_block_size(s->conf.blk, s->blocksize);
 
-    /* Patch MODE SENSE device specific parameters if the BDS is opened
+    /*
+     * Patch MODE SENSE device specific parameters if the BDS is opened
      * readonly.
      */
-    if ((s->type == TYPE_DISK || s->type == TYPE_TAPE) &&
+    if ((s->type == TYPE_DISK || s->type == TYPE_TAPE || s->type == TYPE_ZBC) &&
         blk_is_read_only(s->conf.blk) &&
         (r->req.cmd.buf[0] == MODE_SENSE ||
          r->req.cmd.buf[0] == MODE_SENSE_10) &&
@@ -617,7 +619,7 @@ static void scsi_generic_read_device_identification(SCSIDevice *s)
 void scsi_generic_read_device_inquiry(SCSIDevice *s)
 {
     scsi_generic_read_device_identification(s);
-    if (s->type == TYPE_DISK) {
+    if (s->type == TYPE_DISK || s->type == TYPE_ZBC) {
         scsi_generic_set_vpd_bl_emulation(s);
     } else {
         s->needs_vpd_bl_emulation = false;
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 874176019e..2a32c08b5e 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -218,6 +218,7 @@
 #define TYPE_ENCLOSURE      0x0d    /* Enclosure Services Device */
 #define TYPE_RBC            0x0e    /* Simplified Direct-Access Device */
 #define TYPE_OSD            0x11    /* Object-storage Device */
+#define TYPE_ZBC            0x14    /* Host-managed Zoned SCSI Device */
 #define TYPE_WLUN           0x1e    /* Well known LUN */
 #define TYPE_NOT_PRESENT    0x1f
 #define TYPE_INACTIVE       0x20
-- 
2.21.0


