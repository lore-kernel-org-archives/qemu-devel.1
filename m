Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35684C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D639F20768
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8x32Tmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D639F20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjcW-0006PG-RK
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjbl-0004oY-Du; Tue, 08 Sep 2020 15:48:49 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFjbj-0002Tt-Lw; Tue, 08 Sep 2020 15:48:49 -0400
Received: by mail-pg1-x543.google.com with SMTP id g29so311455pgl.2;
 Tue, 08 Sep 2020 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4ojKecXaQTTfPhCYFFKjoo9GXGqrC0TrAFwXqdlTji4=;
 b=i8x32Tmvc8UWXJQ7y3/AWAhrJ0yhR/HYvU86fmiP3qPuPF5X6Y/5n3Z6zy5Fv/gN/M
 PArKLyHTgzafP+R/Lq0R6CEIGxkTAs8SXSZRu80HD+mqexO1iAtF/C7mqxbeqB+qJIoE
 z9WOjCq7gjm3NMV0syRVhDO/UkjMqdVWQT9F604X5aEvXRRStw5X48Ck0fWBKlZMQ4fA
 40xeMvI18DpBQ8WL6i6AgYpyL47xnZKZ3nm/3TOumOKjERWuyzS7rm9mtOAxYQTC+JqV
 XAXDzYCc8BDl0UQWN3A19m/sfuegYMWGX5t0mf2CJLzRG/c7v6vulqjd3SwUbCeqpEw8
 oTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4ojKecXaQTTfPhCYFFKjoo9GXGqrC0TrAFwXqdlTji4=;
 b=NDjuCh2Vn2h1PFSVN2JrN/vJyShCGQ/MkbCSlH7MeKgsSgQjoj0TUT3NEdPYJQuCXH
 Pkfk32jbi18AjYJa3PZpCLrDZb5nOJ+uuPpI1yymNkQylYHjPQPQxZRiB0r6eB2Ni5GE
 vdzNF6iXgC7/3JZdEtON5x/jQeIcEI/JEFUPFMzurzkFqGzxA6rnWCSb95Row2gMNhzi
 O6f0Z2YKE1Vc9ePrsDDSIXfwdjKZuaEiWP1Lzpa9rC/O7ykMAl01sPcBu48olpTptD6M
 42rC7GqN/XqJ381T3jwO2p+XFn9pK81YhvgUj0/H0PKQ9njGU8/UILlPKcFP9rW0FcSh
 1fKA==
X-Gm-Message-State: AOAM531C4UstaXfI1UEWzXLlvk2x/sI8uEj2dsnK+e8vyoCjhhkXg/3W
 OQBbWFLczsGvpxFWMPGcbGAv/Tww4foyzrjr
X-Google-Smtp-Source: ABdhPJzB+E0fVLpQUkUst1OKtIS1+lsa2szrZIrjwB/Vkt7bcZo0bYFKTRq/0nwpCbOVzVOg5av8+Q==
X-Received: by 2002:a17:902:6bc9:b029:d0:cb2d:f272 with SMTP id
 m9-20020a1709026bc9b02900d0cb2df272mr661938plt.11.1599594525217; 
 Tue, 08 Sep 2020 12:48:45 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id n127sm216922pfn.155.2020.09.08.12.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 12:48:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/16] ci: fixes msys2 build by upgrading capstone to 4.0.2
Date: Wed,  9 Sep 2020 03:48:06 +0800
Message-Id: <20200908194820.702-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908194820.702-1-luoyonggang@gmail.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x543.google.com
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


