Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E873C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 07:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DFF22073E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 07:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1zHY7lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DFF22073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhSrh-0000vM-8z
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 03:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhSqV-0000Lh-Gk; Sat, 06 Jun 2020 03:02:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jhSqU-0005qH-HV; Sat, 06 Jun 2020 03:02:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id d128so11138876wmc.1;
 Sat, 06 Jun 2020 00:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BvQnCtw0bk2oJaedpu6uFfPlSYmlAJJT7ebYcWgdZY0=;
 b=r1zHY7lpGd8nhcV6l6DvZK2UOQWCZQ+U21WlNEonDPRbvC3byrBVLB1lj9tBbG8V8P
 d5TjX42cS8b7cyIAa0z9bmJNGg93qyRMf44zM1d0dLwvVBQE9p67DDpybzdqRdiKL7/r
 ntDKUCKAVQybAzM9E1QCSXnH84J4Pkb1zQRyBie//lZ11gCh9zkg/u/kCoNmybOACg8z
 Uu65zCfHXCQ01hltTRQcHjCX9vJxcsvRgs54IbXD+voo9v/okWXbDBzQFwUeN5itygxK
 1ywnqWiDi3hn0GUtzrfMaxvNEm6yZx1AzdkgSV/2kUVHhTZkfOE0h3SiJqGvquHQXDt2
 xGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=BvQnCtw0bk2oJaedpu6uFfPlSYmlAJJT7ebYcWgdZY0=;
 b=rm8rvy6Pq0ARzYW5SCY3h7/DyhQypHdceQ6sa0bIXIgKkmXyOTUK9NWNT4jy/pfjJm
 ftlG6T5g69eaONB+WopKbKoCupmZhIe1l0pm0D1ekCcYF7YOHHjxassi/FWoHBeRYZFM
 SnLi5Be+xNbpowPR6L/Z5L6yiWb0lUagxohitVmsBNIHV8WPIlogwxoqiez0IvtrEP9g
 g6WUnvseAV4Q6Gsy+un+5i3Riseoat6hMEnnboMbwGrXsotgR3MT4VXsChkWTnMmyd6C
 /JMK8eKlWFdGtExpWbHbW8LqIz22Nahmk89CAJP2EAX8gFtqTPNZvHpDjNCYFCeRB4vC
 nAgw==
X-Gm-Message-State: AOAM531bgd7pCzB1hxYOPnKSTJ4eQLcjccsCUThC6Y7w45QU8QYC15rL
 ACsgHEUR11gtUHVuBgbbVJLXUAfe
X-Google-Smtp-Source: ABdhPJya5W1uzSme10bEYz5PpTRaOqHVPoc+IPcs9GfarQSQ9v23n36xl/mzmdlGMoeWqfs9SYycKQ==
X-Received: by 2002:a1c:24c6:: with SMTP id k189mr6539985wmk.9.1591426939095; 
 Sat, 06 Jun 2020 00:02:19 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id p7sm14826180wro.26.2020.06.06.00.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2020 00:02:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/misc/auxbus: Use qemu_log_mask(UNIMP) instead of debug
 printf
Date: Sat,  6 Jun 2020 09:02:16 +0200
Message-Id: <20200606070216.30952-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: qemu-trivial@nongnu.org, Fred Konrad <konrad@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace a deprecated DPRINTF() call by qemu_log_mask(LOG_UNIMP).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/auxbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index f8e7b97971..06aabf20c5 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -196,7 +196,7 @@ AUXReply aux_request(AUXBus *bus, AUXCommand cmd, uint32_t address,
         }
         break;
     default:
-        DPRINTF("Not implemented!\n");
+        qemu_log_mask(LOG_UNIMP, "AUX cmd=%u not implemented\n", cmd);
         return AUX_NACK;
     }
 
-- 
2.21.3


