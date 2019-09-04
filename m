Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E832C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E7C22CF5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E7C22CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5U3H-0001cD-2S
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 08:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i5TyS-0006Ac-Mz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i5TyQ-0002QY-BJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18505)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i5TyP-0002Aw-TC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:01:18 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 936C1883CA
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 12:00:54 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id o34so20977971qtf.22
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 05:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7r9dMweGGNDarnIE88uzCWq+IdXTJHAmCbvJX0BkJbE=;
 b=FRZUsaUzCoGrtkFM9UpVvUtaybBxiabIx/N5GfY5SZtkII5w7WHopF8ZE5JI7FoEQ8
 DG1v12S03c0/ebA5BdrZdgx6vc2ql2PEfT9UTdTk8xLdEl2KRVEIGgZU1OUMB06ei+DV
 QIbP2x2ETEHu6+KN02mcofQrpLdgVAhfkA0Huxxc7zH93+Zrb/y+larmfMnvyl/x9EcB
 u3hv4khtxmodnqnxDAYqIB00UI2uNgvSCxu5VObz7Vb35y9pIHAVGFVKt48rpw7W5HR/
 gFEHDXwZylY6YpCigENlJ5qt/PdU//FT9H+mdfPS8Qdlm+r6ycxIkc2eJTOqPmJcj7z1
 BOww==
X-Gm-Message-State: APjAAAXCltykLyNTCp9g5zr76MOEaBKOSqAbY6xawq9418E5MRVmvujh
 BFA3JrVQ/zGUD06p8GjhJTGHS/F99fOefuYNaNjNVEJfFogs3HnxBB0CZd+Jfoy44EAO3xCNMEI
 tBdQH1eODp4xds0U=
X-Received: by 2002:a05:620a:15ba:: with SMTP id
 f26mr9115936qkk.266.1567598453406; 
 Wed, 04 Sep 2019 05:00:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz1M5z98PWFc0bmWnkCZog3sQCl/wS3hWe6tOD0QmflPoEFVsXt0+yTl8G1wnPkSnM692ogKQ==
X-Received: by 2002:a05:620a:15ba:: with SMTP id
 f26mr9115918qkk.266.1567598453187; 
 Wed, 04 Sep 2019 05:00:53 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id j17sm4556666qta.0.2019.09.04.05.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 05:00:52 -0700 (PDT)
Date: Wed, 4 Sep 2019 08:00:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190820160615.14616-2-lvivier@redhat.com>
References: <20190904120026.3220-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190904120026.3220-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/6] rng-builtin: add an RNG backend that uses
 qemu_guest_getrandom()
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
 Peter Maydell <peter.maydell@linaro.org>, Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190904120049.WKf0PpO0TAPxaM4NCsfhnXr3Ycf8xekWHxusZqfmqbk@z>

From: Laurent Vivier <lvivier@redhat.com>

Add a new RNG backend using QEMU builtin getrandom function.

It can be created and used with something like:

    ... -object rng-builtin,id=rng0 -device virtio-rng,rng=rng0 ...

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20190820160615.14616-2-lvivier@redhat.com>
---
 backends/Makefile.objs |  2 +-
 backends/rng-builtin.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 qemu-options.hx        |  7 ++++
 3 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 backends/rng-builtin.c

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 981e8e122f..f0691116e8 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += rng.o rng-egd.o
+common-obj-y += rng.o rng-egd.o rng-builtin.o
 common-obj-$(CONFIG_POSIX) += rng-random.o
 
 common-obj-$(CONFIG_TPM) += tpm.o
diff --git a/backends/rng-builtin.c b/backends/rng-builtin.c
new file mode 100644
index 0000000000..3381d47174
--- /dev/null
+++ b/backends/rng-builtin.c
@@ -0,0 +1,78 @@
+/*
+ * QEMU Builtin Random Number Generator Backend
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/rng.h"
+#include "qemu/main-loop.h"
+#include "qemu/guest-random.h"
+
+#define TYPE_RNG_BUILTIN "rng-builtin"
+#define RNG_BUILTIN(obj) OBJECT_CHECK(RngBuiltin, (obj), TYPE_RNG_BUILTIN)
+
+typedef struct RngBuiltin {
+    RngBackend parent;
+    QEMUBH *bh;
+} RngBuiltin;
+
+static void rng_builtin_receive_entropy_bh(void *opaque)
+{
+    RngBuiltin *s = opaque;
+
+    while (!QSIMPLEQ_EMPTY(&s->parent.requests)) {
+        RngRequest *req = QSIMPLEQ_FIRST(&s->parent.requests);
+
+        qemu_guest_getrandom_nofail(req->data, req->size);
+
+        req->receive_entropy(req->opaque, req->data, req->size);
+
+        rng_backend_finalize_request(&s->parent, req);
+    }
+}
+
+static void rng_builtin_request_entropy(RngBackend *b, RngRequest *req)
+{
+    RngBuiltin *s = RNG_BUILTIN(b);
+
+    qemu_bh_schedule(s->bh);
+}
+
+static void rng_builtin_init(Object *obj)
+{
+    RngBuiltin *s = RNG_BUILTIN(obj);
+
+    s->bh = qemu_bh_new(rng_builtin_receive_entropy_bh, s);
+}
+
+static void rng_builtin_finalize(Object *obj)
+{
+    RngBuiltin *s = RNG_BUILTIN(obj);
+
+    qemu_bh_delete(s->bh);
+}
+
+static void rng_builtin_class_init(ObjectClass *klass, void *data)
+{
+    RngBackendClass *rbc = RNG_BACKEND_CLASS(klass);
+
+    rbc->request_entropy = rng_builtin_request_entropy;
+}
+
+static const TypeInfo rng_builtin_info = {
+    .name = TYPE_RNG_BUILTIN,
+    .parent = TYPE_RNG_BACKEND,
+    .instance_size = sizeof(RngBuiltin),
+    .instance_init = rng_builtin_init,
+    .instance_finalize = rng_builtin_finalize,
+    .class_init = rng_builtin_class_init,
+};
+
+static void register_types(void)
+{
+    type_register_static(&rng_builtin_info);
+}
+
+type_init(register_types);
diff --git a/qemu-options.hx b/qemu-options.hx
index ea0638e92d..a8b70d946f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4332,6 +4332,13 @@ other options.
 
 The @option{share} boolean option is @var{on} by default with memfd.
 
+@item -object rng-builtin,id=@var{id}
+
+Creates a random number generator backend which obtains entropy from
+QEMU builtin functions. The @option{id} parameter is a unique ID that
+will be used to reference this entropy backend from the @option{virtio-rng}
+device.
+
 @item -object rng-random,id=@var{id},filename=@var{/dev/random}
 
 Creates a random number generator backend which obtains entropy from
-- 
MST


