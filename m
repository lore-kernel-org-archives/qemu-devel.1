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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16EFC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7814206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+ZGx1cU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7814206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjzO-0008FI-Q6
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuZ-0000Pk-T0
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:59 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuY-0003uI-86
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:59 -0400
Received: by mail-pj1-x1043.google.com with SMTP id mw10so1063515pjb.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iUIJV0NrJHasWSyZnY8jh25seOv6g5EICBiDlFuRKr4=;
 b=V+ZGx1cU4OTfefyAApcuukQl4R7vN5YN202dFspHVkDeN4atRmT84tPnUf4xeYAAIa
 I+mVUzMGV0w3qTrNFn4JwaDQeBLInW2k07SzNOt3jAh0KWui0iqXy7clGiTj6Hd9ysEA
 EDhuZ9DV6Zlbyo+PcUVhiR/cspXLwAQwYWfXIK7i4VNwaAZs6EZk0FU5Iryi/GtxsI5c
 eTbi0s9UpJZqhBqnGvXMZwetX2ALCzcRdQJPOlOm419DnNOiqFTE2nT51n7K/A2yYHrb
 jPXF6yr0+2v7EKieQzK5frmTuDmqeXnRGErolA3Zfsjzxzg1/Pe+YjO1NxxsPRD800i6
 Hh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iUIJV0NrJHasWSyZnY8jh25seOv6g5EICBiDlFuRKr4=;
 b=NJ54UvRL7bi9gkbi+wNg14MtTbRtSi0q7875lt65fK6ky8jdewnwwo7cbX5alw6dz9
 8EDw1Z1Du7g1SJXcl3JM9+ufO7ew6/Q1ZT3qT+EoylKSmjI5jqwVQvJBCuOvqhSYmrEe
 syUBv3WCR59RHZ76ifak8oVqW+qgFLIZeL77ez6cPTUYwwqo7ytVKkve+c+NAizMRYOJ
 ggFmQF/V83TA16U1pDmPK9kJxq+gVz9DiEJyd1y+Qy1dne+oODNgdESzdfzqyHsTE4Q9
 MqI2PSFpcMoMR1yeJqdkO4DCgSypm2Lk6eI3kVI3Cd8f6XHy88db/6e1LslYCAyWOx81
 QlaA==
X-Gm-Message-State: AOAM533jFGZWRACIpB2Lpz4vLnKBCYdBkIJgF4YGi1SLreRtfewyv5gc
 lxF37vJN0/6HxzQ5OsLeq/piw/2XPyfKle2n
X-Google-Smtp-Source: ABdhPJyieuTP3xXoHaWWtLkYgv+toiYfOcMJ/F2wZzEn5itdl2Rkpwy6TLkWSE5O5ma8hcEs733b5A==
X-Received: by 2002:a17:90a:c255:: with SMTP id
 d21mr2126386pjx.212.1599119036513; 
 Thu, 03 Sep 2020 00:43:56 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id o6sm1512472pju.25.2020.09.03.00.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:43:55 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/12] stubs: qemu_notify_event have no need to stub
Date: Thu,  3 Sep 2020 15:43:10 +0800
Message-Id: <20200903074313.1498-10-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1043.google.com
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
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe: libqemuutil.a(util_main-loop.c.obj): in=
 function `qemu_notify_event':
C:\work\xemu\qemu-build/../qemu/util/main-loop.c:139: multiple definition o=
f `qemu_notify_event'; libqemuutil.a(stubs_notify-event.c.obj):C:\work\xemu=
\qemu-build/../qemu/stubs/notify-event.c:6: first defined here
collect2.exe: error: ld returned 1 exit status
make: *** [C:/work/xemu/qemu/rules.mak:88=EF=BC=9Atests/test-timed-average.=
exe] =E9=94=99=E8=AF=AF 1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 stubs/notify-event.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/stubs/notify-event.c b/stubs/notify-event.c
index 827bb52d1a..59935db11e 100644
--- a/stubs/notify-event.c
+++ b/stubs/notify-event.c
@@ -1,6 +1,2 @@
-#include "qemu/osdep.h"
-#include "qemu/main-loop.h"
-
-void qemu_notify_event(void)
-{
-}
+#include "qemu/osdep.h"=0D
+#include "qemu/main-loop.h"=0D
--=20
2.28.0.windows.1


