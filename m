Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7328BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B602077D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lvnp7rCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B602077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdZS-0005uE-DB
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKu-0004vC-Ch
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKs-0006pr-I7
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id r12so23922929wrj.13
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N4xihvXcT2NbzYDWewm5rzgOgSrnKR9VT35cRtylW1A=;
 b=Lvnp7rCBZEi2ZVXPmakSupr3ajkJx4IwkPB3NMdJpvA7i42BUswJd8i4vyaTD/lKNA
 oWzx/5fSn23i3Mv0DdyOG7y0hF5zmmCcoXn5iIJlFRAjmnNN2Uc570IU1APL31h3eQhz
 ewtSa/6Is4V6CjlL9kcGcqwlGTJ62mLwGfNkUey/GUeHmN6+fb8A6Zf/UFXNlBKtxBth
 a5R6q4jjCAdSd1nPMBZvc9RCuiN2nguwgwgnNy7dLa/ngNpOxprEKub4yb+gBnqd5mm7
 8EM7UIZyAT7ptN3q9SJ324ZvLyCNOMA0RK2rZPvwYAWBVWrQq+JqwBTCzin8GARLWXjN
 Kj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N4xihvXcT2NbzYDWewm5rzgOgSrnKR9VT35cRtylW1A=;
 b=jAGM2IyUbbGVFYjZETJZTgKI3w3MmwcIk8tV7/kLfFADax0OgCWxwkTcLbijBfuhwa
 VXw/k5sX0wbw3pzbEYlmlV9Udrw3P6FI7YAeWQUTpojlq5I87qywX943KZgma4lcEsvQ
 nvv2LkV5XbnuHPrMYIlwq10t5jVtEQfUf4+7Qd7RMdRIh46bcOZz26lHVqF6MwCKdhhM
 dcHUo0vdRPzT8V1Sezg899Sq9OCbo9u0mkH7Od9zdVLRJVRY77apODxAFsq2jk7IDzBW
 2A0Brr4odkxMAsWMLuNjoYl/MScKiYtdoz5iNH6FOcuM0MQFsvwJ3uPw+GOmekWdNvKp
 mb4A==
X-Gm-Message-State: AOAM533D+/JV6/U6WTabLGX+NDSGSBv2CMNVm4OAsWrUYjvUNAorXNZw
 uo/9ffMzwphcMCjTUbBSP/ATGw==
X-Google-Smtp-Source: ABdhPJy/uyiQRdWHo5dbqsWmFUE2baMjQVzvs+VT6fs0/ROophzv15G0h9IFjCMnm14pfQOtcDtkcA==
X-Received: by 2002:a5d:60d1:: with SMTP id x17mr26690700wrt.293.1593612217099; 
 Wed, 01 Jul 2020 07:03:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k14sm7323389wrn.76.2020.07.01.07.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E0D81FFB8;
 Wed,  1 Jul 2020 14:56:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 31/40] tests/tcg: add more default compilers to configure.sh
Date: Wed,  1 Jul 2020 14:56:43 +0100
Message-Id: <20200701135652.1366-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

We were missing a bunch of compilers which we could use if they were
locally installed. The defaults are based on Debian as they seem to be
the best distro for well distributed cross-build compilers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/configure.sh | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 2326f978562..37e49736ca4 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -46,20 +46,29 @@ fi
 : ${cross_cc_aarch64="aarch64-linux-gnu-gcc"}
 : ${cross_cc_aarch64_be="$cross_cc_aarch64"}
 : ${cross_cc_cflags_aarch64_be="-mbig-endian"}
+: $(cross_cc_alpha="alpha-linux-gnu-gcc")
 : ${cross_cc_arm="arm-linux-gnueabihf-gcc"}
 : ${cross_cc_cflags_armeb="-mbig-endian"}
+: ${cross_cc_hppa="hppa-linux-gnu-gcc"}
 : ${cross_cc_i386="i386-pc-linux-gnu-gcc"}
 : ${cross_cc_cflags_i386="-m32"}
-: ${cross_cc_x86_64="x86_64-pc-linux-gnu-gcc"}
-: ${cross_cc_cflags_x86_64="-m64"}
+: ${cross_cc_m68k="m68k-linux-gnu-gcc"}
+: $(cross_cc_mips64el="mips64el-linux-gnuabi64-gcc")
+: $(cross_cc_mips64="mips64-linux-gnuabi64-gcc")
+: $(cross_cc_mipsel="mipsel-linux-gnu-gcc")
+: $(cross_cc_mips="mips-linux-gnu-gcc")
 : ${cross_cc_ppc="powerpc-linux-gnu-gcc"}
 : ${cross_cc_cflags_ppc="-m32"}
-: ${cross_cc_ppc64="powerpc-linux-gnu-gcc"}
-: ${cross_cc_cflags_ppc64="-m64"}
+: ${cross_cc_ppc64="powerpc64-linux-gnu-gcc"}
 : ${cross_cc_ppc64le="powerpc64le-linux-gnu-gcc"}
-: ${cross_cc_cflags_s390x="-m64"}
+: $(cross_cc_riscv64="riscv64-linux-gnu-gcc")
+: ${cross_cc_s390x="s390x-linux-gnu-gcc"}
+: $(cross_cc_sh4="sh4-linux-gnu-gcc")
 : ${cross_cc_cflags_sparc="-m32 -mv8plus -mcpu=ultrasparc"}
+: ${cross_cc_sparc64="sparc64-linux-gnu-gcc"}
 : ${cross_cc_cflags_sparc64="-m64 -mcpu=ultrasparc"}
+: ${cross_cc_x86_64="x86_64-pc-linux-gnu-gcc"}
+: ${cross_cc_cflags_x86_64="-m64"}
 
 for target in $target_list; do
   arch=${target%%-*}
-- 
2.20.1


