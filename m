Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A91BC43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 20:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C9120738
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 20:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq9md4tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C9120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEeu7-0001GX-Vw
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 16:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEetY-0000jI-BZ; Sat, 05 Sep 2020 16:34:44 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEetW-0002gF-J3; Sat, 05 Sep 2020 16:34:43 -0400
Received: by mail-pg1-x542.google.com with SMTP id j34so705556pgi.7;
 Sat, 05 Sep 2020 13:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jb0C5wKZBYHTJl4NG7AvTp3blaclsoguhzCBKfU7DMk=;
 b=lq9md4tckFACMCxkow84Dj9OLVRGWIXEHt/dIqtHWEjKoCVZm1+c22mtLmHbPPGW4z
 l7LJLLQcRhJcV3yA37oAjV6ikYib80J0eurry2oDLjguuE+D1JmpdAoxD3HgtneJ4D7o
 99jHM1Nhlo3tYpCsyjhtoA96capqQmKKzO/fhc/OAuyPxpT3SCbcDQEhVohZfwFtiNi5
 BwB/5eT3Lgv6BD3hyLW9mmj9kMX/O3yW16/DU6PmdWkyEBLWJrob+3h/y4MuSm8gFCT1
 6o4Wx4wkOJXkFbnYoLMmCOYPlETp8l7CjVUUwzSgpZjJcPVoZKXzItRpoWmAKo2+Ur7Z
 xn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jb0C5wKZBYHTJl4NG7AvTp3blaclsoguhzCBKfU7DMk=;
 b=oQy/8GJapMgvxAe3LaTjvrwEduN+kLyqeuKZOoiZ8qMqsBBvX+QZ2c3v/DWPTqb4ZA
 vPj6PDXpzskTrU0LC3B69dihSiXq73LfEOevgRYdpmDFXwDNRRc5DhEDi53AjS40iewC
 ijrXXpRRRWYCRhGGoyRKFnCVSm/9+6oyeVEis+6JXA2c4atUxpUmdX35j/hMTdp4xgoe
 a7qdlOI7TahIh2kd6DPTsknBv5gE/KR4Sgj0Ie7KOs/G91XOMWZ9fG3ngzzbXKD7F15S
 8gXqiv30DL4CigZHlipyLYI15IUTW1WtsH55KWvyjO7FMWIPZrBwGVU7xIkpfciEMPvi
 HLQA==
X-Gm-Message-State: AOAM533ltLxaQhhxjTRtsk/k08QA71a2pSm51qvqd6Bd9fTTbUMTxcbp
 3EICGyrMCmLgspduNNafOVMqF+BrbeprRDpd
X-Google-Smtp-Source: ABdhPJxs9I4PtwAlvIiSB/OQPFbvAG4Gl5ngTKVlqEVWUUxJNIM0u0uYSbbWhENZjeBoVy8M63kSRA==
X-Received: by 2002:a62:e404:: with SMTP id r4mr13983300pfh.213.1599338079998; 
 Sat, 05 Sep 2020 13:34:39 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id
 x140sm10519518pfc.211.2020.09.05.13.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 13:34:39 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests: Fixes building test-util-filemonitor.c on msys2/mingw
Date: Sun,  6 Sep 2020 04:34:25 +0800
Message-Id: <20200905203425.1470-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes the following compiling error:
../tests/test-util-filemonitor.c: In function 'test_file_monitor_events':
../tests/test-util-filemonitor.c:620:17: error: too many arguments to function 'mkdir'
  620 |             if (mkdir(pathsrc, 0700) < 0) {
      |                 ^~~~~
In file included from C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/unistd.h:10,
                 from C:/work/xemu/qemu/include/qemu/osdep.h:93,
                 from ../tests/test-util-filemonitor.c:21:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/io.h:282:15: note: declared here
  282 |   int __cdecl mkdir (const char *) __MINGW_ATTRIB_DEPRECATED_MSVC2005;
      |               ^~~~~

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/test-util-filemonitor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/test-util-filemonitor.c b/tests/test-util-filemonitor.c
index 8f0eff3d03..b629e10857 100644
--- a/tests/test-util-filemonitor.c
+++ b/tests/test-util-filemonitor.c
@@ -23,6 +23,8 @@
 #include "qapi/error.h"
 #include "qemu/filemonitor.h"
 
+#include <glib/gstdio.h>
+
 #include <utime.h>
 
 enum {
@@ -617,7 +619,7 @@ test_file_monitor_events(void)
             if (debug) {
                 g_printerr("Mkdir %s\n", pathsrc);
             }
-            if (mkdir(pathsrc, 0700) < 0) {
+            if (g_mkdir_with_parents(pathsrc, 0700) < 0) {
                 g_printerr("Unable to mkdir %s: %s",
                            pathsrc, strerror(errno));
                 goto cleanup;
-- 
2.28.0.windows.1


