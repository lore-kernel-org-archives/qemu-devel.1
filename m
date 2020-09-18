Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E491C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1489E21707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhZGCoBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1489E21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKSu-00067I-2b
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 13:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKO0-0002oR-C0; Fri, 18 Sep 2020 13:41:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJKNy-0000Gs-Qc; Fri, 18 Sep 2020 13:41:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so6461840wrt.3;
 Fri, 18 Sep 2020 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UJjk8ZR/erxbnrLQ53sw18LTpiI4+fnfSdMDknbc4K0=;
 b=ZhZGCoBsfn+UONcYcwvkGlZcMK6BlUdKqbm+mhCYd58+/Eh4d9YE4vY92e8ZuFUA9p
 PiVzVankmaErjjOayyHAsMXkeNXysviLJKTv8r3Ge9wxeHJfToT+LqV1yNxlWlWa8I2N
 53zr5EhFIURU4kyDSn6hDMLLENamBoZBJzgdsq+JGm1BZBhcCcRKrlBVu9kJxlpYV+kp
 JK6Gd7hzv/+ZAniAekN4lr78Blr1y4vkYCIDZqG5pDHHhQUwpMnB2sqTI7tLeAc9Yg+H
 D25ug9cmDG7wlP+NUIqRvJ+wzjqUui5gdJW7uozVEprFL0/06YRSmb9/YwaC0YGjRjBE
 /2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UJjk8ZR/erxbnrLQ53sw18LTpiI4+fnfSdMDknbc4K0=;
 b=W1MWrTUegr23Em4m6jC35AIvEdLoudmHeeQQAoagh/2OpqTXOC/igymIZ3DiBgbFzK
 GV5fxllz6fswCGe3Lx7Bnwlwr0/4ToKDAqXgjel7YJOGWRfaA1EoTJFocMloz/HjHkC/
 BERKHNilJTQaPPNrP5mc4hABZibS+rVtYQWn+uONp8gl5qL8Oekphake+cg5ZksScS/E
 3zaQ2+5VjPLfLWHLZB8tf6WuCHTSqtB/Z58A3ebaGOu4bkUUNVLKNPf8jupqBn7N7bKi
 ty/AhEW/9yKF3BNIFu6G53Qaf6KWaVA5L3zgLvuYTopzle4qbXyQ4S4PN9xg8QKOuELd
 LEpQ==
X-Gm-Message-State: AOAM5330ARiP37TCcqVOEuQN6metJ1ntlENfyVuP56buivLESwrITwnT
 V0u4Lr6I8S2VLP/rw/RB4P6MfzromY8=
X-Google-Smtp-Source: ABdhPJznczTLAPC3R3Zkc7v6W/nZf8C8+osE5w7JYxVujdOV4cbj4HewTfP2XU27rIGGvsfaITRueQ==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr40631017wru.90.1600450885109; 
 Fri, 18 Sep 2020 10:41:25 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a81sm6356179wmf.32.2020.09.18.10.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 10:41:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 5/6] hw/sd/sdcard: Do not attempt to erase out of range
 addresses
Date: Fri, 18 Sep 2020 19:41:16 +0200
Message-Id: <20200918174117.180057-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918174117.180057-1-f4bug@amsat.org>
References: <20200918174117.180057-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While the Spec v3 is not very clear, v6 states:

  If the host provides an out of range address as an argument
  to CMD32 or CMD33, the card shall indicate OUT_OF_RANGE error
  in R1 (ERX) for CMD38.

If an address is out of range, do not attempt to erase it:
return R1 with the error bit set.

Buglink: https://bugs.launchpad.net/bugs/1895310
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ee7b64023aa..4454d168e2f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -766,6 +766,13 @@ static void sd_erase(SDState *sd)
         erase_end *= 512;
     }
 
+    if (sd->erase_start > sd->size || sd->erase_end > sd->size) {
+        sd->card_status |= OUT_OF_RANGE;
+        sd->erase_start = INVALID_ADDRESS;
+        sd->erase_end = INVALID_ADDRESS;
+        return;
+    }
+
     erase_start = sd_addr_to_wpnum(erase_start);
     erase_end = sd_addr_to_wpnum(erase_end);
     sd->erase_start = INVALID_ADDRESS;
-- 
2.26.2


