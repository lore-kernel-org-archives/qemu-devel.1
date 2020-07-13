Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2FAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB9E2075D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yw5nL6g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB9E2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4hh-0001Af-DI
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4ga-0007wO-JI
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4gY-0006GW-Pk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:04:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id o8so1127115wmh.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0GDUfAsY7oBRDehZI0s+LxQK3zPfLdSNXvvRvB9ltNY=;
 b=yw5nL6g3+qlDT1vGZe3O7nVEHuN/ORByMYZCWmIxWlV5hRsbZdkpgasJF+EHpfT/U3
 eFZ7fOM3c+cQMGQly6hlnOL41wG9Zh3u5LH/e5PqJma5RxhBuq5UClbPl8Rpxuu9akMO
 miavOMoDFULXNlHf+y35Msxy7oQQt2WtMDyArCW6l1e8bm8dUSvw26pXFOc6B53slPZd
 dcr5c4jytxONTFdDd4y+TVWWpJi66HcBXgwIddm7K5yqEBxv4I+xuH8I1kIMOrJb49ud
 75+cQJ+vr6iXyeqiwU64stFveQ8q5rKK5hiM6caYy2gos9lhmblwS3EXJyZvh8U2U0av
 UcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0GDUfAsY7oBRDehZI0s+LxQK3zPfLdSNXvvRvB9ltNY=;
 b=RFP8FwTG2AE1cKdt67caE8lgOFYD1Ko5qu/AUuNNhrRJ2oVP860sFVGDWvwvinzXGn
 dZzGO5+oYU6ZqWhHqAy6iHwg9SdFf5ixGv18mNqLQNJ2d8udYLqnAkWHb/oBrmWmN8aH
 NfyJzUHBI5ZHLlHN306cgCcEVy2fZODIBmFHx0bgEIAtgO8YUFtxN88KCgWj91EHQDQe
 XypsqoL9t5JkAODCL/y2C10DhexVgadXopAme1qAiVZkCQ+kiWcB3P32rxSgaBUPr7zk
 nGF9Ocp1qWYFZhduFi/9TXTRW1hOHktnlPYd4cmJXgi8/yxpHOQu0fdhghaJnmCD23aO
 pq1Q==
X-Gm-Message-State: AOAM533SEIOeXlUzjvQCiULA+YoLCe3Hm01RuvXUp1d+rb5GayHFQ6j0
 KDiy1vc8SFHwlkFwxuzcqctsUQ==
X-Google-Smtp-Source: ABdhPJzegv7amUwaE2S81w1cqoMgy56Dy96GV2sB/SBsvOScBidYjJBtHQvM82m4DdvneZtzuadIAg==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr1017817wmg.27.1594670661440; 
 Mon, 13 Jul 2020 13:04:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 133sm1010756wme.5.2020.07.13.13.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 13:04:16 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AD1E61FF87;
 Mon, 13 Jul 2020 21:04:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/11] configure: remove all dependencies on a (re)configure
Date: Mon, 13 Jul 2020 21:04:05 +0100
Message-Id: <20200713200415.26214-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713200415.26214-1-alex.bennee@linaro.org>
References: <20200713200415.26214-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous code was brittle and missed cases such as the mipn32
variants which for some reason has the 64 bit syscalls. This leads to
a number of binary targets having deps lines like:

  all.clang-sanitizer/mipsn32el-linux-user/linux-user/signal.d
  140:  /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h \
  455:/home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:

  all.clang-sanitizer/mipsn32el-linux-user/linux-user/syscall.d
  146:  /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h \
  485:/home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:

which in turn would trigger the re-generation of syscall_nr.h in the
source tree (thanks to generic %/syscall_nr.h rules). The previous
code attempts to clean it out but misses edge cases but fails.

After spending a day trying to understand how this was happening I'm
unconvinced that there are not other such breakages possible with this
"caching". As we add more auto-generated code to the build it is likely
to trip up again. Apply a hammer to the problem.

Fixes: 91e5998f18 (which fixes 5f29856b852d and 4d6a835dea47)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index bc3b9ad931..e1de2f5b24 100755
--- a/configure
+++ b/configure
@@ -1955,23 +1955,20 @@ EOF
 exit 0
 fi
 
-# Remove old dependency files to make sure that they get properly regenerated
-rm -f */config-devices.mak.d
-
 # Remove syscall_nr.h to be sure they will be regenerated in the build
 # directory, not in the source directory
 for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x sparc sparc64 \
     i386 x86_64 mips mips64 ; do
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
-    # remove the dependency files
-    for target in ${arch}*-linux-user ; do
-        test -d "${target}" && find "${target}" -type f -name "*.d" \
-             -exec grep -q "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
-             -print | while read file ; do rm "${file}" "${file%.d}.o" ; done
-    done
 done
 
+# Clean out all old dependency files. As more files are generated we
+# run the risk of old dependencies triggering generation in the wrong
+# places. Previous brittle attempts to be surgical tend to miss edge
+# cases leading to wasted time and much confusion.
+find -type f -name "*.d" -exec rm -f {} \;
+
 if test -z "$python"
 then
     error_exit "Python not found. Use --python=/path/to/python"
-- 
2.20.1


