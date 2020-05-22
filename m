Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B24C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4374120723
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaOU4WrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4374120723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAUG-0006pt-9G
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKj-0003dT-0h
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:41 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcAKh-0006JT-Qp
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:15:40 -0400
Received: by mail-pl1-x644.google.com with SMTP id q16so4580738plr.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NheIrwAPnCYgtMEumEcCojybpzE1xkpB6QxsKMCy5vo=;
 b=GaOU4WrCYODdrY8UKoFMtLv93SAadUOT5ArmGLTkLq+AHpZuoiQFKQa+IMWvS0lqss
 eU1I/J1b/i1fjNWgHGMWmfCs0DqwAFCfyHOLqIWAcc1nLx2rXo+mN6xj6nMon+vf0s7J
 luKu8y9Cnp1/85Pg2i6b5x6mGOyj9vwfRkJ32xqFkDZYjUozjAF1K+FqaghHX3Upkv3z
 mfCKIalBSdooEGfy2aFGy8wMxxUjW9pVG7JhdMTJCvQO+8pf6DOiCbAhTuZSRs1Et0t8
 7awqt4hUHVwdahTXHmTy61xcSotRSKqnm87yraG6gd9KkearXHhKabyht+ACBtReFNuQ
 2HOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NheIrwAPnCYgtMEumEcCojybpzE1xkpB6QxsKMCy5vo=;
 b=jNoeHJwVq3BEI1ZHDbQm67Jt1mL5JFKQEDToNRsneunZ9a/sLecq8G8wGdnFm5shWJ
 21sHBv4+9mioUjrxbfutpEi1fkEsSXbqcuPHkdn/o/EfEiwV4aQZNP8nAIyAE/RQ+zL/
 2hWuh3MfOEYbBZM/ijcd75GslD4zVYyOAXWw9DGR8LmTIAv6sG/pHq9GoCgbFtbrqAee
 XvETVZCBT0muB4xHHK059dj3DLRDses7Uh5gM3x3MV+MnwAQajM5Wjwpsg6KTyaj6pbx
 FxCMnOZWIvQsP029HUSGq2XHZ8Vf7Al/Vn1/ao9EQtDsQfTtgm5H63Y6Tavtwh/UjUVa
 o9Dw==
X-Gm-Message-State: AOAM531+lzV2w6/x+cehvVBQ3ic5gdPfg2S4dApal6wHPjG7EXJCZr+Y
 nULmQ/NEShmW+8hDzgIdhmqlycj8MaSDFA==
X-Google-Smtp-Source: ABdhPJziwesNSRdfYiiN1b2ilegPb02rnpiQXZ9O8pkX7n+TdcHFEYvQlneSlVPW4GNQzsYw8EoG3Q==
X-Received: by 2002:a17:902:44e:: with SMTP id
 72mr15445673ple.301.1590164137952; 
 Fri, 22 May 2020 09:15:37 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:f1d9:5fce:c451:d2e2])
 by smtp.gmail.com with ESMTPSA id y75sm7255428pfb.212.2020.05.22.09.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:15:37 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/19] docs: Added details on TSan to testing.rst
Date: Fri, 22 May 2020 12:07:55 -0400
Message-Id: <20200522160755.886-20-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200522160755.886-1-robert.foley@linaro.org>
References: <20200522160755.886-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=robert.foley@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes details on how to build and test with TSan
both inside a docker and outside.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 docs/devel/testing.rst | 72 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 770a987ea4..5b0a828068 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -397,6 +397,78 @@ list is in the ``make docker`` help text. The frequently used ones are:
 * ``DEBUG=1``: enables debug. See the previous "Debugging a Docker test
   failure" section.
 
+Thread Sanitizer
+================
+TSan is currently supported in the ubuntu2004 docker.
+
+Just add the TSAN=1 argument to use TSan
+
+.. code::
+
+  make docker-test-build@ubuntu2004 TSAN=1
+
+or
+
+.. code::
+  
+  make docker-test-quick@ubuntu2004 TSAN=1
+
+The runtime behavior or TSAN is controlled by the TSAN_OPTIONS environment
+variable.  We set this variable automatically to for example, maximize
+the number of warnings TSan can find and also to specify the location of
+the files with TSan warnings.  
+
+TSan warnings are placed in files located at build/tsan/.
+
+We recommend using DEBUG=1 to allow launching the test from inside the docker,
+and to allow review of the warnings generated by TSan.
+A few important files to note are:
+
+tests/tsan/suppressions.tsan - Has TSan warnings we wish to suppress at runtime.
+In some cases we choose to put suppressions here since the resolution is
+slightly finer than the blacklist, since we can disable by warning type.
+
+tests/tsan/blacklist.tsan - Has TSan warnings we wish to disable
+at compile time.
+
+include/qemu/tsan.h - Defines various annotations which can also be used
+to give TSan more information some example uses are to allow suppressing
+TSan warnings, or annotating thread names so they show up properly in
+the TSan warnings.
+
+TSan without docker
+-------------------
+
+It is possible to build and test with TSan outside of a docker, but with a
+few additional steps required.
+These steps are normally done automatically in the docker.
+
+First, to configure the build for TSan:
+
+.. code::
+
+  ../configure --enable-tsan --cc=clang-10 --cxx=clang++-10 \
+               --disable-werror --extra-cflags="-O0"
+
+There is also a one time patch needed in clang-9 or clang-10:
+
+.. code::
+
+  sed -i 's/^const/static const/g' \
+      /usr/lib/llvm-10/lib/clang/10.0.0/include/sanitizer/tsan_interface.h
+
+When running tests, the TSAN_OPTIONS environment variable needs to be set.
+
+.. code::
+
+  export TSAN_OPTIONS=suppressions=<path to qemu>/tests/tsan/suppressions.tsan \
+         detect_deadlocks=false history_size=7 exitcode=0 \
+         log_path=<build path>/tsan/tsan_warnings.txt
+
+The above exitcode makes TSan continue without error if any warnings are found.
+This allows for running the test and then checking the warnings afterwards.
+If you want TSan to stop and exit with error on warnings, use exitcode=66.
+
 VM testing
 ==========
 
-- 
2.17.1


