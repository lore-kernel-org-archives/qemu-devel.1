Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6DDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F6D20838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtNvyNRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F6D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1MV-00053c-8P
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1L1-0003Kn-LQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kS1Ky-0002is-PU
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:10:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id y12so14660072wrp.6
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gLKWS8Y8T9sXU+gbSEsaUnFE046T7Q7iWcrjHNDSPUk=;
 b=NtNvyNRM4x7aQxGrPNbrQKZW4ltl1eJR38nqwUpNbd0/CVRCciWskuvfINpVkwywVb
 EhQCHZteY4Pb2I1KijKDI5molNPv94ekDuhf5IDR6lMyyy9+s9zXEDy/QBakCoJQjAsC
 lXyr5CcEN5HJ2mpcRitBf1XzzLtlRlss/L8HY+WMZq7Pq+ZC/jLrNqAXrMC+TTbeROQp
 Etnw+k0ihnMDBEAeo0jaHL7/G+ezgSk9vE6hu4L+D4idWAbvQJIelGl0fa7hDx0bgkNy
 6lkdTJyzvbM/2NcR7/95KGNePe0AERHRFL1SOXDg5B17xHxGdJchvPiOHL+ixtPXBZrF
 6Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gLKWS8Y8T9sXU+gbSEsaUnFE046T7Q7iWcrjHNDSPUk=;
 b=QKearW8xyfuJ0DGR6xEQRaFoKJJaBkpzsRieoXiUbFr8CGt0V4dhUFnuZvMaLViG97
 EfcXKObMx/kgyG4MWme1bqgtKQ4NsFNl3p1U0GKz/6g830ucZD/Eiy6rvqMK/bASfa8u
 HQ5pdtR9IfqBolnhekqlEpGIzrntCmRDpoQR5O2jUfKLXseQcWn+6cNfvbd4JC957JXX
 naf2jOs5TFWA5UV17ceFDtC3X+FRCc0DGcTTr/QIs1zPoF1RBh7iBuQbxpJT2gic33iI
 f91WKK3W4Ulh2H1sG/ZRkRODnOnrVVCjxiPXb+xOxyEghdfGfg2on+EwkkyCAbRuXtNy
 68Tw==
X-Gm-Message-State: AOAM531TVeoFObz5r4pU0AErRD+bJoB4pl2Ty7Vk+Qj0r+kxE0fNsoHq
 28AupaX1fSrwwrLk4uMv/WcaNpVm1o4=
X-Google-Smtp-Source: ABdhPJxRfwQn2L34y4SvXdgnGyJtQNCbpsc4mV/IiIX1Oqm+KoanB9VUGPBH4+AldnTX7IqHow+4nw==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr11815107wrw.132.1602522614431; 
 Mon, 12 Oct 2020 10:10:14 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id w11sm25209231wrs.26.2020.10.12.10.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 10:10:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] hw/pci-host/sabre: Report IOMMU address range as
 unimplemented
Date: Mon, 12 Oct 2020 19:09:49 +0200
Message-Id: <20201012170950.3491912-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012170950.3491912-1-f4bug@amsat.org>
References: <20201012170950.3491912-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/sabre.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 4412e23131c..67699ac9058 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -122,6 +122,7 @@ static void sabre_config_write(void *opaque, hwaddr addr,
 
     switch (addr) {
     case  0x30 ...  0x4f: /* DMA error registers */
+    case 0x200 ... 0x21f: /* IOMMU registers */
         qemu_log_mask(LOG_UNIMP,
                       "%s: Register 0x%02" HWADDR_PRIX " not implemented\n",
                       __func__, addr);
@@ -201,6 +202,7 @@ static uint64_t sabre_config_read(void *opaque,
 
     switch (addr) {
     case  0x30 ...  0x4f: /* DMA error registers */
+    case 0x200 ... 0x21f: /* IOMMU registers */
         qemu_log_mask(LOG_UNIMP,
                       "%s: Register 0x%02" HWADDR_PRIX " not implemented\n",
                       __func__, addr);
-- 
2.26.2


