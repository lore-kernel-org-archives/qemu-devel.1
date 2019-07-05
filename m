Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80804C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B23220989
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B23220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjPLV-0002P1-F1
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51446)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <julio.montes@intel.com>) id 1hjPK6-0001MQ-Ub
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1hjPK2-0000Qf-Vg
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:36:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:33639)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1hjPK2-0008Cw-NQ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:36:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jul 2019 07:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; d="scan'208";a="164878137"
Received: from unknown (HELO fedora.zpn.intel.com.) ([10.219.4.39])
 by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2019 07:36:13 -0700
From: Julio Montes <julio.montes@intel.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 14:35:53 +0000
Message-Id: <20190705143554.10295-1-julio.montes@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190703154958.29004-1-julio.montes@intel.com>
References: <20190703154958.29004-1-julio.montes@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
Subject: [Qemu-devel] [PATCH v2 1/2] Makefile: generate header file with the
 list of devices enabled
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
Cc: Julio Montes <julio.montes@intel.com>, pbonzini@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2: generate config-devices.h which contains the list of devices enabled

---
config-devices.h is an auto-generated header file that will use
config-devices.mak to define the list of devices enabled.
Configs that are set to 'n' are ignored.

Signed-off-by: Julio Montes <julio.montes@intel.com>
---
 Makefile.target        | 5 +++++
 scripts/clean-includes | 2 +-
 scripts/create_config  | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile.target b/Makefile.target
index a6919e0caf..65eda0994d 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -45,6 +45,9 @@ include $(SRC_PATH)/tests/tcg/Makefile.include
 config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak

+config-devices.h: config-devices.h-timestamp
+config-devices.h-timestamp: config-devices.mak
+
 ifdef CONFIG_TRACE_SYSTEMTAP
 stap: $(QEMU_PROG).stp-installed $(QEMU_PROG).stp $(QEMU_PROG)-simpletrace.stp $(QEMU_PROG)-log.stp

@@ -170,6 +173,8 @@ generated-files-y += hmp-commands.h hmp-commands-info.h

 endif # CONFIG_SOFTMMU

+generated-files-y += config-devices.h
+
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)

diff --git a/scripts/clean-includes b/scripts/clean-includes
index dd938daa3e..fb05a639d5 100755
--- a/scripts/clean-includes
+++ b/scripts/clean-includes
@@ -161,7 +161,7 @@ for f in "$@"; do
   # Remove includes that osdep.h already provides
   perl -n -i -e 'print if !/\s*#\s*include\s*(["<][^>"]*[">])/ ||
                           ! (grep { $_ eq $1 } qw (
-           "config-host.h" "config-target.h" "qemu/compiler.h"
+           "config-host.h" "config-target.h" "config-devices.h" "qemu/compiler.h"
            <setjmp.h> <stdarg.h> <stddef.h> <stdbool.h> <stdint.h> <sys/types.h>
            <stdlib.h> <stdio.h> <string.h> <strings.h> <inttypes.h>
            <limits.h> <unistd.h> <time.h> <ctype.h> <errno.h> <fcntl.h>
diff --git a/scripts/create_config b/scripts/create_config
index d727e5e36e..00e86c82b0 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -58,6 +58,8 @@ case $line in
     name=${line%=*}
     echo "#define $name 1"
     ;;
+ CONFIG_*=n) # configuration
+    ;;
  CONFIG_*=*) # configuration
     name=${line%=*}
     value=${line#*=}
--
2.17.2

