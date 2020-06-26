Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80132206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf7dl0Tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80132206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolJR-0003qJ-Qy
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jolH7-0000hk-Gs; Fri, 26 Jun 2020 06:08:01 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:43436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jolH6-0005tR-0X; Fri, 26 Jun 2020 06:08:01 -0400
Received: by mail-ed1-x544.google.com with SMTP id d15so6453350edm.10;
 Fri, 26 Jun 2020 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=MSVPMtL0U7LZeXFp6t3i8NiLBjb/HuF+SqmOMbF9Q7U=;
 b=Nf7dl0TcPihaBgGqB9HYMl6NZafLJNyqqDZnDQ/dUHnMhC/MeGMaIYJsXfq0EfqcPw
 OOGo9eEzDA8aIxFPWKN7ykhobCGoaiRy8BV9JmVTgVbY7gpvXThjPHBTYAJ4cI5VmAak
 MZQ2VLhq/eZN62iWFuxtcCLyLSqLm0tZ+Hs9eCFN8z96qcXi/QfYOfjpZq0Yx//5jNqV
 MrhBfb2Gj8h+SBsdYcXvDXusd6OuSesO2ZeQDrE8J8Csz/K/WBdh+hpPna72Jm5NMeFg
 YfBKt5VJd7Ec65TNtJs3A3lwY6R3m4x7bV39NltY8QLNbYqC7kJ9LSy0sLxqJZn8gXGx
 Zyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=MSVPMtL0U7LZeXFp6t3i8NiLBjb/HuF+SqmOMbF9Q7U=;
 b=UrmamlsyiweIUOCYkdcnvIb7QzBZ6jonsDDxq7Ymd8lUg68dq4HU3gctgp1FyPur3N
 YKX3ecfdCZop8Ai1xFTSwKm6QpJf4m6YO+dmyeRDUAkWDyjDfP3Ed+GtPPUI5DFGNlYu
 MLbBuSEsSxUna3NgGt2KQ20z3u30N8KyJD97C2O30QUala/jRRZDg1tl0JzwnF8aETQi
 wJYRdw2HdvSCUwRDCe0qcjxFM8Cl7kt9jcjJNuJgHpME9zAU77QQRRKhaVexAiFv2Xp6
 sZU3VTVAAgRRHsSXN9rVh68R3vVup28Szu9bE6W09saTJQrhUE8YvZVA2uuJk+pOOSgU
 6iRA==
X-Gm-Message-State: AOAM5319l8SryHOeTesrTdE8EYplFGm4cl/M4i5u0+UoQdgEv2Pi2+18
 CnGf/8wbKePUzbJinsjqDRVEvNBaJAQj2OEx8LlDfI8K
X-Google-Smtp-Source: ABdhPJzs+L7vsGWBgDn5C2GwSUJM76LCixQ97aEfvj2ALWJrPp3NMZNNWGsgCEyNIEgL56pbhYsPCYqog8k7bnWqQFk=
X-Received: by 2002:a50:cf05:: with SMTP id c5mr2678664edk.232.1593166077974; 
 Fri, 26 Jun 2020 03:07:57 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 11:07:47 +0100
Message-ID: <CA+XhMqxRDPotkG6ioYipzZNMLj-w1CbFbz2cd6BPet8GQ4r8oA@mail.gmail.com>
Subject: [ PATCH 2/5] haiku build fix
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 19a41d406eda976001827d248398d7fb172d140b Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 10:38:17 +0000
Subject: [PATCH 2/5] Enable *pty API.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure           | 9 +++++++++
 util/qemu-openpty.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 96ba4cf3ce..f040b07463 100755
--- a/configure
+++ b/configure
@@ -2373,6 +2373,12 @@ else
   l2tpv3=no
 fi

+if check_include "pty.h" ; then
+  pty_h=yes
+else
+  pty_h=no
+fi
+
 #########################################
 # vhost interdependencies and host support

@@ -7758,6 +7764,9 @@ fi
 if test "$sheepdog" = "yes" ; then
   echo "CONFIG_SHEEPDOG=y" >> $config_host_mak
 fi
+if test "$pty_h" = "yes" ; then
+  echo "CONFIG_PTY=y" >> $config_host_mak
+fi
 if test "$fuzzing" = "yes" ; then
   if test "$have_fuzzer" = "yes"; then
     FUZZ_LDFLAGS=" -fsanitize=address,fuzzer"
diff --git a/util/qemu-openpty.c b/util/qemu-openpty.c
index 2e8b43bdf5..9d8ad6905e 100644
--- a/util/qemu-openpty.c
+++ b/util/qemu-openpty.c
@@ -35,7 +35,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"

-#if defined(__GLIBC__)
+#if defined CONFIG_PTY
 # include <pty.h>
 #elif defined CONFIG_BSD
 # include <termios.h>
--
2.26.0

