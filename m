Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB98AC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B435206E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crfxegqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B435206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDki8-0004Co-Ji
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfQ-0008Gh-Bx
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:24 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfO-0001Y2-Kc
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:24 -0400
Received: by mail-pf1-x442.google.com with SMTP id o68so1737445pfg.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6lmnRR0tZitC7JnT2Axu3G4iTyGoQuwXgZI7oqF9oeM=;
 b=crfxegqzLtzvHjQPbKaRnD7Mp7dr+VcWUlqSpgwL7RZ2P0Vwn/TrD+tfBl8qxj4HBw
 yetOpMB+UKcEkvPDi7Iu+xKW1cnqYd+rKVxLUvngqhB/2IY5+kIcXvsa/8mM1KxgMl9t
 We7gem8zwTvL68OR90zYZStmrJ1VWPayNll5KMsF+G46KQS9oNUUr1U4HtekcV+TvMxG
 5nkZwDN2tCqrZdwUWN8vd4bH1RuhDq3/bSESwKg46LncGUletuydcHQolEudATYJv5+7
 5zpI16PpNMvMx+T0gGyvhG1PErkQJVxynhME/dRmstEEJ9TAqcfy78mKOwip9nSmDPsg
 h7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6lmnRR0tZitC7JnT2Axu3G4iTyGoQuwXgZI7oqF9oeM=;
 b=miD6Cp3X6Wc/qG+spVHTNvLCgAPL0y5E/ITkGEFnyzl77BdEiarHxETsb3GaupbZdc
 7hRRbnCGYaPqVxhLdt95Ab3ygzJeAZeKXzEF2A5ZcvYd982/AYULnO+owYXfQFvqag0r
 0by2+ntaUoHhJGSeUl72HRIXPnCeUyXUE9uYcbjP8fBDCGaQZF8zrbgEfh7zSSmHJxVc
 CVzmdncEmKs2NHXcOWvGdrRjVxL4lb932pCgX04/qIqNUD/nNPYzY7Jn6B+6vKT+akYS
 wljeVxHD+8ysTQlkZfpwktmebbcybshRCOuo5Hz+r4OEudsitQoZe61WbaMQvZvlFx/s
 p+aw==
X-Gm-Message-State: AOAM530XHkuFxNVqwJvpJa6A37cULHYxRF9sIYLKhMqOLUVpfmYykcBV
 1QJPpYumPR3Bzy090+nk4hXrdMALJ1mpe3wh
X-Google-Smtp-Source: ABdhPJyhXcLybArxKbSoHg3/1IhdFcZhVLprmbIm1fCabTYO6htP4qYDSTJy20fLnIT40FzaSiO4mA==
X-Received: by 2002:a62:5fc4:: with SMTP id t187mr2819613pfb.34.1599121940947; 
 Thu, 03 Sep 2020 01:32:20 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id e7sm1759201pgn.64.2020.09.03.01.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 01:32:20 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/12] stubs: qemu_notify_event have no need to stub
Date: Thu,  3 Sep 2020 16:31:44 +0800
Message-Id: <20200903083147.707-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903083147.707-1-luoyonggang@gmail.com>
References: <20200903083147.707-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  LINK    tests/test-qdev-global-props.exe
  LINK    tests/test-timed-average.exe
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: libqemuutil.a(util_main-loop.c.obj): in function `qemu_notify_event':
C:\work\xemu\qemu-build/../qemu/util/main-loop.c:139: multiple definition of `qemu_notify_event'; libqemuutil.a(stubs_notify-event.c.obj):C:\work\xemu\qemu-build/../qemu/stubs/notify-event.c:6: first defined here
collect2.exe: error: ld returned 1 exit status
make: *** [C:/work/xemu/qemu/rules.mak:88：tests/test-timed-average.exe] 错误 1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 stubs/notify-event.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/stubs/notify-event.c b/stubs/notify-event.c
index 827bb52d1a..59935db11e 100644
--- a/stubs/notify-event.c
+++ b/stubs/notify-event.c
@@ -1,6 +1,2 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
-
-void qemu_notify_event(void)
-{
-}
-- 
2.28.0.windows.1


