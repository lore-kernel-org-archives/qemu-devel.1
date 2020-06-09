Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BCBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23532074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9/htUar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23532074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYtS-0001py-WD
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkM-0004F9-RG
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkL-0007Xy-Vk
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id y17so20042787wrn.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vkDRcgvL+D9VvdrCQbP1oNaPKjBqDOyIV9cIwQ5Bh2E=;
 b=r9/htUarQjXUCye73m5T4O1iYdrevKTE3fpe8UDL8dg1uK5S2rRIAme+RaK7EKQq/L
 JFoRZvryJ1LHB3YhR3UdqBmt5cExy6rIaJXDmpbwip7wYIlPWxvBHfevNexU/MpSiVBd
 nnuEJBjtGw/zYLqyFmf/l4wVngKE2P+lEJ9CzI7kWU7ndqAbM2EgLV5Vc69hfm+lEG3T
 9Nv4ExZ9U5PTkc9PI0pgDRsWl5jDO/0VymdBlP50qQEsX6c77VtCDAotyjp8xDE6hTKg
 Wx3/6IzhcWctjOXsDb8wB7h2LPYx+2Y4s91SS9rl9pRgELu8w6Zco4NPaD+soTQUAjrd
 lFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vkDRcgvL+D9VvdrCQbP1oNaPKjBqDOyIV9cIwQ5Bh2E=;
 b=VuASum0Pq2cDriHaUW81z3rx9Ja4yndMdOLDmQYiIcZQiy3M431s8y4zTGJNHaywQD
 QP8hOFxn5bXM47mPQAr4FIgoIEHF7z9j/8dXPxRKlgBiWddO6FEclBkjgwRq5xp82lil
 nDsCKfgN9NoW0TAHDPshYefrJ5i5P7ENhj5rx9d19OO4iQO7Cv3+gtrwnzQ8SAdo88iU
 HljWRSnJiIc7xyKbD+zr7S+wG2Ne7ciHAyg7VpX92erBDiokRFc9QyQbWA/Z6INvVmA4
 PgT99auqmRrxjvwQgiSqnruJ9GLOdnNhbc2S4HidOzZWBHafk5ppW8raDvQiGQHmSDhn
 qjwQ==
X-Gm-Message-State: AOAM532Fi/+6azm0Eps5fhfzrjCJndKixoJHxA4T8sEMatW5aQouNpNv
 hxEIJFTBuIjJwXYZLLLmky8NySmi
X-Google-Smtp-Source: ABdhPJy1fXTHwxCweDUDKIDIRWTpyljuvVJFozyQX++LgzWAkEKxIE14RFyUJlN+yho2e8MI3thEPg==
X-Received: by 2002:adf:b348:: with SMTP id k8mr3168408wrd.157.1591687952391; 
 Tue, 09 Jun 2020 00:32:32 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/16] hw/timer/grlib_gptimer: Display frequency in decimal
Date: Tue,  9 Jun 2020 09:32:12 +0200
Message-Id: <20200609073214.14079-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Message-Id: <20200331105048.27989-6-f4bug@amsat.org>
---
 hw/timer/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 80ea197594..866c9f546a 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -19,7 +19,7 @@ slavio_timer_mem_writel_invalid(uint64_t addr) "invalid write address 0x%"PRIx64
 grlib_gptimer_enable(int id, uint32_t count) "timer:%d set count 0x%x and run"
 grlib_gptimer_disabled(int id, uint32_t config) "timer:%d Timer disable config 0x%x"
 grlib_gptimer_restart(int id, uint32_t reload) "timer:%d reload val: 0x%x"
-grlib_gptimer_set_scaler(uint32_t scaler, uint32_t freq) "scaler:0x%x freq: 0x%x"
+grlib_gptimer_set_scaler(uint32_t scaler, uint32_t freq) "scaler:0x%x freq:%uHz"
 grlib_gptimer_hit(int id) "timer:%d HIT"
 grlib_gptimer_readl(int id, uint64_t addr, uint32_t val) "timer:%d addr 0x%"PRIx64" 0x%x"
 grlib_gptimer_writel(int id, uint64_t addr, uint32_t val) "timer:%d addr 0x%"PRIx64" 0x%x"
-- 
2.21.3


