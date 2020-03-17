Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30F4C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19D520735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4vMcThD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19D520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGgk-00048J-VV
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUX-0005hV-Nq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUW-0000eN-Hd
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:01 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:36824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGUW-0000Xp-A8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:59:00 -0400
Received: by mail-wr1-x42d.google.com with SMTP id s5so26966433wrg.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w1gc8KtHt2EURW6KK00imtpWe3g+NUK+oh+i1JX/9Jo=;
 b=s4vMcThDB+TdFLvmymz4rpTcWeX7CjMHH3pIz+ehSPTznZxiSVY/5HEMjFCsQADu8i
 rAAOnRoVwE2LAnE+wDzw13I4FnCTZxJ0imXAtQaFZMXLd4ypiFhrp+w3oAhT3ip7TDgV
 sYV8sRWrtvUBe/iyBGXLtja6EtgAchMEJLkijBje1+Y1KxaWTXoGQnXFFDbO5NbpWPwd
 ewR8WzAO7DnXKB69qSkuIb7nCeR91eDQteZB8JAZGgmzKrlL1uDmQ6Y/bckdADRyQd1W
 Dv8h1ZMxCDomeI/26XYg3b+zxET2AQ3GaUW7bSEVyd5dKI33N4g0ksA+QB8KBQOgGoIR
 c+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w1gc8KtHt2EURW6KK00imtpWe3g+NUK+oh+i1JX/9Jo=;
 b=fJLZxD+OQK1OhKK68ulKwUVQznTv4bqiW0G/UhdAGUa6dqSJEU01KkHCAkCfu0kMk2
 E1c+24uN3MPN1Xc9FZDPJTkEe8TIuudmldch3K9gJrJZ/RQgUwhb3wmF7hciYLEQanRJ
 oqzklihYQ7WmtmdGw9ZJDLIpAOZmD+/QZdxe6BK0UzjsIhuOedk6QXLZhR9FerRLeFPV
 TvkoUEAqrApQ/U2u25mxYqzI3U5G20BuVS7FABu0yo7rW33twONnsTWGH3MRmlEk0fJ2
 8VtZkEUurrUXONlIjakl/Ud9xRbfHoFBKqTP/F6u3hx+Ix3vWMSUObUPoDZ4C/lMOD0N
 5iVA==
X-Gm-Message-State: ANhLgQ2d75cP25wDeqcqwgeGWssPbyjKg1eKUhoz9HfxmcI1qIKZiMKT
 3YjRIwI1/H9rF1wroPHo0A2SExl4IYY=
X-Google-Smtp-Source: ADFU+vshzKxK6STUXNYRSyuzPazwwV8kEtMJ3m2hR8d5RZ4kxYl4OgWXDIMRMsi460Mc5g4K6g+BxA==
X-Received: by 2002:adf:ba48:: with SMTP id t8mr158619wrg.329.1584467939173;
 Tue, 17 Mar 2020 10:58:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a1sm5683791wro.72.2020.03.17.10.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:58:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7A0C61FF7E;
 Tue, 17 Mar 2020 17:50:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 21/28] configure: allow user to specify what gdb to use
Date: Tue, 17 Mar 2020 17:50:46 +0000
Message-Id: <20200317175053.5278-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is useful, especially when testing relatively new gdbstub
features that might not be in distro packages yet.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200316172155.971-22-alex.bennee@linaro.org>

diff --git a/configure b/configure
index eb49bb6680c..057994bce69 100755
--- a/configure
+++ b/configure
@@ -303,6 +303,7 @@ libs_qga=""
 debug_info="yes"
 stack_protector=""
 use_containers="yes"
+gdb_bin=$(command -v "gdb")
 
 if test -e "$source_path/.git"
 then
@@ -1588,6 +1589,8 @@ for opt do
   ;;
   --disable-fuzzing) fuzzing=no
   ;;
+  --gdb=*) gdb_bin="$optarg"
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1773,6 +1776,7 @@ Advanced options (experts only):
   --enable-plugins
                            enable plugins via shared library loading
   --disable-containers     don't use containers for cross-building
+  --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
 
 Optional features, enabled with --enable-FEATURE and
 disabled with --disable-FEATURE, default is enabled if available:
@@ -6734,6 +6738,7 @@ echo "libudev           $libudev"
 echo "default devices   $default_devices"
 echo "plugin support    $plugins"
 echo "fuzzing support   $fuzzing"
+echo "gdb               $gdb_bin"
 
 if test "$supported_cpu" = "no"; then
     echo
@@ -7608,6 +7613,10 @@ if test "$plugins" = "yes" ; then
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


