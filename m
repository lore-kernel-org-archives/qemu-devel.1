Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B0CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC18206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1lm+6yO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC18206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtEH8-0003g3-Ej
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtEGS-0003AI-2G
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 13:53:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtEGP-0008KP-Pa
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 13:53:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id l17so4183948wmj.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 10:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mi+L1QRAOMuwUBNcL5oGSFgRCBoiYqgyP+EkC+khtiI=;
 b=a1lm+6yO5YwqPtk+B4Vl8s+uwIn0w9qq10jr7fdMor0i2hzl7/qy1l4GGQUGfYTOEj
 6NQaQGwxas+7QFBd/J05EgGa4HEBvgxANLJlA12H+Ve7aCs1n6Yv/P9NebFvc7+bjm6k
 C6OT3FW7SMIFARI3A1N+S859dBRoY4XS5jQbnYT2LIVaQ7Ff6oihsdZevkhUKtvmAIcI
 bXc3GB2sZgoZEwh9DG0s8qjWgnTyKZ1jJVtBUy6cc5XLuQZolTfLlB7GEweSEezzuqY2
 aomoUhOANsHtwRUKrvXhngo38I9OEWNzqbmNsyYBZfg4cUvKqDj8jYHeYA8sreNCW4pZ
 OKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Mi+L1QRAOMuwUBNcL5oGSFgRCBoiYqgyP+EkC+khtiI=;
 b=QEc8XnwDdRLnX+TxluKMa7HOwU4LVDJ1FaHKu6lGMERaw9YyoS4ELi61Yk24VVZWdQ
 9A7nfGmg7bcEEaD/H19oEXUqxS1fpJF14zjLpacXAl2kcnHdUyC00+wqEH3T9u2BTDu/
 0JzJj++nhb5K6TQDbRpmXCmwAeplPv8FWfZ0pOhmqyIUOPqlZpeWP8uh/tPAPi5py5L3
 bpdIRFyPtOPyFqdxB6X3te3ZGXAysyib3pO/L/Tuqy/6yPF/Yw1Yf6+rz6v/HkFQ9n44
 nP3Z5qXJUeP8IVdZ8XKFhXoTynzlFM6LihJG1RALPU+BwdGvVmSNLyuVrjptNASQ5tB0
 kk3Q==
X-Gm-Message-State: AOAM532LpQMEWonweEi4ZNUL7e/4c0r7GNuJyMfnrgo7bRwGm2zV9BD1
 FhtaHwpneVsKWVtotThro3CX0g==
X-Google-Smtp-Source: ABdhPJzGZhuCLKtayR/tJa5HRNB6434V1qFllotUW6TtXlZwnhz9duu3PzZWTcf19R0oY6URcrA/Ww==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr11132186wmb.140.1594230823889; 
 Wed, 08 Jul 2020 10:53:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w16sm1290830wrg.95.2020.07.08.10.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 10:53:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 33A171FF7E;
 Wed,  8 Jul 2020 18:53:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] configure: remove all dependencies on a (re)configure
Date: Wed,  8 Jul 2020 18:53:35 +0100
Message-Id: <20200708175335.31292-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
---
 configure | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index d2d93ae51e47..81ef123fb187 100755
--- a/configure
+++ b/configure
@@ -1950,23 +1950,20 @@ EOF
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


