Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92178C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF3522261
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7Z/9isn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF3522261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQt0D-0001sj-2m
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kQszP-0001Rv-0l; Fri, 09 Oct 2020 10:03:19 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:38227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kQszN-0003S8-71; Fri, 09 Oct 2020 10:03:18 -0400
Received: by mail-lf1-x142.google.com with SMTP id c141so4189299lfg.5;
 Fri, 09 Oct 2020 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=IAbwpPmzgr1V5gG2lEeRiHos45MFc3LZ0SMyVzcC7XI=;
 b=P7Z/9isnL9EQAoPVXufuPp4Cu85Dy5bEo4gN+NYjIKdZt1hWy0iASPc4M8gm3w3tB1
 6wQ2D8XoAKwJs7J3y7o47Ryce5Y3n8tF+1ptfuLRotVRW0Wkj3a8A12YyUAuHNCNGT0s
 JJi3anziEjpIGh/RLz4oCHSqiMVhTtIq+9iY9QSf5APwe0gg5KSjJWM5UwFwYeGve5Dt
 oePl0lbuPnWZMZQS4dtYeR3WvgDvKcDqqFAevbHWbQdD0HYZMiuRdgs8Kkb/hfvUFC7U
 hNAy2Qo1RXwaidsq50amv4BkrJiDBF7POCqrA3O3MZAa6W8jdmhsuMxLkV3KrJLmRjgC
 1c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
 :mime-version:content-transfer-encoding;
 bh=IAbwpPmzgr1V5gG2lEeRiHos45MFc3LZ0SMyVzcC7XI=;
 b=KqSF18EfsbAKhhMjJr+seXrzr9z7qIRHhRlHpkIXpaFZXT9CygfFrcLOt69LCXrslJ
 bwXSswWE82Z5dx6tXFn/fLdgsa/M4Ww2qMIwWd/mvuajhTm3HB9xjlhihwYSsH6llwLM
 4Fb/t+Dpo6xKNaqzcqp+DUaetOTxfMd2nYYFnd9VAA6rYQK79BLQhH2RgaB4VOKZ3nWQ
 pzCpY2Fl7gbL8SVU8hM3Hj3+/cvI9G9Lq8/qoWHfbTm8tjzZOcwSBo8VHOP4WpH0NtoV
 0v4qVvP21xgYQMKERJcmc4zN+CyTDil/wBxVGmoguI18/cCDCrZnnP6jrZ8hMFufqAjG
 gxGQ==
X-Gm-Message-State: AOAM531q7NBl4ASCFKXtZwRaZdJ3Bq0etye7ckAPC2ZZH54QxhCX2OUu
 rwzXmU1YMCI2wfrf0QN3R00=
X-Google-Smtp-Source: ABdhPJyXHNP2v826p/f3O7d0jc9DU/RghENILNHdfu+l0Cjrtcnc8pQ4R55xcS9oJOvyTzjdl56Yng==
X-Received: by 2002:ac2:4e92:: with SMTP id o18mr4478220lfr.543.1602252194406; 
 Fri, 09 Oct 2020 07:03:14 -0700 (PDT)
Received: from [192.168.167.128] (37-145-186-126.broadband.corbina.ru.
 [37.145.186.126])
 by smtp.gmail.com with ESMTPSA id h25sm1498622lfp.81.2020.10.09.07.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 07:03:13 -0700 (PDT)
Message-ID: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
Subject: [PATCH] hw/net: move allocation to the heap due to very large stack
 frame
From: Elena Afanasova <eafanasova@gmail.com>
To: david@gibson.dropbear.id.au, jasowang@redhat.com, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org
Date: Fri, 09 Oct 2020 07:02:56 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=eafanasova@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00 2001
From: Elena Afanasova <eafanasova@gmail.com>
Date: Fri, 9 Oct 2020 06:41:36 -0700
Subject: [PATCH] hw/net: move allocation to the heap due to very large stack
 frame

Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
---
 hw/net/spapr_llan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 2093f1bad0..581320a0e7 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -688,7 +688,8 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cpu,
     SpaprVioDevice *sdev = spapr_vio_find_by_reg(spapr->vio_bus, reg);
     SpaprVioVlan *dev = VIO_SPAPR_VLAN_DEVICE(sdev);
     unsigned total_len;
-    uint8_t *lbuf, *p;
+    uint8_t *p;
+    g_autofree uint8_t *lbuf = NULL;
     int i, nbufs;
     int ret;
 
@@ -729,7 +730,7 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cpu,
         return H_RESOURCE;
     }
 
-    lbuf = alloca(total_len);
+    lbuf = g_malloc(total_len);
     p = lbuf;
     for (i = 0; i < nbufs; i++) {
         ret = spapr_vio_dma_read(sdev, VLAN_BD_ADDR(bufs[i]),
-- 
2.25.1



