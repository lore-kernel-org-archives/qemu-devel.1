Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E16C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E78207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PYbwWM3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E78207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA73-0007Gm-L8
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xn-0003nz-DL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xh-0001hX-B8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0AUFLU81iOp/XrSwN46eEGvmLgBLas9P1ExOqq2lcnE=;
 b=PYbwWM3uux5L+avoayb6/tuOthJ7xwjeXTKjoEa/JcU8CBciXdB2FhJugyJmDRMnWdHx7B
 euMMAL5+Jy4/tVvpoz73zI6DQ3icD3ktGNsobNjdmls4lQHc1G5FZtST0TLOY7BUzsS1+l
 rl6jAq+ufkkIE+d02aZrcg17JWHPAE4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-2JB0ufBEOXqqPGJF9VzJhg-1; Tue, 29 Sep 2020 03:22:06 -0400
X-MC-Unique: 2JB0ufBEOXqqPGJF9VzJhg-1
Received: by mail-wm1-f72.google.com with SMTP id u5so1460020wme.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0AUFLU81iOp/XrSwN46eEGvmLgBLas9P1ExOqq2lcnE=;
 b=Soim/fZ6KsxUxfEPOkTKF+3XtJMlP8O2oi7wgBBoIOm7P1fHDFyiloV7BHflA4YYin
 2hGm+GhFUoIAcbRhY5ScBY7pIC2+MNNpNyhou0ydZLrpRW8ShBORXw366o95p/7RvluP
 uZQs3Hk8z2n3KU72kUeZrciPUlPrvCVHcu2mDJf3HObOhlLbkcJ8burNoiQWy8vAc+K/
 CValo+lrzgqejVf+EdvxG5vgcIOGClOyTihlqXAFk72JLlaCfpDVcy1BDr4l2P5pykA9
 IDYkKkhn21sd3vtqQzglqZ9b2EuXw9Me9WpcT3o04Xg8cy461DpRmXRSS9+C5Qylo4Nx
 durQ==
X-Gm-Message-State: AOAM530SWNnqv1Y2tZHR3Eju0YjFJOomPVIcsaUqeY0QMppGD9TdlUza
 tCVGaBuBTmLbDcGYe37q0ppHuirClYIjjDkwniluNsrZKLbrwxgWHyWulYpXQHbsB7UrwronKa2
 ooU5xjuA7roiQAx8=
X-Received: by 2002:adf:f190:: with SMTP id h16mr2563581wro.202.1601364124894; 
 Tue, 29 Sep 2020 00:22:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc993OvPHddEyqxoNNk5BuaTX7ySdm7mjWUJVJLc9Je7JCQAdpDEl2WTJGZux8+pfvnHMg/Q==
X-Received: by 2002:adf:f190:: with SMTP id h16mr2563564wro.202.1601364124754; 
 Tue, 29 Sep 2020 00:22:04 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id d5sm4915313wrb.28.2020.09.29.00.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:04 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 26/48] x86: ich9: expose "smi_negotiated_features" as a QOM
 property
Message-ID: <20200929071948.281157-27-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Expose the "smi_negotiated_features" field of ICH9LPCState as
a QOM property.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20200923094650.1301166-7-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/ich9.h | 2 ++
 hw/isa/lpc_ich9.c      | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 703d56036a..294024be5f 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -245,6 +245,8 @@ struct ICH9LPCState {
 #define ICH9_SMB_HST_D1                         0x06
 #define ICH9_SMB_HOST_BLOCK_DB                  0x07
 
+#define ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP "x-smi-negotiated-features"
+
 /* bit positions used in fw_cfg SMI feature negotiation */
 #define ICH9_LPC_SMI_F_BROADCAST_BIT            0
 #define ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT          1
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index a54b3ec8bd..04e5323140 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -647,6 +647,9 @@ static void ich9_lpc_initfn(Object *obj)
                                   &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
                                   &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
+    object_property_add_uint64_ptr(obj, ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
+                                   &lpc->smi_negotiated_features,
+                                   OBJ_PROP_FLAG_READ);
 
     ich9_pm_add_properties(obj, &lpc->pm);
 }
-- 
MST


