Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572B1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2326A206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y52sj9Ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2326A206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGJI-0007DV-Dc
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGI4-0004Im-Lw
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:38:00 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jhGI3-00041W-Hk
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:38:00 -0400
Received: by mail-pf1-x442.google.com with SMTP id s23so3961015pfh.7
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XzO4d9NfxHhnWYA5ypuQ0LUhD/s+5379iGqovYIf/8k=;
 b=y52sj9Axg0xBsiHEVC44k/0Dm4IwyON9v7OpxX7YRbq8zlTRFJRXav3d11iFUrOQ38
 oOBaP2GKKeHWzmUc8MtXZg+DoL5OG2sFCztWiYy/qwAl4VkgRMECZMZJjzPUjsnysh+R
 eWZzBcDBtWHePCEdQXowVjdKpzNJxMnO2wRSZEqsCfG4lX6SPn3HbCej/RbwJyiYCjPT
 n6beifZUWT5BIgt/7W0c0FjsfUiPHMYrGOZTIw58hjWgxjvT4uxGApLneL+f0O1NezGG
 /LV3+jeU3Sjl7UeOjqA28YslsxtA5DfvV9GOBkId5O3/V9/9/uxkMslcnsmJRE4YOAtT
 yjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XzO4d9NfxHhnWYA5ypuQ0LUhD/s+5379iGqovYIf/8k=;
 b=MhOuAcxG0oLIHPttFrV8kX1I2yyNTDPQOD0NE4fmPOfV1185DAk5r+t8+SdFQVKeqC
 xByKDeSak2mLExhhcRcRno3ortlmMb28+g0yyXsiScWUJwagXf8TvZo4/dW2YKuEAbEb
 NpX3Vicf3T570z27FtyBq0vHJtFBrKbG+jJILuOaDkf9chViN/3yj9mlGYFQ5gBkMj29
 jwoTMLWvEdQon66mkzhYU5lQsnAAyrcQog2r0D3ruWHuYlAMflAOXdeLCxEXMTQpADcC
 gILqOMymxR9twkePsunNUaKpdw4iAjPvR40senRG0/ZKoUwZ63IHYYw2F40WBh5fxxzs
 p/+A==
X-Gm-Message-State: AOAM532Mn/mJQy5Ycp05T4q+6q+RXeV112K/ZkBID8RmDZQ+g2jb8Hvd
 M6tLLSk+q885aFFwnBcJKx+Gj99rVuGHDA==
X-Google-Smtp-Source: ABdhPJyzBIKpLrkvpIklD4VG4YKxwyJLORDnH0Q13tLBs3zPCtE/gFZgaDRa3xrsvSR33dhmMVbGzQ==
X-Received: by 2002:aa7:9a5a:: with SMTP id x26mr10972302pfj.307.1591378677823; 
 Fri, 05 Jun 2020 10:37:57 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id a19sm188307pfd.165.2020.06.05.10.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:37:57 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/13] docs: Added details on TSan to testing.rst
Date: Fri,  5 Jun 2020 13:34:21 -0400
Message-Id: <20200605173422.1490-13-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200605173422.1490-1-robert.foley@linaro.org>
References: <20200605173422.1490-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=robert.foley@linaro.org; helo=mail-pf1-x442.google.com
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

Adds TSan details to testing.rst.
This includes background and reference details on TSan,
and details on how to build and test with TSan
both with and without docker.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
---
 docs/devel/testing.rst | 107 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 770a987ea4..c1ff24370b 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -397,6 +397,113 @@ list is in the ``make docker`` help text. The frequently used ones are:
 * ``DEBUG=1``: enables debug. See the previous "Debugging a Docker test
   failure" section.
 
+Thread Sanitizer
+================
+
+Thread Sanitizer (TSan) is a tool which can detect data races.  QEMU supports
+building and testing with this tool.
+
+For more information on TSan:
+
+https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual
+
+Thread Sanitizer in Docker
+---------------------------
+TSan is currently supported in the ubuntu2004 docker.
+
+The test-tsan test will build using TSan and then run make check.
+
+.. code::
+
+  make docker-test-tsan@ubuntu2004
+
+TSan warnings under docker are placed in files located at build/tsan/.
+
+We recommend using DEBUG=1 to allow launching the test from inside the docker,
+and to allow review of the warnings generated by TSan.
+
+Building and Testing with TSan
+------------------------------
+
+It is possible to build and test with TSan, with a few additional steps.
+These steps are normally done automatically in the docker.
+
+There is a one time patch needed in clang-9 or clang-10 at this time:
+
+.. code::
+
+  sed -i 's/^const/static const/g' \
+      /usr/lib/llvm-10/lib/clang/10.0.0/include/sanitizer/tsan_interface.h
+
+To configure the build for TSan:
+
+.. code::
+
+  ../configure --enable-tsan --cc=clang-10 --cxx=clang++-10 \
+               --disable-werror --extra-cflags="-O0"
+
+The runtime behavior of TSAN is controlled by the TSAN_OPTIONS environment
+variable.
+
+More information on the TSAN_OPTIONS can be found here:
+
+https://github.com/google/sanitizers/wiki/ThreadSanitizerFlags
+
+For example:
+
+.. code::
+
+  export TSAN_OPTIONS=suppressions=<path to qemu>/tests/tsan/suppressions.tsan \
+                      detect_deadlocks=false history_size=7 exitcode=0 \
+                      log_path=<build path>/tsan/tsan_warning
+
+The above exitcode=0 has TSan continue without error if any warnings are found.
+This allows for running the test and then checking the warnings afterwards.
+If you want TSan to stop and exit with error on warnings, use exitcode=66.
+
+TSan Suppressions
+-----------------
+Keep in mind that for any data race warning, although there might be a data race
+detected by TSan, there might be no actual bug here.  TSan provides several
+different mechanisms for suppressing warnings.  In general it is recommended
+to fix the code if possible to eliminate the data race rather than suppress
+the warning.
+
+A few important files for suppressing warnings are:
+
+tests/tsan/suppressions.tsan - Has TSan warnings we wish to suppress at runtime.
+The comment on each supression will typically indicate why we are
+suppressing it.  More information on the file format can be found here:
+
+https://github.com/google/sanitizers/wiki/ThreadSanitizerSuppressions
+
+tests/tsan/blacklist.tsan - Has TSan warnings we wish to disable
+at compile time for test or debug.
+Add flags to configure to enable:
+
+"--extra-cflags=-fsanitize-blacklist=<src path>/tests/tsan/blacklist.tsan"
+
+More information on the file format can be found here under "Blacklist Format":
+
+https://github.com/google/sanitizers/wiki/ThreadSanitizerFlags
+
+TSan Annotations
+----------------
+include/qemu/tsan.h defines annotations.  See this file for more descriptions
+of the annotations themselves.  Annotations can be used to suppress
+TSan warnings or give TSan more information so that it can detect proper
+relationships between accesses of data.
+
+Annotation examples can be found here:
+
+https://github.com/llvm/llvm-project/tree/master/compiler-rt/test/tsan/
+
+Good files to start with are: annotate_happens_before.cpp and ignore_race.cpp
+
+The full set of annotations can be found here:
+
+https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_interface_ann.cpp
+
 VM testing
 ==========
 
-- 
2.17.1


