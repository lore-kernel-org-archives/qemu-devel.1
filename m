Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17F0C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B75F206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPGdZhRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B75F206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0Ea-000085-ES
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka0A5-0001nb-JT; Tue, 03 Nov 2020 12:32:01 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ka0A3-0007dM-86; Tue, 03 Nov 2020 12:32:01 -0500
Received: by mail-wm1-x32b.google.com with SMTP id h62so110557wme.3;
 Tue, 03 Nov 2020 09:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s/6NX9jbGA7gWKbxB5Gz4aNw6mxohCMAm/BDmMgMuFc=;
 b=aPGdZhRhlCljuTfRkVrwfmgnEjNRm91Ya9Ario1LCuXRJbnfGTHuXXc3tM2Vv3xMi+
 axoaYyCsl2BJ/gH1l9E5l69242bHCufFrQeVjIRFL4wOSWKariuLPJe3fzM5OuQCAmz/
 /VKBJ2pU0kqYEG7R7QG+JVahvDNFewaNxl8ahlfhU9dkgiHnGjFnheguCmvQKenDcU74
 RjdFq+MJ3XnpHm27uUHBDtKrCoF0ZyWO9FAwzkcbFrIwSiJX5prBTF/HQBFKhNegiX3W
 uj37iEZlJYf/ivn9/wTjpTJsGKHtTHWKjxIAG7cwIXeGNy6QnwacrauDasGKmVUh5Ifs
 2ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=s/6NX9jbGA7gWKbxB5Gz4aNw6mxohCMAm/BDmMgMuFc=;
 b=UinxCjaqBDeHkzHzCZoCZOhIOGy9Am6d1rHBS4LWgeoNunJnuEuGdnPfq+9IlUQ9js
 4xAyYz4WdGW6DQb/VWQH+mHHnOms4qFeDBKezybQaD2foBr/Wdj3fBNgHarMVil+dc+K
 IHFSFw1bochziGKEh3MEI0EmxCm0hzp6y/vi66Wk3lKNefsggUmxYvzwjFfw4KG32x/L
 lLHcRRzjfnOJBql0FoDyRPECCMkwECrdWXJvfylEs5DYpm0GbBbv4jDaMuF2Y3VWXhsd
 1KogGI6K+lnGkHQUdXVEjNM5yNE909xcOwbhqK3B3+dCKpZD1/WG8TXyu94OMALSrGux
 Qw9Q==
X-Gm-Message-State: AOAM533ToPKtI+GOPR+92A0oeWl0NzynXj1a3F1GvO2YaShcBnMX1ZGA
 sRbyGT1of+lyJI5X96QFeARiMOiZZEg=
X-Google-Smtp-Source: ABdhPJzT7wzpZtCeZDjiMhRxZj8TRCwYEFF9RU7pepL0NWAs+cN8DhXitSSUbhjm4ecqA1/4pu8ecA==
X-Received: by 2002:a1c:1b85:: with SMTP id b127mr199522wmb.163.1604424716577; 
 Tue, 03 Nov 2020 09:31:56 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id h7sm26814506wrt.45.2020.11.03.09.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 09:31:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/6] target/mips: Fix Lesser GPL version number
Date: Tue,  3 Nov 2020 18:31:26 +0100
Message-Id: <20201103173127.2704256-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103173127.2704256-1-f4bug@amsat.org>
References: <20201103173127.2704256-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Paul Burton <paulburton@kernel.org>,
 libvir-list@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Chetan Pant <chetan4windows@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chetan Pant <chetan4windows@gmail.com>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201016143509.26692-1-chetan4windows@gmail.com>
[PMD: Split hw/ vs target/]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cp0_helper.c         | 2 +-
 target/mips/dsp_helper.c         | 2 +-
 target/mips/fpu_helper.c         | 2 +-
 target/mips/gdbstub.c            | 2 +-
 target/mips/helper.c             | 2 +-
 target/mips/lmmi_helper.c        | 2 +-
 target/mips/mips-semi.c          | 2 +-
 target/mips/msa_helper.c         | 2 +-
 target/mips/op_helper.c          | 2 +-
 target/mips/translate.c          | 2 +-
 target/mips/translate_init.c.inc | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index 12143ac55b9..709cc9a7e3d 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/dsp_helper.c b/target/mips/dsp_helper.c
index 8c58eeb0bf8..09b6e5fb15a 100644
--- a/target/mips/dsp_helper.c
+++ b/target/mips/dsp_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 6cc956c023d..020b768e87b 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 98f56e660d2..e39f8d75cf0 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/helper.c b/target/mips/helper.c
index afd78b1990b..063b65c0528 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/lmmi_helper.c b/target/mips/lmmi_helper.c
index 6c645cf679a..abeb7736aeb 100644
--- a/target/mips/lmmi_helper.c
+++ b/target/mips/lmmi_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/mips-semi.c b/target/mips/mips-semi.c
index 10a710c1e80..898251aa023 100644
--- a/target/mips/mips-semi.c
+++ b/target/mips/mips-semi.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 6865addaf6a..249f0fdad80 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 0050d0616b6..5184a1838be 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/translate.c b/target/mips/translate.c
index f449758606d..3197a692c45 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index fb5a9b38e5d..ea85d5c6a79 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.26.2


