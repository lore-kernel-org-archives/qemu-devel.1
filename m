Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41A9C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 07:58:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FBF120409
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 07:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBF120409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH0vr-0008DW-Lx
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 03:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jH0vK-0007nS-Lr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 03:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jH0vJ-0001iO-LL
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 03:58:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:48317)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jH0vJ-0001hW-D9
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 03:58:01 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MZTyo-1imsd63Z02-00WX7J; Wed, 25 Mar 2020 08:57:59 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user,
 configure: fix (again) syscall_nr.h dependencies cleanup
Date: Wed, 25 Mar 2020 08:57:57 +0100
Message-Id: <20200325075757.1959961-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W7r4l6LmJ0U3Yk5M1D9CPPm10ZVmS2pIXFZdq7IlZ4D+XMziJe+
 loM8VlFh5w9QE3r55aDxUMnH9RTx0r6itWrP5Ki9anLTdlz+eTm68AEzXdbj32QYW98GSjF
 ryXUOg5e2Lx3ZlPUBjRghwqxtc90nSj/Av/Z5TvEfVh0COuVYpOGSxML5K+MCIHTNOR8D2D
 KY3UjpcOBjVXPGJUGWSmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gl2+vzbG23I=:XCg4KQ7Jz/OUsmKM7a9c40
 6CF5lqFRzYjYIEgFscSEohEGe9nKx0Qiy09Cf4PHeNmyWii4RoXwLAO2H5lniMQyvx/pHmbUM
 nWnHJ4GxG/rY2wjjVDUN1uSUsSRxTnaS23jh/5+mG/bt8sGh/Ysf2HNrXWGV/D5PjPq0DHjES
 VLhIAj+dmx2bkKVqj3Ra7zo4F/A/yqLgwv9SMx5F6O5Q4/ZwCSsu5a1YIxh2/P+eVLbyGr5yL
 oFZNoZZDOl2Y+plr4ZNiWzL4/rhmn/6CXuPTEqswfqHo/IlE8jPsZEylm/L4skXzJ+X4Fk4y7
 v4VdRRDjLPKKYahtWldfd6FB/XiOOk8dob50WK0CDg6GH6Zzev9Z0X8EF8BiC9RO0QMb9EKS6
 h/ct3OW8uoSNI9r3+UPUvXP6xGeSwXnbDSp208zl2vGVrmBtL2oy1m5j8BiiDt0ysHifc6wh1
 wsSyF2xJ/N8y4N4Npv+mJu5a92ojlGdMBo27aVxepuJg9RF/u9ozwU8wSv3ttzDFBv77jmGhg
 JDI2oXkHJemLNwALoULH2SahbUzp//5oHLwpdzY6BwFnTXNTHtSW3yEg8GJ83UnL5uucp0Go9
 Z/nFM//0GrFwUuusm3wGLC38xb5oFTIA/ATFwTjcUay53AhaSn/b/38diGetK6pmUmi6HI5Eu
 jxoZ+HbDxx3lfmQIvF1uns1qc37RqYYdYRqDG7g1q5jY3+WG5wNZCKRUSzgiDETBOV7GkoyPP
 GhnhhCN6hQ9spVggkfmB4Ch311JCbkFtEgx2e7rXhicO8tyoIvkNSNlxayvxeSVuhRluMvPdy
 Tr4vVjaC+me6ZuibB5ZUQj4r2A2HbqBeCfPD2pj4AEkZn6zjB+QYhEO6R6fFaPeLS0G8SXb
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes two problems:
- it cleanups linux-user variants (for instance ppc64-linux-user
  and ppc64le-linux-user)
- it removes the .o file when it removes the .d file, otherwise the .o
  file is never updated

Fixes: 5f29856b852d ("linux-user, configure: improve syscall_nr.h dependencies checking")
Fixes: 4d6a835dea47 ("linux-user: introduce parameters to generate syscall_nr.h")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index da09c3589572..89fe881dd46f 100755
--- a/configure
+++ b/configure
@@ -1910,9 +1910,11 @@ for arch in alpha hppa m68k xtensa sh4 microblaze arm ppc s390x sparc sparc64 \
     # remove the file if it has been generated in the source directory
     rm -f "${source_path}/linux-user/${arch}/syscall_nr.h"
     # remove the dependency files
-    test -d ${arch}-linux-user && find ${arch}-linux-user -type f -name "*.d" \
-         -exec grep -q "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
-         -exec rm {} \;
+    for target in ${arch}*-linux-user ; do
+        test -d "${target}" && find "${target}" -type f -name "*.d" \
+             -exec grep -q "${source_path}/linux-user/${arch}/syscall_nr.h" {} \; \
+             -print | while read file ; do rm "${file}" "${file%.d}.o" ; done
+    done
 done
 
 if test -z "$python"
-- 
2.25.1


