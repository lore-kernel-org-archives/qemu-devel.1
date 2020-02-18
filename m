Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADDEC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957A521D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxCr5G/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957A521D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j419J-0007R2-Rh
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 06:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1j418V-0006qn-RZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1j418T-0005rV-SY
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:33:55 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1j418T-0005r5-Ln
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:33:53 -0500
Received: by mail-lf1-x141.google.com with SMTP id n25so14293637lfl.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 03:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yra27ms85+L5Jwf4+w3nfC9p/D3Kk1aygR/7pvkiwxY=;
 b=bxCr5G/O4kiJ/J2ARlTPPUVDHNNJwcZajs1uWSb7sqg4S1w9sHzx0ngsMzLVQpVghb
 9brfLyz2LT7TZ+DtcGsvcDpewOxEO/v2E59IO7ekkWhP3N0v0wvJV0eMwx999H0rVbRS
 f2v9dhGNrAu2bDzeIk94pBlte9gHltSv6G1U5serYTx9e7nYCHLheb/6mLkc4jAoN6qQ
 hIu836ZkHjnfvRVisKgapKsuAu7hev7tz1m6EUgWbTjS003bb2+f8DzjZCTMgv+kvOrq
 LaCNrb2PU7rHoCrJl/7sCMDVleUOpldBRWfYm42n3GeoIcwTKbYBORSY3rCjKh90w8wM
 0oeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yra27ms85+L5Jwf4+w3nfC9p/D3Kk1aygR/7pvkiwxY=;
 b=ATadb5aRSWYaOG9XVpHHURBkSLcPbHQaIRewl6VwJdzlFx8XFNsL/3aNN3RqjFAhYh
 K7ehSWyLknxuWDpAQNhAnkWWqS0/IkLF4DcQSqToh9AM0dWOIpL4duOCwfV9ZQcvMMkD
 5jsM9u06QDAO682EmTm76wBXhfiaPwhj1cudN3Wpb2WNGfeP51wlEKUXhhIH5SC0n6/m
 0hGpOmqAlJEQo4iVYuxD9cGDFq6JLXak6j+IpCJUBimHbKCgHbos4WUG7r5r3DaqREb/
 R4iEUqZopMc0xWo8kCgqGQ8Yk6zDOFAizHm6oMq0GM9CwJN57GYpsFKVqSw0wdBG7UCN
 4IEQ==
X-Gm-Message-State: APjAAAWLffcG2IKtuF3DB87yHotCksISn4Uk/dw9M/aWYnCCWSRkvXqk
 g/C8YYDZ9Ke/s3hJpZv7AxpS5qSX
X-Google-Smtp-Source: APXvYqxTc5yH01T9Z5sDIzyTkfTj95JZQDUtYWbvngCGCMZFBs9RWAIEl8YfRntASI46e+MaN/dhow==
X-Received: by 2002:a19:c6cd:: with SMTP id w196mr10589290lff.79.1582025631596; 
 Tue, 18 Feb 2020 03:33:51 -0800 (PST)
Received: from localhost.localdomain (31-208-27-151.cust.bredband2.com.
 [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id k1sm2266300lji.43.2020.02.18.03.33.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Feb 2020 03:33:50 -0800 (PST)
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] xilinx_spips: Correct the number of dummy cycles for the
 FAST_READ_4 cmd
Date: Tue, 18 Feb 2020 12:33:50 +0100
Message-Id: <20200218113350.6090-1-frasse.iglesias@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: peter.maydell@linaro.org, sai.pavan.boddu@xilinx.com,
 alistair@alistair23.me, edgari@xilinx.com, clg@kaod.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Francisco Iglesias <francisco.iglesias@xilinx.com>

Correct the number of dummy cycles required by the FAST_READ_4 command (to
be eight, one dummy byte).

Fixes: ef06ca3946 ("xilinx_spips: Add support for RX discard and RX drain")
Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
---
 hw/ssi/xilinx_spips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 6c9ef59779..c57850a505 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -576,11 +576,11 @@ static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
     case FAST_READ:
     case DOR:
     case QOR:
+    case FAST_READ_4:
     case DOR_4:
     case QOR_4:
         return 1;
     case DIOR:
-    case FAST_READ_4:
     case DIOR_4:
         return 2;
     case QIOR:
-- 
2.11.0


