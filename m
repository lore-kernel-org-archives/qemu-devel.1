Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D647C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C31E20772
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIcoBpgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C31E20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgSfr-0006xi-Cf
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 08:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgSej-0005eB-Um; Wed, 03 Jun 2020 08:38:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgSej-0006Od-3z; Wed, 03 Jun 2020 08:38:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id e1so2197099wrt.5;
 Wed, 03 Jun 2020 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dghhn3CcrA48NqWRKIW/ElguQkiStlFvKybxs/jclLk=;
 b=vIcoBpgRnNYQXxduYDU/yigJ9tzHLJzZ/hLoGuohdmEGk+EdhMJDm1oQXsu1imEcu3
 N7xNlVHuUtsqHlOsRpxhZ5hKr0MOcwTBS+ABkpVOiWu/fHzfT9jgJyv+OYCU+YsrWMDG
 CeoJyP2ooACTiq7B1yrB8mIOMrljJhgSidngqliKelLuZ1J4tr+QZE4GSWOfuRKIolh/
 hBWRjEwGO6fVwhPQBebmyZl6ctNhxzmCZy/VOAgxblljsXrcyXpVPy1p9EAbRY8FFMLB
 hjJlBoeZMhMPfjF5NlE6JwHaObRn2Gy6gNpi65YPNXJ8H9iTRC1CbxtoJhQ/uembp7xm
 dFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dghhn3CcrA48NqWRKIW/ElguQkiStlFvKybxs/jclLk=;
 b=NDKwZsZBDSf7ewB7/raMMHG77CelbU7gQrYLhnffhbmw0qjBl9G82/00Ujg1vFziwX
 6DhERl1ADLWPkNnHHBn0DpeBLLwwzlcPKVfQFOztXIx1dKx8c7yf+9Eiqz4yaH59gv3J
 HEf0liWyMU4Yu+OYlkXMbEqoQKhMwcOYu2k+UVpZMKO903zh7aMXcs6rn+KGmCf9933y
 CU/PvfNsrB3BCsTmtrdVcE0yTY4m6cil7zlREs4V+hp/X+Fxet7LWKQ/1jRmHgdaQ/UZ
 yrxs/Aapgng41mDBkBHgXmVCdzIl2D44EDyw5sIUkGJwtmlHSdjFoURIfD+AeGF1hKWq
 z87A==
X-Gm-Message-State: AOAM532kQQ9R++yEtNOnLamAchnMgJSKRKB1j9ExrZICWD0dOJhCqBVO
 wnjWZoewSH2CaS1XomczUt4F5gCO
X-Google-Smtp-Source: ABdhPJznNv8XI6qbX1kfPUmlPHDsXizSsqgyf0wSEvFABUvhiILRLw2juVeEUDWZ7KV/rBhIjC4hDA==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr33318660wrt.219.1591187881371; 
 Wed, 03 Jun 2020 05:38:01 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id r5sm3370983wrq.0.2020.06.03.05.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 05:38:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/unicore32: Replace DPRINTF() by
 qemu_log_mask(GUEST_ERROR)
Date: Wed,  3 Jun 2020 14:37:53 +0200
Message-Id: <20200603123754.19059-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200603123754.19059-1-f4bug@amsat.org>
References: <20200603123754.19059-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace disabled DPRINTF() by qemu_log_mask(GUEST_ERROR).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/unicore32/helper.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index 53292ae311..00371a7da6 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
@@ -106,8 +107,9 @@ void helper_cp0_set(CPUUniCore32State *env, uint32_t val, uint32_t creg,
     }
     return;
 unrecognized:
-    DPRINTF("Wrong register (%d) or wrong operation (%d) in cp0_set!\n",
-            creg, cop);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "Wrong register (%d) or wrong operation (%d) in cp0_set!\n",
+                  creg, cop);
 }
 
 uint32_t helper_cp0_get(CPUUniCore32State *env, uint32_t creg, uint32_t cop)
@@ -153,8 +155,9 @@ uint32_t helper_cp0_get(CPUUniCore32State *env, uint32_t creg, uint32_t cop)
         }
         break;
     }
-    DPRINTF("Wrong register (%d) or wrong operation (%d) in cp0_set!\n",
-            creg, cop);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "Wrong register (%d) or wrong operation (%d) in cp0_set!\n",
+                  creg, cop);
     return 0;
 }
 
-- 
2.21.3


