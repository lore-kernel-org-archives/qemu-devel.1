Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765ABC2D0EF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 09:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435AC20787
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 09:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfy6LfIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435AC20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP0RA-0001Uq-5y
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 05:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rfried.dev@gmail.com>) id 1jP0QM-0000ta-G9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 05:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1jP0QK-0001LG-L9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 05:03:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36573)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1jP0QF-0001Ee-P5; Thu, 16 Apr 2020 05:03:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id u13so3916134wrp.3;
 Thu, 16 Apr 2020 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t0g7U8E3KHE61ic0C65DwUhjti+TQvBSks1i7vapsT0=;
 b=Sfy6LfIhguA9albT4FxwJotLGBSRus3mDuimprkTAgvAhbq8I8BsSHjVgZzI7lQHbH
 yZm97u6gr3JYOgLRodBAgB49uDs/M9XqEGDH6+eMfKY7fsOzgZvmK2y50UikYE0sGUmc
 WXHi6ygtHrZd12nXYmA1/Cycm7vUIgglu8o5fCworqZrcpYuAN1hzXw5PXj+kWMC5fhm
 5lYuwQNKNOEiHh+CL2X9caCN1D+3K6hpjUFpcbhuFJbSHtBdAdaNGf1B1O3HZPd5F9PI
 mF6O/OgMzrxSZVixA5+We/Yu/iqZ9XfOMCRFE7J9iXgZyGQYOOnoHDQs8y7M9/BnzR0K
 sXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t0g7U8E3KHE61ic0C65DwUhjti+TQvBSks1i7vapsT0=;
 b=WjrZE8wDovFH1uf/UDUUmcapd5V4AYH6kEPWWAHD6xGVeNiYjTkjQc8vymEyQzxCwo
 Po/UqFm2Dmy+a6sLFkWDvLtOQib1cDBUNyLTVrBEuRg69K53hhSd3fuGTSzcZ2UzCPzp
 mqfBMwYGeI707NWm1OVzb7BLv7qgvLiM9a3eAAx3EZMAOxLFa2qtr9Ivh+gL5rzbiqFx
 sbMV9E3irsZ5mfKtIRHCv/KwW4f4RzyK9DNchiDi5/WrrRLoi9vxL7f+Q8/GFXypz84v
 +QIlJo5yuCSEOhB6CTA3/G+tPhGWHbh7HMCGJlKYztVIH5gNovYaoZ9qBKDr7LtED1hg
 nwCQ==
X-Gm-Message-State: AGi0Pubz3Ag5s2IiRJ2PP+MEOwUTgcR6+YpPY+a2gug2fKqlgE/DkCAe
 KKYZ5WyrZ08VlIIZKrLib0A=
X-Google-Smtp-Source: APiQypKxLo6uus/SHILyeAfLc+GGrJAPQtP7Rd64XbreP/rxUgtzB3r5Vrw4P+wFGMeVOoYvZwBbbg==
X-Received: by 2002:adf:8441:: with SMTP id 59mr30522047wrf.237.1587027778157; 
 Thu, 16 Apr 2020 02:02:58 -0700 (PDT)
Received: from localhost.localdomain ([37.142.6.51])
 by smtp.gmail.com with ESMTPSA id h137sm3489092wme.0.2020.04.16.02.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 02:02:57 -0700 (PDT)
From: Ramon Fried <rfried.dev@gmail.com>
To: edgar.iglesias@gmail.com, alistair@alistair23.me, peter.maydell@linaro.org,
 jasowang@redhat.com, qemu-arm@nongnu.org
Subject: [PATCH] Cadence: gem: fix wraparound in 64bit descriptors
Date: Thu, 16 Apr 2020 12:02:47 +0300
Message-Id: <20200416090247.353414-1-rfried.dev@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Ramon Fried <rfried.dev@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wraparound of TX descriptor cyclic buffer only updated
the low 32 bits of the descriptor.
Fix that by checking if we're working with 64bit descriptors.

Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
---
 hw/net/cadence_gem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 51ec5a072d..b8ae21cc0d 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1238,7 +1238,14 @@ static void gem_transmit(CadenceGEMState *s)
             /* read next descriptor */
             if (tx_desc_get_wrap(desc)) {
                 tx_desc_set_last(desc);
-                packet_desc_addr = s->regs[GEM_TXQBASE];
+
+            if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+                packet_desc_addr = s->regs[GEM_TBQPH];
+                packet_desc_addr <<= 32;
+            } else {
+                packet_desc_addr = 0;
+            }
+                packet_desc_addr |= s->regs[GEM_TXQBASE];
             } else {
                 packet_desc_addr += 4 * gem_get_desc_len(s, false);
             }
-- 
2.26.0


