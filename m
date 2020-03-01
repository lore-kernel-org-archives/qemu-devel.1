Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C9AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 19:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8325D214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 19:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6lUqXBq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8325D214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8U6u-0005PN-M3
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 14:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcfaracco@gmail.com>) id 1j8U5T-0004g8-5K
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 14:17:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcfaracco@gmail.com>) id 1j8U5S-0005VH-3x
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 14:17:15 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:44686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcfaracco@gmail.com>) id 1j8U5R-0005V7-Ub
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 14:17:14 -0500
Received: by mail-qv1-xf44.google.com with SMTP id b13so1399430qvt.11
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 11:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z5hv8NKRgwZBSYnKj83xWQNko+acePoToJbKL4ekO/Q=;
 b=n6lUqXBqWKcuvZME/0epxSx1ghHS36muuNYclYZmr5MMFNDmF3gsxFZf4+7PLGhwmh
 +2A782B73hdRzASzxd4msO3PzgpqP/FRpGEBX7HSjK1ekAsmyKyDolqtY1wVso/D5uwb
 V4rE6d+JKBuwPqkOvAJEVbo9vq5mbPf8zTB745dv1fIZsMQxsK4edgOljKycelIpZyr4
 vkBs9L/VTRFPIaYC9/F9eSkQiPppa7fuJSpwyRx+J0IS0oW6qv8lDZwW3yrGGelsiQF5
 R6a9K2l9KdHfe+DwQ/gNNtiBaANBsE8wM79c9JxtmpWtzAIyLEb6qF/LChpQDBRzcRh5
 wbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z5hv8NKRgwZBSYnKj83xWQNko+acePoToJbKL4ekO/Q=;
 b=PhFuLYw4Y8eGEfJb07JpL8YrVbHDHthHnTIApTsN1LnCzl1nhZoezXlVxhpM423ruP
 hSzOKgLssEKJc+udJpwPs8JvZg5ozVJwXlPsSvmJ9fBxAPhjTfhYKFea4LQE3ewvgpfc
 GKPL2I+sgufwT2aE7TpgieygSEQ1B1Gda6hYuOYbTJriJNk90n6zEwB2sU/gf11iuXLg
 htFP/qqX2nIymwEp40tjFvQxX0+oqFMB7hx9mSS/cwnIAb9XuYPDQVspSYXWDAlgZN94
 upL+WXtSXDV7FBfof8J7UDQHRTC0cCQuj6nKWGzVYBWsLw7swv0+V/L5qCHst0psn7KW
 Kdgw==
X-Gm-Message-State: ANhLgQ3RDcIGgQ7Gw9v96MliBI6AsOeJWKaGmT0WcpO3uWBBU0Q2GV68
 mc2iyXT7j3Yeu19vHv2KVvRl6eBm
X-Google-Smtp-Source: ADFU+vuOsX2bDdWt4G2SRXGnzoZSbEloa7V0jFu3pfO3IxHgN9ZEmhhepnXY1hyJASbcld8+i+A+bw==
X-Received: by 2002:a05:6214:294:: with SMTP id
 l20mr2509685qvv.28.1583090232664; 
 Sun, 01 Mar 2020 11:17:12 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7cb:f65:3196:5ed7:3478:df97])
 by smtp.gmail.com with ESMTPSA id
 w60sm8773171qte.39.2020.03.01.11.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 11:17:12 -0800 (PST)
From: Julio Faracco <jcfaracco@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] i386: Fix GCC warning with snprintf when HAX is enabled
Date: Sun,  1 Mar 2020 16:17:08 -0300
Message-Id: <20200301191708.18035-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When HAX is enabled (--enable-hax), GCC 9.2.1 reports issues with
snprintf(). This commit is checking if snprintf returns an error. This
is a simple way to avoid this warnings. An `assert()` boundary checks
were added before snprintf too.

For more details, one example of warning:
  CC      i386-softmmu/target/i386/hax-posix.o
qemu/target/i386/hax-posix.c: In function ‘hax_host_open_vm’:
qemu/target/i386/hax-posix.c:124:56: error: ‘%02d’ directive output may be
truncated writing between 2 and 11 bytes into a region of size 3
[-Werror=format-truncation=]
  124 |     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
      |                                                        ^~~~
qemu/target/i386/hax-posix.c:124:41: note: directive argument in the range
[-2147483648, 64]
  124 |     snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
      |                                         ^~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/stdio.h:867,
                 from qemu/include/qemu/osdep.h:99,
                 from qemu/target/i386/hax-posix.c:14:
/usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output
between 17 and 26 bytes into a destination of size 17
   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   68 |        __bos (__s), __fmt, __va_arg_pack ());
      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
v1-v2: Add assert() as Richard Henderson suggested.
---
 target/i386/hax-posix.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index a5426a6dac..dc777751d7 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -121,7 +121,12 @@ static char *hax_vm_devfs_string(int vm_id)
         return NULL;
     }
 
-    snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d", vm_id);
+    assert(vm_id < 0);
+
+    if (snprintf(name, sizeof HAX_VM_DEVFS, "/dev/hax_vm/vm%02d",
+                 vm_id) < 0)
+        return NULL;
+
     return name;
 }
 
@@ -140,8 +145,12 @@ static char *hax_vcpu_devfs_string(int vm_id, int vcpu_id)
         return NULL;
     }
 
-    snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
-             vm_id, vcpu_id);
+    assert(vm_id < 0 || vcpu_id < 0);
+
+    if (snprintf(name, sizeof HAX_VCPU_DEVFS, "/dev/hax_vm%02d/vcpu%02d",
+             vm_id, vcpu_id) < 0)
+        return NULL;
+
     return name;
 }
 
-- 
2.24.1


