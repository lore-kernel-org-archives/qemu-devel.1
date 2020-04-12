Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB97C2BB86
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9747206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4Ei/9dO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9747206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlEN-0006xF-RZ
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDN-0004vF-US
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDM-0001sg-Ht
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:41592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDM-0001rA-Bo; Sun, 12 Apr 2020 18:36:32 -0400
Received: by mail-wr1-x435.google.com with SMTP id h9so8522755wrc.8;
 Sun, 12 Apr 2020 15:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jlN4N/MyMKxw+6nyYt6mkHcMTTQwBCWy2vUqlxSx8T0=;
 b=o4Ei/9dOSd+pb+KfYpGct9KChO9QJ8t3INjgvz03nHbKqV9fZslP8Ow2/fLlWvdpC8
 WIhjv+vxJ9nJo2tS/+cKXe2J7n+38whRwAG3PNDX1El80psE7eA9GIRAsE8QunMWfQ35
 ov6JaB/4LnFtNr1sK+3BMa9KlLFht2LQwx0yp8L2QRFMI2yy3mCfRh7N30QhG4TjrMZD
 uK9tf4jiBaCdyf6sUGrEI0WBXGmtaM53z870M6kVKPdvKHq+1yVqV3H0yMCmx7zPgUhN
 djdaWnc7dAvHxRzPHzBMABbhZKQvHshfp9gO2KcPZrhFqQV2IYcha8XeezZPKGcTwnTC
 UvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jlN4N/MyMKxw+6nyYt6mkHcMTTQwBCWy2vUqlxSx8T0=;
 b=jwSeh5/l5DSzlmbWmP00SAfWvD+c95FQCmXw7PQWLTqXvovg57KFyHcKDGq/Pg4R4u
 RL6Sb1kHjwjngBo3OlIEaHOTUQvHW+EkqVZAomNuOo0Xy9qHaimPcNvN4xY3mJ88xonY
 sajq21MfzmWbFaIkkLhQ7JMCdJZJI471pR4cPf7EJ5hBmsP+u79X0lkqJPnWz8F9Pt9y
 Jo2cTdMCvpQb/dgl7/f6+3L3gvoIcuz+2V7CrNlvurBIeWgCxpnL49bre4wFfPb03N0m
 zTjX1WXwTonlelqrXSvOfql1/xSLrH8nojYY2nwrCCxe0dP2ir5d9YNBaUl5ffTbMIh4
 mkWQ==
X-Gm-Message-State: AGi0Pubi7CYfgefR1nDlg4tDGqsKQ/WKFcNzpuj9LVfm6f5t1P2UBO5j
 HAoYAvz9DL5FxeZN3xalWoyf2TCg5QOG2A==
X-Google-Smtp-Source: APiQypISyMaT/TEYDulrWCp1xfABa0NvDX/ISMcM9WlX6BfAJqa64wFywZotnnQ2RAljUAl7aZ359A==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr15903243wrw.228.1586730991085; 
 Sun, 12 Apr 2020 15:36:31 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:36:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 02/24] scripts/coccinelle: Script to simplify
 DeviceClass error propagation
Date: Mon, 13 Apr 2020 00:35:57 +0200
Message-Id: <20200412223619.11284-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a device uses an Error* with data not modified before realize(),
this call can be moved to init(). Add a Coccinelle patch to find such
uses.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 ...implify-init-realize-error_propagate.cocci | 69 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 70 insertions(+)
 create mode 100644 scripts/coccinelle/simplify-init-realize-error_propagate.cocci

diff --git a/scripts/coccinelle/simplify-init-realize-error_propagate.cocci b/scripts/coccinelle/simplify-init-realize-error_propagate.cocci
new file mode 100644
index 0000000000..2e3ec4d98a
--- /dev/null
+++ b/scripts/coccinelle/simplify-init-realize-error_propagate.cocci
@@ -0,0 +1,69 @@
+// Find error-propagation calls that don't need to be in DeviceClass::realize()
+// because they don't use information user can change before calling realize(),
+// so they can be moved to DeviceClass:initfn() where error propagation is not
+// needed.
+//
+// Copyright: (C) 2020 Philippe Mathieu-Daudé
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch \
+//  --macro-file scripts/cocci-macro-file.h \
+//  --sp-file \
+//    scripts/coccinelle/simplify-init-realize-error_propagate.cocci \
+//  --timeout 60
+//
+// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg692500.html
+
+
+@ match_class_init @
+TypeInfo info;
+identifier class_initfn;
+@@
+    info.class_init = class_initfn;
+
+
+@ match_instance_init @
+TypeInfo info;
+identifier instance_initfn;
+@@
+    info.instance_init = instance_initfn;
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
+identifier func_with_errp =~ "(?!object_property_set_link)";
+symbol error_abort, error_fatal;
+position pos;
+@@
+void realizefn@pos(..., Error **errp)
+{
+    ...
+    Error *err = NULL;
+    <+...
+    func_with_errp(..., \(&error_abort\|&error_fatal\));
+    ...+>
+}
+
+
+@ script:python @
+initfn << match_instance_init.instance_initfn;
+realizefn << match_realize.realizefn;
+p << propagate_in_realize.pos;
+@@
+print('>>> possible moves from {}() to {}() in {}:{}'
+      .format(initfn, realizefn, p[0].file, p[0].line))
diff --git a/MAINTAINERS b/MAINTAINERS
index 642c8e0b6b..6203543ec0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2058,6 +2058,7 @@ F: scripts/coccinelle/err-bad-newline.cocci
 F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
 F: scripts/coccinelle/remove_local_err.cocci
+F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
 F: scripts/coccinelle/use-error_fatal.cocci
 
 GDB stub
-- 
2.21.1


