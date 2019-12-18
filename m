Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B7BC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F2920715
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 03:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGVqbIdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F2920715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihPth-0005rI-Dj
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 22:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs4-00046m-6N
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihPs3-0002ic-71
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:32 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45480)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihPs3-0002i3-1j
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 22:19:31 -0500
Received: by mail-pf1-x443.google.com with SMTP id 2so378268pfg.12
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 19:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SWmO1kQqi8bfr8nyMbMf0tsp3eELnVxdGpB7UInxtBo=;
 b=EGVqbIdRGvMaQXdeWAJtbMzNpZwwWlC76YQ0QG9FY3huacb+X6IX14INLFeYaFFwOh
 JvDxBO4K1V1D8dZW15AzVdFJqdhyEpXB+Wb9GnllpzRhgquuxARiijJ62HM8XO6iHP4M
 EIlkNdVZBMBDtNr0tGoUQLtg++K45HjFayOfSmpdkabTvkglk1KM2bYXilGwYZM61AV3
 PD1HK3RjOMF/v1GTp+oBIFFOYmd0U3wuvKVNpOahK4VjjVPbsncmjSGz0Hn0EUEvEDDx
 Sid6xMrg6u9o8rj88+606e1zICTGUYOrM2SeeQhZicMS7yylfcOFbCi1J5O7fs+NpX1M
 Z66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SWmO1kQqi8bfr8nyMbMf0tsp3eELnVxdGpB7UInxtBo=;
 b=avyeDd54soICOOErE+becu9JHICnaHw7S1QTO6s3LH+2pB+xByob4W0I+K4Du+RimN
 DRtr4KpVoBatvGth60pmeTGoKMCETodt/FdKoLGv/KcXIjVFTrR/56jHisdXqr7urPGU
 2IY9QeLC4pJDGa2I8hFILTmwrmRFJBvguKjwPZc5qoLGusfVX2U5a0fVKnlZFWSVcwcW
 TgYyNRLQ/7XEP4WfuaejUxnxHoh9xrPnnYMI7Ida9abJ7qSzYfxOaAw/RCnd20tUzd+F
 IVwhX329ja4jNxx3Q2/SGGzcSTa/HwCXBpt+y27ijjYlcNXBPYSsFD8gf7zXHfd8CMSV
 nIOw==
X-Gm-Message-State: APjAAAXpekkiBewtzJLon5ox6ab56BTYrq1W1mbJybUILUGBjyWxBEVh
 bZKWLgeVOtfhSntTZf9Rg4qYfneg5iE=
X-Google-Smtp-Source: APXvYqzNkP2ktpfX4dgcQmKYgSda8d77FTds98YszTjvtTcBdJwsfwUQfUse+KvHHSq8o5jc3JjvOA==
X-Received: by 2002:a65:49ca:: with SMTP id t10mr324831pgs.37.1576639169720;
 Tue, 17 Dec 2019 19:19:29 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id k27sm404870pfp.66.2019.12.17.19.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 19:19:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] configure: Always detect -no-pie toolchain support
Date: Tue, 17 Dec 2019 17:19:17 -1000
Message-Id: <20191218031920.6414-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191218031920.6414-1-richard.henderson@linaro.org>
References: <20191218031920.6414-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: philmd@redhat.com, i@maskray.me, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CFLAGS_NOPIE and LDFLAGS_NOPIE variables are used
in pc-bios/optionrom/Makefile, which has nothing to do
with the PIE setting of the main qemu executables.

This overrides any operating system default to build
all executables as PIE, which is important for ROMs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 2fb4457d7c..972ce7396f 100755
--- a/configure
+++ b/configure
@@ -2012,26 +2012,24 @@ if ! compile_prog "-Werror" "" ; then
 	"Thread-Local Storage (TLS). Please upgrade to a version that does."
 fi
 
-if test "$pie" != "no" ; then
-  cat > $TMPC << EOF
+cat > $TMPC << EOF
 
 #ifdef __linux__
 #  define THREAD __thread
 #else
 #  define THREAD
 #endif
-
 static THREAD int tls_var;
-
 int main(void) { return tls_var; }
-
 EOF
-  # check we support --no-pie first...
-  if compile_prog "-Werror -fno-pie" "-no-pie"; then
-    CFLAGS_NOPIE="-fno-pie"
-    LDFLAGS_NOPIE="-nopie"
-  fi
 
+# Check we support --no-pie first; we will need this for building ROMs.
+if compile_prog "-Werror -fno-pie" "-no-pie"; then
+  CFLAGS_NOPIE="-fno-pie"
+  LDFLAGS_NOPIE="-no-pie"
+fi
+
+if test "$pie" != "no" ; then
   if compile_prog "-fPIE -DPIE" "-pie"; then
     QEMU_CFLAGS="-fPIE -DPIE $QEMU_CFLAGS"
     LDFLAGS="-pie $LDFLAGS"
-- 
2.20.1


