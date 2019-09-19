Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45533C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB04208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0lujuMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB04208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4Pu-0002O9-72
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49f-0001Yx-MZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49S-0006CC-3W
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:55 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49R-0006Bb-8O
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:45 -0400
Received: by mail-ot1-x341.google.com with SMTP id g25so4486123otl.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SZ14L8l0Spjq6/ThzBDUirtAqlBzB2jLWm1AH1q1hs4=;
 b=L0lujuMy43rlng/dMaQfYBtzKggUQuSrLNyHHrzP+49AT7DjO6wG9ffOX2NIH7P+q8
 vEL9L3iD7IG8sOFq+pVzZjI+me/u7JnBeo7NaS3/TRlwN2ac8KNTYYUPwMW3MViNOUBR
 kOHRCXrstya/BbBv5eBwWY3YTV6QrXQpKFtMJD5iJi0ci513SmwlmhZ11iLQ8yVnOW83
 /GH4tPtZQja4khD3+rVk85WoJ4RHdtowH7MM5ZoMU44I8fahjuFeyu7k4MYHGG4pawIN
 7XV6dVVgEfaIWxxL13V+dcUVKMlEic9PmN8YgWnGUPuMa5Zzxk3pWr2vBYs3YxNS9IJm
 rzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=SZ14L8l0Spjq6/ThzBDUirtAqlBzB2jLWm1AH1q1hs4=;
 b=oANG39lKLXjX+RvZooNUgjTtMcU6lYCZzW04aZ4uZrfoyS8/8m3x9AeH5cs1xNMZqW
 SWfS0zRyZiNQeuheiirsKE2I2r88ghh84OxwzzP1AT/RFss0T9EJuZxh72YxL2lHWyQE
 rlGsxWsw00JzAtJQVxi6aeYQW7bRPi/MxeKd6RLXAzc+WvzFASfYfcl7xUNOA0bokBme
 rSbDainVDRxcmPG1NNMWCid4XZO3GT5/tVtgXe2BIQ4JkfoxwqdrW1BeuC9/lDD8uTFI
 b+tqr+8OsoKBwZ7Fqsqxav4pEWv2ZeWt89LOCLh+WS5NQndURrsR+ZiWVSdl6V34ibXb
 covw==
X-Gm-Message-State: APjAAAWvWUbJl9sFpAimTcXweNtIrhB2lzpdu8LubtJEXtNDgM4zs0D7
 8alhyKOiZsWp3bhiSAgRuw==
X-Google-Smtp-Source: APXvYqzslGAmP+/hOt3M7FRWJkxc2qX4k9P2Py6D3epM6uRRjC08EwngY2Ne8d5yqpRMit2FgqrZng==
X-Received: by 2002:a05:6830:1492:: with SMTP id
 s18mr3499985otq.283.1568929184475; 
 Thu, 19 Sep 2019 14:39:44 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id r26sm32373oij.46.2019.09.19.14.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:40 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id F3BDB1805A2;
 Thu, 19 Sep 2019 21:39:36 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 10/15] smbios:ipmi: Ignore IPMI devices with no fwinfo function
Date: Thu, 19 Sep 2019 16:39:19 -0500
Message-Id: <20190919213924.31852-11-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

Not all devices have fwinfo (like the coming PCI one), so ignore
them if the their fwinfo function is NULL.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/smbios/smbios_type_38.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
index 0c08f282de..168b886647 100644
--- a/hw/smbios/smbios_type_38.c
+++ b/hw/smbios/smbios_type_38.c
@@ -94,6 +94,9 @@ static void smbios_add_ipmi_devices(BusState *bus)
             ii = IPMI_INTERFACE(obj);
             iic = IPMI_INTERFACE_GET_CLASS(obj);
             memset(&info, 0, sizeof(info));
+            if (!iic->get_fwinfo) {
+                continue;
+            }
             iic->get_fwinfo(ii, &info);
             smbios_build_one_type_38(&info);
             continue;
-- 
2.17.1


