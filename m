Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3F5CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BC620650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVYHa+s7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BC620650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeZo-0004EJ-7m
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj5-00083u-00
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdj3-0007o6-Um
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:54770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdj3-0007nl-OU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id g7so2988057wmk.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=addr6HEN99Dsw110Mj0HtzWMNzU3f7sx/0UbPvS5mDg=;
 b=OVYHa+s72RwVBjxxCnMtsPt2upmay1bGC+AFoJR2IZhCyo3+ReEjyZklbIg46fnWhK
 PWVNf4wWgVNNBOJ9GO49ONYujexVF6FbHibvirIQqxd/Tde7W50NZca4dJ60NSBNMRGS
 zglJRHljvqFJIcJe1zZnjgrchtDy6kL8DSTW7RSeIRsCrzMHFiUFgn3rnEeB8W39qOk/
 8EhMZrnTX6L0IeLNrlPLm7HgTaJkIjgG8CAA5Ew+Ew6M7xySIYeaDm97feblIkLFcfWL
 JLdTOp/lhLiK8Nag5XmvXJdxQebNQfkqixEEhgds1hn+L0UH3r7I96WFgXu9/9GTvhr7
 9Glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=addr6HEN99Dsw110Mj0HtzWMNzU3f7sx/0UbPvS5mDg=;
 b=j08V+QW9fI+1eCBgx0i/wTF5wfHkgiMMF5pOsNNvJAwFcNVU2u0CRXiCFVzASwAlkI
 apCCyjALzl7fHwv2GUQ5X+8EWh580W/iXqhPw3qiEaPpWK/0zx0DACiKYskAy4gbPCJw
 56SexboA9VnXn+Ly9S6CKoqy9Ozn3SYJAaJKdI94FZJbRvBPR2xobuxdTeXc944zbOsV
 UUy/oZfcgteItXTyAyTiLpjgQv4zPWRr4FAO6I/TeJuNkYQz6NQe9WImq5/5JQULCRO0
 n/v+HQ7Ytqsp3r76PxyrJBP1MgVGpci3hC2uk4evxU/DcAInUGZ9zk0XCYVzNvKzZuUg
 j9Qw==
X-Gm-Message-State: APjAAAU+4w4cYP1RrWjP/SZWoqyphaCRhb5Cdac0gAoIU2Fj3ETgs8kK
 uuzNcHZSMYiywa/389Or6aRFtxn2
X-Google-Smtp-Source: APXvYqxLJ9lOZ6z8Vn2vzHR9som7LoayIqV+8eW0LmGrPqRhPiyohTMerHnAyg28NmZZ202G2aQViw==
X-Received: by 2002:a1c:7913:: with SMTP id l19mr5394022wme.26.1571925868453; 
 Thu, 24 Oct 2019 07:04:28 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/39] hw/i386/pc: Move gsi_state creation code
Date: Thu, 24 Oct 2019 16:03:44 +0200
Message-Id: <1571925835-31930-29-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The code block related to IRQ starts few lines later. Move
the comment and the pc_gsi_create() invocation where we start
to use the IRQs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191018135910.24286-4-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_q35.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 255c803..6cf12b7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -211,9 +211,6 @@ static void pc_q35_init(MachineState *machine)
                        rom_memory, &ram_memory);
     }
 
-    /* irq lines */
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
-
     /* create pci host bus */
     q35_host = Q35_HOST_DEVICE(qdev_create(NULL, TYPE_Q35_HOST_DEVICE));
 
@@ -247,6 +244,9 @@ static void pc_q35_init(MachineState *machine)
     object_property_set_link(OBJECT(machine), OBJECT(lpc),
                              PC_MACHINE_ACPI_DEVICE_PROP, &error_abort);
 
+    /* irq lines */
+    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+
     ich9_lpc = ICH9_LPC_DEVICE(lpc);
     lpc_dev = DEVICE(lpc);
     for (i = 0; i < GSI_NUM_PINS; i++) {
-- 
1.8.3.1



