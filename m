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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50556C10DAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E337421D80
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECHoqcsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E337421D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwli-0005Vm-Op
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwgg-0006EL-2s; Wed, 09 Sep 2020 05:46:46 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwge-0007fU-Fl; Wed, 09 Sep 2020 05:46:45 -0400
Received: by mail-pf1-x444.google.com with SMTP id o20so1660892pfp.11;
 Wed, 09 Sep 2020 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4ojKecXaQTTfPhCYFFKjoo9GXGqrC0TrAFwXqdlTji4=;
 b=ECHoqcslXY6SI41cif/GUNa8W+ADqyruiaV0LAm51EPs73p0ARBNiFqdoLSVfiA+8R
 N9EnHnhqEYXnS07qRCWRvj3IWy1fQqmAMA1XkEp7xOWpZAZR46Y3FOLof1ojhDkm70hJ
 5bhkmcCEPZlZdKtlbbSAjVIHcNkbQahKa8SFKRxvQL+A1l62xgnRBRl6vlJ9lWi7ng7V
 krzdPkeFQBstNq275yZg0HO5MMB518MbgGK4zP2o3vzuXClJHCXw6l1UyONVttmt/o4Y
 sKRYbdon+cROeaxevUKmyP/TWAwad9p8aTL3d2jHZqsui3uUKk2tPXhHOb02i71ycX5/
 7U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4ojKecXaQTTfPhCYFFKjoo9GXGqrC0TrAFwXqdlTji4=;
 b=eF5GQ4Bg5fJRVEskMkBvxzdsfIj5EChD6p4nmNP5Tr/FY1Z9oqsqB9Y1QNrYwAehOx
 b9ITzW5vT1kACfXm/1Pnqx6fZABfBZcwijY6IkUuqCjJIr5L6r6/GAZV/Ni4Bhv6KRGr
 T0a66BwoutCx8rYP2q5/kNn3vK6dMKQPr0YVjC0x2QWMK4tFpMzGkxTw7X8NoPfY7JKK
 ElaT/4SO528S9N68RoKgiAr9BKq1YcphFOn7AT0fjJ66Ql8VQhSlXkaSCCN5SQC8k8OD
 HqsxP17Tldg6aQ8jzutgS9rca/U8keXF8xtMACZVPsVlo16u8WegHNxy8NfXtZedbsRN
 gAzw==
X-Gm-Message-State: AOAM531Qcn59ietSx299uWtznc5ALTM3eDM9nUe7bGrrnRFdYrdQH/d2
 mbLQ+TUIbHMLUJG2xRDaKCCgnp04Sfbm0whD
X-Google-Smtp-Source: ABdhPJxWFkhZ84+aby6QOk2XAIoPTAlLF+hEl3VFGl8f2X3rxAUjV+nkn+a86yoBR9ntqku6razz2g==
X-Received: by 2002:a62:1bc7:0:b029:13e:d13d:a0f6 with SMTP id
 b190-20020a621bc70000b029013ed13da0f6mr177781pfb.18.1599644802301; 
 Wed, 09 Sep 2020 02:46:42 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 64sm1708312pgi.90.2020.09.09.02.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 02:46:41 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/21] ci: fixes msys2 build by upgrading capstone to 4.0.2
Date: Wed,  9 Sep 2020 17:45:58 +0800
Message-Id: <20200909094617.1582-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909094617.1582-1-luoyonggang@gmail.com>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
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


