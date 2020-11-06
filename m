Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BEAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953F522227
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dIleZsap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953F522227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5J5-0002uq-FU
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5HM-0001D2-N7
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:12:00 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5HK-0003Mm-TX
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:12:00 -0500
Received: by mail-wm1-x342.google.com with SMTP id a65so2015649wme.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c5vzAfZVeD2fj+XSE443hBvvKPlw3OYEaKcDPAg0K5A=;
 b=dIleZsap3o6+gXkOpa4XvxrVEYJ996ZN0OD9RRKGSTVcfC88Oy44hK7YibbrOwON0K
 ZJOfVd4VrlGwyqvGaqnINa4uofv0mw64XDU7yvbMCBGgW/VVjfTXe/fHUY+piAAweZI8
 aqNkmLicRvZBwxA7HnxQb/7kWtq4eV4EUuYMEQ/wOmycK1hfU06RLPBGdjD7i+A0L90G
 15fwFJyw4rzOcx/w7/ofjlk+Vo6T71UzIVgcnwqvYKl5PTbwG7Fup8EeCKyxQ0CHL5Ak
 ZYxBcfjoXPoPsAhobPej6IlOrGuaz7EIAUANKsC6lvL6S+e39wH5CQu4fqDR8c9QMNgF
 orAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c5vzAfZVeD2fj+XSE443hBvvKPlw3OYEaKcDPAg0K5A=;
 b=OKodl3ZqyjS8P2FWI6Dl3NWO7SVF2eRZPDtqyLATKriz9oxRav6qu4QFcBAgTzoKFg
 yQDfNQSqJcBk3nUJgjxvgTB/jyvQoCI04H8lqCe14Sx/NO8JWc+BGTqf0vM8BT3S1vAj
 miVQ+4381pf83TpnuEmp5ZvZtPalsF7yk2x8jNkMvBjUlWF9zT29G8t83yEZ7HzJubxB
 iIQE68U2NqqlKeb0cShoJyqC6STw+ClfuTnd6l6jjearW8iDbo7EDGj4phfCEDcgYQ4z
 h/KohBLlFnOQ9vevdX+lgJ+4S86IAD2QwS3EhzzkjRP2Yo+Uh9j13mUlyBncuraD0UyA
 A3KQ==
X-Gm-Message-State: AOAM531/n3jpdjrS+Zu+7HB9O3kzPl48lVEgDb2joz41jr8nvn6dgQgm
 jN4LFq5yFbPCTLOBME438wBwu63ScYwtwA==
X-Google-Smtp-Source: ABdhPJztB/QX6nwJKFN+J6RQb+WN+lfvuF7XxFQL8Ijbu/8AR61GfVhaWtoMDjj6qqE/uyEiZ8CC2g==
X-Received: by 2002:a05:600c:2282:: with SMTP id
 2mr653714wmf.154.1604682716930; 
 Fri, 06 Nov 2020 09:11:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id l1sm3162649wrb.1.2020.11.06.09.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 09:11:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 1/4] hw/net/can/ctucan: Don't allow guest to write off
 end of tx_buffer
Date: Fri,  6 Nov 2020 17:11:50 +0000
Message-Id: <20201106171153.32673-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106171153.32673-1-peter.maydell@linaro.org>
References: <20201106171153.32673-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ctucan device has 4 CAN bus cores, each of which has a set of 20
32-bit registers for writing the transmitted data. The registers are
however not contiguous; each core's buffers is 0x100 bytes after
the last.

We got the checks on the address wrong in the ctucan_mem_write()
function:
 * the first "is addr in range at all" check allowed
   addr == CTUCAN_CORE_MEM_SIZE, which is actually the first
   byte off the end of the range
 * the decode of addresses into core-number plus offset in the
   tx buffer for that core failed to check that the offset was
   in range, so the guest could write off the end of the
   tx_buffer[] array
 * the decode had an explicit check for whether the core-number
   was out of range, which is actually impossible given the
   CTUCAN_CORE_MEM_SIZE check and the number of cores.

Fix the top level check, check the offset, and turn the check
on the core-number into an assertion.

Fixes: Coverity CID 1432874
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/ctucan_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index d20835cd7e9..ea09bf71a0c 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -303,7 +303,7 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr, uint64_t val,
     DPRINTF("write 0x%02llx addr 0x%02x\n",
             (unsigned long long)val, (unsigned int)addr);
 
-    if (addr > CTUCAN_CORE_MEM_SIZE) {
+    if (addr >= CTUCAN_CORE_MEM_SIZE) {
         return;
     }
 
@@ -312,7 +312,8 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr, uint64_t val,
         addr -= CTU_CAN_FD_TXTB1_DATA_1;
         buff_num = addr / CTUCAN_CORE_TXBUFF_SPAN;
         addr %= CTUCAN_CORE_TXBUFF_SPAN;
-        if (buff_num < CTUCAN_CORE_TXBUF_NUM) {
+        assert(buff_num < CTUCAN_CORE_TXBUF_NUM);
+        if (addr < sizeof(s->tx_buffer[buff_num].data)) {
             uint32_t *bufp = (uint32_t *)(s->tx_buffer[buff_num].data + addr);
             *bufp = cpu_to_le32(val);
         }
-- 
2.20.1


