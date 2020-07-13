Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5546CC433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220942072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2qq2K4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220942072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzHa-0000CR-Bo
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAx-0005LI-Tf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAv-0006dY-1B
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so13445358wme.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=e5ekV9cWmtxxKazK6zrxMH+2NJII48iBTB73eXHStJw=;
 b=A2qq2K4ilM10laE4/iIpInXguf23DGSPLEhiNTlhjbS8aUQUo1/BJ5GLNCVEHTi0yW
 eV06/XLoTxnr6AaldvbBfXw+MXm6rS0ApXsOCv4U7XG+yp1ANcvVW73xWurz5K7B7bag
 P8n582H4DwN1Gt3MSSuETr0ytY/t1pCsjQV96ibHbXHMdvl+rRpc5mLURyHOeEv9ZwdC
 zrPWPt/nzxnwCqXYSwbhGbOyrRp5Rg013QfMdjihAkgTcUfk/hcvMYduLhYQy7dPCJdF
 cz+HZMFdK/4cZywlT91aeSN5rA0s2ZdrykbNLMvyJbSf6FwRINAmgZ/K8rLcJMtGCcyk
 L0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e5ekV9cWmtxxKazK6zrxMH+2NJII48iBTB73eXHStJw=;
 b=sC2Y64fuTMFwlKyhK0DfoccYK9PSqt3vTgRGS1+fSeHB4odzn9UAjx+YBV1KNO6Ww1
 bfQdG17hrR0l4vIpe3xHiwlq78/iKICrPH6xli8LTfUMaNCIZkgFPaeFEBLg8X3JAOvA
 XIfUBmZQHTP/T6sCVuWEokzoLilx2XSmPLQ5JEf9u0srLyIOjqOiFcPZk0Od8L0KZW2U
 c6S/4mwVVuXkeFLMjZgs6FZPK3IWt6gr29T6fgq9v12uj8jUSHkZlmJ5vrD5iBiFMVOG
 lRV+v9JfK+PQXeOA1KPrjazmVfNcVhY4vksh6jhTffV9ODR7xMNRbzS/A7KwuXQBrry2
 0KTw==
X-Gm-Message-State: AOAM532stZT6T8svGydHaQDzHz1ym1qhUV/vJeDJf30gq7qnBKF70LyJ
 uE7A4AsXFa+r1rLFsLat68tWunIAjUOmpg==
X-Google-Smtp-Source: ABdhPJzdNwRG9zAwx38f8DV0FACF8Ddl/bbZga/0j1wlRYSbAaY26yYJ4JHap2mEvoVIkl6q+uV5sg==
X-Received: by 2002:a05:600c:2253:: with SMTP id
 a19mr158591wmm.136.1594649479182; 
 Mon, 13 Jul 2020 07:11:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/25] osdep.h: Always include <sys/signal.h> if it exists
Date: Mon, 13 Jul 2020 15:10:50 +0100
Message-Id: <20200713141104.5139-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David CARLIER <devnexen@gmail.com>

Regularize our handling of <sys/signal.h>: currently we include it in
osdep.h, but only for OpenBSD, and we include it without an ifdef
guard in a couple of C files.  This causes problems for Haiku, which
doesn't have that header.

Instead, check in configure whether sys/signal.h exists, and if it
does then always include it from osdep.h.

Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200703145614.16684-5-peter.maydell@linaro.org
[PMM: Expanded commit message; rename to HAVE_SYS_SIGNAL_H]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure                   | 10 ++++++++++
 include/qemu/osdep.h        |  2 +-
 hw/xen/xen-legacy-backend.c |  1 -
 util/oslib-posix.c          |  1 -
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 429c938708e..bc3b9ad9317 100755
--- a/configure
+++ b/configure
@@ -3244,6 +3244,13 @@ if check_include "libdrm/drm.h" ; then
     have_drm_h=yes
 fi
 
+#########################################
+# sys/signal.h check
+have_sys_signal_h=no
+if check_include "sys/signal.h" ; then
+  have_sys_signal_h=yes
+fi
+
 ##########################################
 # VTE probe
 
@@ -7433,6 +7440,9 @@ fi
 if test "$have_openpty" = "yes" ; then
     echo "HAVE_OPENPTY=y" >> $config_host_mak
 fi
+if test "$have_sys_signal_h" = "yes" ; then
+    echo "HAVE_SYS_SIGNAL_H=y" >> $config_host_mak
+fi
 
 # Work around a system header bug with some kernel/XFS header
 # versions where they both try to define 'struct fsxattr':
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0fc206ae615..14059bce5a7 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -104,7 +104,7 @@ extern int daemon(int, int);
 #include <setjmp.h>
 #include <signal.h>
 
-#ifdef __OpenBSD__
+#ifdef HAVE_SYS_SIGNAL_H
 #include <sys/signal.h>
 #endif
 
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 083d8dc1b28..b61a4855b7b 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include <sys/signal.h>
 
 #include "hw/sysbus.h"
 #include "hw/boards.h"
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 39ddc77c85b..7ad9195c445 100644
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
2.20.1


