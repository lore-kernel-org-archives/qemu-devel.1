Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B0DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355EF2339E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355EF2339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5U3H-0001cG-66
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 08:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i5TyW-0006Dy-3E
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i5TyQ-0002R7-LF
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61625)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i5TyQ-0002Fn-4C
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:18 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A30D010F09
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 12:01:04 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id e2so22500269qtm.19
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 05:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bIAuvi4Ln9+QYeHNXGil+9sg538izwdTjP2B+V2uOjs=;
 b=r1q/mzzD93reRKJWT/vc5NHB1BPxmiesgYz8RvZEDt8zOpEtWzbmdd1PU1JSXaNMVM
 vaG5i0A55Aia4hKUmRfGo7JM5DK+wGwsbOZMhY5N6zfP2YefxYP2o/JAMQ68EDqmyfVM
 sFDEf0ggpC6dvX+C9yrmpHUf+F91OgC1w7BrlHPMNYYlovKTiFvnTK+XcRFhVN0Ankxp
 wmAdmAV7bWRxqr1xKCwj5nQBLj3owEVfC8KwymbWoIX6KKYDL6ZP8Qf0SkaLel/+8WbS
 2dWBOdXf7LctCfv0xkxjaaN4Rtg1N8qKINCkIAMMXJzcEraUGEi+PfuhTWe6PA0+bkxM
 wyXw==
X-Gm-Message-State: APjAAAXWziamGM2wxv+Hda4Zh0wqQ2ibadv/9CRGQoSBPOxXogAIZN/T
 Fg8hwiNdSD7wuQaWkOt9S2xjWHbUcrt24D9Wut5iqafpnlrRdc2accx+ayvuXuFcqiDhYOk5Q0H
 hMS0+L/aL2zYj7Ik=
X-Received: by 2002:a37:8f86:: with SMTP id
 r128mr13257282qkd.392.1567598463439; 
 Wed, 04 Sep 2019 05:01:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxIopgUx6uVM5GmQOUHYDgw9XnLVa7XMRqwP6our91vRpByD5/kE52ZJl+OG4nStAp4e9pbzA==
X-Received: by 2002:a37:8f86:: with SMTP id
 r128mr13257254qkd.392.1567598463241; 
 Wed, 04 Sep 2019 05:01:03 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id y207sm6479361qkb.41.2019.09.04.05.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 05:01:02 -0700 (PDT)
Date: Wed, 4 Sep 2019 08:00:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190820160615.14616-4-lvivier@redhat.com>
References: <20190904120026.3220-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190904120026.3220-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/6] virtio-rng: change default backend to
 rng-builtin
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190904120058.Zayfzc4KyGeLvGkyR6spQ4tvUMU1czlw_nGFPPqxw5U@z>

From: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20190820160615.14616-4-lvivier@redhat.com>
---
 backends/rng-builtin.c | 1 -
 hw/virtio/virtio-rng.c | 3 +--
 include/sysemu/rng.h   | 2 ++
 qemu-options.hx        | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
index 3381d47174..ba1b8d66b8 100644
--- a/backends/rng-builtin.c
+++ b/backends/rng-builtin.c
@@ -10,7 +10,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 
-#define TYPE_RNG_BUILTIN "rng-builtin"
 #define RNG_BUILTIN(obj) OBJECT_CHECK(RngBuiltin, (obj), TYPE_RNG_BUILTIN)
 
 typedef struct RngBuiltin {
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index fcf3b2e329..e93bed020f 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -19,7 +19,6 @@
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
 #include "sysemu/runstate.h"
-#include "sysemu/rng-random.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
 
@@ -193,7 +192,7 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
     }
 
     if (vrng->conf.rng == NULL) {
-        Object *default_backend = object_new(TYPE_RNG_RANDOM);
+        Object *default_backend = object_new(TYPE_RNG_BUILTIN);
 
         user_creatable_complete(USER_CREATABLE(default_backend),
                                 &local_err);
diff --git a/include/sysemu/rng.h b/include/sysemu/rng.h
index 9b22c156f8..fa6eada78c 100644
--- a/include/sysemu/rng.h
+++ b/include/sysemu/rng.h
@@ -24,6 +24,8 @@
 #define RNG_BACKEND_CLASS(klass) \
     OBJECT_CLASS_CHECK(RngBackendClass, (klass), TYPE_RNG_BACKEND)
 
+#define TYPE_RNG_BUILTIN "rng-builtin"
+
 typedef struct RngRequest RngRequest;
 typedef struct RngBackendClass RngBackendClass;
 typedef struct RngBackend RngBackend;
diff --git a/qemu-options.hx b/qemu-options.hx
index a8b70d946f..b2ba7c501d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4337,7 +4337,7 @@ The @option{share} boolean option is @var{on} by default with memfd.
 Creates a random number generator backend which obtains entropy from
 QEMU builtin functions. The @option{id} parameter is a unique ID that
 will be used to reference this entropy backend from the @option{virtio-rng}
-device.
+device. By default, the @option{virtio-rng} device uses this RNG backend.
 
 @item -object rng-random,id=@var{id},filename=@var{/dev/random}
 
-- 
MST


