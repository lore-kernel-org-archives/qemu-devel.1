Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E1CC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30149206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="parlbEuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30149206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja15m-0006U9-Eg
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 13:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0tl-0003mH-7I
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:57 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f]:43993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ja0ti-0008Uw-29
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:46:56 -0400
Received: by mail-lj1-x22f.google.com with SMTP id l19so5561545lje.10
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O8xcy6488n578YO1tPRl/n3OdZSASWRU/1vD5lfdolk=;
 b=parlbEuyTAjiWXmpUJSfEFRXNMOmi5xVxjmr5IRzn/G/JSfjtH42fTIr3PvlLn4PeF
 RPH9JsMiASytXOp37vBidMV2FkrjkKZlxrSarGNi7gnU35Jj4W2hX9Hsj78gLOFjxvg5
 0+pNyg/98DdKJxHKUYDN4cuC6Nh3d+4VDBbh1DS7e6UBa4tOxbuoTSdNFd8aWdvhTiox
 9qT5NUxfyilXpsH6mYoAamto/j5tyl9PTdjw0/iwEoHJv/fQUkJynWKBn442/b/AJvRz
 AuJqjQYzwNGfFVWMd6z/LJ9RZwNkQlmF6Fym4c72/BJYUlyN1dQE6Oa+3/Ohp7rGrOSM
 no2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O8xcy6488n578YO1tPRl/n3OdZSASWRU/1vD5lfdolk=;
 b=E4DErkZ+JXiyNAgWJ7PHdHhCdq0Y9KHACnoU6A7WrM1Pe7jvhgVCk0FjqbwexXrI0b
 VtN+uxmUNFydzDNWYyZQeM8W3oHVQ8pi7qW/aa9sjIpXJ+dXELkvytXUFFrkvDbItivU
 sQ2adkf4hLN01YNMfmxyx1yyR/VGOdFmZrN8YCg481f2qm3mnqu/OrJzpx/hO6CzfOih
 GnLujR9qAXToa/eQuJJoqUP9veWviEFBqj/mH44Dwum7SklIZ700F9StoaIuqWn0XX/F
 OdnULtniubzcoaZzONCucceLIrTwZ6lDqjxcEsTY+OVpQ6AzXVOwggS51PDO3UJAWDp6
 WNtQ==
X-Gm-Message-State: AOAM530VC/ms3MLKXcI8sPO0FwVePOuKgnKr6rERtUam+CXN3stFOKw8
 2cVVYpSTu+pxuKGabURBdmxrdP1/oBw=
X-Google-Smtp-Source: ABdhPJwRRHcqeETqr+0mJDzd6G3KbuKDTS3/ZiBvKfrw4cjciGgbKeLLMW7qzi0OHq30KL5wRNq2Fg==
X-Received: by 2002:a2e:8107:: with SMTP id d7mr931976ljg.158.1589651212270;
 Sat, 16 May 2020 10:46:52 -0700 (PDT)
Received: from localhost.localdomain ([109.245.227.98])
 by smtp.gmail.com with ESMTPSA id i1sm3024759lja.3.2020.05.16.10.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2020 10:46:51 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/18] MAINTAINERS: Change Aleksandar Rikalo's email address
Date: Sat, 16 May 2020 19:45:48 +0200
Message-Id: <20200516174548.7631-19-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
References: <20200516174548.7631-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-lj1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@rt-rk.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar Rikalo want to use a different email address
from now on.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 .mailmap    |  3 ++-
 MAINTAINERS | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6412067bde..e3628c7a66 100644
--- a/.mailmap
+++ b/.mailmap
@@ -42,7 +42,8 @@ Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@mips.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <aleksandar.markovic@imgtec.com>
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
-Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
+Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
+Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1f84e3ae2c..8d5562c5c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -212,7 +212,7 @@ F: disas/microblaze.c
 MIPS TCG CPUs
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: target/mips/
 F: default-configs/*mips*
@@ -1041,7 +1041,7 @@ MIPS Machines
 -------------
 Jazz
 M: Hervé Poussineau <hpoussin@reactos.org>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: hw/mips/mips_jazz.c
 F: hw/display/jazz_led.c
@@ -1062,7 +1062,7 @@ F: tests/acceptance/machine_mips_malta.py
 
 Mipssim
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Odd Fixes
 F: hw/mips/mips_mipssim.c
 F: hw/net/mipsnet.c
@@ -1070,7 +1070,7 @@ F: hw/net/mipsnet.c
 R4000
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Obsolete
 F: hw/mips/mips_r4k.c
 
@@ -1085,7 +1085,7 @@ F: include/hw/isa/vt82c686.h
 
 Boston
 M: Paul Burton <pburton@wavecomp.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
@@ -2582,7 +2582,7 @@ F: disas/i386.c
 MIPS TCG target
 M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
 R: Aurelien Jarno <aurelien@aurel32.net>
-R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
+R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
 S: Maintained
 F: tcg/mips/
 
-- 
2.20.1


