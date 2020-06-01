Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B30DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A42D206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5oWOZM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A42D206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfn6o-0006e8-BK
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5K-0004z6-Bm
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:46 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5J-0001VC-Pz
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id x14so432594wrp.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+3b+5SquQNrYRWCky6Vcuzoplfy5gaB+l1kP79OUD1M=;
 b=J5oWOZM4c5aVx2F2tZ1RUBaqy7KDLXKVPtA7yJfqwE6ZHbeKuQ2eHT9+qQHug2UGh1
 ys3YCilOQCdZtFkVcRqqt3Q0eTU9JTIXv+lwSkLV2g7v7HsehpMC7CRto4JV0iVICndT
 YvZFla64gpfVVwzS94GTY3glQjPrXhwWODkzdYWoU4iovu3iBoHu/xlSpJyfuO+AH6Lh
 ypBes4kY432xORByFcNXd+APiLan6Uu8kcF4PGG3xzjaXtTvLSA7V3LvU58vdorD42O5
 RDEpWUQQiOZg3qSvERsDPQT1ErponkTUKUgsIy6ha9DnLcq+UZANvnIbeDTzkd3ueMF2
 u2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+3b+5SquQNrYRWCky6Vcuzoplfy5gaB+l1kP79OUD1M=;
 b=aNVnGSiaVMQbMaxMz7AIWcSlY3Al87SQ8dJQTaSU426YRpQ5P/ahETxFhYC+jb8QvD
 t+LyBOmde0dEpA3XX+vS7ADRjvhWRhubd2OlnQv/x8Vu4ossQ//f77VpcbRcQWZ6DfqC
 kBzdCSxrpvotZzWKhUExFSPKBhgr0jLQOSclF0X9SAxZz7xVAZmkyN7XzgXVCafsPF3d
 1WKt/2OOjsU1ES741XTp73RV60Ih2oBS6tpYYhgHvnOVKHuS5mEIZ9ReRQPbJS2Kk79m
 otCQcYOHQicbrvWoJAPR2IxC3l+JZ6mvHk8g39jD8AfQ2l3o571apcP6HoIKYfZG5PwY
 uWsg==
X-Gm-Message-State: AOAM531d3/2Qf8J/07eB6aD4Yyigfskd4jeuUcieeuwdJszHih3/At+Y
 yqjld7vcSs8jEINLTyfQD7UpMU10
X-Google-Smtp-Source: ABdhPJxSYllWxLaqx72g79D3rLgGptETz7/EQaTl6UaHubhRC4XbQoUWtIa0M1Hlscgmj33Zzgxj5w==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr22296411wrr.365.1591028084575; 
 Mon, 01 Jun 2020 09:14:44 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:14:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 01/12] target/rx/cpu: Remove unused headers
Date: Mon,  1 Jun 2020 18:14:30 +0200
Message-Id: <20200601161441.8086-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601161441.8086-1-f4bug@amsat.org>
References: <20200601161441.8086-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x433.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/rx/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index d1fb1ef3ca..0645ba3b6f 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -19,8 +19,6 @@
 #ifndef RX_CPU_H
 #define RX_CPU_H
 
-#include "qemu/bitops.h"
-#include "qemu-common.h"
 #include "hw/registerfields.h"
 #include "cpu-qom.h"
 
-- 
2.21.3


