Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6577AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7902077B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4nW0dnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7902077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3Ip-0003gh-Qq
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if3GA-0001dC-Km
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if3G9-0004oS-DP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:46:38 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1if3G9-0004n3-6v
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:46:37 -0500
Received: by mail-wr1-x42b.google.com with SMTP id c9so24333601wrw.8
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 06:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id;
 bh=USDqUNCM4KMduVA1uLz1BsaNkE7bd5fbPPNLbt82HNw=;
 b=R4nW0dnGIdSkqVkmrivPNCyd+akvvjsoWWoqfyYgZ1okIGy9zfv/amz9s9wnJZTVTm
 VFyRehROrwvQ7gDFc3svarmA+F9smg1tuoX6oRFD19uttkCIbslPzeDpDEEO4ngYiJqa
 aLdmBbTyTqyPGsbPewecCL7OLu7E90Oulot6dqf/5jhTNqSnf08ftgp40TjVf4KPAIWx
 x7cIPFLqCzH2CmsVCHr9g5yyj8YkKLnRaHJWEM8hNKf6YCBsngg9CjwlgNOJJO4uXxxV
 Gv/5oPtZFQrFfyAah+oFAKBvA1DauiJTIwIiMZfigin/hseYqnxIsS2US8eZ5aRCd+J3
 Vttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id;
 bh=USDqUNCM4KMduVA1uLz1BsaNkE7bd5fbPPNLbt82HNw=;
 b=YoTeiEDfS5Qp6vFqPrxfh8AVH3ku7cU6aY1tHZSqONgx1HiB2NYkqqvrkAJXihin19
 nQT35QzzcZvijAWvX/rX4oCnxJ/wKfC/W/vB7vTQ8zDc1x77CVJZPXNvnv6RZyT/QwZz
 ewKQThHR3fWskrkf9adLSiCh+7pOqGY4FDA3pd7Cd+sih9VnZdnQ141W1ufPs5G8mJfo
 p7SRcJQ/S+RcRMTWL8nAjBQmHlAUNAtau1uKD64AGpdHlBocdaTcF+xRuVNJ2ElZtGMV
 CLOv3WtTF4hg6t4PdY12PGrRfvJJwNN6nGtHilFDSxrGtzaH34m7Z1+0FJZTrUWAzrQY
 sasQ==
X-Gm-Message-State: APjAAAUxUSQVWvpOjDjIdq+deU3EYI7u57bB/+NfM+hM86KTmj3gBalv
 7E2RfhhS2m8N72G7tfpOQdTIT7UU
X-Google-Smtp-Source: APXvYqyGF8/UMmINORJiSwkY2NOR7cCyJKgSd4kLguFFOjzFv4xtUUx5i2kEi4HdPDx+fS+vhyTxSQ==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr127933wrj.225.1576075595663; 
 Wed, 11 Dec 2019 06:46:35 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id z4sm2588279wme.17.2019.12.11.06.46.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 06:46:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ff Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Dec 2019 15:46:33 +0100
Message-Id: <1576075593-50346-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

---
 hw/ppc/e500.c      | 1 -
 hw/ppc/spapr_irq.c | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 928efaa..12b6a5b 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -793,7 +793,6 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
                                       MemoryRegion *ccsr,
                                       IrqLines *irqs)
 {
-    MachineState *machine = MACHINE(pms);
     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(pms);
     DeviceState *dev = NULL;
     SysBusDevice *s;
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index c3f8870..15c3dd4 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -74,7 +74,6 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **),
                        SpaprInterruptController *intc,
                        Error **errp)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
     Error *local_err = NULL;
 
     if (kvm_enabled() && kvm_kernel_irqchip_allowed()) {
@@ -287,7 +286,6 @@ uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
 
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
-    MachineState *machine = MACHINE(spapr);
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
 
     if (kvm_enabled() && kvm_kernel_irqchip_split()) {
@@ -295,12 +293,6 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         return;
     }
 
-    if (!kvm_enabled() && kvm_kernel_irqchip_required()) {
-        error_setg(errp,
-                   "kernel_irqchip requested but only available with KVM");
-        return;
-    }
-
     if (spapr_irq_check(spapr, errp) < 0) {
         return;
     }
-- 
1.8.3.1


