Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C613FC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163E922454
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163E922454
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXbsf-0000QL-2S
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbnp-0003dP-0A
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:07:09 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbnn-0006fS-Ei
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:07:08 -0400
Received: by mail-pj1-f65.google.com with SMTP id i3so781422pju.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4Nf/hbrNIff9lkr/M925FsdkkURqsu/knS31MCwkOSQ=;
 b=NrUXIasQlbFFRWZgzDcx2OyRYDmlp32jcaTHpNkHdMgyfnxN2jjj8WzVNbacopaVKc
 7hPeqlOrFjfo1HUEcsELpbMXd2//s593bnUsPHkGa36Nf74O2nlcEfV1FMMgyqFwTkz7
 DtdxhokSrhgF3LDkN4S+QIXmbl2+kFVwxXNBdkrWm516cKTcbytuUbpvjwGyYH6I5ZZP
 3w3L2Zv9bVYuzY+DwIN/HAsx1O1NBykLemeD4y7/VZDdoxHS5oZZXn84+CrBnNKz0hQG
 vnwZBFIssbczW3j4e9EQwj0tdOFH8jNM88xPCh7NB3CXtE5Kr1Qh8wPLKIg14EMwytnm
 kMPA==
X-Gm-Message-State: AOAM533KjrbdGMY85zC3Z5502TA3QeCO2CJVZC3AAVX4KoEhb3vCD+6v
 4CEkwhY5LGLm6v4RnxPIDMs53ZaUtTs=
X-Google-Smtp-Source: ABdhPJxOJllCEmdD+Allwms+/2XriLb/2QxdQbJ2kYY6m3hRPxszt+tyYiqLXsU3QyuyzqXFqlpjUw==
X-Received: by 2002:a17:90a:c907:: with SMTP id
 v7mr2108949pjt.214.1603854425832; 
 Tue, 27 Oct 2020 20:07:05 -0700 (PDT)
Received: from localhost.localdomain ([73.93.155.93])
 by smtp.gmail.com with ESMTPSA id n6sm3407219pjj.34.2020.10.27.20.07.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 20:07:05 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/7] configure: cross-compiling with empty cross_prefix
Date: Tue, 27 Oct 2020 20:06:56 -0700
Message-Id: <20201028030701.14086-3-j@getutm.app>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028030701.14086-1-j@getutm.app>
References: <20201028030701.14086-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.65; envelope-from=osy86github@gmail.com;
 helo=mail-pj1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 23:07:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Joelle van Dyne <j@getutm.app>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The iOS toolchain does not use the host prefix naming convention. So we need
to enable cross-compile options while allowing the PREFIX to be blank.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 configure | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 4e68a5fefe..e211d11971 100755
--- a/configure
+++ b/configure
@@ -234,6 +234,7 @@ cpu=""
 iasl="iasl"
 interp_prefix="/usr/gnemul/qemu-%M"
 static="no"
+cross_compile="no"
 cross_prefix=""
 audio_drv_list=""
 block_drv_rw_whitelist=""
@@ -458,6 +459,7 @@ for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
   case "$opt" in
   --cross-prefix=*) cross_prefix="$optarg"
+                    cross_compile="yes"
   ;;
   --cc=*) CC="$optarg"
   ;;
@@ -1652,7 +1654,7 @@ $(echo Available targets: $default_target_list | \
   --target-list-exclude=LIST exclude a set of targets from the default target-list
 
 Advanced options (experts only):
-  --cross-prefix=PREFIX    use PREFIX for compile tools [$cross_prefix]
+  --cross-prefix=PREFIX    use PREFIX for compile tools, PREFIX can be blank [$cross_prefix]
   --cc=CC                  use C compiler CC [$cc]
   --iasl=IASL              use ACPI compiler IASL [$iasl]
   --host-cc=CC             use C compiler CC [$host_cc] for code run at
@@ -6931,7 +6933,7 @@ if has $sdl2_config; then
 fi
 echo "strip = [$(meson_quote $strip)]" >> $cross
 echo "windres = [$(meson_quote $windres)]" >> $cross
-if test -n "$cross_prefix"; then
+if test "$cross_compile" = "yes"; then
     cross_arg="--cross-file config-meson.cross"
     echo "[host_machine]" >> $cross
     if test "$mingw32" = "yes" ; then
-- 
2.28.0


