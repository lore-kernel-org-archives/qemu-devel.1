Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A19FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8430B2168B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 16:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNTSbFdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8430B2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKmT0-00010l-Hg
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 12:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36170)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3Z0inXQYKCog4myqups00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--sameid.bounces.google.com>)
 id 1iKmNQ-0004Bx-HQ
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3Z0inXQYKCog4myqups00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--sameid.bounces.google.com>)
 id 1iKmNP-0006Fc-Dp
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:20 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a]:34843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3Z0inXQYKCog4myqups00sxq.o0y2qy6-pq7qxz0zsz6.03s@flex--sameid.bounces.google.com>)
 id 1iKmNP-0006E6-8a
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 12:42:19 -0400
Received: by mail-wr1-x44a.google.com with SMTP id 7so6732194wrl.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=BN8bM2TtrG62TEO1U3a7nnR51CqBKCUhjF3qC5P9H3s=;
 b=NNTSbFdoRUGfMKEJDw9EuzjYhZYijB+c3FQgNPXYs3ZtdhZwu85gFLYRa03CSGJ60W
 e7lHOpj0VVKbMQQ7tAlUN16ppBLzSTyV5Tyz6x25fDIquCtTGpP7BQq7adzthVSzMOu4
 X7I1wL80DJZwFWd1MmQSgMHYYvtBKiHwstCO1jph/nKKuuNpi0fgh/LLTjCtxtSxmGgh
 SG5gAYM5+SqkFwVfmnO2G+XsVeW4We+Cv1XDhX19OkdIdCE7JqWgb5l8fFL/FTCwdEo/
 Q4XowSQ7IMDlEjgV+Dx714tuW35x3ICnpcAa4YFg7YytpEkze+3W4h0yiUm2maTzQquW
 8Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=BN8bM2TtrG62TEO1U3a7nnR51CqBKCUhjF3qC5P9H3s=;
 b=lmzDe/94aoSKORQ7s7dvdbqMoh5qWnzUnrPM5lyMo0NzEpTAVLAzr0poWEHvSOl3yL
 d1tVFQKZJMCqlwmTOP0Bics22xFQbF0wZxT9KxDvZXOhihSoSET4NVGK8bmjoRBE22od
 OSL0KTvRQGgYYT7hrJZo7/wjE/mWJ7djj+2YNiUcu5QGx9sJ3ze7ZOgMVM/ZvyYyDjAZ
 N9RB0wcj3RY7ypklCay5BAKiLeNVUIvvlPi9xspMnqKZrTiwdp8oQXr3JxsKI0KVkrYm
 Hw6xj7GaB8nuxfeeOP5/6n2wiiHiorsqC5ZTATFmZBqyMdxtSt/nCqmumv8t2hbIYR/+
 he3Q==
X-Gm-Message-State: APjAAAVIqgGMmjGzDPRyeeW1An9phaDSCbpVgcM7gSdhxVIsIXnXL2AU
 Jk7R7Rj88vG8p8UD0hWucR3KL4UteB9yYHIfo2OyrUdKZXe6oXY3XH1Ul7xB+RhAvgvj76daeUe
 v4pUGsFtdZiwY9AfWonMvtPFg1UMEkZ1sn5eWTtXEBGCd32hRbxKUhwTTHHhY
X-Google-Smtp-Source: APXvYqwusXB46n4F/NZK5qSsw7kyKmOfNyd4grdeACq22ZIaKZeYlgYtmL1oilBtQd05UPAR4YrT7LiCnPs=
X-Received: by 2002:a5d:4285:: with SMTP id k5mr3500690wrq.344.1571244135793; 
 Wed, 16 Oct 2019 09:42:15 -0700 (PDT)
Date: Wed, 16 Oct 2019 19:41:41 +0300
In-Reply-To: <20191016164145.115898-1-sameid@google.com>
Message-Id: <20191016164145.115898-6-sameid@google.com>
Mime-Version: 1.0
References: <20191016164145.115898-1-sameid@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v8 4/8] scsi: Propagate unrealize() callback to scsi-hd
From: Sam Eiderman <sameid@google.com>
To: qemu-devel@nongnu.org
Cc: arbel.moshe@oracle.com, karl.heubaum@oracle.com, kevin@koconnor.net, 
 kraxel@redhat.com, kwolf@redhat.com, liran.alon@oracle.com, 
 qemu-block@nongnu.org, sameid@google.com, seabios@seabios.org, 
 lersek@redhat.com, philmd@redhat.com, jsnow@redhat.com, 
 Sam Eiderman <shmuel.eiderman@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::44a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sam Eiderman <shmuel.eiderman@oracle.com>

We will need to add LCHS removal logic to scsi-hd's unrealize() in the
next commit.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
Signed-off-by: Sam Eiderman <sameid@google.com>
---
 hw/scsi/scsi-bus.c     | 16 ++++++++++++++++
 include/hw/scsi/scsi.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index bccb7cc4c6..359d50d6d0 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -59,6 +59,14 @@ static void scsi_device_realize(SCSIDevice *s, Error **e=
rrp)
     }
 }
=20
+static void scsi_device_unrealize(SCSIDevice *s, Error **errp)
+{
+    SCSIDeviceClass *sc =3D SCSI_DEVICE_GET_CLASS(s);
+    if (sc->unrealize) {
+        sc->unrealize(s, errp);
+    }
+}
+
 int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                        void *hba_private)
 {
@@ -217,12 +225,20 @@ static void scsi_qdev_realize(DeviceState *qdev, Erro=
r **errp)
 static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
 {
     SCSIDevice *dev =3D SCSI_DEVICE(qdev);
+    Error *local_err =3D NULL;
=20
     if (dev->vmsentry) {
         qemu_del_vm_change_state_handler(dev->vmsentry);
     }
=20
     scsi_device_purge_requests(dev, SENSE_CODE(NO_SENSE));
+
+    scsi_device_unrealize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     blockdev_mark_auto_del(dev->conf.blk);
 }
=20
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index d77a92361b..332ef602f4 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -59,6 +59,7 @@ struct SCSIRequest {
 typedef struct SCSIDeviceClass {
     DeviceClass parent_class;
     void (*realize)(SCSIDevice *dev, Error **errp);
+    void (*unrealize)(SCSIDevice *dev, Error **errp);
     int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                      void *hba_private);
     SCSIRequest *(*alloc_req)(SCSIDevice *s, uint32_t tag, uint32_t lun,
--=20
2.23.0.700.g56cf767bdb-goog


