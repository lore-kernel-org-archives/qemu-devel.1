Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D40C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C16862073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiP4b49L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16862073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fvt-0007Ou-Sl
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgl-0004Cr-PW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgk-0001Zb-O3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:59 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:52729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgk-0001XX-Hr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:58 -0500
Received: by mail-wm1-x32a.google.com with SMTP id p9so6540515wmc.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=EvzEX/npkzNudVNtgehSYV+xP5AkZNjc9J75BB9mrvE=;
 b=kiP4b49LQ0rcT0I6Ae8+jCGnTsTL5Y6MFNColumoBgaAyluudauZ6YFwoHAVVT+XVH
 EcuoTMHkVLV3Yc0gWjaccrDRhKXbk7eBnxwLgtcruDzgErhVf5gBuvXyZSYryt8sY7hu
 DXs9Fdw0Tcl+0fmbzxJeX05KJLyEKx6slObYXZFwhi+DYiGt2vwC/HXx8r20AmjuTJ8C
 BMUo/HNmYBnBx466X9nrwjHYnQEVFmnhRSjusuS3LpheGmSsZLTxEmoq3y565WM9ljFy
 /0X1ZDOh2p2JCCsFOZX4U18fyiPy6N1L6aA6TLM9eesVtU4xEU6sCcLuic/hwj645vtq
 qRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EvzEX/npkzNudVNtgehSYV+xP5AkZNjc9J75BB9mrvE=;
 b=qoYnwoCoHFi5WHhg2qcHkOZF3crh5UQ7KR2mJQyDfrefrKpz5kcIlGuSNJlVaG8p/U
 4qd9p/tbEw44sK/Z6zE4yAxz516go8qZVNzo5mPQTCFNEwVGU9WN+vQ9S+kER3qTaaQV
 TGIx8rLCTjPKuCrIK00Jr61SMd81xZy51aTjAADSqw4nqrvGGKJ+HGCptKcU4tONBbHO
 nYirmr8nTYICQml6G6AzaCLGaiUiADWtn9srtQv6/vhQ5Sz7200rjd5CyHvixoiZ9Sci
 2Ak4WV75n7jMb4jHxeJfUSlG2VCzsVADddge8WEUOGqvL5ztc/75Pf7jpNmSGhvRjmOz
 9CWg==
X-Gm-Message-State: APjAAAVLrKq7UMmO2IWnDZ03y/3NsHFIccibDId2rq6TvplAsVMNLoVB
 /vgQyVigi1sTQQwtH66G4QAvhv+tDzI=
X-Google-Smtp-Source: APXvYqwIziJ2N0bGB8ub4aNUGx5Jw/tz+t8RL3CVeNLRxm0NARf8oEh94E1L/XMTb+VJq0Uhl7kQqQ==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr6511058wmf.105.1581604916910; 
 Thu, 13 Feb 2020 06:41:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.41.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:41:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/46] arm/acpi: simplify the description of PCI _CRS
Date: Thu, 13 Feb 2020 14:41:07 +0000
Message-Id: <20200213144145.818-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

From: Heyi Guo <guoheyi@huawei.com>

The original code defines a named object for the resource template but
then returns the resource template object itself; the resulted output
is like below:

Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
{
    Name (RBUF, ResourceTemplate ()
    {
        WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
            0x0000,             // Granularity
            0x0000,             // Range Minimum
            0x00FF,             // Range Maximum
            0x0000,             // Translation Offset
            0x0100,             // Length
            ,, )
        ......
    })
    Return (ResourceTemplate ()
    {
        WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
            0x0000,             // Granularity
            0x0000,             // Range Minimum
            0x00FF,             // Range Maximum
            0x0000,             // Translation Offset
            0x0100,             // Length
            ,, )
        ......
    })
}

So the named object "RBUF" is actually useless. The more natural way
is to return RBUF instead, or simply drop RBUF definition.

Choose the latter one to simplify the code.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200204014325.16279-7-guoheyi@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f3e340b1729..fb4b166f82c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -236,7 +236,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
                              size_mmio_high));
     }
 
-    aml_append(method, aml_name_decl("RBUF", rbuf));
     aml_append(method, aml_return(rbuf));
     aml_append(dev, method);
 
-- 
2.20.1


