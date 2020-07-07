Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3CEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C16206E6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 02:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfSt0N1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C16206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsd28-0005ub-Jz
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 22:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1jsd1N-0005Sq-Sw; Mon, 06 Jul 2020 22:07:45 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:35743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1jsd1K-0005bb-7S; Mon, 06 Jul 2020 22:07:45 -0400
Received: by mail-qt1-x843.google.com with SMTP id b25so9213599qto.2;
 Mon, 06 Jul 2020 19:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YmRCz4CwArI7TD+I+EW3fguN01b3jj4dYKCICNEeHC4=;
 b=TfSt0N1N9W77+ZlljQ6gGaYzMJg2ImLigjRQfF2w2/MTEim/xEMIUVDY4k2JFoqgBc
 qewGHL4vNugZZVq5J6ySJLWpVjLBylJ99PqNKyp5WVsQ6Gbu/QGeHZGwYUxBmwrxt2JF
 OxoKprEP/9/gOpMbyrMqR11S1gW/appK77/jueYGBayCWGz/lWXFnNm4qejaYP9QNOgh
 DKIHvmEYeA0oyPJg2hamy28315Mh33GLATitz6oB2c9I8ugY7DhyB8/k4Wi9TgnVhlQ9
 3cgFSqmluuQPbaCxylT3B5/hnM8ndf0m/aqieH6SRKzDGMd2xyVxwuCkd3EManYt6i6u
 VtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YmRCz4CwArI7TD+I+EW3fguN01b3jj4dYKCICNEeHC4=;
 b=YhQEcZQdymRogz80w8sZVnNRs4JuQm5SqRgDVnRTuKv+MTPrSOMJ5f0NG/ivnmXcQ0
 iqNVvbL5C1NRJ3tiUpa/Oe9kPhZW8LZqAMrcQ/SNv4+il9qHjOUH4Mjvo/k1HGu+PLV+
 +lk6F7a4Y2+Yu6Jx6bEx4QuMst8G1OLfL2o4mBEdgLmxmRTOwybJLHliQFjgYAhZdhFD
 ipRS8ZwCn3gudtwffOcW0j/CNFZ8ppDnChIMdBpT6tc9zOeJaRDjv31ykX8c5YtZ7ZT1
 XUwpE3ApgCUqi/qon1qkJi2Iz7q2ltiliCEOdCe+U8jt+U7rEYJ6BbsMDCFYnt6ykvhk
 tMAw==
X-Gm-Message-State: AOAM530JiUDJKG0XsReibNMWWEwPBQRpheFWK27DZe6LC9ScCg+2VmI1
 uxPv+JAsult3WYzd+/fMdEilDQ+47rw=
X-Google-Smtp-Source: ABdhPJz7mPRSBvkiD/TR4KVHXeuIjk50m84eEH8vtO6+mk4Zgmmc/pBPZsR+YTmTYEYdyMrvyyfv7g==
X-Received: by 2002:ac8:4e03:: with SMTP id c3mr52498987qtw.82.1594087659942; 
 Mon, 06 Jul 2020 19:07:39 -0700 (PDT)
Received: from localhost.localdomain ([177.188.126.13])
 by smtp.gmail.com with ESMTPSA id t36sm25323735qtj.58.2020.07.06.19.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 19:07:39 -0700 (PDT)
From: Julio Faracco <jcfaracco@gmail.com>
To: qemu-riscv@nongnu.org
Subject: [PATCH] riscv: Add OpenTitan Big Number (OTBN) device address
Date: Mon,  6 Jul 2020 23:07:28 -0300
Message-Id: <20200707020728.23420-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=jcfaracco@gmail.com; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 Julio Faracco <jcfaracco@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds basics skecthes to implemente a OTBN unit.
OTBN has address 0x50000000 and size 0x400000.
For further reference, see OTBN docummentation:
https://docs.opentitan.org/hw/ip/otbn/doc/

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 hw/riscv/opentitan.c         | 5 ++++-
 include/hw/riscv/opentitan.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 19223e4c29..8a5d060b57 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -50,7 +50,8 @@ static const struct MemmapEntry {
     [IBEX_ALERT_HANDLER] =  {  0x40130000,  0x10000 },
     [IBEX_NMI_GEN] =        {  0x40140000,  0x10000 },
     [IBEX_USBDEV] =         {  0x40150000,  0x10000 },
-    [IBEX_PADCTRL] =        {  0x40160000,  0x10000 }
+    [IBEX_PADCTRL] =        {  0x40160000,  0x10000 },
+    [IBEX_OTBN] =           {  0x50000000, 0x400000 }
 };
 
 static void opentitan_board_init(MachineState *machine)
@@ -183,6 +184,8 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
         memmap[IBEX_USBDEV].base, memmap[IBEX_USBDEV].size);
     create_unimplemented_device("riscv.lowrisc.ibex.padctrl",
         memmap[IBEX_PADCTRL].base, memmap[IBEX_PADCTRL].size);
+    create_unimplemented_device("riscv.lowrisc.ibex.otbn",
+        memmap[IBEX_PADCTRL].base, memmap[IBEX_OTBN].size);
 }
 
 static void lowrisc_ibex_soc_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 8f29b9cbbf..c739d44fbc 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -68,6 +68,7 @@ enum {
     IBEX_NMI_GEN,
     IBEX_USBDEV,
     IBEX_PADCTRL,
+    IBEX_OTBN,
 };
 
 enum {
-- 
2.25.1


