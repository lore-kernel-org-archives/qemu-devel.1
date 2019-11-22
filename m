Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CE6C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AE820715
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jexQjhrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AE820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYArS-0006rm-MM
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 10:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iYAqm-0006FR-5T
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iYAqk-0005Uy-W5
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:27:59 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iYAqk-0005Up-Qy; Fri, 22 Nov 2019 10:27:58 -0500
Received: by mail-pl1-x643.google.com with SMTP id w7so3219472plz.12;
 Fri, 22 Nov 2019 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=GCzWriIu4N0LBgO938q0R/XT7fvDgSNrqLwMyXX/ghY=;
 b=jexQjhrg3l111yJwZky4vkESt7FDIKSlWOPtolE0JxOfOBBFqySZEoYvDteTf9KeTb
 M4hjsxBFlnkaTYbx6e4qRLT4B+tVPLagrWTMTjlwedpu9eMGahvwRj53oVY9qPXPfXxR
 T21tXZo2poIYDUYUHLFUXCWAFZJbTAJ7GHumj3eznQeBf9LLijx6iMXGytdnt5s38nVO
 vviEs5yxDrgLk6y8oTnBwtLqjhH9+YoKnXMDdRo8y6urLQp5Kg7bfaWr8Zb3VaVJdb/N
 vorkMw5MD3ZigEb9qr0j9Z6DOxUnm9+cSuqljKlbrrwqEqco4/K7nDjmS4eOqLzEV2Ci
 GA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=GCzWriIu4N0LBgO938q0R/XT7fvDgSNrqLwMyXX/ghY=;
 b=ofSR1EihNJvhFMim/Z4Ag3yEbBESn4s3irPlN241526S40umrrsbpZaKMe2yf2a7oh
 anX2vzGL0phBg3lMEkHW19a9cPeVWgWkYjGqKskB1h+g6LEsXfbl1VUK6bRqYCvSWi9l
 h4yg3GMTAbeoXHYgrYhmRJLY2ob95zPVAgqB+l9vJbVLaz27GAsJbnumgeV1mqHOj99C
 Lsb0BFk0SqwuHFCMaaOKO+qeMUBHZ+dD8wdhgz9GxMaN7Wlf4OWhLAcYDW2v67b6iWzb
 EJcslu46uZ5e1tmDEkHellVR5vkKHk92dG6h1UvhldlIgEC7aq2MNonPD/OFkTNonGeH
 SwZQ==
X-Gm-Message-State: APjAAAX12+/FeLL7XmsLQhoBIAUO5yuQ2/xxGjMiFqchwVwiMCecXZx8
 0eyFOhzNNG1crZ6KmXjLxCE=
X-Google-Smtp-Source: APXvYqxWZykeGlXWdoUQq7xaO4FnDylmzVZ5Rd6/tM11UB0hb0FM8TowVLCx4e12nooG2DtJzIz4Yg==
X-Received: by 2002:a17:902:758e:: with SMTP id
 j14mr15094859pll.254.1574436477615; 
 Fri, 22 Nov 2019 07:27:57 -0800 (PST)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b9sm8020053pfp.77.2019.11.22.07.27.56
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 22 Nov 2019 07:27:57 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH] riscv: virt: Allow PCI address 0
Date: Fri, 22 Nov 2019 07:27:52 -0800
Message-Id: <1574436472-6017-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

When testing e1000 with the virt machine, e1000's I/O space cannot
be accessed. Debugging shows that the I/O BAR (BAR1) is correctly
written with address 0 plus I/O enable bit, but QEMU's "info pci"
shows that:

  Bus  0, device   1, function 0:
    Ethernet controller: PCI device 8086:100e
  ...
      BAR1: I/O at 0xffffffffffffffff [0x003e].
  ...

It turns out we should set pci_allow_0_address to true to allow 0
PCI address, otherwise pci_bar_address() treats such address as
PCI_BAR_UNMAPPED.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 23f340d..411bef5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -603,6 +603,7 @@ static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
     mc->init = riscv_virt_board_init;
     mc->max_cpus = 8;
     mc->default_cpu_type = VIRT_CPU;
+    mc->pci_allow_0_address = true;
 }
 
 static const TypeInfo riscv_virt_machine_typeinfo = {
-- 
2.7.4


