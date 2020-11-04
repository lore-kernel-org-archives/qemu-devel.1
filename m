Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E46C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277F020BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yorg10/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277F020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaBCw-0003pK-7L
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAxx-0001RO-MP
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 00:04:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAxv-0000OQ-3V
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 00:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604466250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kxx7KBtrm7vYLNNi8ILRStjcIKIqdM/KqZjCc2FDurE=;
 b=Yorg10/LTSaZKxvoe6KCVCuXKr5F0v2QIzioiMq87D39dXffNt4gTz1q6SOb/kenupqNhL
 TKRGY8v74CoUpnJXmcds/Ky5JWei0Ol7FmviSH1EZe26OMfCSXedbpMOVvhMps+oZadnJ5
 ILCAr6w7GMkeAwTkapN1FyH/r5Oi0UM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-rdD6XZqoMlyucA7B8eusGA-1; Tue, 03 Nov 2020 23:51:13 -0500
X-MC-Unique: rdD6XZqoMlyucA7B8eusGA-1
Received: by mail-wr1-f70.google.com with SMTP id v5so8788369wrr.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kxx7KBtrm7vYLNNi8ILRStjcIKIqdM/KqZjCc2FDurE=;
 b=eaeMeFAEE1f6wCwB9hUi2A1mrBHxY0Ci0fB6ssDh3wldWyjslrjrjYx32tyY8lUxGE
 GCbh4nOFzrhmI0086I2R7XuzaJMknva4Mqvuc0OPPwayXJUbuTJ1NYsMsxD7DAcW/5of
 lrQ1B8DMy3WO9ZkJ555NFNQtkLTxn7TMlzOTSmT2iIWwNurGngeCb/q+RP3RQOKh4iqq
 fOgdmwqmPK7OaMPpujiyQPp9NZIl8lRpQ21ak/HIaz6SyOQQLHqOpOr2MVT5j/DO4h//
 cspiXD5X4bzw6H3iWWJf1uwnvlMte1oGPggbYkb/fhoENknkfm9F3Yhye1zI+SitNBIi
 zSuw==
X-Gm-Message-State: AOAM532JFDkjQuJq5+WPz5/KreJ1C8XCaK/Gwh4zluzI+rDHkGm+2MB4
 pyHV0wpOb+R3wDR8Iss+YCPiRXvviCZHX00cwX8ku5e6u2Q9P5OANwD9VpBCOZ46Eyav9Cr9ZAZ
 P0uRmEc13oCaWBgU=
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr11675060wro.63.1604465472130; 
 Tue, 03 Nov 2020 20:51:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXS2o5I7NKNl1d9yjYzni7laQE3Lf9kXXMHhjkEApkeyPw5C9iYEyYc/QEW2bghgeZ//t5xQ==
X-Received: by 2002:adf:ed4c:: with SMTP id u12mr11675046wro.63.1604465471963; 
 Tue, 03 Nov 2020 20:51:11 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id 30sm852812wrs.84.2020.11.03.20.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:11 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/38] hw/acpi : add spaces around operator
Message-ID: <20201104044937.226370-11-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Kai Deng <dengkai1@huawei.com>,
 Xinhao Zhang <zhangxinhao1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xinhao Zhang <zhangxinhao1@huawei.com>

Fix code style. Operator needs spaces both sides.

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
Message-Id: <20201103102634.273021-3-zhangxinhao1@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/pcihp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 32ae8b2c0a..17c32e0ffd 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -400,7 +400,7 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
     s->io_len = ACPI_PCIHP_SIZE;
     s->io_base = ACPI_PCIHP_ADDR;
 
-    s->root= root_bus;
+    s->root = root_bus;
     s->legacy_piix = !bridges_enabled;
 
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
-- 
MST


