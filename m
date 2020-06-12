Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67FBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C4220792
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 19:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YwX0qdCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C4220792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjp7I-0001mZ-V6
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 15:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjp2O-0001wx-Hu
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:08:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37045)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jjp2M-0007av-NM
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 15:08:24 -0400
Received: by mail-wr1-x441.google.com with SMTP id x13so10850039wrv.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fmvqRWXA4S4s+D50fC0aMio8k7PyGt04LZMtINTzwxg=;
 b=YwX0qdCFw6656yVdn3ZuyHcLqiRMU51QcNhqDIMoiW9IhsTqc3+PsAx6UA/yrCrtlB
 d1gV+2B8vmfYTGeS9vutWssVF54vXC96F1yh6+P33kap8H3386GDbuol1K61l1/7Qmpx
 D6JLw7p/CGuDTzsWQ2QNGi/Zurd470JSlGfPGXDhARZOexw30Vwx1yDr8mTUbPbkhH5X
 PyLzzddcDN0EShGWXKfVoRn6tDttssoSG+DXtbkyYhDpw41WRt9AcREnVrYsc97QyL9l
 0/Oo1mofTHCbjWCBBbt1YENlsK2INOnz8RyiywKtJsWQNQrD2gtb0sgg6ECY42A/gvSX
 OxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fmvqRWXA4S4s+D50fC0aMio8k7PyGt04LZMtINTzwxg=;
 b=T93+gsjKKvpNwTgdnHnJYuRSgnG6zrChH8ep6sYWXGgFlyVINhCkNiItjzjztN2FdF
 8QlY2tM7JUD5I0lrSVQ5r/cOsL7zDrX3Gglm3n7/uA1DUPxWsAp9PqzBWDzZ2+O00Rlw
 +1L27g9jk6jln5dHYmRmxZapQAFP/nEXkPQaVRH4p04ybsOpX4XLOIQHzRVhFONejF/v
 XqD4ZoAWDUYAjQoFPUyX1Fh/rEmX9Y7LKEMTYgOglvQid0+xirF2Swe+9W2D1wFJff4K
 XPj0EtqlSqFdoUNYy/78RtXfR4uDvjSWOOgrWWw6mhLr+6YjkH1XuTClVYbvsrw0cHvD
 QImg==
X-Gm-Message-State: AOAM533dc9rtLwUCUmg4C7Wi8BXw81Img7vVUid8dKdmSxP94FhCz+J3
 NNEPDb71n03wUAC+fYGZnPbmGQ==
X-Google-Smtp-Source: ABdhPJxRgb6U+Z7/oI7B8osdf9PMWNgqUljz6rHEAW5mhKk1MJd82eyRY1NVuMPU5NFpcSmSuvIwGw==
X-Received: by 2002:a5d:4c45:: with SMTP id n5mr16558362wrt.341.1591988893816; 
 Fri, 12 Jun 2020 12:08:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d11sm11503801wrm.64.2020.06.12.12.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 12:08:08 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7DE441FF9D;
 Fri, 12 Jun 2020 20:02:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 15/18] docs: Added details on TSan to testing.rst
Date: Fri, 12 Jun 2020 20:02:34 +0100
Message-Id: <20200612190237.30436-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200612190237.30436-1-alex.bennee@linaro.org>
References: <20200612190237.30436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

Adds TSan details to testing.rst.
This includes background and reference details on TSan,
and details on how to build and test with TSan
both with and without docker.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200609200738.445-13-robert.foley@linaro.org>
---
 docs/devel/testing.rst | 107 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 770a987ea42..c1ff24370bf 100644
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
2.20.1


