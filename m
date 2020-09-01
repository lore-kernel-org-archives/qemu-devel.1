Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26465C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA745206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADpbKxGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA745206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6wq-0001TH-0s
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6tZ-00045X-RG; Tue, 01 Sep 2020 10:04:21 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD6tX-0002nF-Qp; Tue, 01 Sep 2020 10:04:21 -0400
Received: by mail-wr1-x441.google.com with SMTP id g4so1191460wrs.5;
 Tue, 01 Sep 2020 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7Iy4WwGvN3Gz4Zd774fBlzCPud190ropj83rLlS3/Tg=;
 b=ADpbKxGeSSNLywBua3yoYyYkw0AVDjQG8X+XEIrcYB9DV1hVlVcbkPsmuI4FaNdY4U
 dk4MGbcdNEU1EmRXmg70aqSFh3ikqMzSdt2mvcV+9VdB0rzYzYNdDprpByWCjVI6jV9+
 +B/5XCx/qrdKJu1QvdauHVkF8sdnWy9ZF90hUGt9HFnODRoBzx52qwNznE+RuhVr4XBn
 pjTDhx5Ga/qeeYkiCLPhFE31IqBqjae6hAvCMNsp6fSWQbwj/OMCPjHl2ZcGlZiJrPAO
 OxojhGkx+lSlu13LUKxDZjeHlgk5dYl+uqW9v91+QuYnozAaYt2RFhlaNQ3vbdcbGF8v
 hp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7Iy4WwGvN3Gz4Zd774fBlzCPud190ropj83rLlS3/Tg=;
 b=aSrmgeyt8Dskm/9sp8691ejgPiu+xPpjiEsl2T/pWeA2z75prDwFoy+upWaa7R+FrZ
 99C8vsBb8P21lBIiwCdRKUjGIVYT7nAcNbwFL1H2XQBmiHKyJQ3hcjHOASBcieHhlg0U
 4V2Pk0QTyyYsWJGfXNAcDu9My9pcmDF0t26MGmbuRma32kiYVFMBnF7t/Fv1M6woCxjX
 TkYsoUkabTwuNMW0LTDiwcDNrlGZHX0f+bdh6pzHnppqNt6H22O0wzi9a7V6OVceZrJI
 S+52WYCl+vCpoByA5XUyABBTK0xVZGO610j7NevX8dhiBaab4ORFWStodyp+xOdF7MNY
 Kw8g==
X-Gm-Message-State: AOAM531rr3V8AyFKX7WAeqEF+zKwL+fEA3ZFi3jHK3vJo6KS6iky4rLw
 VmqsRl6OSHov++y7/BR4vm8oVvgQsPE=
X-Google-Smtp-Source: ABdhPJztzeN54Xd/4b+iMFmbR6QmcuSKGF7G4sRCI13zjRk38j2/7FGDD9HilATkSf1Km2aNamIDfw==
X-Received: by 2002:a5d:5272:: with SMTP id l18mr2035832wrc.89.1598969057397; 
 Tue, 01 Sep 2020 07:04:17 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id p22sm1872505wmc.38.2020.09.01.07.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 07:04:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] hw/sd/sdhci: Fix DMA Transfer Block Size field
Date: Tue,  1 Sep 2020 16:04:11 +0200
Message-Id: <20200901140411.112150-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140411.112150-1-f4bug@amsat.org>
References: <20200901140411.112150-1-f4bug@amsat.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 1892960@bugs.launchpad.net, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, bugs-syssec@rub.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'Transfer Block Size' field is 12-bit wide.

See section '2.2.2. Block Size Register (Offset 004h)' in datasheet.

Cc: qemu-stable@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1892960
Fixes: d7dfca0807a ("hw/sdhci: introduce standard SD host controller")
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: 1892960@bugs.launchpad.net
---
 hw/sd/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 60f083b84c1..ecbf84e9d3f 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1104,7 +1104,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         break;
     case SDHC_BLKSIZE:
         if (!TRANSFERRING_DATA(s->prnsts)) {
-            MASKED_WRITE(s->blksize, mask, value);
+            MASKED_WRITE(s->blksize, mask, extract32(value, 0, 12));
             MASKED_WRITE(s->blkcnt, mask >> 16, value >> 16);
         }
 
-- 
2.26.2


