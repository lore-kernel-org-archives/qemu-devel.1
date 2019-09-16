Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71549C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB082184D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7NIO+XV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB082184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tBZ-0003Hr-H2
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD1-0006aI-Jf
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCz-0007Vh-Qr
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:31 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sCz-0007VP-Ec
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:29 -0400
Received: by mail-wr1-x42b.google.com with SMTP id v8so3820469wrt.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N0oh/2xJJWk1j4doZ9EhbFAH+Bw5VBTm7B5dvFyJxMo=;
 b=u7NIO+XVj3ccpipmfYTQfbR+8BRbI7a/u5aUDIvMiF+EyKgi1A+IH7Afa6svOk4Amv
 uuGHgIiybSfV7sVVD8kPUSO/ZrZ+WFAnwIXITRi6PGl7DqlrY1TROq0trF5e/sHnf5Db
 wwaYRnorvn0OYDvtLMKuuwrRwMzV379t7b6lPHKC8uSbtKxBB2OzyM1xAZZRMuGWzrFT
 E4d+TX2Ye8J2Nxx2TwG1Mg6NZeKA4WmwsluIRY01yuMOro5gbbviPhOnHHSnk6eIsorP
 6kjIQhqBsYzbXv0A/5RKDl8K8GdxR88ffN2+3DMhQ8Tmow5wHP1EUJpk5ivYevmZtglk
 XxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=N0oh/2xJJWk1j4doZ9EhbFAH+Bw5VBTm7B5dvFyJxMo=;
 b=gcIMOYTzD4HJ0+RlWJu54jYT5YlY7ZGa+0zxoBYv1Wkvd6a6b9fRqhpHQQXTskrgFR
 XiIWmEDB3CPPUKnOgtDWyWUtUuEyHm7dIJ6IjO61vSfZOCjE3gKI94jfoN90p2x0JMgv
 iUKPt9PnDApd98PmenkHNZR1kuQJwpoP0yq4BNDtWUQUZoo568QxCSBZca7qi3TBuhtj
 WPXuR3CWuDlqoBZDRGld/miaRDbWFm/q0zX5HMg6xg97+kULcDpMgYEBKd3OhpPVarQw
 +kwdgvAfSfx8kbr6mFT54TKqzpU5W3E2Z1+WUDZ/R99iX5pCuT6Hpso5n+/ptFwnF/2w
 6VKQ==
X-Gm-Message-State: APjAAAW3F5+MpANyG3kWSWyHE3dCE+c5ignr3hLsJzARl1XAuM7m32MP
 qS4w53iXWL0gRx38/v7kKdRO08MZ
X-Google-Smtp-Source: APXvYqxrb6gZxLpOdwr98FsFqFBV16qQXwNqVU1sOSTgsEk39cGHAQJ9xMHRmcgd/sa6cq9YZB+J4Q==
X-Received: by 2002:adf:f112:: with SMTP id r18mr140843wro.88.1568644947938;
 Mon, 16 Sep 2019 07:42:27 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:55 +0200
Message-Id: <1568644929-9124-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PULL 15/29] hw/i386/pc: Use e820_get_num_entries() to
 access e820_entries
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

To be able to extract the e820* code out of this file (in the next
patch), access e820_entries with its correct helper.

Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190818225414.22590-2-philmd@redhat.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bad866f..31e9c1f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1029,7 +1029,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as, PCMachineState *pcms)
     fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
                      &e820_reserve, sizeof(e820_reserve));
     fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
-                    sizeof(struct e820_entry) * e820_entries);
+                    sizeof(struct e820_entry) * e820_get_num_entries());
 
     fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
     /* allocate memory for the NUMA channel: one (64bit) word for the number
-- 
1.8.3.1



