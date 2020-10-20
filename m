Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97BEC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A53C22253
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 10:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="RoLhxgc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A53C22253
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoW6-0002CR-2e
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 06:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kUoTt-00082D-He
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:03:01 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:1688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kUoTo-0007Dt-RX
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 06:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1603188176;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zf0xNBg2rvKZ1PY17/ruG8OT28rHF2w1XniqvoCnWWs=;
 b=RoLhxgc94Qn+XEDofc5zVfn1nx5eE8KZZNPcZCHOxl2q5JZe+e5BxkzP
 mt8pcPyHaPR+QtTEeq2g4T+HbLmUSyFw9DcNGs6y5KLhOH+YLv7t7Xw2Z
 WpbHWc3IzN4/n+aTiSoCx8GBczdZ/JMLpsOZVN7a72WuzWLGQlYfG2dTs s=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: 6WoSkRcgJM0A9EMx6tkY2Qb3gLwxcXjvfMn6Q7JwGLst5NK3NnHUxrDxi50oq/PQSwTUzcJb/T
 28O8LcJNWkpnh0oVqjDmMb7Q+CQqUh+Khr1dhQ2c78bPF/aJOzVafBGscXkDXycYZ4XSJzR8mU
 5nQ8g65S6PT+AhDUfYR9V8UhN39ax6ilY2pvp2+CWAPmrPmLTDlU9quWCJvq1EDNx6tKYw4dDb
 gPXw2nZC5ESqyK6U9kki7xsHqqBFPORRsJHVMstG/KAwc/7bNvr/21dBkNhsGj3fK8I7sQqrnp
 +zM=
X-SBRS: None
X-MesageID: 29425539
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,396,1596513600"; d="scan'208";a="29425539"
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev
 <mjt@tls.msk.ru>, Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 1/4] xen: xenguest is not used so is not needed
Date: Tue, 20 Oct 2020 11:02:36 +0100
Message-ID: <20201020100239.272748-2-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020100239.272748-1-anthony.perard@citrix.com>
References: <20201020100239.272748-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.155.168;
 envelope-from=anthony.perard@citrix.com; helo=esa5.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 06:02:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

From: Michael Tokarev <mjt@tls.msk.ru>

There's no references in only file which includes xenguest.h
to any xen definitions. And there's no references to -lxenguest
in qemu, either. Drop it.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20200727140048.19779-1-mjt@msgid.tls.msk.ru>
[perard: rebased]
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 configure                  | 4 ++--
 hw/i386/xen/xen_platform.c | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index a73fb8756ef1..e6754c1e872c 100755
--- a/configure
+++ b/configure
@@ -2532,7 +2532,7 @@ if test "$xen" != "disabled" ; then
     xen_ctrl_version="$(printf '%d%02d%02d' \
       $($pkg_config --modversion xencontrol | sed 's/\./ /g') )"
     xen=enabled
-    xen_pc="xencontrol xenstore xenguest xenforeignmemory xengnttab"
+    xen_pc="xencontrol xenstore xenforeignmemory xengnttab"
     xen_pc="$xen_pc xenevtchn xendevicemodel"
     if $pkg_config --exists xentoolcore; then
       xen_pc="$xen_pc xentoolcore"
@@ -2541,7 +2541,7 @@ if test "$xen" != "disabled" ; then
     xen_libs="$($pkg_config --libs $xen_pc)"
   else
 
-    xen_libs="-lxenstore -lxenctrl -lxenguest"
+    xen_libs="-lxenstore -lxenctrl"
     xen_stable_libs="-lxenforeignmemory -lxengnttab -lxenevtchn"
 
     # First we test whether Xen headers and libraries are available.
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index e9601031bfd9..7c4db35debbd 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -37,8 +37,6 @@
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-
-#include <xenguest.h>
 #include "qom/object.h"
 
 //#define DEBUG_PLATFORM
-- 
Anthony PERARD


