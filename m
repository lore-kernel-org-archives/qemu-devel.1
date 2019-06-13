Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBBAC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A32021721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WvAXgAMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A32021721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39394 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOrs-00079P-6p
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcz-0007uG-Rg
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcx-0003zA-Dc
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:49 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52231)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOcv-0003ub-5m
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id s3so9965488wms.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bX4hRH4lVhTWXUt9Xxv5/AT7FDCVaSNWnYXS84dsZh8=;
 b=WvAXgAMkHfkAb0RVlgzGELM/5iiBMiC4eT16/axY8wTQ+6tmguvh7HbrWvUL0i5CQl
 qlmYHWLcvOr76KlMxLZ1wcp3INz3C6i7dZanzkyxK6rh7neJ+rFMjeKLXXiayElItj7P
 MvsKe8sXqgdpqkK/oHjTwsDXmB/yYTBtkgey5P5b4Vecyk/fml2UF7ZIS0qWy5zjj118
 MP7XnamQ2bYVeTqPfge2/tMtYmwJdXtE3K0xqt6oO0pnnVyNrgp16+7qVlZVmfIVjxDz
 G85poM9KHZjsW//0VYJRBqhLU3zxBOfE1I9TtwbNbu6VBT/Rhu8736TiB7DQcUZQnXil
 haqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bX4hRH4lVhTWXUt9Xxv5/AT7FDCVaSNWnYXS84dsZh8=;
 b=SSxxPFM7mw9zkcbmgzpJHCBvn4LWRF6XFiVK+gPmEqWk80tDUYQKdTP/xNHYRdT/nt
 jdjmhnjwUFvspzn6i62JmpyUq5Nfpi18Fqo71Qrg2FK7cYBsKa4GPIZR5R2DU6QTgOeK
 ERWnd/Y81XQj1IkCZHUF2JZMY9Rtsz902hIk7OKhoMfleO7fbV8tjALS+d9NmoLBDbBR
 h37K5Wgm7haniVsiuuQxgm4pT2G4CrdOCpKKn3VEGN4tr6bpB7da4md4FcotOr6zIwM4
 OUratHoIF+cI8jXN4LBibECnsfEgwm6lmN2cYUqDNeVIWvFDBfV89Qs08wky+SxSPaQ8
 1ODA==
X-Gm-Message-State: APjAAAXwgLaCAnqcfuRrorCMPu8qoE/0DOKJKrgNPQIA70sLJaNzW+Gq
 Z0IBLimAseUMxMK6cPKbd2evl1sPFSQh/g==
X-Google-Smtp-Source: APXvYqzlIhbVQFhZkRHvMg+GCPRGCn//2PNeQujRqbTUNYW2C07Dl8qurdQahcamh5agaEtpCI+HhA==
X-Received: by 2002:a1c:c907:: with SMTP id f7mr3639072wmb.142.1560428081281; 
 Thu, 13 Jun 2019 05:14:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:50 +0100
Message-Id: <20190613121433.5246-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 05/48] hw/core/bus.c: Only the main system bus
 can have no parent
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

In commit 80376c3fc2c38fdd453 in 2010 we added a workaround for
some qbus buses not being connected to qdev devices -- if the
bus has no parent object then we register a reset function which
resets the bus on system reset (and unregister it when the
bus is unparented).

Nearly a decade later, we have now no buses in the tree which
are created with non-NULL parents, so we can remove the
workaround and instead just assert that if the bus has a NULL
parent then it is the main system bus.

(The absence of other parentless buses was confirmed by
code inspection of all the callsites of qbus_create() and
qbus_create_inplace() and cross-checked by 'make check'.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190523150543.22676-1-peter.maydell@linaro.org
---
 hw/core/bus.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index e6baa04e52b..17bc1edcde6 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -97,10 +97,9 @@ static void qbus_realize(BusState *bus, DeviceState *parent, const char *name)
         bus->parent->num_child_bus++;
         object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT(bus), NULL);
         object_unref(OBJECT(bus));
-    } else if (bus != sysbus_get_default()) {
-        /* TODO: once all bus devices are qdevified,
-           only reset handler for main_system_bus should be registered here. */
-        qemu_register_reset(qbus_reset_all_fn, bus);
+    } else {
+        /* The only bus without a parent is the main system bus */
+        assert(bus == sysbus_get_default());
     }
 }
 
@@ -109,18 +108,16 @@ static void bus_unparent(Object *obj)
     BusState *bus = BUS(obj);
     BusChild *kid;
 
+    /* Only the main system bus has no parent, and that bus is never freed */
+    assert(bus->parent);
+
     while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
         DeviceState *dev = kid->child;
         object_unparent(OBJECT(dev));
     }
-    if (bus->parent) {
-        QLIST_REMOVE(bus, sibling);
-        bus->parent->num_child_bus--;
-        bus->parent = NULL;
-    } else {
-        assert(bus != sysbus_get_default()); /* main_system_bus is never freed */
-        qemu_unregister_reset(qbus_reset_all_fn, bus);
-    }
+    QLIST_REMOVE(bus, sibling);
+    bus->parent->num_child_bus--;
+    bus->parent = NULL;
 }
 
 void qbus_create_inplace(void *bus, size_t size, const char *typename,
-- 
2.20.1


