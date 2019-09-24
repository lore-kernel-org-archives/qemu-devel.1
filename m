Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E3DC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A412146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVL0t1+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A412146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtMS-0007Db-BC
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs55-0003Eg-Sj
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCs50-0007YP-7k
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCs50-0007Y0-18
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:10:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id l3so3651598wru.7
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1FxA19EJXqVzVVxV/lcD510kd0tyA3qdkBCm+GGbDgQ=;
 b=DVL0t1+tO/Ad3+NukDmIl5kvHylGLVOpyJbTjwOpYMVBn5hzihQgWcsI2/gNI034nQ
 1Tr2b61H3r8gZMEZ4kUBCHkZ7p6jjZ3mGHgdu4cSlE5sKBy74u/b88RUTNr8jt7sMIAZ
 ooeUcHyasAA07I04tA0QGXhRRL9tOcxnQKz6f3dwQtQu2j7yhx0r+/OcmWLoGM/ZMhN7
 MeyFMgc0NOZ+L3zW68UxmbWq2jL2rWajMB935yho82IinPawwC2Y7IRXP+gBRXQO440X
 7J2Sy4s8smmFe580rpxJsC9tCRlJ9yHwyaA9vmP11eUZBSfNYJrI0aGqghD2kl+RbveB
 ax/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1FxA19EJXqVzVVxV/lcD510kd0tyA3qdkBCm+GGbDgQ=;
 b=X5Lv892N/ZF2+mL3/oLssJ8KAAaYp9ljHlQYeyfASsyT30xTflBJjvgZmMPjLwdGbF
 BgIoQw90TkKTe8p0yHQ1iPCv/I6NyvpArBTVbFcob6GSiN5sI1riTB/c3WTg5y3tc/x6
 BNJszIH+jCi3J6i1f5F2J3mW+qgE4gGSc4QpQ1xxQl0o6hRajaMQoWytfJ3FMsK3GCl/
 tKAXUAy+4oHwDilV1bmk/aeoYopXJU9kCahtTKWexLa2z0rxwjmSkgY/RRQ5k4hFMgHx
 DVJnvaFNK0t4wQ6tdW5+vo6JrEFsvnjF7vTRbITCs90KvgNjechkqr2UImlK5+5tQqw0
 aJZg==
X-Gm-Message-State: APjAAAUUHATi22sN/AUfhQuy6xcz8i10HAQnF7PAnVZYZxqx7jecQ6Jq
 5b2ynjSxclkYWbuVJugL0Tj67w==
X-Google-Smtp-Source: APXvYqzUqZJKwobhZT3O3PHP52J2ZDYSf97faidyeBFEdhpAc0GreYlpWU3vhtV0b5zQ1QkQOmFfvA==
X-Received: by 2002:adf:ee4a:: with SMTP id w10mr4516271wro.138.1569359436991; 
 Tue, 24 Sep 2019 14:10:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b194sm1223084wmg.46.2019.09.24.14.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:10:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A3D31FFAC;
 Tue, 24 Sep 2019 22:01:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 24/33] target/i386: Fix broken build with WHPX enabled
Date: Tue, 24 Sep 2019 22:00:57 +0100
Message-Id: <20190924210106.27117-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, f4bug@amsat.org,
 jsnow@redhat.com, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilias Maratos <i.maratos@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The WHPX build is broken since commit 12e9493df92 which removed the
"hw/boards.h" where MachineState is declared:

  $ ./configure \
     --enable-hax --enable-whpx

  $ make x86_64-softmmu/all
  [...]
    CC      x86_64-softmmu/target/i386/whpx-all.o
  target/i386/whpx-all.c: In function 'whpx_accel_init':
  target/i386/whpx-all.c:1378:25: error: dereferencing pointer to
  incomplete type 'MachineState' {aka 'struct MachineState'}
       whpx->mem_quota = ms->ram_size;
                           ^~
  make[1]: *** [rules.mak:69: target/i386/whpx-all.o] Error 1
    CC      x86_64-softmmu/trace/generated-helpers.o
  make[1]: Target 'all' not remade because of errors.
  make: *** [Makefile:471: x86_64-softmmu/all] Error 2

Restore this header, partially reverting commit 12e9493df92.

Fixes: 12e9493df92
Reported-by: Ilias Maratos <i.maratos@gmail.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190920113329.16787-2-philmd@redhat.com>
---
 target/i386/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 0c15241ae49..def0c284801 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -18,6 +18,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/runstate.h"
 #include "qemu/main-loop.h"
+#include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
-- 
2.20.1


