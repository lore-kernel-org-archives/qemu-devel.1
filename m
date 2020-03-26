Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E129C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5091920714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 07:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5091920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMuD-0000GI-Dy
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 03:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jHMs5-0005K0-G4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jHMs4-0007si-BY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38897)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jHMs4-0007sD-3O
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 03:24:08 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFsER-1j1i5b3Vmx-00HQPR; Thu, 26 Mar 2020 08:23:57 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/6] linux-user,
 configure: fix (again) syscall_nr.h dependencies cleanup
Date: Thu, 26 Mar 2020 08:23:47 +0100
Message-Id: <20200326072352.2056553-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326072352.2056553-1-laurent@vivier.eu>
References: <20200326072352.2056553-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jd+OvPYm+kCNHyyetBI49o2wCmvezeSoNAwqDhb4dhN+/saLhiN
 LyyD9bLT83nAGtsW3D61EXTVYyJlDSi45hwJxHL0uSrbc33emzZ29w3MViD16WsXDKm3VH7
 0p4vMah7WKVCoxMZVPMaiaX89l6D4IxeLzJzhYNI8hSTeRv+IiAQVQw0QKyRbjajd9hlDQE
 v8b//KH2Xngvpru8pe4Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YQ6nJRH3Mp4=:GgGZMzynOawDE9hP8THjys
 4YkTEO3bTVFWHKNsAl7IjliTzKFH5R5ekAR6CkB+MSYS9ZhQY8jhFxdKQC7Gbi3qTvz5haipC
 nsx62wJk+GXnsTPl593tDfg3kzdfwN9Uqpwxf/6q08o3N/65aoy1p1UW+nAGxpEqETyoZLJEP
 KdOQtDAHpzSoth39jnPu8nUkbc3fjD1IUu5d793p3eu+N+hY+27HI8cXNmuh5eFIMbbzOSbhV
 q7x9XYe7EEnHsNEsExUjcA5GBkUxYfkb8rfGTeJXZt55/W4rgyie3gMIDui7zHbgt+GKnKFmF
 60v54tOjOiwzcDFTNeGy3ZJoYcf9iaNf+0YnSAF53OKmbcOdJcnIv/OcZm2tuYfGUXmyazEKl
 c1OJMT7pO3ubYkG/M1hsNnKe9NI1Upxzz4jsPdW1Mpvl1K6rlf4CWXDEnuR11hDDNhviHpytN
 8rzTg/FIsT3lW5L3uHPhuU7hisN0B4UuVZrMn3yROqqf/tyBs92VSO9ZKWzpVkLtHZF5/LBEl
 Df8S+X+EKGUIcS0rnPXcF3DxVc7aWRKKm8V5Y0YJ2srvrv37drjD6UP7t8wEpMS4419Nsvmgr
 O0qGuNZ43Ju6FCQIWLzBrwSxlk+/xbtwTQbN+KRKtwOznWOKbiHqXPcKJQ0N1aMdkUAdZkXh+
 gB5hLjqOV4/qCzh0PRA2WprKAFpqDUhuPgZs3jYjogsCMHW1voNfKYi5Vpr5LV9QmCOCcntOh
 iT8YdHn5SdAo1n9YfH6F4tQUf7D7O476yo6fYTi3PvIWKpKd1tT2L3birYKvNQhiH4yqlPS99
 aGdq1h/MFBQmomjEAAQ1905EN8lmbwKBEM8mp3mg3W8sdtnvwWr+eyLokVTSFDZ4HyuDhwL
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200325075757.1959961-1-laurent@vivier.eu>
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


