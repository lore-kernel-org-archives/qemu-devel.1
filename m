Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73532C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 12:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38BFA2076C
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 12:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHuMesqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BFA2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcpT1-0003US-BA
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 08:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jcpSC-0002yQ-Em
 for qemu-devel@nongnu.org; Sun, 24 May 2020 08:10:08 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:36601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jcpSB-0001oh-0f
 for qemu-devel@nongnu.org; Sun, 24 May 2020 08:10:08 -0400
Received: by mail-ej1-x62f.google.com with SMTP id z5so17903847ejb.3
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=pE0544bVzAHxGzGtcjxA9Kb0Ph+uGGIchLw+MZDkglQ=;
 b=SHuMesqEHmtpHoj3ESyjoY/7neaIQ13bpBBwTkItAcpr6/LYobHB+865ADbw4fKTGP
 VVLTO3rkzMTLoQdSxxTWGLRmt5GnRAfWbkCdgQmav9o5lA++uQH4CNBu60zERwyTj57d
 Z7q8clky/w+JUcoyNXmNUhyNDHgUbGOqBVmZMq5zmTtYzs51QRw42j0nLKDSh0lhBV22
 wS5CQy8fLWJluR37NGwW5pwT8ezBmvqoinn0eYRuKePWxlXbzN/34GUEYMe9ut/gckln
 IDjHST1ZoZAdnt4mBrw7HG2m2RRUv/kxXprVTx0a//M/4kKDOK8U97vee/7ViupGrL0l
 ub+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=pE0544bVzAHxGzGtcjxA9Kb0Ph+uGGIchLw+MZDkglQ=;
 b=tB1vzNvvFbLC/63ShQoAintV4SvAM8Zt5mDbzlMV6tw70lUR+ZnR5Gr5K/hlXQafsB
 f2B1MKwInNCt9k5DwLyx27VtuxwSMsuS2l0aE9Ym7TgPbY55jTw/YU838nlK1a56amEn
 alszrhGpU1N4VfB8IuVNI8WLA2qhkati4m2TYqw3eZvQqpLSOAFv1I1p1eXp1dt3nzPr
 RCM6e+cvUWL6awDgQcQf77wZ+YZnEMy9HaQ71gp/pkg5BoCigfCIVtNCk5dWUemZQiGz
 7UoA5/w5Wy54qH0s1c2piSPln0yOygwCDKMhV8McIzE0iNGf9reTOQyrkvVbYR3U6IP5
 Axpg==
X-Gm-Message-State: AOAM530qJ4fdeYSRntqI/57dTbq0pnrpKPeUBe9xGVHOIJQsBpJvCRR9
 763kvlb9SfU/waPkownHsIJPEshcYNmkYVwodsLI+B/C6f4=
X-Google-Smtp-Source: ABdhPJz9awj134dG3XRkbPe3E++h0fN0PMkcIz/kAdr5tPmUmG1CzJMzlCSbeQ7W8EYY1Um6PxNTyZRaMB9hGls5l7c=
X-Received: by 2002:a17:906:7e56:: with SMTP id
 z22mr14628953ejr.60.1590322204329; 
 Sun, 24 May 2020 05:10:04 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Sun, 24 May 2020 13:09:53 +0100
Message-ID: <CA+XhMqyZ9yZjckTcYinCOYqb4ybE6z9vmgcJzue1WEGuZ0NTWA@mail.gmail.com>
Subject: [PATCH 1/1] util/getauxval: Porting to FreeBSD getauxval feature
To: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x62f.google.com
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

Hi here porting qemu_getauxval to FreeBSD. Thanks. Regards.

From 5be5e56a59631b28ed7b738d251dda252ba9b03e Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sun, 24 May 2020 13:03:32 +0100
Subject: [PATCH] util/getauxval: FreeBSD has a similar auxilary vector API

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 configure        | 6 ++++++
 util/getauxval.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/configure b/configure
index 2fc05c4465..545fd2364f 100755
--- a/configure
+++ b/configure
@@ -5824,7 +5824,13 @@ getauxval=no
 cat > $TMPC << EOF
 #include <sys/auxv.h>
 int main(void) {
+#if defined(__linux__)
   return getauxval(AT_HWCAP) == 0;
+#elif defined(__FreeBSD__)
+  unsigned long a = 0;
+  return elf_aux_info(AT_HWCAP, &a, sizeof(a)) == 0;
+#endif
+  return 1;
 }
 EOF
 if compile_prog "" "" ; then
diff --git a/util/getauxval.c b/util/getauxval.c
index 36afdfb9e6..373ed3899f 100644
--- a/util/getauxval.c
+++ b/util/getauxval.c
@@ -33,7 +33,13 @@

 unsigned long qemu_getauxval(unsigned long key)
 {
+#if defined(__linux__)
     return getauxval(key);
+#elif defined(__FreeBSD__)
+    unsigned long aux = 0;
+    elf_aux_info(key, &aux, sizeof(aux));
+    return aux;
+#endif
 }
 #elif defined(__linux__)
 #include "elf.h"
-- 
2.26.2

