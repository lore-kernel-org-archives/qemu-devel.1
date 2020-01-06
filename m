Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EAEC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A56A2075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrAP8wv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A56A2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUTS-0006t3-Nj
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1ioUHp-0006cF-Ie
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1ioUHm-000810-6c
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:27:21 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ioUHm-000802-22
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 10:27:18 -0500
Received: by mail-ot1-x341.google.com with SMTP id p8so35711823oth.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 07:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=RALcAVMrFgZq7I9MBPW6YNVoQ1qjsckt124hKks9wk4=;
 b=SrAP8wv92ItJK/zTkHiXJ17CcFOI0JnJSorhRxvx3KW4Yaq1m0w0uICyy8CU85ANF3
 oV2QczP+04Duyy9N2JDHs4Ot2hQsg5Fs+jauN8fp3at9mEaES0iD5wL0dYVix6jMKuKO
 cqS5AJ9pIxtfpQlsh/cMPSAGHu9JJ87wrz1KHfQ+Z1XTLy6igsKnYFtp0PIqDvb9ULrN
 3qY/sobDjT6VHJkRv4xtFh4vvjKDNA4OrgjTYF11j4hwj05LIPTU8F9mHsGoRJReC9DN
 K9T1duha0tXAPeT5WapO1AVxQNcNxizsqfGfdeXmczfzLAEI61PDij3eIGLPkJ2XLNFW
 G6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=RALcAVMrFgZq7I9MBPW6YNVoQ1qjsckt124hKks9wk4=;
 b=EkA94BOorTGIEt02aYYy4TWqlkGq/DTZjgjT1ELgh9jLl4kiWPzIbIE2Upuvz4Pys6
 my9EZWY/I4hRbvLjAITMOZSgFq7Hsw87QeWMqwR/aV2wlfKmyNrZzopd7Ml5Y9YF7xvx
 COLYN8F5Lh8ZBueS5Gi42VvEExNaWaa6r3GxjPKADoEMyS8R8Sf872yM4Z8Iscz66Pfr
 tod93vZEIP0o6Rg4z5mtm78go+kDugjG1e5arDX1uQgcPjapKQG0VX2jm3IIV+5Ok+17
 jqIDhLWFvm2MdGHcYpv0nRgYc5ydJr+AygunAuMuDPKwuIKDriMsTBe+BOkSHt+RiK8v
 Tnfw==
X-Gm-Message-State: APjAAAXu2e/U7gK+swQSaLByhvBbGaJcKNysMoOS1QzFFY0bmhHt+b7V
 9Y756zxuDj7dl89IiMqxUw==
X-Google-Smtp-Source: APXvYqxEbniKz152PhZQ33JLNRkyrjRQiyDHQsXhJG4B4TQM72cbaKmGbJWzt9R+IdHxmWTo792msw==
X-Received: by 2002:a9d:3a65:: with SMTP id j92mr117482186otc.37.1578324436612; 
 Mon, 06 Jan 2020 07:27:16 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id 17sm24243378oty.48.2020.01.06.07.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 07:27:16 -0800 (PST)
Received: from t560.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:adc3:7c20:81:d62b])
 by serve.minyard.net (Postfix) with ESMTPA id 6DB1D180050;
 Mon,  6 Jan 2020 15:27:15 +0000 (UTC)
From: minyard@acm.org
To: qemu-devel@nongnu.org
Subject: [PATCH] i386:acpi: Remove _HID from the SMBus ACPI entry
Date: Mon,  6 Jan 2020 09:27:05 -0600
Message-Id: <20200106152705.8258-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, wanghaibin.wang@huawei.com,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Per the ACPI spec (version 6.1, section 6.1.5 _HID) it is not required
on enumerated buses (like PCI in this case), _ADR is required (and is
already there).  And the _HID value is wrong.  Linux appears to ignore
the _HID entry, but it confuses Windows.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7b8da62d41..ab73a8f4c8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1815,7 +1815,6 @@ static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
     Aml *scope = aml_scope("_SB.PCI0");
     Aml *dev = aml_device("SMB0");
 
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
     aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func)));
     build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
     aml_append(scope, dev);
-- 
2.17.1


