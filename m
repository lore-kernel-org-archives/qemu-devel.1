Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A086C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:24:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF7D20885
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8E2hshr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF7D20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLVQ-0006Ml-LQ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiLT7-0003nN-69
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:21:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiLT6-0005tb-Hg
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:21:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id q25so334642wmj.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 10:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZfSjGus2sNx7q9JWi00W5AqjcdebVWjFBicMmlBzMgU=;
 b=d8E2hshr7l6Gmm891uDwew8CbNJdtDF4aECgFfOK5tpc+b4Yec3UEYKf0Mv9/jmzjQ
 eyINXz5sm0p/AaFLvViKgxSmFV4CNWzPUYRTZZ+XCe0q5SBAO0kvyU+CeZnjR/TdUTh3
 pK81YLIaEVMHBUGnsk3/5i69vb4Q09NAhq1ZUYTGZo8z2ns0cejea5gk7FdI51dTeO7w
 2wQbSL0ldlotP08ei48Yf2uOYbgQeaH+eT4kI6YlkY53d+maiERYMEjwlovQjaKhTgtN
 leWCsY6z1YMqw4uFkjTJGbBRD4BtwEfdPHxayFwSJouM5UNJGhSZwKT7szqJh1SYhHTu
 nA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZfSjGus2sNx7q9JWi00W5AqjcdebVWjFBicMmlBzMgU=;
 b=sBQ6TQBjyU9NQnyUAv1LjijpAKeyaFcflfuuC14RpCrM0AhtvU9Tk/ds+akKOvcTL5
 bH9jA216Ql6ExGQCYTQ8/29Prz0rXT+8AivfjYyx6WhEjizsZs8fS0JvGtWn3DCm0EvG
 aBP8nQQf8MfFqgKYgZJb8+t+hW/mjaNve3SAKQjk11B+kRAAipMgmUS22swNbxKW/IK0
 3gjmnjzLvFqvduRm1E2sI09w6D5Vy/05NogfEs5pKrD+lNBmnB7YoboN8cuKZo3W9KHj
 bA9HQdp+MzSa6LgrupWpFj7cBVchPHqGzn0X0tz6oaqAyebRBxFL6+xfKHiMSDXQ/TVo
 +n9Q==
X-Gm-Message-State: AOAM532vPzsruJHJddHmDhMM/P2zw4RCY4F6bnSW/x9oqsByhU4FM/Sr
 xdFwOExgN7HhurLHpqaFdO8z37qm
X-Google-Smtp-Source: ABdhPJwCjn2PG0SRz6eKF7xkT+Tz7hofdr+a2BpMIu+qj1MOak7ZV4drCMqFhd+UZYNlHollI0xRgQ==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr411877wmg.68.1591636908008; 
 Mon, 08 Jun 2020 10:21:48 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id n23sm223618wmc.0.2020.06.08.10.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 10:21:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/sparc64/niagara: Remove duplicated NIAGARA_UART_BASE
 definition
Date: Mon,  8 Jun 2020 19:21:43 +0200
Message-Id: <20200608172144.20461-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608172144.20461-1-f4bug@amsat.org>
References: <20200608172144.20461-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NIAGARA_UART_BASE is already defined few lines earlier.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sparc64/niagara.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index ab5ef8c5b3..201fb05d50 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -68,7 +68,6 @@ typedef struct NiagaraBoardState {
 
 #define NIAGARA_VDISK_BASE  0x1f40000000ULL
 #define NIAGARA_RTC_BASE    0xfff0c1fff8ULL
-#define NIAGARA_UART_BASE   0x1f10000000ULL
 
 /* Firmware layout
  *
-- 
2.21.3


