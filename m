Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B23EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C68207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bd1MT3oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C68207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jistb-0001iG-V0
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisPD-0005Zn-OE
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:32:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisPC-0000k6-Px
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2tWNry73oPv2gQlztpgeBRBkHzYAUwx8arM+2V6vlZU=;
 b=Bd1MT3oUk38A/EFEMY7sLiouqHQxqcGXRhSx5fdgLVB4LWf+/INSf7WD/1NurHfYshT1ZJ
 IBMZvBZFqU6R2/UuI2NoU1fudS+WwP/hjXIb2c2muDIM1n6oXQtJtHXgouccfDe6hbhr82
 xqyYkoUvjxjuuCHjIDnMBtblARzVJyo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-by6ql6GrPXmkQqHNt62bSQ-1; Wed, 10 Jun 2020 00:28:38 -0400
X-MC-Unique: by6ql6GrPXmkQqHNt62bSQ-1
Received: by mail-wm1-f72.google.com with SMTP id j128so87258wmj.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2tWNry73oPv2gQlztpgeBRBkHzYAUwx8arM+2V6vlZU=;
 b=dg/eVHWCdpMWM+SHIpVIcJi4oUGtA6omoFK3otd/WX3cDVhr3z7/dO1kUJXnZYSYVj
 taxHW6AHy71V5hFlOpJnoNajwQ31uHsm1TJIbNTGXjxeS5hgkJwTbl51/iaSxgd/8tlP
 YnyKF+59bJz7jj5Ds5vuMwTKYuZBccD1rg3mnLYKJVhdNftQVRA0hWxMhuihRY+8l89o
 f85DF4BvQ8wPT3ow4bOqVZ8a4BficR0c+2yxTelus77njx0OUd3u0RENxgnvT9lqvk4l
 xQHy9tMjIxKVs5/76ChGSWZTIxIMKtjWMqlkmskPWrqb91z36g4TWNSw9Hga0L3EFGhh
 +mVA==
X-Gm-Message-State: AOAM533rGttBcuSdjP7SuYEDMe6v9sTdWA8H5fc5JaxMJiwQ8wBVdAZM
 XXWN0pg9I9WOfSQqMa66G316xB4PG83X0uPTOk3aaCtF3TTFzPRGz8c87WvtdUaMmelBG1F7pDj
 HPysdlUvqt7NpzV8=
X-Received: by 2002:a1c:7e41:: with SMTP id z62mr1096646wmc.113.1591763316720; 
 Tue, 09 Jun 2020 21:28:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoRBMsoAlLRMxxflDDwWDOKBE+u/+3Whwk4ZwJ3SGYy4OmlXYI/g8YMta1SLCeS8cZUQeyCg==
X-Received: by 2002:a1c:7e41:: with SMTP id z62mr1096638wmc.113.1591763316526; 
 Tue, 09 Jun 2020 21:28:36 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id e10sm6210290wrn.11.2020.06.09.21.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:36 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 54/56] acpi: fadt: add hw-reduced sleep register support
Message-ID: <20200610042613.1459309-55-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Add fields to struct AcpiFadtData and update build_fadt() to properly
generate sleep register entries.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200520132003.9492-9-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi-defs.h | 2 ++
 hw/acpi/aml-build.c         | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index c13327fa78..3be9ab5049 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -88,6 +88,8 @@ typedef struct AcpiFadtData {
     struct AcpiGenericAddress pm_tmr;    /* PM_TMR_BLK */
     struct AcpiGenericAddress gpe0_blk;  /* GPE0_BLK */
     struct AcpiGenericAddress reset_reg; /* RESET_REG */
+    struct AcpiGenericAddress sleep_ctl; /* SLEEP_CONTROL_REG */
+    struct AcpiGenericAddress sleep_sts; /* SLEEP_STATUS_REG */
     uint8_t reset_val;         /* RESET_VALUE */
     uint8_t  rev;              /* Revision */
     uint32_t flags;            /* Flags */
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index d24e9e6c3a..2cb7b991ef 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1866,9 +1866,9 @@ void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
     }
 
     /* SLEEP_CONTROL_REG */
-    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
+    build_append_gas_from_struct(tbl, &f->sleep_ctl);
     /* SLEEP_STATUS_REG */
-    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
+    build_append_gas_from_struct(tbl, &f->sleep_sts);
 
     /* TODO: extra fields need to be added to support revisions above rev5 */
     assert(f->rev == 5);
-- 
MST


