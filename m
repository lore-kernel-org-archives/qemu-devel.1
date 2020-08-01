Return-Path: <SRS0=xT3E=BL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A756C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 22:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8E220738
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 22:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob04Td5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8E220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k20FE-00051l-FD
	for qemu-devel@archiver.kernel.org; Sat, 01 Aug 2020 18:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkitover@gmail.com>)
 id 1k20Eh-0004co-Ee
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 18:44:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkitover@gmail.com>)
 id 1k20Ef-0003Wn-PB
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 18:44:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id j19so17881600pgm.11
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2020 15:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Og3/zHh0UM89uAeNOcj10IiFsMigQDC9DurLdzeP7BM=;
 b=Ob04Td5xQid4Ytlgy20+PUcGo+lCanEf4sGqglPKl9u5abL8ZS/plYctWpKxAAxZHO
 EmE+TLHVqE3uO5kX+USw1+szDFeJFe9zbdOJuHKBBkQzXjPbw4VX65Em7r74R8tAuVBN
 6u/tDs74MgGa9wYc1Ir9I+TDSbnKvGRbPfuzBByyq2eYnm8zICvTL18FQcOFNz2BZtpy
 LUi/bPInpiANyqnJpJhE3RG7kAvuo4OOMCBqeHOpojcXbvxKCblFQzGIEygR3flYx/Yz
 MlwdVDPwonT9H+SCUHKDKTnLIswALKbot75/n+HIFp4YlUaFVITcYzfxeWyhii7uHb+p
 rB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Og3/zHh0UM89uAeNOcj10IiFsMigQDC9DurLdzeP7BM=;
 b=fdbM4D0fs6NXHL2QptvIY9rjLR1DFFiqNjkkUOh55k9VgpBhe7iZe/Ay+VPdFujucb
 9hz96VSLGl+kwgN6QuMdLc0BAQ3MnkmyyIjzVMNSm8ZHMB1b5UTHnQWqaajmca2sK4Kr
 uadUK+u+zKNjgW8ZK+BAxE3X8l3pE8TybmbZFeqLFTd63qiqz5AuO7KOxPY8cGbyTz+t
 CtIQqawfI6BUOuFlgK03pOYLXqFvI2W48CCzsxhwFJZji0GTEy4N5QXb8fH6mx087oq9
 gkM/p6M7NshiNL2mByvXE2Sdl/n2B+XcduR2p1EJ2OnucyoxTUUXmn3UdiEtHrWIZ4Z2
 DZsQ==
X-Gm-Message-State: AOAM530BjSvL+xp8HUrluNI59nn9ZeynfwaWtm1o1hlUyFy62FPWkCDs
 c3sLQvPXX5DFLYFzCI6GK+E=
X-Google-Smtp-Source: ABdhPJxBNayg9l9ntXIBxJ1BY3tj/aEBgBSRTFTLXtygrWfG+KfsBb3RKVXBBdw3eqHpaq7R8wEnWQ==
X-Received: by 2002:a63:7357:: with SMTP id d23mr9319617pgn.393.1596321851501; 
 Sat, 01 Aug 2020 15:44:11 -0700 (PDT)
Received: from epyc.localdomain (c-24-6-9-54.hsd1.ca.comcast.net. [24.6.9.54])
 by smtp.gmail.com with ESMTPSA id
 q24sm14851655pgg.3.2020.08.01.15.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2020 15:44:10 -0700 (PDT)
Received: by epyc.localdomain (Postfix, from userid 1000)
 id 1B84912395; Sat,  1 Aug 2020 22:44:10 +0000 (UTC)
From: Rafael Kitover <rkitover@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Require pixman for vhost-user-gpu.
Date: Sat,  1 Aug 2020 22:44:06 +0000
Message-Id: <20200801224406.315875-1-rkitover@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=rkitover@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Rafael Kitover <rkitover@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the test from Makefile to check if vhost-user-gpu is being built,
and if so require pixman.

Signed-off-by: Rafael Kitover <rkitover@gmail.com>
---
 configure | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/configure b/configure
index 2acc4d1465..181b465861 100755
--- a/configure
+++ b/configure
@@ -4062,20 +4062,6 @@ if test "$modules" = yes; then
     fi
 fi
 
-##########################################
-# pixman support probe
-
-if test "$softmmu" = "no"; then
-  pixman_cflags=
-  pixman_libs=
-elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
-  pixman_cflags=$($pkg_config --cflags pixman-1)
-  pixman_libs=$($pkg_config --libs pixman-1)
-else
-  error_exit "pixman >= 0.21.8 not present." \
-      "Please install the pixman devel package."
-fi
-
 ##########################################
 # libmpathpersist probe
 
@@ -4491,6 +4477,20 @@ if test "$opengl" = "yes" && test "$have_x11" = "yes"; then
   done
 fi
 
+##########################################
+# pixman support probe
+
+if test "$softmmu" = "no" && ! ( test "${linux} ${virglrenderer} ${gbm} ${want_tools}" = "yes yes yes yes" );  then
+  pixman_cflags=
+  pixman_libs=
+elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
+  pixman_cflags=$($pkg_config --cflags pixman-1)
+  pixman_libs=$($pkg_config --libs pixman-1)
+else
+  error_exit "pixman >= 0.21.8 not present." \
+      "Please install the pixman devel package."
+fi
+
 ##########################################
 # libxml2 probe
 if test "$libxml2" != "no" ; then
-- 
2.28.0


