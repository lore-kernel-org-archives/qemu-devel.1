Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8864EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D16D2073E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D16D2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03kX-0006Dr-D4
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1k03gh-0004Uy-J6
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:01:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:58297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1k03ge-0004tg-Is
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:01:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 51E9240002;
 Mon, 27 Jul 2020 17:00:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with SMTP id 4F7CEE8;
 Mon, 27 Jul 2020 17:00:54 +0300 (MSK)
Received: (nullmailer pid 19826 invoked by uid 1000);
 Mon, 27 Jul 2020 14:00:53 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>
Subject: [PATCH] xen: xenguest is not used so is not needed
Date: Mon, 27 Jul 2020 17:00:48 +0300
Message-Id: <20200727140048.19779-1-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 10:00:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Tokarev <mjt@tls.msk.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's no references in only file which includes xenguest.h
to any xen definitions. And there's no references to -lxenguest
in qemu, either. Drop it.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 configure                  | 4 ++--
 hw/i386/xen/xen_platform.c | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index 2acc4d1465..09da2637a4 100755
--- a/configure
+++ b/configure
@@ -2646,7 +2646,7 @@ if test "$xen" != "no" ; then
     xen_ctrl_version="$(printf '%d%02d%02d' \
       $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
     xen=yes
-    xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
+    xen_pc="xencontrol xenstore xenforeignmemory xengnttab"
     xen_pc="$xen_pc xenevtchn xendevicemodel"
     if $pkg_config --exists xentoolcore; then
       xen_pc="$xen_pc xentoolcore"
@@ -2655,7 +2655,7 @@ if test "$xen" != "no" ; then
     libs_softmmu="$($pkg_config --libs $xen_pc) $libs_softmmu"
   else
 
-    xen_libs="-lxenstore -lxenctrl -lxenguest"
+    xen_libs="-lxenstore -lxenctrl"
     xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
 
     # First we test whether Xen headers and libraries are available.
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index a1492fdecd..6e10451178 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -38,8 +38,6 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 
-#include <xenguest.h>
-
 //#define DEBUG_PLATFORM
 
 #ifdef DEBUG_PLATFORM
-- 
2.20.1


