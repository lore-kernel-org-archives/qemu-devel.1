Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE93C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6058221D81
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 11:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KMog/3jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6058221D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFyHn-0001rU-AM
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 07:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGY-00005i-QH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kFyGW-0006X6-Or
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 07:27:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id x14so2500999wrl.12
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 04:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NDKRkKEXnbkC3JfaTHJZ5ZvrkL50opHif1TLWay2Zxk=;
 b=KMog/3jEPaq58b4tiu55P1b7e0locE5mrPEGCpf0e9YQLPD644QwVlyyaDSvc0DnIp
 FfjjNL9YMJkKksD3Ltq0c5xzcx3ypndvgb17bxXtREfqWdN7DfpPKkRWj8CmJhHDn6Kr
 JX7Ig3plmxCn83iKFT3qk6sucg7FkEoPdkZWDL5R5tZSVTSFOUuQO1EaQ4t1JGvEOirC
 9sfHp6LiD5RqILG3CWyUOpWUi5vYU2dUozy+pfvGe8TQZK0yaaFMz65vi33B2NBTrpxO
 9qbefIF1AsbjHjugJVbL1CUj2cisa301ZrAxJSzoR870dh9+t3OY13/n9YceHtb7S6VR
 Pftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NDKRkKEXnbkC3JfaTHJZ5ZvrkL50opHif1TLWay2Zxk=;
 b=K0QbYmExqHRzJ1/VeLGtPqUQ1+7XsBXesCRJzMZtOxMjHm/ubU3KYmEvynnH61FmYe
 SvSjlqykEBqbXJcAmOOkEq+zMMTquLU4S7wKNfx9/f1uabnMa6tEQAza5Bw3eaGtY40P
 12P/+N0DS9BR40qzJN6z05MQdWS5nqF04TytBHwiumdBFkRvLhVnao0a31SHKOcHMSYM
 xrzSY6OayMXmLbfxFyKTcMi7yFyjdPKImqo9PaA2uwFX8AZPCeqMFFKpUAJbUYNqGs+p
 CP4BecTUBjFrIR4rDM4eF+iOOZLLL9e7QNVcgqWEPO3r2fjp1gbaKxs/w9/TLJsCrBeY
 ubOw==
X-Gm-Message-State: AOAM533P1qImZ8YC/RMB37a9/tieSySsXM2ExhDyKsY10ksAklrqoX25
 pWKNvzLeZgS+wi4nJNjhGtf0Gg==
X-Google-Smtp-Source: ABdhPJxdEw7/HcQV1quSfiCgsmksGvow/pIpirCvOFDk9lcJAn5M+ZlRFBgf1hr5Zy/uscF4Mstg9g==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr3784382wro.178.1599650871410; 
 Wed, 09 Sep 2020 04:27:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 189sm3505363wmb.3.2020.09.09.04.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 04:27:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 962F31FF92;
 Wed,  9 Sep 2020 12:27:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/10] configure: don't enable ppc64abi32-linux-user by
 default
Date: Wed,  9 Sep 2020 12:27:37 +0100
Message-Id: <20200909112742.25730-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909112742.25730-1-alex.bennee@linaro.org>
References: <20200909112742.25730-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The user can still enable this explicitly but they will get a warning
at the end of configure for their troubles. This also drops any builds
of ppc64abi32 from our CI tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/configure b/configure
index 4231d56bcc0..2b5492a0d63 100755
--- a/configure
+++ b/configure
@@ -542,6 +542,8 @@ gettext=""
 bogus_os="no"
 malloc_trim=""
 
+deprecated_features=""
+
 # parse CC options first
 for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
@@ -1720,26 +1722,25 @@ if [ "$bsd_user" = "yes" ]; then
     mak_wilds="${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
 fi
 
-if test -z "$target_list_exclude"; then
-    for config in $mak_wilds; do
-        default_target_list="${default_target_list} $(basename "$config" .mak)"
-    done
-else
-    exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
-    for config in $mak_wilds; do
-        target="$(basename "$config" .mak)"
-        exclude="no"
-        for excl in $exclude_list; do
-            if test "$excl" = "$target"; then
-                exclude="yes"
-                break;
-            fi
-        done
-        if test "$exclude" = "no"; then
-            default_target_list="${default_target_list} $target"
+if test -z "$target_list_exclude" -a -z "$target_list"; then
+    # if the user doesn't specify anything lets skip deprecating stuff
+    target_list_exclude=ppc64abi32-linux-user
+fi
+
+exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
+for config in $mak_wilds; do
+    target="$(basename "$config" .mak)"
+    exclude="no"
+    for excl in $exclude_list; do
+        if test "$excl" = "$target"; then
+            exclude="yes"
+            break;
         fi
     done
-fi
+    if test "$exclude" = "no"; then
+        default_target_list="${default_target_list} $target"
+    fi
+done
 
 # Enumerate public trace backends for --help output
 trace_backend_list=$(echo $(grep -le '^PUBLIC = True$' "$source_path"/scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
@@ -7557,7 +7558,7 @@ TARGET_SYSTBL=""
 case "$target_name" in
   i386)
     mttcg="yes"
-	gdb_xml_files="i386-32bit.xml"
+    gdb_xml_files="i386-32bit.xml"
     TARGET_SYSTBL_ABI=i386
     TARGET_SYSTBL=syscall_32.tbl
   ;;
@@ -7667,6 +7668,7 @@ case "$target_name" in
     TARGET_SYSTBL_ABI=common,nospu,32
     echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
+    deprecated_features="ppc64abi32 ${deprecated_features}"
   ;;
   riscv32)
     TARGET_BASE_ARCH=riscv
@@ -8011,6 +8013,12 @@ fi
 touch ninjatool.stamp
 fi
 
+if test -n "${deprecated_features}"; then
+    echo "Warning, deprecated features enabled."
+    echo "Please see docs/system/deprecated.rst"
+    echo "  features: ${deprecated_features}"
+fi
+
 # Save the configure command line for later reuse.
 cat <<EOD >config.status
 #!/bin/sh
-- 
2.20.1


