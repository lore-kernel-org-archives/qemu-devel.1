Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18739C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48162072B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Otgo+bZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48162072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irO35-0006A8-H2
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNxy-0008Qa-8R
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNxx-00086M-1K
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:18:50 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNxw-00084N-QB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:18:48 -0500
Received: by mail-wr1-x433.google.com with SMTP id g17so12549637wro.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NwJkJGKdheizEM/DhEJNn7UgplpcwW/3CxupFcFkyrM=;
 b=Otgo+bZSIwT/Co4+uODiZE9Q1nhvPmL6COUYRtPHYY6sEX2Vc8gfC/4jEr37DPKQyd
 t4xhM5m/QgEfaqT0YRxreIGbqw3G2yyDMUtpARzMxpE3pKQpk/swJkiYR4swLqzrkoYb
 cCjSQbn0JQbucP2CVcgJGAlXPeRzlx8E7zQ2C+a6HnalurCe1OoewYb++8Oj1JO8Htj7
 VXusZr7gGdOWrefaS+eOaoujupci8fHu4hYSK5EbUuRWbqZAH0npSrObUKmGCsAKo1Wa
 EkVc0AxcMNLlfxoPFPEPlPdg6kPw1yvo+v/UxH8W7wvKaz1yTKx/YQB98fpfX4EabEw+
 7hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NwJkJGKdheizEM/DhEJNn7UgplpcwW/3CxupFcFkyrM=;
 b=Om0pqYEgcectmcYMNPrWwH3usdDQE/vv9pkjUXgFah442eLcGKoqgaDIlXst4YCtWk
 Ko83d/79d4+f8NyO0vCUhPfuHslUT3/hwWwQJUmp/lz3jZR4OGHgQ0zlacfHcIHEiAec
 Jj94JWJvPHDIEH8Egv90N6X8/tPd5NXzIXFPR6cqYeZ4czdXg/PC9+pvUo5EpTL6wd/4
 PYJPgfOZvRe1wsyZo7yLkeXpV1R6Wa8ID3AKdR333IFSnelISJv5SNhtg4/X4idp5r5i
 R02FCHenjZ/m5O2lmPduwFsRDqruzvghSTYOdNermT5q2otB4Dqoh9ebH0kW2rHilK3/
 sG4g==
X-Gm-Message-State: APjAAAUtI9j48DRsB7NOVg6kVUO3RY9CLK4XBmI+1JkzUUv2v1P3zTP0
 kFHpqimstAkit7oLt5DIXvjZjQ==
X-Google-Smtp-Source: APXvYqyM84CN48MqIEhNJOgzV/0t52+FuI1hb4v/ucQFRXde61cl8h1MC4Kce1rlEteL3+jhLv7qlA==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr24883862wrs.376.1579015127408; 
 Tue, 14 Jan 2020 07:18:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b137sm20168534wme.26.2020.01.14.07.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:18:46 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CF17D1FF9F;
 Tue, 14 Jan 2020 15:09:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 16/22] configure: allow user to specify what gdb to use
Date: Tue, 14 Jan 2020 15:09:47 +0000
Message-Id: <20200114150953.27659-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114150953.27659-1-alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is useful, especially when testing relatively new gdbstub
features that might not be in distro packages yet.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configure b/configure
index 08c3a1c1f0..df702a708f 100755
--- a/configure
+++ b/configure
@@ -303,6 +303,7 @@ libs_qga=""
 debug_info="yes"
 stack_protector=""
 use_containers="yes"
+gdb_bin=$(command -v "gdb")
 
 if test -e "$source_path/.git"
 then
@@ -1540,6 +1541,8 @@ for opt do
   ;;
   --disable-containers) use_containers="no"
   ;;
+  --with-gdb=*) gdb_bin="$optarg"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1724,6 +1727,7 @@ Advanced options (experts only):
   --enable-plugins
                            enable plugins via shared library loading
   --disable-containers     don't use containers for cross-building
+  --with-gdb=GBB-path      gdb to use for gdbstub tests [$gdb_bin]
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -6576,6 +6580,7 @@ echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
 echo "plugin support    $plugins"
+echo "gdb               $gdb_bin"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7422,6 +7427,10 @@ if test "$plugins" = "yes" ; then
     fi
 fi
 
+if test -n "$gdb_bin" ; then
+    echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
+fi
+
 if test "$tcg_interpreter" = "yes"; then
   QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
 elif test "$ARCH" = "sparc64" ; then
-- 
2.20.1


