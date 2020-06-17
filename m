Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D975C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E792320776
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 11:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCndc+86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E792320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVtS-0000aZ-6O
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 07:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlVql-0005hQ-VZ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:03:24 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:43794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlVqj-0005K9-PP
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 07:03:23 -0400
Received: by mail-ej1-x642.google.com with SMTP id l12so1825818ejn.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WiNUb7t32KnTMP03i/GQezdP9adjf5u3/DZqFCVRrqs=;
 b=fCndc+86fuFDxadHuNrbrNaPjXpZq/GfveWO3KTK+OtXetzWXRpXkKS/c7sQ5PWHze
 lKajarmMWe/uw/XMh6OdENLu9TqpNCMVOMcUQyhvzpcKoxE2aoQKfI3iHdyjKpFVjFiW
 3JSRydjnIGDw1fAnWkaL3uK5afgl05zg22mtqspMKa5y4HLBqVMNbgVmxVM1TQbv+VSN
 KZ5N5N9RAa8Y1VjYkzkapyUSzfyKDQJU4iuDXSTqX/kjr3sU6gE+5FVjdvcCts5qDKPF
 P/u62MdVpi3FGi3Spyih4zNwqKindNOhivHTF7L0Z/vo8QNT3lieUV0wbOk19QX4xqqr
 cOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WiNUb7t32KnTMP03i/GQezdP9adjf5u3/DZqFCVRrqs=;
 b=g0osc7BpEE4b341bxV6sJlJ9OH69WmpdTU16SL6BRsDmuUUR79l43AAL7F4dnSDOr7
 yN/lMcDIF/VDGb17JO3XBw8JH8x7BnrgXXCVaY8dEX/lp0JaN+twtnhmCOx1Qkxnha5w
 HvfZGOb7ElCNTtnyGzEOJOCW6WvFb5BQwW00gy8I3D7UwjrmtHDcU+uS7ToaSmQu9ptc
 /aA8a4zX12MiFvdHv6DqDZRq2+ed1FKBSMEzl/gXbFgxOgz0L/WoZzo7Nj4T+APcQfFu
 1BUDERUfqM26RSYjkhKY8P3zMQYadM81ijH6VZEFkiCrlkc2l3CvAX5Gqxmyw6SBjNti
 SJbw==
X-Gm-Message-State: AOAM532lUbeFwBTIu0T5TzXW77rwOsxQt4T/RcdRzvb87fqCJqlw5c02
 liVNa5D3npbiuNHhy2lUKvTS6hwH
X-Google-Smtp-Source: ABdhPJzupnxEIo99d/+2gAsYak2sXfm/d+ISqDN/u5H7AODlg9Y1QMuwgcWDCwgRN8cE7yg1jLvo1w==
X-Received: by 2002:a17:907:7294:: with SMTP id
 dt20mr6840732ejc.355.1592391800322; 
 Wed, 17 Jun 2020 04:03:20 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 dc8sm11835806edb.10.2020.06.17.04.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 04:03:19 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/3] i386: acpi: vmbus: Add _ADR definition
Date: Wed, 17 Jun 2020 14:03:03 +0300
Message-Id: <20200617110304.636666-3-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617110304.636666-1-arilou@gmail.com>
References: <20200617110304.636666-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mail@maciej.szmigiero.name, Jon Doron <arilou@gmail.com>,
 rvkagan@yandex-team.ru, imammedo@redhat.com, pbonzini@redhat.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It seems like latest HyperV sets _ADR to 0 in the ACPI for the VMBS

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/i386/acpi-build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index dce680e97c..508f5d9dd7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1061,6 +1061,7 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
 
     dev = aml_device("VMBS");
     aml_append(dev, aml_name_decl("STA", aml_int(0xF)));
+    aml_append(dev, aml_name_decl("_ADR", aml_int(0x0)));
     aml_append(dev, aml_name_decl("_HID", aml_string("VMBus")));
     aml_append(dev, aml_name_decl("_UID", aml_int(0x0)));
     aml_append(dev, aml_name_decl("_DDN", aml_string("VMBUS")));
-- 
2.24.1


