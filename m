Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A3C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD84A22248
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQYl/9GY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD84A22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWkv-0005AR-TG
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWX-0002LI-I9
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:26:57 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:41867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIWWV-00059M-Q1
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:26:57 -0400
Received: by mail-wr1-x42a.google.com with SMTP id w5so6697267wrp.8
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5iSSa42PazJoHEVNt7cs++ElcTxDkn7cDPvhYrmokYY=;
 b=rQYl/9GYYL2ulWNVIu+uhGHV3K1FZcHQJNKjpbsPQIhMybPfKJL1SCxSLKk7PBbQ/b
 jy/gkobYyHoc29dRW5qwVJ4cOeMDFZefeSKLN8hqUoMxbQHggcHwHnwP+3uHi9VyCxaY
 UlklLaUmIf+3WFUo1Fy8dAF2ZKf+greyrakBcxW7Ufz9GO8+eU8lz9+h9Zs7aIOHaaX5
 o+1BSLTZoMciHZo9TRg56lmvYhIUn9n0cpMcqM7Guk1EwsQKb6WchkszHtPXn9/DzujX
 YGxWR4uN65Ze1P9AVQneMfsJ8mlBIKWZwjoCW9JIVvFHNR1BSxgfmWH8teIHWaGJoxKt
 am/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5iSSa42PazJoHEVNt7cs++ElcTxDkn7cDPvhYrmokYY=;
 b=X9cMD5+IWI24WNJ+jAGAtx8cD7wscBq2y1TBZ6SI7q5kStzMxjXACqyzcV0bfa8mnC
 Wlz/J+xtNDDikyPsJ5o6I/YTadNrdqJUEPP9bfgcZH5AC/C+o48iu59cN5fDtWJrGzN9
 dxyM0nW2pvUUheD8jweI/YzM4EAmh3f8YJ9Na1pAKaypUo193qCIZKbg+aiPdjhfFo1a
 TtLgCp7CMuDwcanL9VUgtaYT/6ZfcITndvJ4bNjdvnlO4xUxJALUzhDn8yibmzaYbPCm
 hnEsPdxur4j/1ssyf5ZDzjSsk6ZidycYLmljODpHOcDscerXu27sqn8Fpr/c/Pen8KsQ
 b4cA==
X-Gm-Message-State: AOAM531C3+yjvG7/wx8vJFQvL3FJiE5SNCFjo8Mibc7ptXSA6QyLewa3
 6sga8avbvNOBqsotE9x8PsZdHA==
X-Google-Smtp-Source: ABdhPJyi1lb9BucQK+YSGCgwjAE4v/wcMxWRzaFCiUjXcfLHqnTPGmu7sLGALTmBR1o0MLac7XzrUQ==
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr26315164wrr.283.1600259214510; 
 Wed, 16 Sep 2020 05:26:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i3sm32231510wrs.4.2020.09.16.05.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:26:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B7DEC1FF8F;
 Wed, 16 Sep 2020 13:26:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 3/8] configure: move deprecated feature processing to
 supported_target
Date: Wed, 16 Sep 2020 13:26:43 +0100
Message-Id: <20200916122648.17468-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200916122648.17468-1-alex.bennee@linaro.org>
References: <20200916122648.17468-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the common point at which we validate targets so it makes
sense to add_to deprecated_features here. It will make future target
deprecation easier as we only need to tweak one list.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200915134317.11110-4-alex.bennee@linaro.org>

diff --git a/configure b/configure
index ce27eafb0a9e..51d03a8d340f 100755
--- a/configure
+++ b/configure
@@ -280,6 +280,9 @@ supported_whpx_target() {
     return 1
 }
 
+deprecated_targets_list=ppc64abi32-linux-user
+deprecated_features=""
+
 supported_target() {
     case "$1" in
         *-softmmu)
@@ -301,6 +304,12 @@ supported_target() {
             return 1
             ;;
     esac
+
+    # if a deprecated target is enabled we note it here
+    if echo "$deprecated_targets_list" | grep -q "$1"; then
+        add_to deprecated_features $1
+    fi
+
     test "$tcg" = "yes" && return 0
     supported_kvm_target "$1" && return 0
     supported_xen_target "$1" && return 0
@@ -542,8 +551,6 @@ gettext=""
 bogus_os="no"
 malloc_trim=""
 
-deprecated_features=""
-
 # parse CC options first
 for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
@@ -1724,7 +1731,7 @@ fi
 
 if test -z "$target_list_exclude" -a -z "$target_list"; then
     # if the user doesn't specify anything lets skip deprecating stuff
-    target_list_exclude=ppc64abi32-linux-user
+    target_list_exclude=$deprecated_targets_list
 fi
 
 exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
@@ -7668,7 +7675,6 @@ case "$target_name" in
     TARGET_SYSTBL_ABI=common,nospu,32
     echo "TARGET_ABI32=y" >> $config_target_mak
     gdb_xml_files="power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml"
-    deprecated_features="ppc64abi32 ${deprecated_features}"
   ;;
   riscv32)
     TARGET_BASE_ARCH=riscv
-- 
2.20.1


