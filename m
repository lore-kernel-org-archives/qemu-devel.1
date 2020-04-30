Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC237C47253
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC3C2070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmy3douO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC3C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUC4H-0002pp-Ku
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUC01-0004uh-DU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jUBzT-0002MQ-C5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:25:21 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:46689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jUBzS-0002LQ-UM; Thu, 30 Apr 2020 12:24:46 -0400
Received: by mail-lf1-x141.google.com with SMTP id g10so1714823lfj.13;
 Thu, 30 Apr 2020 09:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jTxYyzvXkv9MeH8Q3QMDd3BWICncxWHUn/5+KS17qqU=;
 b=rmy3douOS/UBJS+MKNUf6oFV//I+I+3M2moL8FRZ7lJyw+lP2GZYXTJjNjFM/IXS0h
 3UfY8NsCr5r77oSttSzFh9FYOrlyafJAa+sDIOorbIug1ZkUHbQ9P4aZ6pUi7WWy9hU1
 GCtKiczaN9ZJcE6XXEpXTEApftDctIplEkv/tvUoIduSA3jCOZmp3+yIBTy4lZi0tREM
 b+NWB89wRi+JJ02/HZ8HclM9JSM9M2QVEH5ejLPFyhV7h6un7BIfiFF3zIb1CEIvRAsJ
 SseUwK+PeNBMaF2D9fTvN0Zo6c8yWLuMFNivpTqQNLy4re/4j96ODWFjaRz3AxG1ng+w
 m02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jTxYyzvXkv9MeH8Q3QMDd3BWICncxWHUn/5+KS17qqU=;
 b=ANKjO9cVZeBB41S8fw6bTnFLAm9Xn3SNK22WgCUJxggGmX/Xtm2mLuQlGWQGeY0a+L
 /5ruaCynZXCah6gAeEqXHQfsR6FcP+K9omDyxSlkwm1uiYwRuVmEs+zQryQ0scJ+OfKk
 hegMcTlmyvoPnIb/X4e6Zn/Xy0tEiimBbLLltbXJmGAauUYP4L4Gd5urA60JxcAz9MNO
 5pJWAMTIKTvdZOo0aqQdbQyIcLAorhH4qQHwBhT0aybxyjjFFHImPPtHab4vIhzBKL2C
 ZX/NOKVxJTiuhpG2qJDqGLO6CM8IWsP146+Tm7WpjzVP+9TYaVL5egvWNY1Nt4waXMMt
 EvnA==
X-Gm-Message-State: AGi0PuadKap/52JSbZmxLsS1hmNyIIiBYFMSbmXGjZzfejEl1HtRVSZz
 bGqJfFVH3I3NjvTNir4vCQ20B3oI3Q0=
X-Google-Smtp-Source: APiQypJP/YujnpLVEbhSMQohbO5thhXnH97SUUa33sxJUPslWtgZHgnCsekUDlExvsGJ+S9bcAboGA==
X-Received: by 2002:ac2:5395:: with SMTP id g21mr2744422lfh.61.1588263884916; 
 Thu, 30 Apr 2020 09:24:44 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id z9sm126650lfd.9.2020.04.30.09.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:24:44 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/9] hw/net/xilinx_axienet: Remove unncessary cast
Date: Thu, 30 Apr 2020 18:24:33 +0200
Message-Id: <20200430162439.2659-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162439.2659-1-edgar.iglesias@gmail.com>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, jasowang@redhat.com, alistair@alistair23.me,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Remove unncessary cast, buf is already uint8_t *.
No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/xilinx_axienet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 84073753d7..c8dfcda3ee 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -918,7 +918,7 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size)
         uint16_t csum;
 
         tmp_csum = net_checksum_add(size - start_off,
-                                    (uint8_t *)buf + start_off);
+                                    buf + start_off);
         /* Accumulate the seed.  */
         tmp_csum += s->hdr[2] & 0xffff;
 
-- 
2.20.1


