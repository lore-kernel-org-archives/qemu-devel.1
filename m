Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49C2C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6613206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok4WPrVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6613206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWBa-0006GX-Q3
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrD-0002FC-R0
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrB-00037s-MD
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:40470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrB-00037R-GR
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id a81so298429wmf.5
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YhVPUQsfht6jA/IUTaj+buf6eqXAxfk/bBYv1XmJLk4=;
 b=ok4WPrVUixwIKypERf9YDPnea3W9Jvy7sanmZCZ+u9uMZMV0TH+h1feoKfAQYSCia8
 aKVETMkgPqRtKV8RFGFlosxY5dcheaR53J56AWxRC+WN8A2DzL6MTUDRuuMODdrknKxK
 bkXjAganl6WsOl5iBU3GAo2UTdCjldIL9JyeYnAdSoKtfpDVoQHIv9HGCfqJa0pL4MJC
 di1OSYsrTpiRA3X91/YG7grAFgRt4Ocxk4utXW4ouE/YOrZs/ujnjPs7o5WYSfHRanD9
 0JX2VpHs8JBQ/kzOLblGZ4T0vl8nH9zO8XN4QGAU4pnURoHNxmrmuNxEaVdtzWAcd40y
 xoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YhVPUQsfht6jA/IUTaj+buf6eqXAxfk/bBYv1XmJLk4=;
 b=XoTDMhSTbm/02aSi04JEye4G4VXFWMOTjXquHkIK80FCTVBSNl2Fc19espPZAQ3g8e
 3HUejHi4IvD9Gp9vbSeEOw3vHNdXLNLn6aQHPJ3fd14kqOVzzlGlsyJ22cMElBwRyqFO
 /eCdhZo+Wqy0aZnelAUHtQc0N0VMxto/QkRwOhpsNOq1TwoD9tmFh7o4lFp5xLBOhciF
 S6sElYLcana5yf+B4PE7ML+BIag8ld8lLR/QUnz90OKImy5BTqIWkGB9b2RPELSsc8le
 oV/QnEow+kLEjW6ECbYvE3nS9Y0/U/BdfFtaR3jt29eLNKkj6Zt+bQU4uPx6faQlprpI
 F12Q==
X-Gm-Message-State: AGi0PubeyU5zwUG3WHhtwqdD2blOBR9NRKSeRTW4X/320flWE3JS2xuX
 MocstZZTa0j0gB4iRbrXCgPxjN+NPNg=
X-Google-Smtp-Source: APiQypIiSUddRW6GrDP1x9LqwJu4HPIC+MyntKbNyZdQRmc6Zn7xN1OrxmXLbGwi5yjCUEDF0VqzBQ==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr205798wmh.82.1586195300185;
 Mon, 06 Apr 2020 10:48:20 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 25/54] scripts/coccinelle: Catch missing
 error_propagate() calls in realize()
Date: Mon,  6 Apr 2020 19:47:14 +0200
Message-Id: <20200406174743.16956-26-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

In some DeviceClass::realize() while we can propagate errors
to the caller, we forgot to do so. Add a Coccinelle patch to
automatically add the missing code.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .../use-error_propagate-in-realize.cocci      | 54 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 scripts/coccinelle/use-error_propagate-in-realize.cocci

diff --git a/scripts/coccinelle/use-error_propagate-in-realize.cocci b/scripts/coccinelle/use-error_propagate-in-realize.cocci
new file mode 100644
index 0000000000..7b59277a50
--- /dev/null
+++ b/scripts/coccinelle/use-error_propagate-in-realize.cocci
@@ -0,0 +1,54 @@
+// Add missing error-propagation code in DeviceClass::realize()
+//
+// Copyright: (C) 2020 Philippe Mathieu-Daudé
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch \
+//  --macro-file scripts/cocci-macro-file.h --include-headers \
+//  --sp-file scripts/coccinelle/use-error_abort-in-instance_init.cocci \
+//  --keep-comments --timeout 60 --in-place
+//
+// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg691638.html
+
+
+@ match_class_init @
+TypeInfo info;
+identifier class_initfn;
+@@
+    info.class_init = class_initfn;
+
+
+@ match_realize @
+identifier match_class_init.class_initfn;
+DeviceClass *dc;
+identifier realizefn;
+@@
+void class_initfn(...)
+{
+    ...
+    dc->realize = realizefn;
+    ...
+}
+
+
+@ propagate_in_realize @
+identifier match_realize.realizefn;
+identifier err;
+identifier errp;
+identifier func_with_errp;
+symbol error_abort, error_fatal;
+@@
+void realizefn(..., Error **errp)
+{
+    ...
+    Error *err = NULL;
+    <+...
+    func_with_errp(...,
+-                      \(&error_abort\|&error_fatal\));
++                      &err);
++   if (err) {
++       error_propagate(errp, err);
++       return;
++   }
+    ...+>
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index d06ffeddd5..7b58f02efb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2059,6 +2059,7 @@ F: scripts/coccinelle/error_propagate_null.cocci
 F: scripts/coccinelle/remove_local_err.cocci
 F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
 F: scripts/coccinelle/use-error_fatal.cocci
+F: scripts/coccinelle/use-error_propagate-in-realize.cocci
 
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
-- 
2.21.1


