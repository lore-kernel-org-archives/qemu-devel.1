Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017F5C76196
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD14D21738
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IImjpVp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD14D21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIZ1-0000ua-Am
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59760)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYV-0007sJ-Ms
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYU-00038L-Dn
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYU-00037i-6x
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id x15so17659935wmj.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=s2VORvYpXzDmq+pVd9Zwp8LUzbuylAos0sk8Od+qroI=;
 b=IImjpVp53nxxXA496kh9MAUu6SKssJAonAL8l/Lzb/7TPPiCgG8LRYZ8HdCSUzKTaf
 4OqRd8FMzQIopyIElB3V6wRArsHSrp9qE2Et5K6emylBjpD5IrTZbTGNGm2NUxbsYpMZ
 OtQej6WzNg6BHJkapPHnl22q5JRYLH0oV9eSnAkJyEtsD35Pko1zfVj04c9UfjkMzcdT
 aZtGyjvMXmSqO1sf+8vxKYs6Ll/+WmS97loqXl9Toan8AZLu9qkhQbQQ4AAH3IXml9Xe
 FvKV0IcTjD1SVewkR0yZFPz6g5cAdYF/+NEvS82FtaZZKxCO1TcKYwp9BOjcRV+8aBxO
 XILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=s2VORvYpXzDmq+pVd9Zwp8LUzbuylAos0sk8Od+qroI=;
 b=KSDn8ZmIl5gZXE8Up2eut432wUnfQ9M4tR62ni9He77WVJhJc8AYsQs97ASRVQ/1nB
 EdoKgm2gf+DhOC/T2HIe/37I/+flxW9q7rShvubJLHuhE91JuhUBXUuz6KocpWWt+ffj
 E0J1UQ9pVY0doWIqJWoOz193bsyrBiUkqXM2GG1YvEaT9DQKCan7TljBmlxYeluCD4pl
 FL45IxSqknJ/n1Ckzb3qo+dq/u4jAn6rcytv+XpfrdQC8ICU+Qf0bBvw5y2XqVYUs3Jh
 5WAjfmPoGOOQuoYk+dsosuaTlnLr5zAS0I/hpiIh4a24Y2S/3nRGycSkp4oc9xLvHHyc
 Hydg==
X-Gm-Message-State: APjAAAVUao9c8Q+e0SLJNKNUYA9ljyCK27xoyHvMlTy6hGZv+tosOpxY
 K1bV9fy0BGnUddYHDCfe6G36imfrAMI=
X-Google-Smtp-Source: APXvYqwzQ97h5vi3QX8wv3yRppLlNVLVp4LXyJMr5t8LmW7ae/maxVSn28qefUu325KJ96LNXOQSFw==
X-Received: by 2002:a1c:d108:: with SMTP id i8mr30585909wmg.28.1563264680696; 
 Tue, 16 Jul 2019 01:11:20 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:10:59 +0200
Message-Id: <1563264677-39718-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
Subject: [Qemu-devel] [PULL 01/19] scsi-disk: pass sense correctly for
 guest-recoverable errors
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
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>

When an error was passed down to the guest because it was recoverable,
the sense length was not copied from the SG_IO data.  As a result,
the guest saw the CHECK CONDITION status but not the sense data.

Signed-off-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index ed7295b..5d3fb3c 100644
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
 
@@ -456,6 +458,7 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
             if (error == ECANCELED || error == EAGAIN || error == ENOTCONN ||
                 error == 0)  {
                 /* These errors are handled by guest. */
+                sdc->update_sense(&r->req);
                 scsi_req_complete(&r->req, *r->status);
                 return true;
             }
@@ -2894,6 +2897,12 @@ static int scsi_block_parse_cdb(SCSIDevice *d, SCSICommand *cmd,
     }
 }
 
+static void scsi_block_update_sense(SCSIRequest *req)
+{
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIBlockReq *br = DO_UPCAST(SCSIBlockReq, req, r);
+    r->req.sense_len = MIN(br->io_header.sb_len_wr, sizeof(r->req.sense));
+}
 #endif
 
 static
@@ -3059,6 +3068,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, void *data)
     sc->parse_cdb    = scsi_block_parse_cdb;
     sdc->dma_readv   = scsi_block_dma_readv;
     sdc->dma_writev  = scsi_block_dma_writev;
+    sdc->update_sense = scsi_block_update_sense;
     sdc->need_fua_emulation = scsi_block_no_fua;
     dc->desc = "SCSI block device passthrough";
     dc->props = scsi_block_properties;
-- 
1.8.3.1



