Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E254C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6092084E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6092084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heDNb-0001lN-3o
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 02:50:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1heDKd-00084e-21
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1heDK0-0005VY-J0
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:46:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1heDK0-0005V9-G6
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:46:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id c70so3683745qkg.7
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 23:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4a367De+MaFB/R4qvFTLUbUDKGFJvFceJZYzgUfwehk=;
 b=gIYMf6sXum9YN8aiz4upZPjC6+4k5pmTdXKeXwpH9TloffI/CwdRA2WNG9RuqUF1rb
 ez6bqbaKQMweVhSu4osedh8HOifD+2XtQ3dyEzANgVNhEF0ufjA/b4L+uFmrVnuWo50b
 xh+EuzJiUc0Ry+bUWUDe20pcrMY0PNxhoyJy4ydEUVA4mDyxYMxispEvs49elfgCcqwh
 3ZLGkO5bHbSdXf9khYwELbahki83y4IZ5Bq6zJpn9jnEab5ZVrTc6XrDdFPwM+LXJBWD
 5j4SNoRxKriwWg4PniFmw0wJyI9loytzfCZHOh9bC+ar9pN5mF6HCSCnYv0yg6Oyznop
 2C8g==
X-Gm-Message-State: APjAAAVfIlgH2mW9KdUZvYtzLgB02BR3VgFHfmxhOQyNuyk0/E5JB0q+
 3Sw6uUvC5CSJwKjDjt8snkdqfIY1i88=
X-Google-Smtp-Source: APXvYqxj0DWmRWR76tDVP0rl9tAhgp5e8jBxCU6G09jlc02rDDz1HiWHumhu8auDMkcOF6vQKDWJHw==
X-Received: by 2002:a37:b843:: with SMTP id i64mr15728891qkf.77.1561099611579; 
 Thu, 20 Jun 2019 23:46:51 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id y29sm976202qkj.8.2019.06.20.23.46.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 23:46:50 -0700 (PDT)
Date: Fri, 21 Jun 2019 02:46:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190621064615.20099-4-mst@redhat.com>
References: <20190621064615.20099-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621064615.20099-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.194
Subject: [Qemu-devel] [PATCH 3/3] pcie: work around for racy guest init
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

During boot, linux guests tend to clear all bits in pcie slot status
register which is used for hotplug.
If they clear bits that weren't set this is racy and will lose events:
not a big problem for manual hotplug on bare-metal, but a problem for us.

For example, the following is broken ATM:

/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -S -machine q35  \
    -device pcie-root-port,id=pcie_root_port_0,slot=2,chassis=2,addr=0x2,bus=pcie.0 \
    -device virtio-balloon-pci,id=balloon,bus=pcie_root_port_0 \
    -monitor stdio disk.qcow2
(qemu)device_del balloon
(qemu)cont

Balloon isn't deleted as it should.

As a work-around, detect this attempt to clear slot status and revert
status to what it was before the write.

Note: in theory this can be detected as a duplicate button press
which cancels the previous press. Does not seem to happen in
practice as guests seem to only have this bug during init.

Note2: the right thing to do is probably to fix Linux to
read status before clearing it, and act on the bits that are set.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index f8490a00de..c605d32dd4 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -610,6 +610,25 @@ void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_s
     uint16_t sltsta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
 
     if (ranges_overlap(addr, len, pos + PCI_EXP_SLTSTA, 2)) {
+        /*
+         * Guests tend to clears all bits during init.
+         * If they clear bits that weren't set this is racy and will lose events:
+         * not a big problem for manual button presses, but a problem for us.
+         * As a work-around, detect this and revert status to what it was
+         * before the write.
+         *
+         * Note: in theory this can be detected as a duplicate button press
+         * which cancels the previous press. Does not seem to happen in
+         * practice as guests seem to only have this bug during init.
+         */
+#define PCIE_SLOT_EVENTS (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD | \
+                          PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC | \
+                          PCI_EXP_SLTSTA_CC)
+
+        if (val & ~slt_sta & PCIE_SLOT_EVENTS) {
+            sltsta = (sltsta & ~PCIE_SLOT_EVENTS) | (slt_sta & PCIE_SLOT_EVENTS);
+            pci_set_word(exp_cap + PCI_EXP_SLTSTA, sltsta);
+        }
         hotplug_event_clear(dev);
     }
 
-- 
MST


