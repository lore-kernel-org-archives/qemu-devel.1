Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B936C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:59:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB2820818
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB2820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42441 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0zv-0005Av-H5
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:59:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0rv-0006MH-Sc
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hR0ro-0001YG-7T
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hR0ri-0001Tp-TU
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:51:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E26F2C05B038
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:51:04 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-17.ams2.redhat.com
	[10.36.112.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 314715C557
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 20:51:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 22:50:25 +0200
Message-Id: <1557953433-19663-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Wed, 15 May 2019 20:51:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/21] sun4m: obey -vga none
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not create a TCX if "-vga none" was passed on the command line.
Remove some dead code along the way to avoid big reindentation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/sparc/sun4m.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index ca1e382..07d126a 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -850,7 +850,6 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     uint32_t initrd_size;
     DriveInfo *fd[MAX_FD];
     FWCfgState *fw_cfg;
-    unsigned int num_vsimms;
     DeviceState *dev;
     SysBusDevice *s;
 
@@ -909,8 +908,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         error_report("Unsupported depth: %d", graphic_depth);
         exit (1);
     }
-    num_vsimms = 0;
-    if (num_vsimms == 0) {
+    if (vga_interface_type != VGA_NONE) {
         if (vga_interface_type == VGA_CG3) {
             if (graphic_depth != 8) {
                 error_report("Unsupported depth: %d", graphic_depth);
@@ -945,7 +943,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
         }
     }
 
-    for (i = num_vsimms; i < MAX_VSIMMS; i++) {
+    for (i = 0; i < MAX_VSIMMS; i++) {
         /* vsimm registers probed by OBP */
         if (hwdef->vsimm[i].reg_base) {
             empty_slot_init(hwdef->vsimm[i].reg_base, 0x2000);
-- 
1.8.3.1



