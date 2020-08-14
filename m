Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BEBC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F2C2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 08:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2G+AhK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F2C2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6V5z-0005Kg-8R
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 04:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V4z-0003Nw-3C; Fri, 14 Aug 2020 04:28:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6V4x-0004Lc-JN; Fri, 14 Aug 2020 04:28:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id k20so7219824wmi.5;
 Fri, 14 Aug 2020 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gPP3i1OySIOEchR+vbmDC0pxKakXyB2ET0Tvdz9ALkE=;
 b=l2G+AhK5j5qZqgRTf3dVx+u67ook/837XCxGnnpnoecz4K/PgEej3QDYpkhAI7ljq+
 +d5MxxFxzi4/WS1I/tkaJnvUH9KHGr6zW+c0efaJ7JROFNnq9BXTb4hQMEeC519o/c6W
 nx4gLMp7hW316JDLdu2hvDmU00bq3SyUDVZl6ZX4R37sI5Kr5yz0luz0leOpToTAmahD
 YgsM5h1VRiCYH1F1EGfJrZVtNGayr/MDg+l7PlbDbP0ScpI1YGcc9fRFLzHypRBv+SV6
 az4QjZHwEaWN/aFxawYFrqgoiwcn2fH+wgkf2H2R/KBjrvg429E3B/KLSwYKIiRiv4wR
 LFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gPP3i1OySIOEchR+vbmDC0pxKakXyB2ET0Tvdz9ALkE=;
 b=dBDwAscgG7kyOzWZEnucTPDNaysOoeHVZNxQA/9wTlrtnVEOCH+XIg+ybyqBu1FhYW
 PZ9YI3N8QeTUBySSRNIkt3/pgVlnvDbQDitihv0wlR41/senpLj42E3OfMAVuVHW1NaJ
 xvhPuNt9q1HUP6Cqw2CoMOkEtzz4gLGeUqTsQi0Bs81zDbIt0DzYEKXafN/y+Sbs1fdm
 OXblAVc+wYopo+x5DNauZA+F56Ac7M/y23ihZD7C+L852VMjGXPhB2S9baa0+3A4n//1
 UIoF2AHC3IYUvFKTRzE7W8jAzzXJ5MOL0l0khGGBvQvqphzCj1+u/GTDiZfFvBvt1tSb
 ZB0w==
X-Gm-Message-State: AOAM531YSmOsdV1ULfFSBySgRcDDHqq7bkPsvq7zsTwmrXB87Qa5XPD8
 pE08KwIjXZ/Omx12s8waGrcwc3Kgljc=
X-Google-Smtp-Source: ABdhPJzpUYuoXoQ17vWZzlmIOYmvHyXDRkOktOqNsXwTPLrhDUOgsZZwft1I+kZRL+KMDly774xx0w==
X-Received: by 2002:a7b:c0d3:: with SMTP id s19mr1499911wmh.84.1597393725130; 
 Fri, 14 Aug 2020 01:28:45 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d14sm14668107wre.44.2020.08.14.01.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 01:28:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] block/null: Make more explicit the driver default size is
 1GiB
Date: Fri, 14 Aug 2020 10:28:35 +0200
Message-Id: <20200814082841.27000-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814082841.27000-1-f4bug@amsat.org>
References: <20200814082841.27000-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As it is not obvious the default size for the null block driver
is 1 GiB, replace the obfuscated '1 << 30' magic value by a
definition using IEC binary prefixes.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 block/null.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/null.c b/block/null.c
index 15e1d56746..8354def367 100644
--- a/block/null.c
+++ b/block/null.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
@@ -21,6 +22,7 @@
 
 #define NULL_OPT_LATENCY "latency-ns"
 #define NULL_OPT_ZEROES  "read-zeroes"
+#define NULL_OPT_SIZE    (1 * GiB)
 
 typedef struct {
     int64_t length;
@@ -86,7 +88,7 @@ static int null_file_open(BlockDriverState *bs, QDict *options, int flags,
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &error_abort);
     s->length =
-        qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 1 << 30);
+        qemu_opt_get_size(opts, BLOCK_OPT_SIZE, NULL_OPT_SIZE);
     s->latency_ns =
         qemu_opt_get_number(opts, NULL_OPT_LATENCY, 0);
     if (s->latency_ns < 0) {
-- 
2.21.3


