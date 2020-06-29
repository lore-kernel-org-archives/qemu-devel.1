Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AF1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5E9206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 00:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8/tBNYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5E9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4Ou-0003Si-Ox
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 20:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1di-0007Q3-RE; Mon, 29 Jun 2020 17:48:34 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:34884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jq1df-00085m-Lr; Mon, 29 Jun 2020 17:48:34 -0400
Received: by mail-ej1-x62d.google.com with SMTP id rk21so18386792ejb.2;
 Mon, 29 Jun 2020 14:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=35g12xHVXZcCNi5/Umeoe37I7tRdY6+Vc3QDHRqhA8E=;
 b=U8/tBNYhtsR7LSLM7aiGIqUWst4OpNiXoqtJvctrCHK0taetvksJqhY/S0mnyu1Oh0
 N/kub4fh5Mf1ML3k+g0+c2gqFa2Fi3d0L4DqJGHGZM8knskxK+5ugCtcCWr+/WuFLB0H
 9ah7s9dKsRponeucBah6kzonb8S0PyVdLHoFI3C9u8N4+TWL/uGDWPKE1EnNbtm2mfSB
 ooGdYdidiX8RScVFriv3mNWrSYzy2BQeL9mRPjy9tud2n0UTpCBaJc29IelODXcP7c5d
 RQdXMHn/BfH3ayaRa+pp8wMkfpA4xXuSBeFeg41bJJ/0Z4HEa6viMase0gHPk3SOMrYi
 y9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=35g12xHVXZcCNi5/Umeoe37I7tRdY6+Vc3QDHRqhA8E=;
 b=c+sbnRn4zN0GhSgiETQkVLGpVUwT+X774K4O9AuiBV+D44iFTCo/sKqP9nUT+cYxRu
 9ioVdaadgIrNDvgsx8S+MdjuGXLdbNbbC2DXFAS7uxhPRBPn6xRHPJyGuJ8MEMbTToEc
 3gzm5QVsN1KT2pOTh9DZJ4OdvQMGLQu28v+q/pA8+TURYzGa5gwVrv5AtijcALoVkgqu
 U0LcOic/SknrpfVIKKziNemGD3dCrJaFcZXGZDHbigkF7/UJRzvNMvuDY0p6YDhQB1g3
 +LeoVaQ88cDJjiAWLjfB4WwjBX9dDMWS7iNx7hJAzEW1Qw/WrTA6bj9majg0SgjejR6j
 ftXA==
X-Gm-Message-State: AOAM533dY5aZ6qquwTi4mVVPQu8xrVFAgph9o1x38wymGV0zbB/3Hgav
 8ylndmT2WEn9ureB292bOHFmR/I9i6t5BuxUJuJC9s59+zQ=
X-Google-Smtp-Source: ABdhPJxUTvPEPQUK1D+dNnmh+zD8dLsMfwgdfuaVRNGAjqNzwsvP5Ak37eUSkjEJHfXuFWgOYWFsD554jZT6TAhyBS8=
X-Received: by 2002:a17:906:9244:: with SMTP id
 c4mr15456316ejx.60.1593467309788; 
 Mon, 29 Jun 2020 14:48:29 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:48:19 +0100
Message-ID: <CA+XhMqztrEOU5KQQ91qkNMrXZOxfnKQDFhC_UiJP8MkoyVoquw@mail.gmail.com>
Subject: [PATCH 4/9] Checking sys/signal.h presence.
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x62d.google.com
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
X-Mailman-Approved-At: Mon, 29 Jun 2020 20:42:18 -0400
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

From 9d43c8cd1611d0347db9066b1df1dc34431b2028 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Mon, 29 Jun 2020 22:17:53 +0000
Subject: [PATCH 4/9] Checking sys/signal.h presence.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure                   | 8 ++++++++
 hw/xen/xen-legacy-backend.c | 1 -
 include/qemu/osdep.h        | 2 +-
 util/oslib-posix.c          | 1 -
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 0b278f1646..83d8365d23 100755
--- a/configure
+++ b/configure
@@ -3212,6 +3212,11 @@ if ! check_include "ifaddrs.h" ; then
   have_ifaddrs_h=no
 fi

+have_sys_signal_h=no
+if check_include "sys/signal.h" ; then
+  have_sys_signal_h=yes
+fi
+
 ##########################################
 # VTE probe

@@ -7398,6 +7403,9 @@ fi
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
index 0d26a1b9bd..6e0cf9132d 100644
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

