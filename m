Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69C6C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49469206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOySHyzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49469206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOP0N-0002zq-7b
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyY-0000Yr-Ki
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:40367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyW-0003KY-Qd
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:10 -0400
Received: by mail-wr1-x42f.google.com with SMTP id j2so2679193wrx.7
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CIHGBqIWtbWESa47zsQ9GTVFuyweiSkZ/Mu8fjQk2dY=;
 b=WOySHyzdBTPzAxMkdUinxkswZxWCvDA24tA1Pi0WqiH+vDyCXjHmhukNHMbCbauI3e
 sRc3y071UBrCadKjMWSh7j4mqmnIk9/0ETUSm0IJgPYRDmFuhhKtqdJNfnHggiEIPN+V
 VKGm/g3weLXDGjLaX0y5feC3IYwyE2Mch67tfImyJH0MvoEdU764Gv7YwbJvOs6hDhvS
 JbJL6fJcDFEzrvZCqFDNYlWT7wHoKhRk58jm2+9OV7RujI0KKGvEmFQgZUGOJdPH72tp
 IBz1IwrVu6Pw7ZZQ5PQ7RKAeEBU8MocqiTIzLc4xZ+PZzWH8Z4tSW0/fOOKbch//qmYh
 GZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CIHGBqIWtbWESa47zsQ9GTVFuyweiSkZ/Mu8fjQk2dY=;
 b=Qec6KYjAGSlpvyhdNHX2I7U+uZbp3oF09XL1p1vqHvbkRV+m12CBVXwN/HyXm4Odbd
 atbFx2xW4aqPl61delQTcPmYfHwCgECS9ZMDshCybKDvhpkmERC5s1e5fPQdgayCONnh
 77woCxDQbt2QR8OJMi/I9a3URObp4kLnlb6IRWnAUBhbQY8PzkNt+GHpnAq0ma53WAQ3
 Df/hP9yOYPoNrDyoJesvnBmTzI+DfNbQr6l/RULeZlvOC1KtJ7QVvikzqk05LBQt31FX
 vfMgk0mzLCztVZ85w1ky8clB23YDttsFNb0n1DVSt5vtWJRrWRfJeIB4Sa97tbYKSyru
 wneA==
X-Gm-Message-State: AOAM532XFNuFwO12azL6aOe+bIWRNmYVrr9ws/ZvofmLdPPTafCgc7Iz
 yEfthRkR/OT3+xgYePElyrrd/6te+XU=
X-Google-Smtp-Source: ABdhPJyebixF1wc6t8n3bjMcNqC12IhFcO1/iu4m+f7s+yxJl53leS7gW21hJz1Vl3YyFyKUm9/UUw==
X-Received: by 2002:adf:f290:: with SMTP id k16mr4555422wro.124.1601660167266; 
 Fri, 02 Oct 2020 10:36:07 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id
 l8sm2516454wrx.22.2020.10.02.10.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:36:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/10] scsi/scsi_bus: Add scsi_device_get
Date: Fri,  2 Oct 2020 19:35:56 +0200
Message-Id: <20201002173558.232960-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002173558.232960-1-pbonzini@redhat.com>
References: <20201002173558.232960-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Add scsi_device_get which finds the scsi device
and takes a reference to it.

Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-Id: <20200913160259.32145-8-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c     | 11 +++++++++++
 include/hw/scsi/scsi.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 7599113efe..eda8cb7e70 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -73,6 +73,17 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
     return do_scsi_device_find(bus, channel, id, lun, false);
 }
 
+SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int id, int lun)
+{
+    SCSIDevice *d;
+    RCU_READ_LOCK_GUARD();
+    d = do_scsi_device_find(bus, channel, id, lun, false);
+    if (d) {
+        object_ref(d);
+    }
+    return d;
+}
+
 static void scsi_device_realize(SCSIDevice *s, Error **errp)
 {
     SCSIDeviceClass *sc = SCSI_DEVICE_GET_CLASS(s);
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 7a55cdbd74..09fa5c9d2a 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -190,6 +190,7 @@ int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
 int scsi_SG_IO_FROM_DEV(BlockBackend *blk, uint8_t *cmd, uint8_t cmd_size,
                         uint8_t *buf, uint8_t buf_size);
 SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
+SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int target, int lun);
 
 /* scsi-generic.c. */
 extern const SCSIReqOps scsi_generic_req_ops;
-- 
2.26.2



