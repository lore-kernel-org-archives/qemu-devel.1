Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74F5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BE2204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpNL+/K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BE2204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZjz-00030L-NG
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhO-00068F-QN
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:32:54 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:40781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdZhO-0005o3-32
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:32:54 -0400
Received: by mail-ed1-x541.google.com with SMTP id l5so17660449edn.7
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZxmLzjQ4bUorljqYuWr6VmTgXnIbg6am868WkyxH1FQ=;
 b=BpNL+/K5SfywsaJDSQ9O21LwYnTqCvzt7t63Vo/Mpao/5JAAjf+fFbRSMSdNsLhQ5Y
 6jRVtd6Il3VhkTC1n6M8gNK2T0lk+3nQidh5iHavVK0r/SANwbDd/t5jMlHzSbOfJUQp
 nwbbmP/nTYDxZIPp+vfCrzHaQbFH4s8oV84iK81KSOb+l1aw9HwvFs/OoQUF1i5g2xaS
 sJdJ0M4SO1aD//pPqnoinNEEoQVG94Cw6fT/NwnOlbuU7kZIdXriRYCId3LJVrnvpTh5
 2Mj51PKdwjKHGj4qRS4G/DmVh20iJW0vkR8AAlJ0+64JsmSO7JqnrE8TBa7nph+htv62
 TOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZxmLzjQ4bUorljqYuWr6VmTgXnIbg6am868WkyxH1FQ=;
 b=Qwtdmk8DZ/Mp2/i8pAQTnvYavDAMcXAvZ3em/QwZjpL6SiNaHM4zDuds2hCwMj680+
 mvLbXgZtaKeU6AsO989TpP8VpVWsxae3r53f0O4OSvwHbithVRVyKSw6LDE2ACqT5gtb
 DnJ6LKROVMN5Ny1KFbRdiv894M9TAVRLcJvz4BLAuUosC52f5UCZzJHQDTzlGzstffZJ
 NiEZQB5kmR/1B/Sb+egwmdtFlTb3lS8jPlj39ErzIF6z9/AxYl244bE62EUG9FUmY5fJ
 UEakbL5PXZVWgl+8hFDYHiL92AQW18ThdZk8UkTWV2O8uJSxY/DnnJRx9Nyfw8EZEISL
 1DEQ==
X-Gm-Message-State: AOAM531yerypLst2rGPg/zMQAgFEx/1TlpMWBAXTN8V21YtYCaF3JcR3
 2PLg4xfUxu+cAgwKQnmoaJK4q/iD1BY=
X-Google-Smtp-Source: ABdhPJzYHzoRGE1wRVBnVl/SGEjiVqL2TidTtPjmaa+8kLuri9nxRc4LVKVSWfZFp6XS+Xi6mlJdxg==
X-Received: by 2002:aa7:c609:: with SMTP id h9mr2594792edq.155.1590499972630; 
 Tue, 26 May 2020 06:32:52 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id n25sm1623084edo.56.2020.05.26.06.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 06:32:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/14] hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito
 North Bridge
Date: Tue, 26 May 2020 15:32:35 +0200
Message-Id: <20200526133247.13066-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526133247.13066-1-f4bug@amsat.org>
References: <20200526133247.13066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <chenhc@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Ease the kconfig selection by introducing CONFIG_PCI_BONITO to select
the Bonito North Bridge.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: <20200510210128.18343-6-f4bug@amsat.org>
Reviewed-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/Kconfig           | 1 +
 hw/pci-host/Kconfig       | 4 ++++
 hw/pci-host/Makefile.objs | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 2c2adbc42a..2240504dff 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -43,6 +43,7 @@ config JAZZ
 
 config FULONG
     bool
+    select PCI_BONITO
 
 config MIPS_CPS
     bool
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 9642c77e98..8db41edc7e 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -55,3 +55,7 @@ config PCI_EXPRESS_DESIGNWARE
     bool
     select PCI_EXPRESS
     select MSI_NONBROKEN
+
+config PCI_BONITO
+    select PCI
+    bool
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index 8c87e8494d..e422e0aca0 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -12,7 +12,7 @@ common-obj-$(CONFIG_PPCE500_PCI) += ppce500.o
 common-obj-$(CONFIG_VERSATILE_PCI) += versatile.o
 
 common-obj-$(CONFIG_PCI_SABRE) += sabre.o
-common-obj-$(CONFIG_FULONG) += bonito.o
+common-obj-$(CONFIG_PCI_BONITO) += bonito.o
 common-obj-$(CONFIG_PCI_I440FX) += i440fx.o
 common-obj-$(CONFIG_XEN_IGD_PASSTHROUGH) += xen_igd_pt.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) += q35.o
-- 
2.21.3


