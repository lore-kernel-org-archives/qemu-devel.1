Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06710C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 22:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57A7214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 22:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VNlcrqrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57A7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgGj7-0001Jm-PP
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 18:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44544)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=073dc7726=alistair.francis@wdc.com>)
 id 1hgGia-0000so-UK
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 18:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=073dc7726=alistair.francis@wdc.com>)
 id 1hgGiZ-000421-PT
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 18:48:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=073dc7726=alistair.francis@wdc.com>)
 id 1hgGiZ-0003ys-4d
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 18:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561589428; x=1593125428;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fv+dBrw8Af1rOeCzCqUq1cX/iYawMdK17OWtjPNg5J4=;
 b=VNlcrqrflZewi86bJxzURE/9qPauZzgnHcB6pt3grAaaVL9P7Iu2PKUh
 qAs6RkI+dPtqQBbSMOwmrO106AQv3mafzCHra0Y9SpE2v8gRdiewvFNO8
 tExKES2jSOsCvmD6c4273oB1CZ3aDrCtFmmTc78ijW0PaCBEBHLLkfZ/o
 uu5f3sbtzqWFcaAaidbVny45yUEDdiqNPraIE+0WdqKOSjTwvkfrLk4yK
 gSsAFt/imC68eJLmN+4CizMej4O9e7skchcrP8RWjXghfxTb5yiFMR+hz
 A86Sd3TufDHIfQChvqC3l+kboSAS5t6DMcp2BmP8tyeMO5lM+twrDgxLc w==;
X-IronPort-AV: E=Sophos;i="5.63,421,1557158400"; d="scan'208";a="211437468"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 06:50:19 +0800
IronPort-SDR: PxigtWkDvxovXuIDw208eSq3n8p7TrAeS9MxMDp3TUsF57381TK5O/uXVv0jV2gffjJXHLJ3es
 tvNNDjfJkdReEkDMnfuKy2VJ9xL+Bzo4OwhVbE6RmVicq4F3dERykGp7TSVH4Db63SwWGMtj/v
 DFckeAEFoG6Y+fZBW7AARa5m/d5l08M+/DUs6kbJHzz4uj/+iwzPnZ0UX1ct58LfoPPlo+Bn9x
 7vXpUrUZLINob4FNBIhDaNRUeG7Lp78HuuNlIz579Xe75gFnYLDd1J0HGRyfXU8x0VxpulbKYo
 rzoNgc8Y5yRaeBfZluWIdVrk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 26 Jun 2019 15:47:45 -0700
IronPort-SDR: 1doCjqKWvjQ+f1OVuss2HOEJo+iMk26G0QUEH38y3nuGbQK07Hje5mVA5BZD9sW0phRX6zDxpt
 FwJOrLShfu9mkAyU34QzGEdQu7QYTrfLd5PZQoe3RC1pY5YB8QFEQFd2VHv2KZugyM89x20Nsd
 QPSd2PrbB6/2GGgLFxFIiKP7rUSw03ujYdqALqFDHmi2gaxiTaIDMCoa0TeA+vJ7dLx9eRgZ4D
 rX08KLNrK1aBSFcNSCsMBz5JLpeO8i+HwB+3XA8VqmKQZTGbeWTke9VJfy3D8P88e+kPrMqNoQ
 yns=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Jun 2019 15:48:36 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 15:46:05 -0700
Message-Id: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 1/1] hw/scsi: Report errors and sense to
 guests through scsi-block
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
Cc: fam@euphon.net, pbonzini@redhat.com, shinichiro.kawasaki@wdc.com,
 alistair.francis@wdc.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

When host block devices are bridged to a guest system through
virtio-scsi-pci and scsi-block driver, scsi_handle_rw_error() in
hw/scsi/scsi-disk.c checks the error number to judge which error to
report to the guests. EIO and EINVAL are not reported and ignored. Once
EIO or EINVAL happen, eternal wait of guest system happens. This problem
was observed with zoned block devices on the host system attached to the
guest via virtio-scsi-pci. To avoid the eternal wait, add EIO and EINVAL
to the list of error numbers to report to the guest.

On top of this, it is required to report SCSI sense data to the guest
so that the guest can handle the error correctly. However,
scsi_handle_rw_error() does not passthrough sense data that host
scsi-block device reported. Instead, it newly generates fixed sense
data only for certain error numbers. This is inflexible to support new
error codes to report to guest. To avoid this inflexiblity, pass the SCSI
sense data that the host scsi-block device reported as is. To be more
precise, set valid sense_len in the SCSIDiskReq referring sb_len_wr that
host SCSI device SG_IO ioctl reported. Add update_sense callback to
SCSIDiskClass to refer the SG_IO ioctl result only when scsi-block device
is targeted.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/scsi/scsi-disk.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index ed7295bfd7..6801e3a0d0 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -62,6 +62,7 @@ typedef struct SCSIDiskClass {
     DMAIOFunc       *dma_readv;
     DMAIOFunc       *dma_writev;
     bool            (*need_fua_emulation)(SCSICommand *cmd);
+    void            (*update_sense)(SCSIRequest *r);
 } SCSIDiskClass;
 
 typedef struct SCSIDiskReq {
@@ -438,6 +439,7 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
 {
     bool is_read = (r->req.cmd.mode == SCSI_XFER_FROM_DEV);
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+    SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
     BlockErrorAction action = blk_get_error_action(s->qdev.conf.blk,
                                                    is_read, error);
 
@@ -452,9 +454,12 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
              * pause the host.
              */
             assert(r->status && *r->status);
+            if (sdc->update_sense) {
+                sdc->update_sense(&r->req);
+            }
             error = scsi_sense_buf_to_errno(r->req.sense, sizeof(r->req.sense));
             if (error == ECANCELED || error == EAGAIN || error == ENOTCONN ||
-                error == 0)  {
+                error == EIO || error == EINVAL || error == 0)  {
                 /* These errors are handled by guest. */
                 scsi_req_complete(&r->req, *r->status);
                 return true;
@@ -2894,6 +2899,13 @@ static int scsi_block_parse_cdb(SCSIDevice *d, SCSICommand *cmd,
     }
 }
 
+static void scsi_block_update_sense(SCSIRequest *req)
+{
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIBlockReq *br = DO_UPCAST(SCSIBlockReq, req, r);
+    r->req.sense_len = MIN(br->io_header.sb_len_wr, sizeof(r->req.sense));
+}
+
 #endif
 
 static
@@ -3059,6 +3071,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
     sc->parse_cdb    = scsi_block_parse_cdb;
     sdc->dma_readv   = scsi_block_dma_readv;
     sdc->dma_writev  = scsi_block_dma_writev;
+    sdc->update_sense = scsi_block_update_sense;
     sdc->need_fua_emulation = scsi_block_no_fua;
     dc->desc = "SCSI block device passthrough";
     dc->props = scsi_block_properties;
-- 
2.22.0


