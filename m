Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D38C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB62B206E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiVmbdyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB62B206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwrw-0001lh-4M
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLE-0003x1-1U; Thu, 03 Sep 2020 17:00:20 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:45655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLB-0007Yp-QV; Thu, 03 Sep 2020 17:00:18 -0400
Received: by mail-oo1-xc41.google.com with SMTP id u28so1121631ooe.12;
 Thu, 03 Sep 2020 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=D8aV+SuTlrxPWeHJfsFhm4DwE+6NojdwAEJTWEzO0A0=;
 b=SiVmbdyJCkYwEnqKlOkKlofmyUmNpBwRV+8sI/tp1iCMcE1QLrGoUlBSonJMW5kmge
 FUMlWCazFVqHDdnemiN3nzAU4xDI9p/ffSxDEtlq42E+ttUOZ0dWZAV13XjjERkkCF3j
 U8KDeb4AdSYGC93HrpF0UiSsUtEmlt4k2m+Kh/H+SvvgVP4wlhZqQeNPzQQxmCCgsP2h
 LtrbIji8IPUHaymkRxLiajJEXSzjuzCOrRgZl+I1vtyUV9dLuxwy/K1ursyUc0QdlER3
 R2NX4wuac27bLNRm5tNv2okc1824Ebn9pWldVCR/4wBCKCPi1nRH0dtOBmZBlAyvwXIZ
 l75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=D8aV+SuTlrxPWeHJfsFhm4DwE+6NojdwAEJTWEzO0A0=;
 b=H/pPPhs+6d6mYhhu3Pc1y18BS4lvBkDtG8scBeV4IwKiSyQ2Yx4G3dkGcDLODTJYs4
 x+bd94Ud1/CaaAy5lPda2j63uAwzQ631YqJOTCB41SHB/lbO46hOENAcKzae7ASHgj24
 ARpLSSTZdnvDQsHDIBfOnk2IFPBIaXII84m1xKq1Y9RMiPpM7so+Op8Y37lDZFCiF9/t
 bnyCN5TYYVzcLd5zN6PlDraK/prCHvva84aasLMWSujb0/Nd2RkGkpAcuQe/dynNtU0p
 0l+qf1tgZvEiWRunDWwBJVLAlVeV1CjrANpWLpMWDfNprFOa1aJ4Hqtqc1yE5qlXjG6x
 ogIQ==
X-Gm-Message-State: AOAM530vLcbqfRyuyfncQ9oQXXtToc7I6IrTrCkTwLAVmxFeSjAmt64w
 3TAxIDg5CHgjM+xlREJuYunUihByFGw=
X-Google-Smtp-Source: ABdhPJwqM43KFDWLqHXcy+anFG9U/WavwYDpAHIJ/emuYFoKHpw0km50yaM2V0T5zOWmvci/y8jFsw==
X-Received: by 2002:a4a:aa0e:: with SMTP id x14mr3282896oom.27.1599166815905; 
 Thu, 03 Sep 2020 14:00:15 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l63sm711626oia.56.2020.09.03.14.00.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:15 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/77] libqos: pci-pc: use 32-bit write for EJ register
Date: Thu,  3 Sep 2020 15:58:46 -0500
Message-Id: <20200903205935.27832-29-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

The memory region ops have min_access_size == 4 so obey it.

Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4b7c06837ae0b1ff56473202a42e7e386f53d6db)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/qtest/libqos/pci-pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
index 0bc591d1da..3bb2eb3ba8 100644
--- a/tests/qtest/libqos/pci-pc.c
+++ b/tests/qtest/libqos/pci-pc.c
@@ -186,7 +186,7 @@ void qpci_unplug_acpi_device_test(QTestState *qts, const char *id, uint8_t slot)
     g_assert(!qdict_haskey(response, "error"));
     qobject_unref(response);
 
-    qtest_outb(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
+    qtest_outl(qts, ACPI_PCIHP_ADDR + PCI_EJ_BASE, 1 << slot);
 
     qtest_qmp_eventwait(qts, "DEVICE_DELETED");
 }
-- 
2.17.1


