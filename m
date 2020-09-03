Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0013CC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B114520665
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1aKQANe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B114520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwxq-0005O8-TM
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLT-00047T-H5; Thu, 03 Sep 2020 17:00:35 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:46478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLR-0007fc-GX; Thu, 03 Sep 2020 17:00:35 -0400
Received: by mail-ot1-x32a.google.com with SMTP id c10so3974252otm.13;
 Thu, 03 Sep 2020 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WPTghg1JdY/T9Chd/wvCDZJhQbF7QTuk1z+gP+1I088=;
 b=a1aKQANe0qgPOb94YAlu0JVQWZJ9x/BCoP0gG3D/OdBG9/+rU3L23STY47d9xMI5Cp
 IT/G7juy/pISK7II74iJ64MBzHsyjytaa9M2E4IT3W8GEHriGrm2kmWd0PtnadF23fT7
 VtBTj4qlTv8+5Mmqypo6zLjjyH+e+XvaRSMrMs7pSN1CgfMpEF+pej4etaK6dik1dWUR
 gImJOLbJXvIKgEJQq/kgbjQyCuaw5Lb1SxSsDNcAriFCXqndMmRf5eEk09CvrjpgXqip
 9ZffXf6LmGE+fR20nLkTYKvHeo2U5dBNuCmJSF+6qlNxt7TelOgYchtkAO7G90Gx2rYa
 uzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=WPTghg1JdY/T9Chd/wvCDZJhQbF7QTuk1z+gP+1I088=;
 b=oaZBUiy5DOBYl4fPckK8LlXCnCAnKjaE9lHpeDQ4qBSuJ30tnvOUu9+tzYSSgqMi5B
 UXBd88VF/rMhqp/AMfrczZstak1R09hwdipo4DhdEyqTk3qGudeLWgBcHuA3m/aJ9k90
 z80N1a5yobJmC8NZG66kMt+ofrJmYqHQo0OsuC0ihiTisxjad4yzN0HFKJtr18+JRTeJ
 p0vnvF+PJ3BifXf5Wa6KRxsV+zufZ3EvMvilA53WV19gbQbQv2nh/oxwjAhd+MALAeQw
 OFC9uvV8JDm+zvyvMW0AVNQZ+rAAE/l+M1ZDEjneXbQsJHliA+YQZQ3SKAqNuJN0volI
 OkFw==
X-Gm-Message-State: AOAM531iZmA0URwktUmS+MkcSRJMB/z4ZppV4f6NH9gbofvUt0izg/r+
 Pd5Jh1qNZaNMQObAkdBdPbwXktvIUmE=
X-Google-Smtp-Source: ABdhPJzT/UvyJ6V7XgHu5FGN79WqCUAdGQEFsx/cGblV3zmS/s6aiDmvMQqbigm1YBtwqFllS6evRA==
X-Received: by 2002:a05:6830:13:: with SMTP id
 c19mr3138247otp.65.1599166827608; 
 Thu, 03 Sep 2020 14:00:27 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id f194sm718215oib.44.2020.09.03.14.00.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:27 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/77] net/virtio: Fix failover_replug_primary() return value
 regression
Date: Thu,  3 Sep 2020 15:58:55 -0500
Message-Id: <20200903205935.27832-38-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Jens Freimann <jfreimann@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Commit 150ab54aa6 "net/virtio: fix re-plugging of primary device"
fixed failover_replug_primary() to return false on failure.  Commit
5a0948d36c "net/virtio: Fix failover error handling crash bugs" broke
it again for hotplug_handler_plug() failure.  Unbreak it.

Commit 5a0948d36c4cbc1c5534afac6fee99de55245d12

Fixes: 5a0948d36c4cbc1c5534afac6fee99de55245d12
Cc: Jens Freimann <jfreimann@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20200630090351.1247703-2-armbru@redhat.com>
(cherry picked from commit ca72efccbe33373810341a0d8a10f5698b8fbc87)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a46e3b37a7..e7e2c2acdb 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2828,7 +2828,7 @@ static bool failover_replug_primary(VirtIONet *n, Error **errp)
         if (err) {
             goto out;
         }
-        hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp);
+        hotplug_handler_plug(hotplug_ctrl, n->primary_dev, &err);
     }
 
 out:
-- 
2.17.1


