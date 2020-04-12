Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA2EC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B1E2051A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6fZuN0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B1E2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlb6-0003lk-FD
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 19:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJK-0001h9-Ob
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJH-00069u-Jj
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:42:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlJH-00069Z-8E; Sun, 12 Apr 2020 18:42:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id h9so8536377wrc.8;
 Sun, 12 Apr 2020 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NTYH+s0TzLC/P3q6ndIJmCyp+nySJM10cWkO/ozqO2g=;
 b=c6fZuN0aKL58br/hJwvDJuphF3l2RPJk0wiLzBKLGEwTvDB607f/gBfIhE7YvBDI9V
 /kRCtVdi3VCSa6eiVhvBD+oGJ5RUEpBeqEbmH611YZBjGXDoKqykyGqf3a/MA5rM5nbF
 NmVrybcT7k2ay92MhFezTNfqo5S6VMrs/PbXIQfG3wVPRw+AOI8YcykhUCsG4fOYgWeL
 ZQeBgltyW1kEqQMO4haddZRmUU4/VrfdfLzObWjIJ/AAhiA1YbU4F+fQ/zT3ISzIUvO8
 YHhf8bOeQ5TAxSkP3Pm9o8hAbYu6aV5dhZnSv/Jm+zE5SaoPF+gYABJ0j7WPcuPkvhel
 0H3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NTYH+s0TzLC/P3q6ndIJmCyp+nySJM10cWkO/ozqO2g=;
 b=g7yQRxuPp+7M1LeoT7M+tHuSqpI/KiMyCANsPgxwVUhtGY9KTrtwIvMUKKKAv7Hhhu
 tq9nVj7//7m86d+gV1fADBgrzT5qihiFQpc4yB4Ly6Nk0mrmN/GfXZL8nysGPsIIhAg6
 KoKbfICwcGhCwwNk0BcAqC6pmNHV96Uk53ay+nf77wlmkIsxD7p5ohoolVGH/tPsidCJ
 u2C47+LZoQiS2u2/Vuuta3KAgGdFpAbm7R7BmU87ZSTvYTVKuhb/38Okdk2YYQzgsrLS
 ifnJ177peUaADBDB9QP2BKRDc38h2CBpnC+ml9cRtdqPXeIHjgeDqmrx0PmrXxIvSKeb
 8/fw==
X-Gm-Message-State: AGi0PuZD011pqzqhmXWy5WbR+Ky8XMmlcXR6SSMNHcac4yJaaZZUzTuR
 dqpOcEW9qQHQWZXV7rc2vo8olJsZCUN+0Q==
X-Google-Smtp-Source: APiQypItav/v6t5lS6P4Dm/fa3Z7WzEtpjzkEhjOdvhhw5s5FPk8R5dmmJ9o0MthD0JaR9OhUFdBMQ==
X-Received: by 2002:adf:f881:: with SMTP id u1mr10583380wrp.348.1586731357841; 
 Sun, 12 Apr 2020 15:42:37 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f63sm12083825wma.47.2020.04.12.15.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:42:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 13/23] scripts/coccinelle: Add script to catch
 missing error_propagate() calls
Date: Mon, 13 Apr 2020 00:41:34 +0200
Message-Id: <20200412224144.12205-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412224144.12205-1-f4bug@amsat.org>
References: <20200412224144.12205-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In some places in we put an error into a local Error*, but forget
to check for failure and pass it back to the caller.
Add a Coccinelle patch to catch and automatically add the missing
code.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Fixed typo 'provides', let prototype return 'void' (eblake)
---
 .../add-missing-error_propagate.cocci         | 30 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 scripts/coccinelle/add-missing-error_propagate.cocci

diff --git a/scripts/coccinelle/add-missing-error_propagate.cocci b/scripts/coccinelle/add-missing-error_propagate.cocci
new file mode 100644
index 0000000000..4b82e40418
--- /dev/null
+++ b/scripts/coccinelle/add-missing-error_propagate.cocci
@@ -0,0 +1,30 @@
+// Add missing error-propagation code where caller provides a Error* argument
+//
+// Copyright: (C) 2020 Philippe Mathieu-Daudé
+// This work is licensed under the terms of the GNU GPLv2 or later.
+//
+// spatch \
+//  --macro-file scripts/cocci-macro-file.h --include-headers \
+//  --sp-file scripts/coccinelle/add-missing-error_propagate.cocci \
+//  --keep-comments --in-place
+//
+// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg691638.html
+
+
+@ add_missing_error_propagate @
+typedef Error;
+Error *local_err;
+identifier func, errp, errfunc1, errfunc2;
+@@
+void func(..., Error **errp)
+{
+    <...
+    errfunc1(..., &local_err);
++   if (local_err) {
++       error_propagate(errp, local_err);
++       return;
++   }
+    ... when != local_err
+    errfunc2(..., &local_err);
+    ...>
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 54e05ecbdf..f996e72780 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2054,6 +2054,7 @@ F: include/qemu/error-report.h
 F: qapi/error.json
 F: util/error.c
 F: util/qemu-error.c
+F: scripts/coccinelle/add-missing-error_propagate.cocci
 F: scripts/coccinelle/err-bad-newline.cocci
 F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
-- 
2.21.1


