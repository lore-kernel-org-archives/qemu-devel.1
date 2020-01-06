Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAADC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF46C2072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XepBHbRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF46C2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXbX-0005No-Js
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX5A-0003oe-Pz
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX59-0005Ey-M0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:28 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:33026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX59-0005Ed-Ik; Mon, 06 Jan 2020 13:26:27 -0500
Received: by mail-qk1-x741.google.com with SMTP id d71so32446953qkc.0;
 Mon, 06 Jan 2020 10:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JJWYjaXsWA8uSjmMFIfhA7Z1i5kUfBIKlMWt+XL7NrA=;
 b=XepBHbRcdoMRwO/gywlmTxjNi0ImO5cPV4DtOK1NSPJGEfrf8JEDe0NrCB4TaMx9v2
 gnrkoe6RF42aFys5F9Ukvws0ZF8e5DXACSzyTa0p0XR3RCF1t/414Yo649bJstTeBEop
 fBc/75GDTZKOismSWmAKMBj5KKDi1NsRnK69joXE2lkeNAy6a6kXfbCRnGR0r/YOFAUH
 1MXbUWMCMTuVyAbd+f/8uRuU4ToXh+nS88I6kjOwX2r18ta46hzA1FYzOYN0RZMPxJ4o
 Fd//G+Sij6PXgvhnpzyr8GhsjgY2UavIx07s5wBkxd1LbWNDiQ3owxKWxCQuUT6TrQ64
 5V2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JJWYjaXsWA8uSjmMFIfhA7Z1i5kUfBIKlMWt+XL7NrA=;
 b=gjemjH1oQ2bWRVZBL+Aut+GJOOJv80XijT/moGCwR4qCH9bwBxRKg6Dspqxl+NwLsw
 7W03nWf2tHzRUYJUm79qdgrPEQu8RpgIdphMxdeYB6qgENy28mT/YyVmPNm643VlS3vM
 GNekJpddfMZuS9dT37Nx0q2iCxVNmbAYnrzvmkqFl/1Z3I9edhRjJAPD70yEJIYCeL2E
 GqYOU9OV/jYmV/CR7cOlEkjknnSuq0s6R8v62vs0G1mwySmgOZJLhPt2cK1ZTzzb0EmE
 yKRYc5aeNvxNxioqvdXSmwWyslv8rAEp+XnY53THfQLFFUDl1Jpcxj1Vl2TlHKuYFPWW
 4MaQ==
X-Gm-Message-State: APjAAAXMywTwwQ9YIagzDTQbUlq/HyEZVSXnd2D2ddCslN4whXxtauga
 Xy1+9GuF84tXDWZhkIBFq8HzRW9F
X-Google-Smtp-Source: APXvYqyvzVhyJMExc/vZgKmVGSOiey8uffmAAxbMnZ4hCmyLPBsiUp1omZBy6qvRrKZ6Kt3Av2xXgw==
X-Received: by 2002:a37:6794:: with SMTP id
 b142mr85102518qkc.216.1578335187051; 
 Mon, 06 Jan 2020 10:26:27 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:26 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 53/59] net/net_tx_pkt.c: remove unneeded label in
 net_tx_pkt_get_gso_type()
Date: Mon,  6 Jan 2020 15:24:19 -0300
Message-Id: <20200106182425.20312-54-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'func_exit' can be replaced by 'return' with the appropriate
return value. 'rc' also becomes unnecessary after this change,
thus let's remove it as well.

CC: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/net/net_tx_pkt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 162f802dd7..3cd6aa1d0e 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -287,21 +287,18 @@ struct virtio_net_hdr *net_tx_pkt_get_vhdr(struct NetTxPkt *pkt)
 static uint8_t net_tx_pkt_get_gso_type(struct NetTxPkt *pkt,
                                           bool tso_enable)
 {
-    uint8_t rc = VIRTIO_NET_HDR_GSO_NONE;
     uint16_t l3_proto;
 
     l3_proto = eth_get_l3_proto(&pkt->vec[NET_TX_PKT_L2HDR_FRAG], 1,
         pkt->vec[NET_TX_PKT_L2HDR_FRAG].iov_len);
 
     if (!tso_enable) {
-        goto func_exit;
+        return VIRTIO_NET_HDR_GSO_NONE;
     }
 
-    rc = eth_get_gso_type(l3_proto, pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_base,
-                          pkt->l4proto);
-
-func_exit:
-    return rc;
+    return eth_get_gso_type(l3_proto,
+                            pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_base,
+                            pkt->l4proto);
 }
 
 void net_tx_pkt_build_vheader(struct NetTxPkt *pkt, bool tso_enable,
-- 
2.24.1


