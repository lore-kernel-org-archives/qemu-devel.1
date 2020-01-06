Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AF2C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:57:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2E22072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViZJtqqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2E22072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXZ4-0001ce-Tq
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX59-0003lH-38
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX58-0005DM-0C
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:26 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:42555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX57-0005D7-Sm; Mon, 06 Jan 2020 13:26:25 -0500
Received: by mail-qk1-x743.google.com with SMTP id z14so39016754qkg.9;
 Mon, 06 Jan 2020 10:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0v81XTgpe39UJaMXds5mD2XgR/7Ua6QyU6w1mwdmCXM=;
 b=ViZJtqqCIYXTcWLD/22pFaG95qUlFyo49tNVAh+CDYXLpd9LYH7KX/BQYcvqDs/yUi
 ik/p6lx3qUPTq4i6XbhwIxEjo8Sd+AgnpNeWJbdMu1MBqfIUeECHbHUT0L3oqopUTsvm
 o9VrmlLYUvA1OjLMlG8wYNlmzCMOfjUnqO/ZZO7sCCVrG7QCmVLb8oqR9ctL+P40BQSg
 jxXaw3ci7t+pcuwoIuV20wJ7sESgk7Vr0KXzpwuvI8rz92+CcDALJWQlYkcYBL6W6zDh
 /7UjsAO/YcG18Ne8i5epZN3bVZ9L0FnV0hkK1KpHhSMh6Pd3JDkOu8Kia8eBV5kbx4cq
 xjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0v81XTgpe39UJaMXds5mD2XgR/7Ua6QyU6w1mwdmCXM=;
 b=IvujFk0Scgxtfew7ZG9UZKqfl2TC5gh8tDomOQCheeLQ4dMiY1z1vB1NsFWo7MRbbV
 d/H/0sxHru5i55QhIpnKkGtqzWSoa2qWoGZkx3C1tF/pYJtmBzKLSy7eVgjG9Q7LbCUV
 F+L728bJbRs2SyV3wOYhgHwjij60GNob1zaFX4S/v2I79DzjDElezPJcF+/x0RbWOdXn
 ebjeD9KrpuMnsrFN3yM0F/oRHSlKb8yMVK9bGG0YGXOlS9K8hbCD5Bo5sXRhFOPr+QCO
 r1Cam5SMTKxV4wWSa9tFJue/8VyP125krpYlxfOoFTfzGcd1mxGKfgAflgkggUiRvfN6
 aiYw==
X-Gm-Message-State: APjAAAUqJi36Row61Wnu8IvsExNcCrhS25q5vxrKNEa55Y2+qpWlmmcs
 M+G4g1T2gawhecxMZkNERUvP4pYE
X-Google-Smtp-Source: APXvYqy9QOYrdk3Drvow6+RkYXXFtLZ8YsGNL4zUxm54gTZBLULiM8QInD8M5hYvmyXCmFTkggQkEw==
X-Received: by 2002:ae9:f711:: with SMTP id s17mr83113900qkg.238.1578335185353; 
 Mon, 06 Jan 2020 10:26:25 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:25 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 52/59] net/vhost_net.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:24:18 -0300
Message-Id: <20200106182425.20312-53-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Label 'fail_notifiers' in vhost_net_start_one() and
'err' in vhost_net_start() can be replaced by 'return r'.

CC: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/net/vhost_net.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b82803fa7..272519f970 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -230,7 +230,7 @@ static int vhost_net_start_one(struct vhost_net *net,
 
     r = vhost_dev_enable_notifiers(&net->dev, dev);
     if (r < 0) {
-        goto fail_notifiers;
+        return r;
     }
 
     r = vhost_dev_start(&net->dev, dev);
@@ -278,7 +278,6 @@ fail:
     vhost_dev_stop(&net->dev, dev);
 fail_start:
     vhost_dev_disable_notifiers(&net->dev, dev);
-fail_notifiers:
     return r;
 }
 
@@ -331,7 +330,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     r = k->set_guest_notifiers(qbus->parent, total_queues * 2, true);
     if (r < 0) {
         error_report("Error binding guest notifier: %d", -r);
-        goto err;
+        return r;
     }
 
     for (i = 0; i < total_queues; i++) {
@@ -362,7 +361,7 @@ err_start:
         fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", e);
         fflush(stderr);
     }
-err:
+
     return r;
 }
 
-- 
2.24.1


