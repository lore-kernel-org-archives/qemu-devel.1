Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B360DC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FD9216C8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBH6G181"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FD9216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35361 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsWEW-0003sO-ND
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hsWBY-0007OV-EH
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hsWBX-0004l9-E8
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:45:16 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1hsWBX-0004ki-6X
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:45:15 -0400
Received: by mail-pf1-x442.google.com with SMTP id c3so7078924pfa.13
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=cvS6j7L4RGks6c/xdAxmA9aq+ZtT2dbcFIv9lTlHrU8=;
 b=FBH6G181bdVB9ee/nLHCKPAWuZPIvBf7h76ANEsqRY8pk+Pi7wnQNwiXyq/oCXL5L9
 duLVzg7LbkX0FatgchOPgNxzrRx2qmXsweQw/6FBMRRTVm7Hk+huDcSkz4Yeg5bPi3eu
 kMDmfR2bbWIX2vg5Yx/46zEydFYzgu2gngH72QsmXAwVOMqsQquVcJX6qLKTC5/63Eji
 EbkjGJC1mA+DbQhFqRpqnLAgw+FjutMvlbgihxiIKKGhkv8hcHyIQeKSx7J2CHsCB1lS
 bdEf3cJIGiRjwZM6JFcC00gJblp7j+CWQaLJib2qGqG9Oylji7kIrZfb7HVPx+aABope
 vQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=cvS6j7L4RGks6c/xdAxmA9aq+ZtT2dbcFIv9lTlHrU8=;
 b=L0Q2OBOt8nh7OhkatMFAPH1R56uj8+wd9hBntlPhtIihFCXLGI37FBm2LMaJk0Ipox
 ffNdahckXxuuWbbdXPXk4LtQdIRAOcGjhs8nTTucrOs7ipjEPMdWKIq7uEWFygWlriFa
 VZ8ElGeDd/iFKyB7qV8dp2VFpiSVz6QTV1zstxBLRUZ6No2cNWnry+fqeBxU08N3aFox
 KsVW3DYRBRsyDTlnb2aQaewn3lfnveL0DgJOFPqdVu2gj2oFLhiMTuCjwarN8gDD/XEJ
 cECcSd/vHsEfzw+pXB9hhj/oBBwtSETZq7ZdXfz1+embHZUJs3pdcW+HIhkjFAdiHgK5
 PVMA==
X-Gm-Message-State: APjAAAVb3en9z6n4jGGH6iy6mt2wplVr+DBH0hXJCSwMac/76TUH4mHY
 v6y5nf/rlor75rtGT+QyUdQ=
X-Google-Smtp-Source: APXvYqwqdKeqOGyTv4mACkpUkpmyrFSOZAVFe879ObYUD9BmaUKhDRLjGK5cigAGMnLyjJhdJcHDXw==
X-Received: by 2002:a17:90a:1d8:: with SMTP id
 24mr120052444pjd.70.1564508713893; 
 Tue, 30 Jul 2019 10:45:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id r13sm93613640pfr.25.2019.07.30.10.45.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 10:45:12 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 30 Jul 2019 10:45:10 -0700
Message-Id: <1564508710-22909-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH] ehci: Ensure that device is not NULL before
 calling usb_ep_get
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following assert is seen once in a while while resetting the
Linux kernel.

qemu-system-x86_64: hw/usb/core.c:734: usb_ep_get:
	Assertion `dev != NULL' failed.

The call to usb_ep_get() originates from ehci_execute().
Analysis and debugging shows that p->queue->dev can indeed be NULL
in this function. Add check for this condition and return an error
if it is seen.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/usb/hcd-ehci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 62dab05..c759f3e 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1348,6 +1348,11 @@ static int ehci_execute(EHCIPacket *p, const char *action)
         return -1;
     }
 
+    if (p->queue->dev == NULL) {
+        ehci_trace_guest_bug(p->queue->ehci, "No device attached to queue\n");
+        return -1;
+    }
+
     if (get_field(p->qtd.token, QTD_TOKEN_TBYTES) > BUFF_SIZE) {
         ehci_trace_guest_bug(p->queue->ehci,
                              "guest requested more bytes than allowed");
-- 
2.7.4


