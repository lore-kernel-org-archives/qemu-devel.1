Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B07C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC20A207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 20:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIFiVkvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC20A207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdgO3-0003LN-TV
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 16:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jdgNN-0002bV-MS; Tue, 26 May 2020 16:40:41 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:44161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jdgNM-0005Bd-4E; Tue, 26 May 2020 16:40:41 -0400
Received: by mail-ej1-x644.google.com with SMTP id x20so25247920ejb.11;
 Tue, 26 May 2020 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=wIVSx8nuFV0C/ZwGcJt2YLvwEDbKDhleCMhZsPUzjfY=;
 b=dIFiVkvlrBsqp6mDY8MwaicIuBSA27u9IHzh1o9+6k3GFKAfeM+lh1AiXZjutbIjhj
 Ro8sGQG9hyfl6Ld08Z1/tpg6NmJF6aeNsqfW8FVfqsTzzG7ro1mtDVKeoNbUjIRivsci
 q4ctuK3GNOeGxf36ZKTpP8gb5z/r1Oz016AzHwDYueV7StkOdTipy4A6AU8OI9jS1cl3
 R+5iZsvHOUMBZnoCPBYDbhgZM+9HN5CCz8L8KrtHcx+ed24Tp3OlqLDQouVOoBFw3yHm
 E66978vRpOldaC6GZtf9gbGO/jSxJYKtucKxPLJlOEkjAOT4NK4kR/5XJDr3p+tcqagL
 q1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=wIVSx8nuFV0C/ZwGcJt2YLvwEDbKDhleCMhZsPUzjfY=;
 b=J3CS+vhqxqxYijSG4xr3tiBE7exRYSKmMfGfvGOo4jV3hm3SSvl7EC+xyAnEZdORDs
 arA+xu0aIb66xaSuA70lKkJQpVYfCEmhwEp7nj9FheGOM1d7jyixG45DbfViK8D+Kphe
 5uJuVjC/6x1sxZwMPC0BSWq+9xKUIGSw3oLTA+KSveowFAgDuaDElzaFiz+C/2sPZXuk
 HwQDMQEZtx015vIiRYXPkr5QbnLJCgVUn7xyLqsm62oLVuUl87AvDHAupvQRg2JDuFit
 fZrDK/xdubJRAzcJcsHs9mzpO+AEgJm709MFPvnvM0KpdDm3NEAESwq3TALBwIBxGNer
 Mdeg==
X-Gm-Message-State: AOAM531DsV8UNJLPiv8aCkzoQNG8OnuRAEWOAixx/K9jTT9YvoB5PIVF
 Td1DNarCwBwlopAjvq5Z+JRUkNIippSmQ0IXcJh4/rPy+MA=
X-Google-Smtp-Source: ABdhPJz0FjjNinoGNLHCdNwJtvEC58jETArNtwLJswN3j7CR5NUwxr1waY8c4R/bP/3jID8BCai6bOweCxZVNCSMtGA=
X-Received: by 2002:a17:906:3481:: with SMTP id
 g1mr2541665ejb.530.1590525638120; 
 Tue, 26 May 2020 13:40:38 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 26 May 2020 21:40:27 +0100
Message-ID: <CA+XhMqwH6btbKFD0Ei47e+QHN2eBPG5H2PTS92MAje2Tij4Y=A@mail.gmail.com>
Subject: [PATCH] util/oslib-posix : qemu_init_exec_dir implementation for MacOS
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From b24a6702beb2a4e2a9c1c03b69c6d1dd07d4cf08 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Tue, 26 May 2020 21:35:27 +0100
Subject: [PATCH] util/oslib: current process full path resolution on MacOS

Using existing libproc to fill the path.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/oslib-posix.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 062236a1ab..96f0405ee6 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -55,6 +55,10 @@
 #include <sys/sysctl.h>
 #endif

+#ifdef __APPLE__
+#include <libproc.h>
+#endif
+
 #include "qemu/mmap-alloc.h"

 #ifdef CONFIG_DEBUG_STACK_USAGE
@@ -366,6 +370,15 @@ void qemu_init_exec_dir(const char *argv0)
             p = buf;
         }
     }
+#elif defined(__APPLE__)
+    {
+        uint32_t len;
+        len = proc_pidpath(getpid(), buf, sizeof(buf) - 1);
+        if (len > 0) {
+            buf[len] = 0;
+            p = buf;
+        }
+    }
 #endif
     /* If we don't have any way of figuring out the actual executable
        location then try argv[0].  */
-- 
2.26.2

