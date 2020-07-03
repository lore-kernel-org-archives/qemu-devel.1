Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D318C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5750D2088E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tabBWabv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5750D2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrN9y-0007lt-IT
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 10:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN72-0003lJ-MU
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrN70-0006ju-ST
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:56:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id a6so22515539wmm.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=srUPSKtqaAn1mMUbd1++IlCCTBASkwRrKLk2aoUltZI=;
 b=tabBWabvR9rAPGPW+8opjMD8UrSGSzpi+Icu6HW7o6a3r822/UF7H1LuCGGfIp7AD3
 1YVwcIamsQUtEjTGlvD6S5kf2XQxBK35wYprcmT+AgmkTKNhE25VojZKRpXEQsMRHDeg
 3dnJUvp2VVYsM/Lw14za3qgxaRy/9vCTwHsFqbAT3wLYKeV84PBfeRSf4cKhd/NxoYNa
 1FIkGMRTLu38dm2r4IpM9X8PyVrIB+JTEIem4w9pn9RLrS72uautys1xpnseVk5pz7eu
 5oqbb+BPkqBDbmf/dtm6yV4JAYZ2bDAWUPhCFu8IO4JPYLSP0F0t79t/4OxeWTDKyOOF
 F6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=srUPSKtqaAn1mMUbd1++IlCCTBASkwRrKLk2aoUltZI=;
 b=hSBeCx78AWBsqONVtqrL3msc77G+D/nV1nTvzz3BOHXARaC9G8mXC7Hp7aps+R7U+n
 kizk8R9AU+dke5FBXRYyW99O3QLCsfzW49upErgF1p8fjsShYOJA4Xqhr66HXx8r+7/B
 J4vuKqgrWAs9fOTYgoM8XKbcHe6DjPQyB6rosbIgoTtqWDXgTHbdzKlK2hjXPW482fPA
 39wctAWQn5Bk7g9RffyViIniN3O9Mllne/UkihWpIb69BuXylKi9IGmgpyd9kY4kwnT3
 F0ELNcvlD6+yBL91zVA7MvL8nCHVmr6YO5jRH2hdUpi7TF+NlF3LUHXUngpU04JlBR4m
 SLUw==
X-Gm-Message-State: AOAM532358tm61SRGs4Qv0Sl9iwIl4WWKsOTuFODQ4rjWqupTHVq2J6U
 1RFwfyxG3Y3ROwNER1vG2ITOmy9CINR/Gg==
X-Google-Smtp-Source: ABdhPJwGNwumLD3T1Qz741QSvoO4gMrZzOj/5VqiGPnwTYrShI/KeIjbAiHMN4onzicsx2+PpM/Eng==
X-Received: by 2002:a1c:4846:: with SMTP id v67mr39261676wma.175.1593788181311; 
 Fri, 03 Jul 2020 07:56:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s10sm14078347wme.31.2020.07.03.07.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 07:56:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/9] osdep.h: Always include <sys/signal.h> if it exists
Date: Fri,  3 Jul 2020 15:56:09 +0100
Message-Id: <20200703145614.16684-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703145614.16684-1-peter.maydell@linaro.org>
References: <20200703145614.16684-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: David Carlier <devnexen@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
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
[PMM: Expanded commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure                   | 8 ++++++++
 include/qemu/osdep.h        | 2 +-
 hw/xen/xen-legacy-backend.c | 1 -
 util/oslib-posix.c          | 1 -
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index ddc53d873ef..d131f760d8f 100755
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
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0d26a1b9bd0..6e0cf9132d9 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -104,7 +104,7 @@ extern int daemon(int, int);
 #include <setjmp.h>
 #include <signal.h>
 
-#ifdef __OpenBSD__
+#ifdef CONFIG_SYS_SIGNAL
 #include <sys/signal.h>
 #endif
 
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 7d4b13351e0..965abe3ad34 100644
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


