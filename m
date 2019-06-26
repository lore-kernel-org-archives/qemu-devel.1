Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB2AC48BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 02:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A100C205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 02:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq2pFT21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A100C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfxpA-00061J-1f
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 22:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48376)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hfxjP-0001Yv-Th
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 22:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hfxjN-00021n-MZ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 22:32:19 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hfxjN-0001p7-Ch
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 22:32:17 -0400
Received: by mail-pg1-x541.google.com with SMTP id m4so418522pgk.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 19:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8MJqz+TiFePml7vV+waCP1DUA2DS40UgJSmuxu49ueA=;
 b=Jq2pFT21SogPA8uk6WWe+O8YpfocN0ejdVfo07PAHg8bCrS8cTMyfyv7obWsaVtg64
 uk2ssvi0EzdFCoNZqjO2jNmA8Q3pzbma0kivweJHmTEMO+FcNr/ueeBcAMptlAF5Lvyq
 CtOkiVVk6UrYaB2VKvUeLnf/4F8MahgPOv7ITJ46uItz6m8oOh2gWeT2cv0YNoM7Muio
 gZImUsJbV4nx7bCdw1N71zJuagTMwOjSn+Gq3P1gM8OTVkQi/cnmo8jxFKo/zZum6mQo
 ZThroV4ztM7kUS9E8wEg9EoQM0YDWQpaJ8QfTyvNfwnqQ0I3lRjZO66C0Us02jWmolLH
 d+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8MJqz+TiFePml7vV+waCP1DUA2DS40UgJSmuxu49ueA=;
 b=U5w9+ob6FRrFo27doBFCKZEBaVJB9MGSTE2tvO+hyP0wmVhPZaEZ8dDcb2Fvc61Bog
 lKahjz1BUzswUINy5Bf0WUl0gtgDhbgJ6d1w8ph1nzgJulMj/yGxgIfHcmjLCyX6RpRf
 yOjfEW2zdBMqhP31NaHAWv4e193VH7kubuUy2zAtRYkTWPIMR8dT0IaYamyxDE9PLAv6
 OT9YpnBQT6Wkkk5h55W+raevK96OHl7hiV72WBY9Igb9lXqhg81aJq+bEd2vjgBKR48C
 iNYZ9H7rHWOEozkuumsidR8edJWOR+WgGvChLOHsJy9HRr2lsTXJk+DWyB91mveyFEaq
 gvGw==
X-Gm-Message-State: APjAAAWIY81P2VF/EOkJ+bX73SChSzYVP9l8IiC2g1DhLZahJGjMD8hR
 6QBD56BqSLgUnmoZnJYEEdQ=
X-Google-Smtp-Source: APXvYqwSCbQ1vpcbDv/QpqbgiwvloC+qEMXNIwGSoF2CTmUKbPqyCTjHZyPMcE6Mfl2/5vbzJ6azYA==
X-Received: by 2002:a63:f746:: with SMTP id f6mr297876pgk.56.1561516329240;
 Tue, 25 Jun 2019 19:32:09 -0700 (PDT)
Received: from localhost ([116.247.112.152])
 by smtp.gmail.com with ESMTPSA id t5sm16256309pgh.46.2019.06.25.19.32.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 25 Jun 2019 19:32:08 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org
Date: Wed, 26 Jun 2019 10:31:30 +0800
Message-Id: <20190626023130.31315-6-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626023130.31315-1-xieyongji@baidu.com>
References: <20190626023130.31315-1-xieyongji@baidu.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v4 5/5] virtio: Don't change "started" flag on
 virtio_vmstate_change()
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
Cc: lvivier@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

We will call virtio_set_status() on virtio_vmstate_change().
The "started" flag should not be changed in this case. Otherwise,
we may get an incorrect value when we set "started" flag but
not set DRIVER_OK in source VM.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
---
 hw/virtio/virtio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e098fc8ef0..18f9f4c372 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1163,7 +1163,10 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
         }
     }
 
-    virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
+    if ((vdev->status & VIRTIO_CONFIG_S_DRIVER_OK) !=
+        (val & VIRTIO_CONFIG_S_DRIVER_OK)) {
+        virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
+    }
 
     if (k->set_status) {
         k->set_status(vdev, val);
-- 
2.17.1


