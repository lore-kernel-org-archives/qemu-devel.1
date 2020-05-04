Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCBAC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D63C206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMxoSTjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D63C206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWaA-0007tl-En
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWXs-0003Kp-2I
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:33:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:38160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWXq-0007Rn-Lm
 for qemu-devel@nongnu.org; Mon, 04 May 2020 04:33:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id x17so19850060wrt.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fHSKVhvgJ0/ZOfFaf+BP/P6hX2XQjwkZB5BoXLgjiYk=;
 b=hMxoSTjfJ80sQfPeIaXs98wQXEsQbyGvMOoag6M9eMCmfwFah4SbUvlGvFO9v9RSzk
 kfxrQscyzsG4RU81fIHbMfP9NAKhsMzJKz/Ve5fqsjlgUJL+1xYM9ysrENiZ5FdhxnYV
 L6qK8z7Xx28VZjOFawqtxWsY3myems5bXyBwXrbM8ao3nUCpwDcWU6EUUEVqKYPHgQCi
 3dEbczUGignSEM458OHUZABs4pFdAUhbqzKGr0Radyn7on25LY9YnuQHvpgAuBkBezRV
 5XYThjHzWRX3A3Q8hxc6DyFd/pFasJw+non4fU4Y5Og1ST51S0tXidn67fYgNNCfL21w
 jhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fHSKVhvgJ0/ZOfFaf+BP/P6hX2XQjwkZB5BoXLgjiYk=;
 b=QOMIkMgkpiSUqs78vTCnl8yVB64jZCo5wUK2+lHM81lRzFOZfaeQrqm/wmiXWb/l0l
 Vhzg/k3G2edqKI+znL2wx3Kz6kt4mIa3C1D9BmIOr/cmasRkpss6ilSecNu8cR8NcLjE
 Of9yeZHvQr7sDUqhdcr434pDXZ9fVZKt5VcOl3ExZjT+J2FIoh9S5P4cpO08puymga9F
 oS6tN6BD2rFF6E+3YUQk7B+XL+esZbkO5V2TGhIMppxPY/tqIB1YEwgFy3zzJhqWgTuP
 krC7Qwax6epucYSojmCdjWNxVKWAIvYnw5rT5/sC35zf610XBH52+VhYjfBr28zdHjOo
 uA9A==
X-Gm-Message-State: AGi0Pub5CDeGOP9Y7AWJEotBzPw8mAVrFm47IhDor16PbJH72cMe8Nqu
 ESz78ArWTsJ3WgHkLW2H6iLB7T/I
X-Google-Smtp-Source: APiQypJd8ySdOwLgwomQkWryWn5gCaTMV526JzY+aSlDmQQbBEIz1vpjUCET/mExAr6C231y8aiA+Q==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr19216874wru.326.1588581225080; 
 Mon, 04 May 2020 01:33:45 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id 2sm13048053wre.25.2020.05.04.01.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 01:33:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/i386/pc: Create 'vmport' device in place
Date: Mon,  4 May 2020 10:33:39 +0200
Message-Id: <20200504083342.24273-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504083342.24273-1-f4bug@amsat.org>
References: <20200504083342.24273-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x429.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i386/pc.h | 6 ------
 hw/i386/pc.c         | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6ab6eda046..26e2a3d92b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -132,12 +132,6 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
 /* vmport.c */
 #define TYPE_VMPORT "vmport"
 typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
-
-static inline void vmport_init(ISABus *bus)
-{
-    isa_create_simple(bus, TYPE_VMPORT);
-}
-
 void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque);
 void vmmouse_get_data(uint32_t *data);
 void vmmouse_set_data(const uint32_t *data);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5143c51653..84669ddc84 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1152,7 +1152,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
 
     i8042 = isa_create_simple(isa_bus, "i8042");
     if (!no_vmport) {
-        vmport_init(isa_bus);
+        isa_create_simple(isa_bus, TYPE_VMPORT);
         vmmouse = isa_try_create(isa_bus, "vmmouse");
     } else {
         vmmouse = NULL;
-- 
2.21.3


