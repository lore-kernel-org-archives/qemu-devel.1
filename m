Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47074C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134022476A
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBl8MMBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134022476A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmzRn-0002P4-BG
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOV-000584-Sc
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOT-0002pR-BV
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id o11so6293227wrv.9
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fCWXr6zHNQbQPJ8BLLwrAx76MymcZFD1NlfKOZXdkr4=;
 b=LBl8MMBRq0x5dvaPdSnIIewDS96clfQSoYg3vnOsVsowPfduFOAYyATDofVQjYG0DE
 LmJn8wxVL9uAdTifjjEV2My8jQXy25030TVvOIl+NasM+tOWz/lzg3BSRyngi9/2IE+I
 EZHHt8lzMxh7CImwBLpnBkNYWaA1lZbTIh+UNZuyXf4Pu9ImVU+3I9DrUf8RzByhGh2k
 Xe8rbGJJmbIlwtcwTCXOsjxbvJfFDVGn6VwxmNqybKQgQaRaEfRDD5bJtP28kcGBjtU3
 r8r8KHoPo8MMHpF7zyuyiVS8KDEE29lO7z/bd55937QiJWXIEA2Ydyt0e0oBj9ZtmoCS
 irIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fCWXr6zHNQbQPJ8BLLwrAx76MymcZFD1NlfKOZXdkr4=;
 b=q2ajPubXHmahjqN91ABx4VE1OEiWurSMoPrsOzXeJBLr6eOglwN+OLDa6QG67BkmdB
 oB9lJo6o4GbFFQCtRt+5h/bx075ZbUBScn5MRMd0BfggzW8rEApL+BYjDYTUq4OMBPn4
 7Ym6r1M9EmzJl2ImHM5InXfHiYlvinDWWktfiTsrcRAOpryqZoAccaRc14aSoDEYHNSm
 UcsC9JRRUyysZmUZ8fEokz+iKeoW7OhrrvSv88Q4crw9sH6XYB6a6WsoZ0/15RPF4Oke
 xl6FXQ50kg8gOKOE41UEHEIPi1HxJ73xVIu3i/CxEsRQXnDXS2xLTj3objeJZrQa+6e9
 fBmg==
X-Gm-Message-State: AOAM533fXSOyP3XPJ4DQhJL1g9uAOXdmixMZJt7E1n32Fx/hl19SehIX
 Vw5Dz12W/BSaFAYjZfVPEVdj+Myy
X-Google-Smtp-Source: ABdhPJwXJCl7mCBQ2lxvCGZeZXCvjoLf+Ht0pltqb6EZ3HCckBJQ0ZEkkYpKN+m0iEMKR4BKpab+3g==
X-Received: by 2002:adf:9525:: with SMTP id 34mr14398293wrs.313.1592743695879; 
 Sun, 21 Jun 2020 05:48:15 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o10sm13779362wrj.37.2020.06.21.05.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 05:48:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/15] hw/timer/sh_timer: Remove unused 'qemu/timer.h' include
Date: Sun, 21 Jun 2020 14:47:57 +0200
Message-Id: <20200621124807.17226-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200621124807.17226-1-f4bug@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove unused "qemu/timer.h" include.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/sh_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index b9cbacf5d0..bb0e1c8ee5 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -13,7 +13,6 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
-#include "qemu/timer.h"
 #include "hw/timer/tmu012.h"
 #include "hw/ptimer.h"
 
-- 
2.21.3


