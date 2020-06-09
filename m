Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62365C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E43207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfHMa+XC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E43207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYqp-0005L4-AZ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkK-0004Av-W5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkK-0007XV-3h
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so20081122wru.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/Jz4ECzvOcsIpQrlcWrLyo2Cu8aSLRX7Wv/hnluuwCM=;
 b=cfHMa+XCq4yxOM5uaezQJ46d3vRT1x/j0bia7QZ96klt1hpDndFiaoLrJyiJa2Fe+R
 eL15G8m3RGpPJOljYl4TS4Snzp+tOd0u/pWWj1REU0rvlvR7RVqYQr714YS+qsCuPQ+Q
 h9g7UwJe+zUyHz8XaIx7U77KYv+sJuyxXrZGmXa7JBEBJdgzt8reTrdJcjk+tMJoGAc8
 GSdtBG14NTdqGpUUR/sVdOY6GnHzBr0LFFAdW8awTlX4QJpzPrViuMY3stQntMynuJwO
 9MBRowvSOQKO4J5Bk3pywH24hfzOf75x1sME75lPyoYePvrRlRj+gAsIMk4ju5NOhUg9
 wxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/Jz4ECzvOcsIpQrlcWrLyo2Cu8aSLRX7Wv/hnluuwCM=;
 b=oKRUTDCTsh/HyDjLraipIgZfBGFajHlD8643BxLK8F131+AfklDHL9IZtfNAoZbScF
 vMRxQ9saURbOGdLFQSrE46NFMPfRZwotPHkUoH2XARHlbzIGZVQ0CetEZOkUWIjsBDgd
 Xev7xBzsAJHhLXlwl9ChjpqDv2tkRHgppdKpq/60cOIP7dWzEP8cmlwPbeXzOnsl5+WN
 gb5eV+dlVpOXNv6SnuBaQE+Nriruy0vBywtNvsaEDRg5w3yNBNktNQ1helSijXO8yqxh
 JYlYx3/PgeeDTpYSjHcCPLCeBUhLc4ufYYf/UaF2JvwKx5oYKsGgSRGPHxHHhIfFe3Ho
 tYJA==
X-Gm-Message-State: AOAM531peMqBYlFw3YUoqkrPD4EtinghDIrY/XodZSCrjsFbDOGHHZ0O
 PE9fHtOb5e2B3jBztupjPgleuGzU
X-Google-Smtp-Source: ABdhPJyn9n2ZFPzhj/Ltc9sby+foN5c8cj8On8PEi/PxDiQHH5jDHhxLDsACJRes8iOvt2Em6zkvOw==
X-Received: by 2002:adf:82c9:: with SMTP id 67mr3112295wrc.149.1591687947854; 
 Tue, 09 Jun 2020 00:32:27 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] hw/sparc64/niagara: Remove duplicated NIAGARA_UART_BASE
 definition
Date: Tue,  9 Jun 2020 09:32:08 +0200
Message-Id: <20200609073214.14079-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

NIAGARA_UART_BASE is already defined few lines earlier.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20200608172144.20461-3-f4bug@amsat.org>
---
 hw/sparc64/niagara.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 148a26890e..a87d55f6bb 100644
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


