Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFA2C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D058120674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIFqx6bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D058120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtX5-0002HW-0G
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDsH2-0004Lo-FN
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDsH1-0001Wd-DR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54586)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDsH1-0001VZ-9W
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584374844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5MseejxD/7No0UFmjuvYKtOzc/OHo7duv42MWn+BaII=;
 b=dIFqx6bcN6gIN9lCWEwEEgHDgZr36/wLikByEnPkQYHARlskNueM2llvlUByMmigSaC035
 LOlULgAdH44dtNYrzJueQyRiZmD9s+Y10JCgKusSol8OhkVJuOHdyLy/DQjqO41mJbyO4W
 pea9f1VZAAFIboxKyVMlndAHVY1eOPs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-aK5BX1ZhN9GlviFBOtor6Q-1; Mon, 16 Mar 2020 12:07:23 -0400
X-MC-Unique: aK5BX1ZhN9GlviFBOtor6Q-1
Received: by mail-wr1-f71.google.com with SMTP id l16so8540248wrr.6
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CXjQwOZg5TRrzV2gPeofWVxsNWA85AadaVJBm5vW278=;
 b=jSAUUcU6nD/y2K1BDwAL22W+brDUlGIj8Juix1WZ00rfq1X5nw+YSyVLwCpyZ4Ch1F
 116Vky7Z7gzIyNj1JPwfuj32Saof5NaoCbhArN9snC95GUr+qEasnu/ee66fPo8dYtbV
 BeSA2EJiJKFCG2yFESqPsVHe9RWU8HFV9frvk9tsvdJfKFeeyGePC1LGl6yaP8Rb9fos
 GUldH3NJXyyBMVTvap8t3jWMoBcTTPJXwjLPjw8UObx/hCwvXbWkwmaGVrXDNMjEACVo
 +hTn12KvKqip7t1hGbLw5vE/j91yW+d3MuS00DxQg6HEBn2GnCt1yxW/D/B1qzU4p2xn
 qFeA==
X-Gm-Message-State: ANhLgQ1uzdaegp17rA3atQd6CjuajS1Ycjh/ZL0V3H24bzfAaOqX06xt
 FK9fMqMI8vpAU/ZrpvSYwUT089b7vDqB+GQdOAX76a+Zz4qngA4ZnUSZEfPI/hT+oR186BBPJMn
 3DPp9Rmlz0KhZN9o=
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr63154wrl.201.1584374841785;
 Mon, 16 Mar 2020 09:07:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsxe/KqUgpqRGockZFKDs2m6WInFJ38H8FHOWfbUrTbCQq4cCk2UoU+Cb7vY3P51wmSj99eAw==
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr63130wrl.201.1584374841621;
 Mon, 16 Mar 2020 09:07:21 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id u204sm185104wmg.40.2020.03.16.09.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 09:07:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/19] target/arm: Add semihosting stub to allow building
 without TCG
Date: Mon, 16 Mar 2020 17:06:23 +0100
Message-Id: <20200316160634.3386-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316160634.3386-1-philmd@redhat.com>
References: <20200316160634.3386-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Semihosting requires TCG. When configured with --disable-tcg, the
build fails because the 'do_arm_semihosting' is missing. Instead
of adding more few more #ifdeffery to the helper code, add a stub.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/arm-semi-stub.c | 13 +++++++++++++
 target/arm/Makefile.objs   |  3 ++-
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/arm-semi-stub.c

diff --git a/target/arm/arm-semi-stub.c b/target/arm/arm-semi-stub.c
new file mode 100644
index 0000000000..47d042f942
--- /dev/null
+++ b/target/arm/arm-semi-stub.c
@@ -0,0 +1,13 @@
+/*
+ * Arm "Angel" semihosting syscalls stubs
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/semihosting/semihost.h"
+
+target_ulong do_arm_semihosting(CPUARMState *env)
+{
+    abort();
+}
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 0c6f8c248d..fa278bb4c1 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -57,7 +57,8 @@ target/arm/translate.o: target/arm/decode-t16.inc.c
=20
 ifeq ($(CONFIG_TCG),y)
=20
-obj-y +=3D arm-semi.o
+obj-$(CONFIG_SEMIHOSTING) +=3D arm-semi.o
+obj-$(call lnot,$(CONFIG_SEMIHOSTING)) +=3D arm-semi-stub.o
=20
 endif # CONFIG_TCG
=20
--=20
2.21.1


