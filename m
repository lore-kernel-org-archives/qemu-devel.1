Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54998C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:51:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7842C22201
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBX0zYKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7842C22201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShBb-0004cy-F7
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kShAg-0003U7-Cl; Wed, 14 Oct 2020 09:50:26 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kShAd-0008Vp-Sp; Wed, 14 Oct 2020 09:50:25 -0400
Received: by mail-pl1-x643.google.com with SMTP id d23so1792317pll.7;
 Wed, 14 Oct 2020 06:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=XrPbpA3GsHQpFZ8QbmSfSwsyiZnfpJ7jykZYqxiFtio=;
 b=bBX0zYKzTouAgyWSq3u34hh/PBe9/9N7O/TjFXvvOIarH0QJ/JipcOVGgDGJ8xWCNM
 zpcQ068HptwvgdKAgdmwLUD2kxd5Bsv4Mllwo6PpGovmun1IjNaKgtZYgeM01SrFipYI
 DEfqj31IH2Hl9urdPegSErFm2Qaz3O6X2Ju/nt/sj9d7f7Hwd1xb7V1P3OtOz8Mi10BI
 UT7eE24T8ka6Ju9nTBzD3tYeshhRl3a/mHgAa1BWBmJV0+2GFRe3i05B01a50TY9QNXD
 Wi7HZhSKkuRWi3mLdS1F1O+Va/Exzpe2PjinnZqb04hmcXe3DL4XSGE2p5aeQCc38EDK
 h4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=XrPbpA3GsHQpFZ8QbmSfSwsyiZnfpJ7jykZYqxiFtio=;
 b=RdE+uEGfFMmKb7bv1Gmz5pDF+yyC928BlTu87ZmMo0rPFdaUg4L01t0TcMcI4LRetz
 YDaSMrtwQcCVJN3T6+Q6Iv7cQe4ktyhz6iAgxrfhYkYDtaUzjRhARx2clP4Ua6yWZnfG
 kDZ7D8Q4GpOlZJDxFm/FMK5ljWxmeYwvnU+Eoxtp6dG8PkfZncGE8LXJBrfFkpiyfVWi
 xUkX7Nz+3nR3Y8MtZfs/uV6NjUsx+XAlSystAFfgMvyQf/s/4mhGZR/Mh6eTgsIiuXrn
 zsnFfiGXuAYClMOxANLPcdB3FQkrwO+POiDWldZBaI3aN7V3a906OeArqwqPOdy2glTC
 s2rQ==
X-Gm-Message-State: AOAM532L5ABSTErAD+vFN8Sy/6lLSdDP76BE9sNUAcEy85Vcyzvu2l2e
 qwYjt86AtT9ZeuYlkAuUx1v92u4N9We8WX/2
X-Google-Smtp-Source: ABdhPJxpaJ6u3LmKINTH+xD8RiJV03Uhwpv5WNIi1Ar0YUAWEr85nTgvym4ZpmGC1E07mJcUFDdpVw==
X-Received: by 2002:a17:90a:9313:: with SMTP id
 p19mr3634272pjo.90.1602683421240; 
 Wed, 14 Oct 2020 06:50:21 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id s10sm3434578pji.7.2020.10.14.06.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 06:50:20 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 4/30] authz: Fix Lesser GPL version number
Date: Wed, 14 Oct 2020 13:49:02 +0000
Message-Id: <20201014134902.14291-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=chetan4windows@gmail.com; helo=mail-pl1-x643.google.com
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 authz/base.c                | 2 +-
 authz/list.c                | 2 +-
 authz/listfile.c            | 2 +-
 authz/pamacct.c             | 2 +-
 authz/simple.c              | 2 +-
 include/authz/base.h        | 2 +-
 include/authz/list.h        | 2 +-
 include/authz/listfile.h    | 2 +-
 include/authz/pamacct.h     | 2 +-
 include/authz/simple.h      | 2 +-
 tests/test-authz-list.c     | 2 +-
 tests/test-authz-listfile.c | 2 +-
 tests/test-authz-pam.c      | 2 +-
 tests/test-authz-simple.c   | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/authz/base.c b/authz/base.c
index c75bce3..f2b7fbe 100644
--- a/authz/base.c
+++ b/authz/base.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/authz/list.c b/authz/list.c
index 28b9909..0e17eed 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/authz/listfile.c b/authz/listfile.c
index cd6163a..c9dd116 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/authz/pamacct.c b/authz/pamacct.c
index c91593b..e67195f 100644
--- a/authz/pamacct.c
+++ b/authz/pamacct.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/authz/simple.c b/authz/simple.c
index ee061e9..18db035 100644
--- a/authz/simple.c
+++ b/authz/simple.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/authz/base.h b/include/authz/base.h
index eca170e..b53e4e4 100644
--- a/include/authz/base.h
+++ b/include/authz/base.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/authz/list.h b/include/authz/list.h
index f73bc5c..7ef4ad4 100644
--- a/include/authz/list.h
+++ b/include/authz/list.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/authz/listfile.h b/include/authz/listfile.h
index 51824f3..0a1e5bd 100644
--- a/include/authz/listfile.h
+++ b/include/authz/listfile.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/authz/pamacct.h b/include/authz/pamacct.h
index d05c18a..592edb2 100644
--- a/include/authz/pamacct.h
+++ b/include/authz/pamacct.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/authz/simple.h b/include/authz/simple.h
index 9f5b979..c46a5ac 100644
--- a/include/authz/simple.h
+++ b/include/authz/simple.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-authz-list.c b/tests/test-authz-list.c
index d80e6a6..5351992 100644
--- a/tests/test-authz-list.c
+++ b/tests/test-authz-list.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-authz-listfile.c b/tests/test-authz-listfile.c
index 26166b6..64d0e15 100644
--- a/tests/test-authz-listfile.c
+++ b/tests/test-authz-listfile.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-authz-pam.c b/tests/test-authz-pam.c
index 02bb149..1baeade 100644
--- a/tests/test-authz-pam.c
+++ b/tests/test-authz-pam.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/tests/test-authz-simple.c b/tests/test-authz-simple.c
index d21d43e..6f9034d 100644
--- a/tests/test-authz-simple.c
+++ b/tests/test-authz-simple.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


