Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1E6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94CE205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVmfn26Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94CE205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvc2-0007uJ-31
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXi-0000lP-J2
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXh-0004xs-AW
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:42 -0400
Received: by mail-wm1-x341.google.com with SMTP id g14so12414459wme.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PSejtQaKsSmZz/8Wr+NX++8sCGeGvlfmEfdXWCygToQ=;
 b=EVmfn26Z3z+7bUbRO5nloiuSx9YmvczUwFD4Y8avIreMZKTFK/HH0sbXIwERQgaO7g
 /u6zrH5v+xtwdim3Y538lL8wQUxo7WSUSTeEOJPFgo+0Wkndw4oKOiBvQt8PRfoNMGbX
 DOATXVaCK7uvx6vAdgG1ao+/9/xVUFawNtlrW/hADPYUMyT6nijoBCFgdOYLzJ4vKVaR
 dGRb6peCtmpsKPkuE4tUt5zHR2uLG50OCly2yNWj2Ep9YAiIML0x75fyrj5eV1nUX8+p
 h/HqoUeryo+1MBRZ0qscG9Xf7nh8rvNYwEp6fuEeWVFhcAmEE3YZLdR8XpNEp6zQmtxi
 rBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PSejtQaKsSmZz/8Wr+NX++8sCGeGvlfmEfdXWCygToQ=;
 b=BxRJZqOHra8ZJ/gF7Qfc/m9cO9gQHk+IM5l8qrI8qIJOXIgbV0zpSHAHp8ude1JliL
 6bAR6ur6yDZ+W74MGww2y28D1PYcLcMfxQ4kSkE+exA4UUwKEAb9eUejkLzcAGXon61B
 CFnxt0/hVbmYs3CFkf2UWZjSn6z1kAaJH668o+nm7QWXr1+7Q5bsMh6VkxV4dK7KSYXG
 qW0AELGXArnyJM60X/9HxRfIljNJU2hbGwQtT2MC/xPqrq6Y+mXgWFwMQAxRDaqC1U0a
 aEP7PAZLSCjYGB7O3NbrP+jLXVJTsQq4zY16W0gv90NaEkHwPsHnDb+8sG1Il9TqGkw8
 HYHg==
X-Gm-Message-State: AGi0PuZACHkU6RC/Lct5sbC7aLq9uBgDJbQpx7HuraQ99PqE6eNRnJbb
 T+5C8EOBYZsKOinCn3/Az9hf8kLuYPQ=
X-Google-Smtp-Source: APiQypKisOOrzW7u4O2G41DbGNbSU4YLdXcgGKlPEqt9kgoMOy2mZLQ/VybGujXZgqhiNG67vaauSw==
X-Received: by 2002:a1c:a545:: with SMTP id o66mr14712113wme.167.1589392299919; 
 Wed, 13 May 2020 10:51:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m7sm13722433wmc.40.2020.05.13.10.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:51:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 189221FF8F;
 Wed, 13 May 2020 18:51:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 03/10] tests/docker: Kludge <linux/swab.h> breakage by
 pinning linux-libc-dev
Date: Wed, 13 May 2020 18:51:27 +0100
Message-Id: <20200513175134.19619-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513175134.19619-1-alex.bennee@linaro.org>
References: <20200513175134.19619-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Salvatore Bonaccorso <carnil@debian.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Linux kernel commit d5767057c9a [1] aimed to fix an issue with the
swab() declaration, but doing so it introduced the BITS_PER_LONG
definition, without using the kernel __ prefix, leading to odd
failures in userland code using kernel uapi headers, such:

      CC      block/file-posix.o
    In file included from include/qemu/timer.h:4,
                     from include/qemu/timed-average.h:29,
                     from include/block/accounting.h:28,
                     from include/block/block_int.h:27,
                     from block/file-posix.c:30:
    /usr/include/linux/swab.h: In function `__swab':
    include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evaluates to 0 [-Werror=undef]
       20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
          |                                  ^~~~~~
    include/qemu/bitops.h:20:41: error: missing binary operator before token "("
       20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
          |                                         ^
    cc1: all warnings being treated as errors
    make: *** [rules.mak:69: block/file-posix.o] Error 1

The issue has been fixed in Linux kernel commit 467d12f5c78 [2].
Some distributions already backported the first commit, but still
lack the second one.

This is the case for Debian Buster.
The linux-libc-dev package contains the Linux kernel headers.
Kernel commit d5767057c9a has been backported in package
commit 1fb0eb7956 "Update to 4.19.116" [3], see debian/changelog:

  +linux (4.19.116-1) UNRELEASED; urgency=medium
  ...
  +    - uapi: rename ext2_swab() to swab() and share globally in swab.h

The previous released update before it is debian/4.19.98-1,
released as debian/4.19.98-1+deb10u1.

We can find this package in the Debian snapshot archives,
luckily archived on 2020-04-28 21:20:54 (see [4]).

QEMU use Debian based Docker images for most of its cross-builds,
which are tested by our Shippable CI jobs. The current broken
package makes most of our CI red. We can kludge this by using the
latest package released before the breakage. Do so by pinning
the package version (apt hold), and using the snapshot archives,
similar to commit b4048a7cd1.
We'll revert once the fix is backported on Debian.

Reference to commits:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5767057c9a
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=467d12f5c78
[3] https://salsa.debian.org/kernel-team/linux/-/commit/1fb0eb7956
[4] http://snapshot.debian.org/package/linux/4.19.98-1%2Bdeb10u1/#linux-libc-dev_4.19.98-1:2b:deb10u1

Cc: Salvatore Bonaccorso <carnil@debian.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[AJB: dropped pinning]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200513120147.21443-1-f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian10.docker | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/docker/dockerfiles/debian10.docker b/tests/docker/dockerfiles/debian10.docker
index 0769700a416..58b23117240 100644
--- a/tests/docker/dockerfiles/debian10.docker
+++ b/tests/docker/dockerfiles/debian10.docker
@@ -9,6 +9,15 @@
 #
 FROM debian:buster-slim
 
+ # Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
+ENV DEBIAN_SNAPSHOT_DATE "20200428T212054Z"
+RUN sed -i \
+    "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian/${DEBIAN_SNAPSHOT_DATE} \2%" \
+    /etc/apt/sources.list
+RUN sed -i \
+    "s%^deb \(https\?://\)security.debian.org/debian-security/\? \(.*\)%deb [check-valid-until=no] \1snapshot.debian.org/archive/debian-security/${DEBIAN_SNAPSHOT_DATE} \2%" \
+    /etc/apt/sources.list
+
 # Duplicate deb line as deb-src
 RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
 
-- 
2.20.1


