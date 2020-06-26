Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929C7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C07207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPayi8Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C07207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joows-0004OR-KX
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1joovp-0003NQ-Vk; Fri, 26 Jun 2020 10:02:17 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:46165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1joovk-0003T9-LN; Fri, 26 Jun 2020 10:02:17 -0400
Received: by mail-ed1-x542.google.com with SMTP id dm19so769987edb.13;
 Fri, 26 Jun 2020 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Sk4jPNPZZZQEXgb8aF5QfKzPGN3qP8PnnMdQeGvFFTU=;
 b=ZPayi8MtEppC+1aB1oPYIXmeYcYcnB9oKV74CIZXTQbrq1o4eRJaRlXBwLFFCY61Jj
 +7yg557iC1xkUwubFB6ji/btXJR90c3ylSl5lisuC4AXQfBGb6edNIhJE0+k36Sto/KC
 OKKo3l2S8ZNTFDIi7j9awtAbtha3lvc9rYnD3KB1WUz5hZ1pn4pIuFiRTkxftY5vQCdd
 0Cl2KDa3JXHlxHgJeBUOgXR6+Wrojfdg+gNqgtDvnbp778liCoE3cvFw6Ustp0H6Ze3h
 yQ9Uh9OJLXWC5RGR/SUpcZeAVNBmm/w15TF72PIZ5g0ngWZMvKpu6kENYq01mmgx3eex
 iTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Sk4jPNPZZZQEXgb8aF5QfKzPGN3qP8PnnMdQeGvFFTU=;
 b=JuWt9ekPeBwPgrcVINNO7SnFRxNGLuZIH5t7F97f+4tH0eq866EMNVnkTx2MZppIrv
 JhKy7pslf5dNAiY8PfoxMMY5h297lqv6/p8WHRqBTIXpk4dGQTz5MK7mtYACtiNTbv7T
 PBisV+dkNB6rkLeFXp6z9U/5QSoFmi6zMuXr3mMXSaZ/3McYadOrSvWaDnMZyncgS4IN
 ngJAEGR0wGYJLVNKyqyOscKjNP6XiVjHKVKwC6+hXHxTu1WdNoYRRYTwG9gtFCZBZJLX
 YihLQSmswhKSMM/6u1yjgLKVHgX+9ttYdI41oMVcEf/CBB/YF80cSmq7blYRqrGfO0tL
 QHEg==
X-Gm-Message-State: AOAM533THMm0ULGCGmvXE+kMIa0fZuhoXhnDqoyllRkfntzAJtEopYtT
 kdUPyYq3EfS2uf0JjXPGViXRaANkM55zv6RDixdulsRYxPZCDg==
X-Google-Smtp-Source: ABdhPJx5FlwKxaqa0AfRsJPr1OaULD567mNbq6Pzs+KwqW7iTimIGlfy4QDOhmpdRyPA62Js4j/3UOttBgLKuMVgps0=
X-Received: by 2002:aa7:d792:: with SMTP id s18mr3580645edq.7.1593180125760;
 Fri, 26 Jun 2020 07:02:05 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 15:01:55 +0100
Message-ID: <CA+XhMqxZKmaR6hdq3B5OBq=z3ah2SGEETOZQph7OWQxHrixKKQ@mail.gmail.com>
Subject: [PATCH 1/3] : haiku check sys signal.h presence
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=devnexen@gmail.com; helo=mail-ed1-x542.google.com
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

From a4dfa918e6eea7a5ccc4375d83d1f0162e3bb122 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 13:43:59 +0000
Subject: [PATCH 1/3] check sys/signal.h presence

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure                   | 8 ++++++++
 hw/xen/xen-legacy-backend.c | 1 -
 include/qemu/osdep.h        | 2 +-
 util/oslib-posix.c          | 1 -
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index ba88fd1824..5101fd79fd 100755
--- a/configure
+++ b/configure
@@ -3181,6 +3181,11 @@ if ! check_include "ifaddrs.h" ; then
   have_ifaddrs_h=no
 fi

+have_sys_signal_h=no
+if check_include "sys/signal.h" ; then
+  have_sys_signal_h=yes
+fi
+
 ##########################################
 # VTE probe

@@ -7286,6 +7291,9 @@ fi
 if test "$have_broken_size_max" = "yes" ; then
     echo "HAVE_BROKEN_SIZE_MAX=y" >> $config_host_mak
 fi
+if test "$have_sys_signal_h" = "yes" ; then
+    echo "CONFIG_SYS_SIGNAL=y" >> $config_host_mak
+fi

 # Work around a system header bug with some kernel/XFS header
 # versions where they both try to define 'struct fsxattr':
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 2335ee2e65..92f08fca29 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -23,7 +23,6 @@
  */

 #include "qemu/osdep.h"
-#include <sys/signal.h>

 #include "hw/sysbus.h"
 #include "hw/boards.h"
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index ff7c17b857..f88fe23936 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -104,7 +104,7 @@ extern int daemon(int, int);
 #include <setjmp.h>
 #include <signal.h>

-#ifdef __OpenBSD__
+#ifdef CONFIG_SYS_SIGNAL
 #include <sys/signal.h>
 #endif

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 39ddc77c85..7ad9195c44 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -38,7 +38,6 @@
 #include "qemu/sockets.h"
 #include "qemu/thread.h"
 #include <libgen.h>
-#include <sys/signal.h>
 #include "qemu/cutils.h"

 #ifdef CONFIG_LINUX
-- 
2.26.0

