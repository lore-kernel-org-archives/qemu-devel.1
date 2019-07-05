Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6ABC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9CC2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0EsWzym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9CC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUL2-0005oA-Kn
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 15:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55687)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUER-0005ci-Fx
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEQ-0004E4-FH
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:36118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUEQ-0004DI-8l
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id n4so10988493wrs.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SPExf4yDsumfqyFIHIT50jMK4mdhNlTATWWdAQczcRU=;
 b=r0EsWzym8DRq+tQDvJWeK2r8kpvG/HRHDBLLDnKc1no3EyQZPMyg1dU59vzc+KmH5I
 +7SlSow5GViq9pzZiqRp9fhhpqPVQrdWJIhfnjU/OmNAWmBKs5ZF2Vxe5QUIFq3bcm6+
 Q3ZY5jDpQ0rPURMoLJDIC+ZQV27jQwuhP3/3I4Nd+vraClbaBfMALTucdPFWDeBAzDw6
 YEsJZ0BBz0Y7QGC2rnbfNaFTazvYMyfPTSRqgpJ/24Pbty6PvrPJytfb6o6qSs+0rVOs
 5lEhWmMHX1jTpG71tupu5eMlynEcl2tIGJ+Ugu73RJawqitm5rUOQRq2cW8KWw1ohAzP
 k1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=SPExf4yDsumfqyFIHIT50jMK4mdhNlTATWWdAQczcRU=;
 b=UNxQSKtCLlBqzSvMXi2hZS9PRZn4S+xTJQVnh9litcCyFT1J6KRMVlkVlkRe/zH/7J
 t7CgYXUv5KrclPLYXFRez1Z7DNAPtes2xGG6c7pUvuJ2OaH2YahBPsZqmpYR3F0XQwy0
 KSMonMexz8JjiTq2IlP+mCdf2ok17alCFIwgtZG2bSRxtfx2+zUGt9QsG02ZMON+gXRo
 As8QP8AT/07YVzTCXNyTBa7vhHWTbZMQRWPkiKqwxfG2GQG8WOJHrif4WrmemJEeDFGG
 3QQUK1pfk/cpH03Q+kBAvJ0MapOPBwypQGBqONbWy8wTCT51+iGN11jggRjOccdp7DGd
 WDDw==
X-Gm-Message-State: APjAAAWu1vgaaNvu7SPE1KI1gUUYnBMI66HeDnf96L+o+SMxwQUf9Eli
 vvgH1/3fLDsRzRqv/Nav5OStKMqDn/s=
X-Google-Smtp-Source: APXvYqxWhQd3ByMpzrY+K5JmWRAaPZr86sPYmCKIxQbsLqu4pdxSHObrDkujHECafv7LkYZr22QO8g==
X-Received: by 2002:adf:fb8d:: with SMTP id a13mr5226223wrr.273.1562356252789; 
 Fri, 05 Jul 2019 12:50:52 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d10sm11478625wro.18.2019.07.05.12.50.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 12:50:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 21:50:37 +0200
Message-Id: <1562356239-19391-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 10/12] Makefile: generate header file with the
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
Cc: Julio Montes <julio.montes@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julio Montes <julio.montes@intel.com>

v2: generate config-devices.h which contains the list of devices enabled

Message-Id: <20190705143554.10295-1-julio.montes@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target        | 5 +++++
 scripts/clean-includes | 2 +-
 scripts/create_config  | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile.target b/Makefile.target
index 72c267f..25383f5 100644
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
 
@@ -171,6 +174,8 @@ generated-files-y += hmp-commands.h hmp-commands-info.h
 
 endif # CONFIG_SOFTMMU
 
+generated-files-y += config-devices.h
+
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
diff --git a/scripts/clean-includes b/scripts/clean-includes
index dd938da..fb05a63 100755
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
index d727e5e..00e86c8 100755
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
1.8.3.1



