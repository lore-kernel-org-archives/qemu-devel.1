Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EC7C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5875D20731
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJLN2R8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5875D20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAEY-0006dI-EG
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qI-0000XJ-S3; Tue, 15 Sep 2020 08:13:51 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kI9qH-000899-1G; Tue, 15 Sep 2020 08:13:50 -0400
Received: by mail-pj1-x1044.google.com with SMTP id gf14so1614294pjb.5;
 Tue, 15 Sep 2020 05:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qBiHjFc2XldMuU70Rv/GASQm/Q1CmoJMQE32Qhbbw0w=;
 b=FJLN2R8RyyiCUgjf4S7wi5csg/znuwBY8H9s2TJQJ2ni/KB0yZaDm+TeNK1KBT5iNg
 7fLoZimL7CufnMQo1TrFW0xHKCTmxb1K9jQD8GlDZsNWjW7BwlihqkcDWiFE58uXFNv6
 INUy35fQmuNohONEhl84oDPahsjKWSnQoAtFjjP0/C3MG3J+VKrIaUqvqEX5OnaCDBgN
 AlXVetsJFmuAUhGuO37xhsgLXKeJ7cgL5DaMcUAirJp0Rt3QHA1O1mLGOxLdlI7Y+vd/
 WactelzQkIVSQCOJamFB5yNit/LxzUkRwExt8A4PsVdFStiQhH1e7OLWON7/lowyLU1i
 0ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qBiHjFc2XldMuU70Rv/GASQm/Q1CmoJMQE32Qhbbw0w=;
 b=p44MfaKw+ajJwN8+chDgX18eBYH5DUuj2nSfi0jwiNUkUvjI8FZmLXH6my6oW0z0E3
 1tOLteM6RMjEMr/yB6YTbwcuzXF2xFNLMvZjP82gnU1EgRNiEhpZZQk+xGA+US31Ywmo
 w015pyl1CMv15ZYYOc6KiyW+yz9xBwCFOMWInph9Kd6pUcoYE/3cBzH3BMPW8fhoaEZb
 84FrK7ZrAqu35wk82mj27Z4TyaESITyleKZinCMgKm6/1MHktY10zKOHAoGTLbwfZGB3
 VwTXfjh/cSVM2CSjYEYDYvJsfUIy2vxRh5vEVA8hEfRep5WeId1iWB0kFv1gbyaQV1iB
 aUaQ==
X-Gm-Message-State: AOAM53338pbZE6fAFSDcMs6mgxayisZLYFJViiqRyUve5ueyvbOYqdPu
 IZdYIYWDG6yQnHgBb7qWCAM2+SqsJmYBKLhfrR8=
X-Google-Smtp-Source: ABdhPJwUGnNJNo26A0ff1ET+pLtDkOBF7JIHVPUdG6sQi+qP73QgIUQ71caVdf1G9VDGAyPKh3qkHA==
X-Received: by 2002:a17:902:c202:b029:d1:cbf4:c596 with SMTP id
 2-20020a170902c202b02900d1cbf4c596mr7840166pll.27.1600172026597; 
 Tue, 15 Sep 2020 05:13:46 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 k28sm13683061pfh.196.2020.09.15.05.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 05:13:45 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 02/26] ci: fixes msys2 build by upgrading capstone to 4.0.2
Date: Tue, 15 Sep 2020 20:12:54 +0800
Message-Id: <20200915121318.247-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915121318.247-1-luoyonggang@gmail.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
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
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
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
index ce27eafb0a..f59080703e 100755
--- a/configure
+++ b/configure
@@ -5157,7 +5157,7 @@ case "$capstone" in
       LIBCAPSTONE=libcapstone.a
     fi
     capstone_libs="-Lcapstone -lcapstone"
-    capstone_cflags="-I${source_path}/capstone/include"
+    capstone_cflags="-I${source_path}/capstone/include -I${source_path}/capstone/include/capstone"
     ;;
 
   system)
-- 
2.28.0.windows.1


