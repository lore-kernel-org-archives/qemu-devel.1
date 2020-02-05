Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A05C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242D521741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HIMVRjf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242D521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOIX-0007AJ-9B
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCS-0005BH-C6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCQ-0005sU-GU
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:52 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:35916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOCQ-0005oj-87
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:50 -0500
Received: by mail-wr1-x429.google.com with SMTP id z3so3697376wru.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9N/lsyAdVVEfXKAb/mTABzyFkRO0Dh8F/Et1NcKMxII=;
 b=HIMVRjf1eXV/tQla91ocyDQ0Dank1f/0MjaaGK43qWuhp2w+DR2HN3AN2G/Q0REb/I
 CG5wy7jhaEJpPyxEuglcQ/L/g1t8b7UkoNoz9QgaR/gMhlh7KjfU0uHJjfyRHrJxhOfH
 ufClc4J4ZrSwpd7/nJl6DHBGkotxazziNWLqMTeaRSL/sPS1/LPdRjHeufIiz4MPI24s
 H52N5CADb2bH7yK7djpVk4kfoN5aWW9whWHbzY2OPydWUS0XooNwjfxuDZaHHzNE+fXW
 XhTVk+yDqXtnxPpOkbO4i+9WIAcI7kaAxcUYZsRB66KUgE4Q5zSLcv/K2hntqxlgV8z5
 wKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9N/lsyAdVVEfXKAb/mTABzyFkRO0Dh8F/Et1NcKMxII=;
 b=XboP36NLj5fwjdv4br66Nxs/2skewQL996oCbwqfvNIXlx9p6qEnss9WPA83Z8dBcT
 y292M/ZaehZE+ZmzHlsCIy78e7Hp3R5xBj7O3cJ/B3mr4vqKLsPm+jNQAeQjEzT9JMNw
 /Q4TFxg2PcSRIdfiy7yVSwe0SPmcpZlgkSChTCI394dz9ytOMIbgfRPskMpbLHCDqarx
 iqU9K9cFAUHoz+L8brvN2N4HT8RVB8dJ2GMtoR5ZnbYCYhmlKv17Tye1Y10kVw7TII14
 AC8GtQYh86O4tTwOho/ylkTrv5EixyDpzq8g5iUFYrs5L2xv+eeq49Yt+UzPJFB91Crv
 +iog==
X-Gm-Message-State: APjAAAWTuA4KY3C3ExPCgyJcNUKBN00LWF1GKzUTPCHyrLBGGZxtx1wF
 1wnC3Y8frHwlG3Uy2lS0o6ZWKQ==
X-Google-Smtp-Source: APXvYqxA+oBxyid4LGMdhv5XfL+CS9USazBVlPIflVQ5gCnp8FRZKeAjv92oQ5jYL7VIJML709ksGA==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr27745298wrw.281.1580922649138; 
 Wed, 05 Feb 2020 09:10:49 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w19sm233434wmc.22.2020.02.05.09.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:10:40 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4BFEA1FFA5;
 Wed,  5 Feb 2020 17:10:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 16/22] configure: allow user to specify what gdb to use
Date: Wed,  5 Feb 2020 17:10:25 +0000
Message-Id: <20200205171031.22582-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is useful, especially when testing relatively new gdbstub
features that might not be in distro packages yet.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configure b/configure
index 115dc38085f..12a0e84578d 100755
--- a/configure
+++ b/configure
@@ -303,6 +303,7 @@ libs_qga=""
 debug_info="yes"
 stack_protector=""
 use_containers="yes"
+gdb_bin=$(command -v "gdb")
 
 if test -e "$source_path/.git"
 then
@@ -1545,6 +1546,8 @@ for opt do
   ;;
   --disable-containers) use_containers="no"
   ;;
+  --with-gdb=*) gdb_bin="$optarg"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1729,6 +1732,7 @@ Advanced options (experts only):
   --enable-plugins
                            enable plugins via shared library loading
   --disable-containers     don't use containers for cross-building
+  --with-gdb=GBB-path      gdb to use for gdbstub tests [$gdb_bin]
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -6621,6 +6625,7 @@ echo "libpmem support   $libpmem"
 echo "libudev           $libudev"
 echo "default devices   $default_devices"
 echo "plugin support    $plugins"
+echo "gdb               $gdb_bin"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7478,6 +7483,10 @@ if test "$plugins" = "yes" ; then
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


