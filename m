Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFCEC10DAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67E74206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vE/bfbdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E74206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2nd-0005IT-DI
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2kT-0000GQ-1g; Wed, 09 Sep 2020 12:15:05 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2kR-0006Vd-8c; Wed, 09 Sep 2020 12:15:04 -0400
Received: by mail-pj1-x1044.google.com with SMTP id gf14so1585430pjb.5;
 Wed, 09 Sep 2020 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Q/d/vfX2r5ok5sWGBwNZjHxKJu0oUaT5gHBOiJ10fI=;
 b=vE/bfbdjP5SHyibm8NcSNfCaIfqKFJf7SLaN57JH9LLIW1r+R3vtjsITuqQIRflcwe
 g/+fVQeaRJPiOBPMYeYAP0d0shU7HxM7D+jmCjA98LGpe3HU4YT/p8M0Xe3cvhYwW8FO
 TcXLuergIDKmI5YkneYYelIIuoAg+DDlXTUrYdT2EZNOMhdpIO6JUilPV4juI9EwBcWI
 Vba5n7P8GdI+sWGsbKfIFeI8HbnlP93CPtdXe8i6NBNpr3fX0mCXoycWDBsmV4FH6qds
 2FnyAoojT3ciwwfLLPOKHJRTIXECuZZT1vk6Vx2RUIJgK3KmtldJ5Z89R0x8GQ4c/Ywk
 M5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Q/d/vfX2r5ok5sWGBwNZjHxKJu0oUaT5gHBOiJ10fI=;
 b=Gejlod+gt4IFB617ctDrTtTVWzqkxnRm0veCPb45AheFXrxpN/8sFQ2IJSwZCJoPEi
 qyyk8bxXQsu0E42XMrHTyVWX0C9tBxkUcx96Z4KtKXva7ZxecKqIk7OWx5YQlQ3u6oqo
 6UoUbjKz1ZvnF/JW3uZ1Aa5KmYB1e0+eGqpVwbhnDnohn2VrHsADHWY9fsW/MrXAGoHz
 qYuAxQztRAhHmDFUOiB/Oup0zsjwNipvXYBIzrYCKvu3NjCZBJ610gOlvGP9Cl12yD++
 17PKYxOc85Sg5aqIk7v+IofixoIWIfJAln7ryMmWbaQ7p2SYMNuA+U3goS8FcgWi1V3l
 6dig==
X-Gm-Message-State: AOAM5331o/OSnAQACUwZSLdGZyvdKwUAWAK0jV5XCtUt35WFQUKYT/eH
 5qounVzVOBjkavqsNxC/STIcCbs57Vr+sNWE
X-Google-Smtp-Source: ABdhPJy9FKq24HXe4r1sRYjjSovItWKr55VhO0tGrgXqzIETisEUW67sNTY90G8psD0+qeTvbWWY6A==
X-Received: by 2002:a17:90a:120f:: with SMTP id
 f15mr1469763pja.120.1599668101027; 
 Wed, 09 Sep 2020 09:15:01 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id l123sm2506987pgl.24.2020.09.09.09.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 09:15:00 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/24] ci: fixes msys2 build by upgrading capstone to 4.0.2
Date: Thu, 10 Sep 2020 00:14:23 +0800
Message-Id: <20200909161430.1789-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909161430.1789-1-luoyonggang@gmail.com>
References: <20200909161430.1789-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The currently random version capstone have the following compiling issue:
  CC      /c/work/xemu/qemu/build/slirp/src/arp_table.o
make[1]: *** No rule to make target “/c/work/xemu/qemu/build/capstone/capstone.lib”。 Stop.

Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1 are the tagged version 4.0.2
when upgrading to this version, the folder structure of include are changed to
qemu\capstone\include
│  platform.h
│
├─capstone
│      arm.h
│      arm64.h
│      capstone.h
│      evm.h
│      m680x.h
│      m68k.h
│      mips.h
│      platform.h
│      ppc.h
│      sparc.h
│      systemz.h
│      tms320c64x.h
│      x86.h
│      xcore.h
│
└─windowsce
        intrin.h
        stdint.h

in capstone. so we need add extra include path -I${source_path}/capstone/include/capstone
for directly #include <capstone.h>, and the exist include path should preserve, because
in capstone code there something like #include "capstone/capstone.h"

If only using
    capstone_cflags="-I${source_path}/capstone/include/capstone"
Then will cause the following compiling error:

  CC      cs.o
cs.c:17:10: fatal error: 'capstone/capstone.h' file not found
#include <capstone/capstone.h>
         ^~~~~~~~~~~~~~~~~~~~~
1 error generated.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 capstone  | 2 +-
 configure | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/capstone b/capstone
index 22ead3e0bf..1d23053284 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
+Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1
diff --git a/configure b/configure
index 4231d56bcc..f4f8bc3756 100755
--- a/configure
+++ b/configure
@@ -5156,7 +5156,7 @@ case "$capstone" in
       LIBCAPSTONE=libcapstone.a
     fi
     capstone_libs="-Lcapstone -lcapstone"
-    capstone_cflags="-I${source_path}/capstone/include"
+    capstone_cflags="-I${source_path}/capstone/include -I${source_path}/capstone/include/capstone"
     ;;
 
   system)
-- 
2.28.0.windows.1


