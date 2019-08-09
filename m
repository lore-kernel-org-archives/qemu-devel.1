Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3CAC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:26:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6262166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 07:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH/KPdqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6262166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvzI4-0006IA-Ao
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 03:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54883)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvzHd-0005ld-8B
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 03:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvzHc-0004pC-80
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 03:25:53 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvzHc-0004nN-01; Fri, 09 Aug 2019 03:25:52 -0400
Received: by mail-pg1-x544.google.com with SMTP id t132so45411970pgb.9;
 Fri, 09 Aug 2019 00:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=5/4YpSmtyH6BPG/1zxeAbgDZu4GjwrumofWYP4xdKQY=;
 b=VH/KPdqi0FaG48FRDSK+vM5KAXQS8jE+xWiReCSwkZ7nXaY0y0CCpQOO4lDxzd0+z3
 oKMrQB8sfkKqAu3bUAtm/VLY++MxMrdKBp29rplxndBW3agiRrIXf1pMwgw7fujOni3d
 xh6V2Mfhn3AvA51XJ2W3IHpnjO1H1MN8P51gHosPUUgQdgm4twFK/OqxHPTFf8aMQByj
 zxmO8o2VWAbVuBFA3MZmfNKqd+dS8ZEy2vQWgQLYEIXjN2oE6JaKLB4/qQ/hR0oSDTCw
 scvTY6BexA2AXmgIGun/xI9YYDxh8y1bDF7MpQAcx1DRYR8fV6KB7560emBDLGIE0h/Z
 C3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=5/4YpSmtyH6BPG/1zxeAbgDZu4GjwrumofWYP4xdKQY=;
 b=hADxK/mzo06JTm9knmuS07Cj2PTSew2V4LHgti2C4kjZPkcv500NDq7s+TMW/2+NCf
 3/lXAGQd0yifyKr0dgM7QsHHFfrvWHcgDfWULThXZ7LJeb2xOHDgYP41hxF0eqNpnr+l
 RBQlH7Ka68zaThJ1ZhFR0ggmp+sxA0ZypxFFvu97sghTfINlJZEIMZkF2qSPrROftEm5
 Opj+SRrH+TMN1fckVUbuFmjvNQkWLicARoiqPcTsoZ6IzrlcmL4/A9fjXcYLCTjgg6Nu
 PcRi/lTYnoK1aQp9S6waTxEy5OWFExMTWO2574HePsiymvLQraHBwJx7TlAiHcjXTy+I
 S2Qg==
X-Gm-Message-State: APjAAAXhVjYd/urK/ZpxSxwMwP3j8zfJ12rn02co6pOFrL7UU+/+63o5
 Yfmn5+r7uMpPbnD94q10Q60=
X-Google-Smtp-Source: APXvYqw/2N3A/YjPSUfQZs1kILgv//whaWVj3XLYITZ3ngnwhPEGSf0Y5e3SlobJ8vyGoma8WT4SXA==
X-Received: by 2002:a62:be0c:: with SMTP id l12mr20039945pff.224.1565335550279; 
 Fri, 09 Aug 2019 00:25:50 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 23sm100737693pfn.176.2019.08.09.00.25.49
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 09 Aug 2019 00:25:49 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Date: Fri,  9 Aug 2019 00:25:44 -0700
Message-Id: <1565335544-23584-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3] hw: net: cadence_gem: Fix build errors in
 DB_PRINT()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When CADENCE_GEM_ERR_DEBUG is turned on, there are several
compilation errors in DB_PRINT(). Fix them.

While we are here, update to use appropriate modifiers in
the same DB_PRINT() call.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v3:
- use PRIx64 as rx_desc_get_buffer() returns uint64_t
- use %u for unsigned
- remove unnecessary cast in DB_PRINT()

Changes in v2:
- use HWADDR_PRIx instead of TARGET_FMT_plx for consistency
- use 'z' modifier to print sizeof(..)

 hw/net/cadence_gem.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d412085..e26ff98 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -983,8 +983,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
             return -1;
         }
 
-        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize),
-                rx_desc_get_buffer(s->rx_desc[q]));
+        DB_PRINT("copy %u bytes to 0x%" PRIx64 "\n",
+                 MIN(bytes_to_copy, rxbufsize),
+                 rx_desc_get_buffer(s, s->rx_desc[q]));
 
         /* Copy packet data to emulated DMA buffer */
         address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
@@ -1156,9 +1157,9 @@ static void gem_transmit(CadenceGEMState *s)
 
             if (tx_desc_get_length(desc) > sizeof(tx_packet) -
                                                (p - tx_packet)) {
-                DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x space " \
-                         "0x%x\n", (unsigned)packet_desc_addr,
-                         (unsigned)tx_desc_get_length(desc),
+                DB_PRINT("TX descriptor @ 0x%" HWADDR_PRIx \
+                         " too large: size 0x%x space 0x%zx\n",
+                         packet_desc_addr, tx_desc_get_length(desc),
                          sizeof(tx_packet) - (p - tx_packet));
                 break;
             }
-- 
2.7.4


