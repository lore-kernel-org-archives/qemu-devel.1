Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E60DC2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275CF206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNgL36Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275CF206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWRa-0007WP-AL
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrm-00035e-FR
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrl-0003cC-8r
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrl-0003bo-2f
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id y20so309000wma.4
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+cshPsuV+p8IWnAz7VC2hUR8PIasPI419EzyAajDQQE=;
 b=mNgL36Vb89yMQ5n8Ku7zfqfPAxnaWgJRgbgA0rF+/hj6UudBNa+dz0UuOcxcJlM4F+
 fZwhsg6c1KnDO4hlVVdrWRQv5xUc2jV+co7WWAS/I+OnIMYITjtEsQr98nnSuwZoReCK
 wXoybjOyOeLAiQOcNCSvWWyoZCoUf9lkJI3OGE1im+YMB9yLxeeptse1sAIRH++BrvCm
 7oIWQHeimeXrmXLe7rAWg1Bv7zKMmvdyzkfKw8lKtNG2AHyArKxEN5YIvFQ4KgEe9wqA
 O7nF86CTESy6KrZK3rUdMnS/qdMvLZKrJImhs1Q/GtwL2CvygNWMAwPjh9AzVYvHOwoa
 AvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+cshPsuV+p8IWnAz7VC2hUR8PIasPI419EzyAajDQQE=;
 b=mknuzEXaqvwJfzWFY7BJBDNJllcBcfBoCILOBnC4ePpH+/7ie6q+aFvTuxUJp/Yqq/
 Ot6+0R+dHLAIxgiDqZJLUJcTQATGHxWZx3cABnoe+YR45eIcUM7Ez4V58o2dKlcCI/kw
 GvciFX8NF1eL4KYEeQFrTu7LRNt1isPziCkXT86m6etCJcdTBmstxGZ6GyR3wpNw+hWe
 EjCQUtKuLZIyujEvcOO+Hh0AojWWfwR9yuGQLKIJG/ZP1vek8ewFvkzYumbq2/7yWLjt
 kUM/uNMehNMM5JiwG3p6WKKjNcwR5jCbPVb+0vtJviYrdXBAttkn0Wb6q+18mNMuap6n
 J1yA==
X-Gm-Message-State: AGi0PuZk4PJ3jsxQu99bNHE+hBoTM9xWhHnUcAZX26bRXPMrWoNGAWxo
 xRF5COZIHAJ2sEhtujQkPFBlv3gAP58=
X-Google-Smtp-Source: APiQypKUaK6m68AfwdJGTHp2tkQjoZ+Jd58PLCxSSes/kO6DaxxU1osQdDWF8je6BdRnKZV7I656gw==
X-Received: by 2002:a1c:1f8e:: with SMTP id f136mr175199wmf.166.1586195335715; 
 Mon, 06 Apr 2020 10:48:55 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 48/54] scripts/coccinelle: Use &error_abort in
 TypeInfo::instance_init()
Date: Mon,  6 Apr 2020 19:47:37 +0200
Message-Id: <20200406174743.16956-49-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The instance_init() calls are not suppose to fail. Add a
Coccinelle script to use &error_abort instead of ignoring
errors by using a NULL Error*.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .../use-error_abort-in-instance_init.cocci    | 52 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 scripts/coccinelle/use-error_abort-in-instance_init.cocci

diff --git a/scripts/coccinelle/use-error_abort-in-instance_init.cocci b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
new file mode 100644
index 0000000000..8302d74a0c
--- /dev/null
+++ b/scripts/coccinelle/use-error_abort-in-instance_init.cocci
@@ -0,0 +1,52 @@
+// Use &error_abort in TypeInfo::instance_init()
+//
+// Copyright: (C) 2020 Philippe Mathieu-Daudé
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch \
+//  --macro-file scripts/cocci-macro-file.h --include-headers \
+//  --sp-file scripts/coccinelle/use-error_abort-in-instance_init.cocci \
+//  --keep-comments --in-place
+//
+// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg692500.html
+// and https://www.mail-archive.com/qemu-devel@nongnu.org/msg693637.html
+
+
+@ has_qapi_error @
+@@
+    #include "qapi/error.h"
+
+
+@ match_instance_init @
+TypeInfo info;
+identifier instance_initfn;
+@@
+    info.instance_init = instance_initfn;
+
+
+@ use_error_abort @
+identifier match_instance_init.instance_initfn;
+identifier func_with_error;
+expression parentobj, propname, childobj, size, type, errp;
+position pos;
+@@
+void instance_initfn(...)
+{
+   <+...
+(
+   object_initialize_child(parentobj, propname,
+                           childobj, size, type,
+                           errp, NULL);
+|
+   func_with_error@pos(...,
+-                           NULL);
++                           &error_abort);
+)
+   ...+>
+}
+
+
+@script:python depends on use_error_abort && !has_qapi_error@
+p << use_error_abort.pos;
+@@
+print('[[manual edit required, %s misses #include "qapi/error.h"]]' % p[0].file)
diff --git a/MAINTAINERS b/MAINTAINERS
index 14de2a31dc..ae71a0a4b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2059,6 +2059,7 @@ F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
 F: scripts/coccinelle/remove_local_err.cocci
 F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
+F: scripts/coccinelle/use-error_abort-in-instance_init.cocci
 F: scripts/coccinelle/use-error_fatal.cocci
 F: scripts/coccinelle/use-error_propagate-in-realize.cocci
 
-- 
2.21.1


