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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4335CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F482080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aE77UK9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F482080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlafQ-00069J-95
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlacu-0002Qt-UJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:09:24 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlact-0008FZ-FV
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:09:24 -0400
Received: by mail-ed1-x541.google.com with SMTP id w7so2429521edt.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rn1IAhGNs9/upHthsg/8AavsULB5jQuIWRYuBoQ3LOY=;
 b=aE77UK9H9VuQY5sDkMsvL2qDEkUNj9pQpz4BgF8rdlwB1SCOKLZhF7N5EkPX+Grvk5
 E2IhThKrguJUkBZVaSDbDg2FANXthrpQ6b7QKUnnGP6k8CTs6OEnqKp5o3Y+WbQ5XFo3
 /sN2Y1YymBj2/c4o3Z161nA2c3dGXNf2YVOe5lWfsIiWWlZJofQjACiorsyKAPNO4pw4
 tKOow6KAcVg5S8beRu/N7CeLSJLy6JN6KFMPwzR7ILXyXIlGBmHHxZllnpPBcSAcneyQ
 s57UIRuRnMv/klz9h6oBUb1X2tvknqny0UNYxHOuNn6ItDpOut2wIdw40Mw6yZ7L9w7p
 pABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rn1IAhGNs9/upHthsg/8AavsULB5jQuIWRYuBoQ3LOY=;
 b=Y3Stfdi2krUwTBW40Wk+0XnTuwKoE27xz+U3IGM03j/O9Bs9cUHhBHpxHve711jT3o
 hxo+Bkln6xOQ3X4PXMAKLp3b0SGwma4kKw2TBNuxUBOmia5O3DxIWGa7DiN0Y6KZk2Cy
 DXg03gfN3JWCExycW3HdTsXQdiZj8q2HstYdZulhg86Pm1TNmCBvUSCRPOaUYsfd/rI4
 TBVO8b8g67xGdFnFiSD0MrneKeP8e4dqBclBuDOFCrm5UbOECcC4EKneBbBcEeyPeasS
 MpZiz1qDQEQl41JX4G0Kp2uazyL/EyKo2EMSO1V5Vo/9K3lBG9YhNrLZE/SALgjc305+
 yNzQ==
X-Gm-Message-State: AOAM533HtN1+wIbpycuAmZaBS9/sPxs15EIZSWutr7VxEnyJOxtBjHto
 6e604kKwI5tiDjMf6jhOiYHoUhBeIYA=
X-Google-Smtp-Source: ABdhPJwr/jlPGs7aNNNdUXWFM1lUZxeGOWtaF+bWDCXTD0hom2IWKa3nsX+8bbZm2yVZ1kbbe47yQQ==
X-Received: by 2002:a05:6402:148f:: with SMTP id
 e15mr8245903edv.368.1592410162035; 
 Wed, 17 Jun 2020 09:09:22 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 bs1sm65365edb.43.2020.06.17.09.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 09:09:21 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] i386: acpi: vmbus: Add _ADR definition
Date: Wed, 17 Jun 2020 19:09:03 +0300
Message-Id: <20200617160904.681845-3-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617160904.681845-1-arilou@gmail.com>
References: <20200617160904.681845-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=arilou@gmail.com; helo=mail-ed1-x541.google.com
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
index 91af0d2d0d..6d9df38e31 100644
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


