Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE274C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7165E206A5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G01H/Ecy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7165E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOP63-0007qj-IX
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyT-0000PW-UP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:54463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kOOyS-0003JE-EE
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:36:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id s13so2429761wmh.4
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hDip1TuoGE2uTB5vESfk4LG+Rb+6jGwMeV9JdwzMKi4=;
 b=G01H/EcyvqF2YmQZc5uOTabHzb3JS1Jc6ZdneEb/xlYwL+yDSZhNW/y+xqWGtesRzn
 0q1syvn1/xfXhMoyDUH77NICImuGynHtEFB5ySQa8/q5lkoz/P76lRYXz2JDPg3DbOj1
 gJ6oqUa5lH0H2JXn4Bi1oKJYsYow3qArKh+SdyIlG5yvEqgn55X1rdgPSN7gEYkOlDgb
 zmGwIBpvZ9OeixyGvHAxvVuQHmYXakueSthTRIvWtbGG4tXDc0BmAN9foRO0QX1c/Jvr
 u/RYwwLyojhYQn50AEU1mDOPIM1kPIZ/3de2wh+J78fOPOYe/d3o8dhfy5JAPCgpFlKd
 fw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hDip1TuoGE2uTB5vESfk4LG+Rb+6jGwMeV9JdwzMKi4=;
 b=cWy4g7AJz39QjOtJjwsFU6e0oUZlEFrAVprNFSANoMRzszrOdQW59EbQLmVIIX9p9v
 tu8GDj3ABBrSkBeCU+ZOa+gbPGDihKYGaKvI+Gv8FA/+rPBaVbMj9Td64o4++t1waU59
 C3oMtQICoaX+5nitKaFuxAdqirjfA733gEKW4BbBPobjtCAf3YBc1l4bwlPMyowpNBnZ
 8coJ92h57aEBJABWaAFqahq/2srn6Pg3WkNSHCkRoKs1EB8uc+UM1HGMTMtFgvMayeAt
 KVPe1gtPpl5K19WRb64Yhyqu2jrsJyEPqLgiQtkVuJ2H2lKfcfiLFJ1aFH++7uuRSDLW
 0wXA==
X-Gm-Message-State: AOAM533XT5KziJ2u5m79e8qS3YGYuZDxbc+GP9Qx3gTWZzGoXwRmYNLW
 q7+ez+hD8aHIfBdyLFaIZdAnyZJaMak=
X-Google-Smtp-Source: ABdhPJwwZmc8UGnvwiBJtCM53oIJH/kIksxq0VUqQ0TIJXth3yanVdHe73NJ0y3rau+nKuhokhnM7g==
X-Received: by 2002:a05:600c:2186:: with SMTP id
 e6mr4329959wme.189.1601660162749; 
 Fri, 02 Oct 2020 10:36:02 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:47e0:e742:75ba:b84d])
 by smtp.gmail.com with ESMTPSA id
 l8sm2516454wrx.22.2020.10.02.10.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:36:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/10] scsi/scsi_bus: switch search direction in
 scsi_device_find
Date: Fri,  2 Oct 2020 19:35:51 +0200
Message-Id: <20201002173558.232960-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002173558.232960-1-pbonzini@redhat.com>
References: <20201002173558.232960-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x32d.google.com
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

This change will allow us to convert the bus children list to RCU,
while not changing the logic of this function

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200913160259.32145-2-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 94921c04b1..69d7c3f90c 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1571,7 +1571,7 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
     BusChild *kid;
     SCSIDevice *target_dev = NULL;
 
-    QTAILQ_FOREACH_REVERSE(kid, &bus->qbus.children, sibling) {
+    QTAILQ_FOREACH(kid, &bus->qbus.children, sibling) {
         DeviceState *qdev = kid->child;
         SCSIDevice *dev = SCSI_DEVICE(qdev);
 
@@ -1579,7 +1579,15 @@ SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int id, int lun)
             if (dev->lun == lun) {
                 return dev;
             }
-            target_dev = dev;
+
+            /*
+             * If we don't find exact match (channel/bus/lun),
+             * we will return the first device which matches channel/bus
+             */
+
+            if (!target_dev) {
+                target_dev = dev;
+            }
         }
     }
     return target_dev;
-- 
2.26.2



