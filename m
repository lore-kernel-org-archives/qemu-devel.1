Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775DBC76195
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466D82084C
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRWkQsYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466D82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hor93-0007z9-VB
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 11:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39858)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8U-00061I-1X
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8S-00088H-SM
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:57 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hor8S-00087f-LY
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id s15so10148286wmj.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gj1dzVnsDBAhFX864QFCDoNoirTM3GNCZ/rXgc7TqQ8=;
 b=BRWkQsYh5UjdBwmJmtyzBJuul/vu9LtLCtYntBXNp3blYAyact2pYhqP1i5tCO9fgq
 E9dneQTEZO7ew4SHJ1ubL6X76OHGzvs9/pF9qoD2wXr22UUHIb0DKKQc/50Zueuw5D93
 8LcJ1eN5RLyIP1QbNGbvizIaMKxP7IzCzTe/ZgFXwd7a+QkKS4AdG3guD1pO3rFOinrk
 qFt07XmXpW6i8e5SYo3rw4bqafghgymf6hfZVrt8eRd5h9WtlYwiYy0e/sOUa01tzSqs
 zOx82vsyCEJG0YJGKxSQxN6mYfmH/yH0S7WhYG0bQBKeVb7aUvXmQredu0QVdUktQGRW
 XWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gj1dzVnsDBAhFX864QFCDoNoirTM3GNCZ/rXgc7TqQ8=;
 b=qnY1mSzRK/R+YS9VhVw+Ao+PUwoVbwmru67ERlsMam8oCzFJR5Acet4VKp6FZcZCZB
 mWMqdwnmBhDvLE//kXaGzc52SYuMlq/Fkku9dJj7KbFm+bIk1Nt4oVLlIwo8a6SUdk/0
 mda+LD9zssO3O60zyI9OEvx3YkkS01LQxsqIFRftei7Knn4//ajrTSJA2BCVhuTcSclv
 GKhYLdIrJMjHMLLMTjFrxnb0olZGiKm82eD/ttA3+oIOk0FC0+ag2zF3tTphUZKzt0BT
 BEgdjQVfDwIm2igCtoChdRc2jAh9EjxlO1UaUeGYIFsjTPRDZzRtNaVNsrYJq49nOvTD
 S7Gg==
X-Gm-Message-State: APjAAAW/M6DwiyJg+u+W/v7s4Pu1xI++QA/IR65soJqZCd6r67S7jqsK
 MG7PW4bJDsuyHFsC9vWwmfBpf2HFv48=
X-Google-Smtp-Source: APXvYqxb1/nRGycAEQnyHsE2l4l+SfshJdkzW2stlOm5vCZKaaqV4N+uE4ykL6tIDAa13Efdrmix1w==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr56460259wmb.112.1563635935411; 
 Sat, 20 Jul 2019 08:18:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 4sm77517291wro.78.2019.07.20.08.18.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 08:18:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 17:18:40 +0200
Message-Id: <20190720151846.7450-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
References: <20190720151846.7450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 06/12] scsi-generic: Check sense key before
 request snooping and patching
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
index f07891b..c11a0c9 100644
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
1.8.3.1



