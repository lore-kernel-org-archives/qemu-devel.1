Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79065C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFF1205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grZkoh9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFF1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPQ2z-0001A8-Iw
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 08:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQ1c-0000Go-C9; Mon, 05 Oct 2020 08:55:32 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPQ1a-0000q8-Cx; Mon, 05 Oct 2020 08:55:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id 13so8506397wmf.0;
 Mon, 05 Oct 2020 05:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wlWVSOO/aREpLlLadE6mtcQSK8dWwT8nqz07OWfYY0c=;
 b=grZkoh9vK0eDXQ/x75t891GfLow7DrtdbDy1tL4nb473KomrtawONgf3UV58zqppmk
 Cgtk6ybVhP3UcbTTFMf2z7O4eCb9xV8yA9huBPhjsbC0Ec6dYG1CdliFh9V5UwoFmPMp
 +7eVgLg9lwVCEOEvShm5lRRv3Ud59NsDN9BpIWSt1JeY1KRlMuCF5HK1snWwqFxDMXy9
 wHpOU88lIJ2/V5D0ohzRQMaRJfrEz3/zlOuRfFgiDSg8e0CYS2S2k7aoRjA2FFHDr1EG
 KJV0/emuDg+fkhVkBCSCipX+fP7lSPU0OLdMEEQtqTVNwLT7t7TWp7EEuBHDxpbU3o+B
 9lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=wlWVSOO/aREpLlLadE6mtcQSK8dWwT8nqz07OWfYY0c=;
 b=lDjl/Dfaoa9ySf5Ua8JD32onR84iJxH4Yt5D/HzD0i8x3ngulU80dGlHyaDhWrVJTa
 xQ/OjupOkVpQQMCI6Y0CzrA4ldmlqIFif12jetHjZT7gaJ4o2ALmn5AZpMfImNXP3R8D
 1Aq0WAHDsFwBwyOM+hMTNa4taHKNoXiM8DzuG9XzvxnZm9r1oBm/Kc5iGGhr2vXHyTTa
 t0JZJkxewt6Sxo82Vwx63Fgdl3xd5aev//NjGyUElwoWQDJDGxlmZGZ12PVUdmWsefje
 05pwnAuIpCjvuWEB4DOdIt9q0XIWKSYM+0swKV8kCqj7mkNkQx3HkA+mLzJnDAlQ3Z7L
 f78w==
X-Gm-Message-State: AOAM532XGDSJ0ELw0RNxj7jHsIsQMkTtz3GFgIpVY8sJynSSSPxIDHxW
 c5u3Sn0h06hXetq2p5hF3NdJ+r6RoQs=
X-Google-Smtp-Source: ABdhPJxr4vYzwP1moB3VcZGzdhFLXFmbfLxYenm70Ah5UcIXbshdeVtFGOrzHknF31YIUlc9Y2IZQQ==
X-Received: by 2002:a1c:7c12:: with SMTP id x18mr3109972wmc.107.1601902527029; 
 Mon, 05 Oct 2020 05:55:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:2e86:3d8b:8b70:920c])
 by smtp.gmail.com with ESMTPSA id m14sm4499528wrx.62.2020.10.05.05.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 05:55:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ide: clean up ahci_populate_sglist
Date: Mon,  5 Oct 2020 14:55:27 +0200
Message-Id: <20201005125527.429187-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: jsnow@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex reported an uninitialized variable warning in ahci_populate_sglist.
Even though the warning is bogus and happens only because of -Og, the
code in the function leaves something to be desired; the condition that
triggers the warning is easily shown to be entirely redundant.

In particular, the loop's "if" condition can be rewritten from
"offset < sum + tbl_entry_size" to "offset - sum < tbl_entry_size";
this is safe since the LHS cannot underflow.  Because off_pos is
exactly "offset - sum" it is clear that it can never be less than
zero or greater than tbl_entry_size.  We can therefore keep the off_idx
check only and, for documentation purposes, reduce off_pos to an unsigned
32-bit integer.

The tracepoint also is not particularly useful at this point, since
we know that (if it ever triggers) off_idx will be -1 and off_pos
uninitialized.  Instead, include the requested offset and the total PRDT
length, which will be smaller than the offset.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/ahci.c       | 12 +++++-------
 hw/ide/trace-events |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 680304a24c..997b67a6fc 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -924,8 +924,7 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
     int r = 0;
     uint64_t sum = 0;
     int off_idx = -1;
-    int64_t off_pos = -1;
-    int tbl_entry_size;
+    uint32_t off_pos = 0;
     IDEBus *bus = &ad->port;
     BusState *qbus = BUS(bus);
 
@@ -952,19 +951,18 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUSGList *sglist,
     /* Get entries in the PRDT, init a qemu sglist accordingly */
     if (prdtl > 0) {
         AHCI_SG *tbl = (AHCI_SG *)prdt;
-        sum = 0;
         for (i = 0; i < prdtl; i++) {
-            tbl_entry_size = prdt_tbl_entry_size(&tbl[i]);
-            if (offset < (sum + tbl_entry_size)) {
+            uint32_t tbl_entry_size = prdt_tbl_entry_size(&tbl[i]);
+            if (offset - sum < tbl_entry_size) {
                 off_idx = i;
                 off_pos = offset - sum;
                 break;
             }
             sum += tbl_entry_size;
         }
-        if ((off_idx == -1) || (off_pos < 0) || (off_pos > tbl_entry_size)) {
+        if (off_idx == -1) {
             trace_ahci_populate_sglist_bad_offset(ad->hba, ad->port_no,
-                                                  off_idx, off_pos);
+                                                  sum, offset);
             r = -1;
             goto out;
         }
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 6e357685f9..81706efe80 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -88,7 +88,7 @@ ahci_populate_sglist(void *s, int port) "ahci(%p)[%d]"
 ahci_populate_sglist_no_prdtl(void *s, int port, uint16_t opts) "ahci(%p)[%d]: no sg list given by guest: 0x%04x"
 ahci_populate_sglist_no_map(void *s, int port) "ahci(%p)[%d]: DMA mapping failed"
 ahci_populate_sglist_short_map(void *s, int port) "ahci(%p)[%d]: mapped less than expected"
-ahci_populate_sglist_bad_offset(void *s, int port, int off_idx, int64_t off_pos) "ahci(%p)[%d]: Incorrect offset! off_idx: %d, off_pos: %"PRId64
+ahci_populate_sglist_bad_offset(void *s, int port, uint64_t sum, uint64_t offset) "ahci(%p)[%d]: Incorrect offset! total PRDT length %"PRIu64", offset: %"PRIu64
 ncq_finish(void *s, int port, uint8_t tag) "ahci(%p)[%d][tag:%d]: NCQ transfer finished"
 execute_ncq_command_read(void *s, int port, uint8_t tag, int count, int64_t lba) "ahci(%p)[%d][tag:%d]: NCQ reading %d sectors from LBA %"PRId64
 execute_ncq_command_unsup(void *s, int port, uint8_t tag, uint8_t cmd) "ahci(%p)[%d][tag:%d]: error: unsupported NCQ command (0x%02x) received"
-- 
2.26.2


