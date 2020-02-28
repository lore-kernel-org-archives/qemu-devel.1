Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601A9C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A9424695
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuoicvW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A9424695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eI9-0001aT-AZ
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e8G-0001hT-El
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e8F-0001aC-AH
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42829
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e8D-0001Yy-Gb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8BGhqYvAxWxH9RR4HNdmBjAggFWzcDPf58d0HXElA0=;
 b=DuoicvW3PmlexqPMhZY8s2aZ722x1GIQEUUbuDs8Bi86j8E/x8hZM/mt8zlas+T/K+enzU
 faBINFLteVjPZwuBfLur3fr14bPPxhHMcZdSWnkWwIImzOWdXlwDSi5/Qd0N5uSgRuT9kn
 VRZ90d6CH/7hNg8XosF7kRyJzdwAx0s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-M5O2Ii90ONi62I8_cEzHHg-1; Fri, 28 Feb 2020 06:48:31 -0500
X-MC-Unique: M5O2Ii90ONi62I8_cEzHHg-1
Received: by mail-wr1-f69.google.com with SMTP id z1so1226188wrs.9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XJL8zcwpbbfm3fUEVt8ZadYdnagmELDf/cCcBxJaPzQ=;
 b=sGexRy0KhqTzBxa58HKemQKWeJAHvN8QjEdlHH3G9C/Etl6w8axr3ce6O/mwmtYZgg
 vRN92fhnhzSJlJBaAqiVWte0kzCBTrkDP+99HFJ+KcF0XUB7Qr+sbhkKfxXmXJr8Kb7u
 2E2T8sdot8k1ERD51TuhRveZxgdf2OFauDPHdaxSIWD3yYD0cWeE6XNR0b/YgccdBXcf
 x2LdngY7TgIkeGIXocgAIEWwECa600shwT8bUUBDjdaWqp7ZqXk0kwAW4dcC/MPWbjrz
 7qzHeaFDiXRYvOBEn0rSmQS3sSvigfGZnstOV3qZNjdp3Mfio+6RQfubn2Qu8omiv4//
 xxWw==
X-Gm-Message-State: APjAAAWIRQbRCC1tK0iRO1EjaFsawvEiJOuxv+eIJmPnb5q/4VH4IMAs
 NnRKi+7AhyIm4+2ugB4S83hv3hHuhr0jx4CWR4qsr5ns7vQ0Gu7DWxsdCueZNgFU3vZR9VMcTOp
 3gqIzXyaalX5Rl1o=
X-Received: by 2002:adf:f641:: with SMTP id x1mr4461376wrp.248.1582890510052; 
 Fri, 28 Feb 2020 03:48:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLCjRs3+/wwxvobfNEWrKhWYJfIhitg7qQUMnrsXNtIKgKBTusamdzSQfoVvo9B6Zs8pZyMg==
X-Received: by 2002:adf:f641:: with SMTP id x1mr4461361wrp.248.1582890509891; 
 Fri, 28 Feb 2020 03:48:29 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id a7sm1736226wmj.12.2020.02.28.03.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:48:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/18] hw/acpi: Include "hw/mem/nvdimm.h"
Date: Fri, 28 Feb 2020 12:46:46 +0100
Message-Id: <20200228114649.12818-16-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228114649.12818-1-philmd@redhat.com>
References: <20200228114649.12818-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both ich9.c and piix4.c use methods/definitions declared in the
NVDIMM device header. Include it.

This fixes (when modifying unrelated headers):

  hw/acpi/ich9.c:507:46: error: use of undeclared identifier 'TYPE_NVDIMM'
        if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
                                             ^
  hw/acpi/ich9.c:508:13: error: implicit declaration of function 'nvdimm_ac=
pi_plug_cb' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
            nvdimm_acpi_plug_cb(hotplug_dev, dev);
            ^
  hw/acpi/piix4.c:403:46: error: use of undeclared identifier 'TYPE_NVDIMM'
        if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
                                             ^
  hw/acpi/piix4.c:404:13: error: implicit declaration of function 'nvdimm_a=
cpi_plug_cb' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
            nvdimm_acpi_plug_cb(hotplug_dev, dev);
            ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/ich9.c  | 1 +
 hw/acpi/piix4.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index fdd0a6c79e..4e74284b65 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -39,6 +39,7 @@
=20
 #include "hw/i386/ich9.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
=20
 //#define DEBUG
=20
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 6d621c31e7..b84dbba2c3 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -38,6 +38,7 @@
 #include "hw/acpi/cpu.h"
 #include "hw/hotplug.h"
 #include "hw/mem/pc-dimm.h"
+#include "hw/mem/nvdimm.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/xen/xen.h"
--=20
2.21.1


