Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99466C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690482073A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMTwBEDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690482073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtXOt-0000qa-KP
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 10:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXJ7-0000b3-Iy
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:49 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtXJ4-0001M2-Rj
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 10:13:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id o11so2546845wrv.9
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6oUsKppsQSQ9dDcWGFfn/h24xQJ4dIbnKOSlIto0GoA=;
 b=kMTwBEDNnNx8igNKTQwFi4OlDltpw0xtCqrvORcvBDvWTL4k4eLfqpMDdVZDnjJy9X
 u0ePj2buNN/3uRT5QZXRg1nlHDKcKNQdN7z2pLnBiMpcoIXzy0TLRHXsQMFVWxAynA8O
 QKKUT8MXP9ajSas+4ggQhxwSyUQHq0cBYvw6hZFzFkVDd+BiJPRTswGFj9TLvstQi1x/
 dWKF34T2JSXjZXzoibJgH4oxC+u32zcxq/1yj7WMPGFVfPt8nwASJ5EZqjgnqfxZ290/
 m6LRRICRWRHu+C+3CcDz1dy4ErDiqFr0GY6IwnJMBj9T1EhtJqup1iIFHShmD1eTXkIw
 +SHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6oUsKppsQSQ9dDcWGFfn/h24xQJ4dIbnKOSlIto0GoA=;
 b=ONVPz7DiGx8zdMjyBIC2VMDW5ve3oLR0+cxjWgPpBUirddvsiDSKEVWmFBDfq3hYW0
 Np1T2x85C1YLkqnDgsmXk/Ge6lmPMkQgVDXAThq1GfnCeW/WZMqhgwOg5K9CvFO3GnYU
 bj0guCm2P+0UW8W2LHk2iOZxqlWXaHCt89Vv5yam/fFHk8kX+CWVqvI0yz4AjUJFeB/9
 Vv1O1Evu5Fy29rpsPt1xfIuMvPwDphBYfFFcI1jbPRocs11Zwt2+F0bZn41NExTGpZGT
 GYXhD4WbC73dvKeefBJr6U4VZx1ij2lMYamlwyLMoILfa1BMy3qC5RbubUP95p4BZsFK
 Stlw==
X-Gm-Message-State: AOAM531HbnfKJ0YVPhra0orDhWiSRYS7z6RN81BjYSIJ+0Ip0gRRefxz
 Glu1OozmpH4NCZezgBT/pLw5Gg==
X-Google-Smtp-Source: ABdhPJw4SgWFtowly5L9aq1IwICjqwM3HGDrpnHb/PgplbNrnxYyWwLA7TCutv9ryOTj3cHNF6TECA==
X-Received: by 2002:adf:f388:: with SMTP id m8mr66146649wro.338.1594304025439; 
 Thu, 09 Jul 2020 07:13:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 51sm6158514wrc.44.2020.07.09.07.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 07:13:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9C9F91FF9C;
 Thu,  9 Jul 2020 15:13:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 13/13] configure: remove all dependencies on a (re)configure
Date: Thu,  9 Jul 2020 15:13:27 +0100
Message-Id: <20200709141327.14631-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709141327.14631-1-alex.bennee@linaro.org>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
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
---
 configure | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index 1e977601a47a..3c404f31f4f4 100755
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


