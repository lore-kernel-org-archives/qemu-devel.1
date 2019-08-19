Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB916C3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7548E206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBdzmvdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7548E206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzo7j-00013T-2g
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5o-0007gw-GL
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5h-0003Ir-G5
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:28 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hzo5h-0003Hp-B5
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:21 -0400
Received: by mail-ot1-x343.google.com with SMTP id b1so2888305otp.6
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SZ14L8l0Spjq6/ThzBDUirtAqlBzB2jLWm1AH1q1hs4=;
 b=eBdzmvdL6I0zZ3k7ix3IgDXw4Y4p4NJAB5WrTzcjitcGP/2aYakYlHRv5vdbDzwIX3
 FAdnCIB//uDPHeSAcx2GI6AosZmyJgx7+Am8J2onf8GZ9qrJGewKgSXDYKF2qpPxlF6n
 ZnntQ6X2UYJwxycyQJOLmenCz3VseAnaJstNvTyK7axnHwpSWQ2bFVCpuswS09g31QO5
 XwobTq1hDASd7zhpaC/LZ8fvlwUS+/Ln0LvwM1zRdSMM9u7c6E0FJts8dLSBUi/B6IFq
 MtGLKWMvyPsgqJ0+Et6i/sfqgacJSKSvmrWn7/LAQHYQc8qCYHXSvauMfAmzNl+YNRle
 OnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=SZ14L8l0Spjq6/ThzBDUirtAqlBzB2jLWm1AH1q1hs4=;
 b=E6lKhRSJgXi97fzQLbgztCnrPfujS9u6aawE426vrOmBeACPkAF8qvXQ7uq7CuhZZM
 d3SFFU65gxEIMz8eWgCmk1JsPDBtxdX1WMszsgCqkEMDDfsf+RvHvBCpf9oVEu7qI159
 jiALKyO5phCs1mAaderb3tdROIwqiIDmSCFlPX/XtKKQM7DtpKnAXJZzichSwVvHrn73
 raoo1+oV59BFml5IZ1nwVVHS8kEONMuO/YyCviqFNnpU3ZqFw55jI5pmjjmDfjQHCGW9
 IScCgV8nyV3eNpAxh4xo903wo/10GXOva+1NigAQxUf7ZsSP70Msa8GUUIuOJCLSt7Er
 RP9A==
X-Gm-Message-State: APjAAAX/q4AmPPTbQMveVRcg2HQPrU57BvW5xMyMJXbpG68WDQ2icyq3
 6NzA0sryWITiGa/tTu/7lQ==
X-Google-Smtp-Source: APXvYqxcIItNy9Yaqrkk3gXA502l7CBX002THJLFyi6lILMvykqYrtDSyMzXE+JcXyrNvwABqANvTw==
X-Received: by 2002:a05:6830:187:: with SMTP id
 q7mr15944365ota.23.1566245840175; 
 Mon, 19 Aug 2019 13:17:20 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
 by smtp.gmail.com with ESMTPSA id i22sm5703395oto.80.2019.08.19.13.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 13:17:19 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id D93031805A8;
 Mon, 19 Aug 2019 20:17:17 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id A65B2302524; Mon, 19 Aug 2019 15:17:17 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon, 19 Aug 2019 15:17:00 -0500
Message-Id: <20190819201705.31633-11-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819201705.31633-1-minyard@acm.org>
References: <20190819201705.31633-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: [Qemu-devel] [PATCH 10/15] smbios:ipmi: Ignore IPMI devices with no
 fwinfo function
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
Cc: Corey Minyard <cminyard@mvista.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
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


