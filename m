Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81635C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503E521849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1V++fUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503E521849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoO4O-0005n9-Cu
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 04:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47149)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hoO4D-0005OF-25
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hoO4B-0003DO-W2
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:16:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hoO4B-0003Cu-Q6
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:16:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id n4so31377805wrs.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nJleUCNBRDLL3HyCCpVeuFb2qGcMhIFiwg4PYgcaX0o=;
 b=M1V++fUV4axr24/N6IonSsGBjC5ROOM3zXIIBwONLf1D+OVduoLjTVDjSqWyIpyCnt
 /cuK/e2Iesn/PX/+FduP+an22wpeBblAzBa38GkaK+zonlMXl7dBMfhGBatRxjamDBaV
 XnFNXo058u910gDj3Q6TiJSvAMBilO1oj9nFC7e1yXM6APxFyPdKTDKAQ/mXdfWtX7QX
 T7+LiQicr+dibn6LhbEg/RtBgGCF0GlW8U4CghE7Y1Dg1DovQz2HRQl339ktNgTvLkOf
 tOUHjayL+CcverjfXhlb83uc+dBzqXFT2KMW6F3NpYoU+U98LaIPTEUWuF1ac+AWX9Mp
 e7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=nJleUCNBRDLL3HyCCpVeuFb2qGcMhIFiwg4PYgcaX0o=;
 b=DUcBsi9EWivDumWK02+LiyGdpkNoJOBM43g0IOjAlGnrpc0rOhPGHFCuIUZkMU0TtK
 bHXDnHogxH1cWhfc6empWsMe0sOoslUS+sFy1LRACNSZ/43KvLbJsdxpV376uM9TWaNw
 yWj+JqIBhtVtH5sqX5QpJHdqKRRQxK+AZ/Bb1VrcepDyFADbsIHRkhYWETVUMdtjKd7e
 HF2gBevcc5lddCXkKeqMRPdU/+Ep3jdkdpjMa7CNML9qXhiBC28PtQdy5BABJgcVhl0O
 v6NKJm7RQXVpfDnXOfO8aL8bmSF2L9wvzmxhC2XZViri0DfDi8ThDxfC5qVCKuJxnJil
 6NBA==
X-Gm-Message-State: APjAAAWP3AkXtGRoYShg55oQXARNHXrvuVQ6nzsEq1+UBVbsWyb3FUk7
 ZZ7FgpLGDVqJ9GLhKXKnkEZMM8q/Xqg=
X-Google-Smtp-Source: APXvYqwv+sZjkrjAEGtWRrvlBlBmEBkqfn4uLSaAIANjURC3+NDlXKhc8pcwcjPyQ8QFbgA7wwoGYA==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr41763680wrq.340.1563524194158; 
 Fri, 19 Jul 2019 01:16:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id o7sm1758931wru.58.2019.07.19.01.16.33
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 01:16:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 10:16:32 +0200
Message-Id: <20190719081632.12770-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH] scsi-generic: Check sense key before request
 snooping and patching
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
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

When READ CAPACITY command completes, scsi_read_complete() function
snoops the command result and updates SCSIDevice members blocksize and
max_lba . However, this update is executed even when READ CAPACITY
command indicates an error in sense data. This causes unexpected
blocksize update with zero value for SCSI devices without
READ CAPACITY(10) command support and eventually results in a divide
by zero. An emulated device by TCMU-runner is an example of a device
that doesn't support READ CAPACITY(10) command.

To avoid the unexpected update, add sense key check in
scsi_read_complete() function. The function already checks the sense key
for VPD Block Limits emulation. Do the scsi_parse_sense_buf() call for
all requests rather than just for VPD Block Limits emulation, so that
blocksize and max_lba are only updated if READ CAPACITY returns zero
sense key.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
[Extend the check to all requests, not just READ CAPACITY]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index f07891b3f6..c11a0c9a84 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -254,24 +254,28 @@ static void scsi_read_complete(void * opaque, int ret)
 
     r->len = -1;
 
-    /*
-     * Check if this is a VPD Block Limits request that
-     * resulted in sense error but would need emulation.
-     * In this case, emulate a valid VPD response.
-     */
-    if (s->needs_vpd_bl_emulation && ret == 0 &&
-        (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) &&
-        r->req.cmd.buf[0] == INQUIRY &&
-        (r->req.cmd.buf[1] & 0x01) &&
-        r->req.cmd.buf[2] == 0xb0) {
+    if (r->io_header.driver_status & SG_ERR_DRIVER_SENSE) {
         SCSISense sense =
             scsi_parse_sense_buf(r->req.sense, r->io_header.sb_len_wr);
-        if (sense.key == ILLEGAL_REQUEST) {
+
+        /*
+         * Check if this is a VPD Block Limits request that
+         * resulted in sense error but would need emulation.
+         * In this case, emulate a valid VPD response.
+         */
+        if (sense.key == ILLEGAL_REQUEST &&
+            s->needs_vpd_bl_emulation &&
+            r->req.cmd.buf[0] == INQUIRY &&
+            (r->req.cmd.buf[1] & 0x01) &&
+            r->req.cmd.buf[2] == 0xb0) {
             len = scsi_generic_emulate_block_limits(r, s);
             /*
-             * No need to let scsi_read_complete go on and handle an
+             * It's okay to jup to req_complete: no need to
+             * let scsi_handle_inquiry_reply handle an
              * INQUIRY VPD BL request we created manually.
              */
+        }
+        if (sense.key) {
             goto req_complete;
         }
     }
-- 
2.21.0


