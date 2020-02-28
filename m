Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3451CC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F242C2084E
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PrvmETWy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F242C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eCS-0000lg-2f
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e7g-0000V2-8I
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e7f-0001SK-9B
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60677
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e7f-0001Rk-5r
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HrRTVdOozv2swNberymfD/6/LBZVv8zEj+lFL8+gIA8=;
 b=PrvmETWyOxiyo3gYRHdvQCzoJzhWpQyeckfHzjIRstVZHFNSYfBlgc+LC6xArArTsxCu5M
 Fj0ZXULFwoXxiLgZZXH4xxW1vFKSgJ4RtergABTyeelPeZNyNSPkgMJYtAy360u+oHNOJf
 SLJQeUj/lWltQVxdEPagKn6uiMYmWkU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-wWCx-xZaNZaFSlmBJDwAAw-1; Fri, 28 Feb 2020 06:47:59 -0500
X-MC-Unique: wWCx-xZaNZaFSlmBJDwAAw-1
Received: by mail-wr1-f70.google.com with SMTP id z15so1238868wrw.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yh9hMHA4I8RamAySV+tXZ2gxC3VYLXS2TKM9OKFdh90=;
 b=EImRpJ9TyBlRu/HnzyFcpsGwfJJejF7b7MT8SEBIyIk2tPPyI/T9P1zGkYyNP7YDzV
 tzm06iVKSZsJLGItHA4Pwyjm+BIM4W5OEGoebp28bwGDM5bkF958vjPWJe/1VXkGMToH
 mify985dbt4sTbFeJMULtG4lqXHpRIWPZrREbdl6Txz42UxZWFd8NnuHaD6rWODnwI40
 1KjpzkQO2PQ0B7WIAadZ7VVvUYlUvQYN6Scju20iCd+reBcBW04BVQgCTbVPkhFYma9g
 Yapf1rVR9aAzuSwGrVedfhLJt5mdfWEnRvjBJ7gZVJRSB6NaEV6ZvXq7Opegg5GlR+EB
 lHpA==
X-Gm-Message-State: APjAAAWlFLHqscIwyLtn6FBx2BABha8ZQEyiduGhmBIaPajWfBsi1T51
 szq3TXTmAFPnFVUdHabutPdPFbhlKXNsnO7IoA7kekJdM0i1Ej3Lo4+Hz5BrjvL5Rxa/0jiiv2b
 8rFgiW62lyhwCtmU=
X-Received: by 2002:adf:fa0f:: with SMTP id m15mr4775671wrr.392.1582890477936; 
 Fri, 28 Feb 2020 03:47:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwahxOejGcUYrooOz98isjVLiq45yBuIhe5WFJkm0IJ2JEUp/XhHUcozZZ87r4B+zm0T+daZw==
X-Received: by 2002:adf:fa0f:: with SMTP id m15mr4775659wrr.392.1582890477766; 
 Fri, 28 Feb 2020 03:47:57 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id v8sm11901514wrw.2.2020.02.28.03.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:47:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/18] hw/acpi/cpu_hotplug: Include "hw/pci/pci.h"
Date: Fri, 28 Feb 2020 12:46:41 +0100
Message-Id: <20200228114649.12818-11-philmd@redhat.com>
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
X-Received-From: 205.139.110.61
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/acpi/cpu_hotplug.c calls pci_address_space_io(). Include
"hw/pci/pci.h" which declares it.

This fixes (when modifying unrelated headers):

  hw/acpi/cpu_hotplug.c:103:28: error: implicit declaration of function 'pc=
i_address_space_io' is invalid in C99 [-Werror,-Wimplicit-function-declarat=
ion]
      MemoryRegion *parent =3D pci_address_space_io(PCI_DEVICE(gpe_cpu->dev=
ice));
                             ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/cpu_hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 9c3bcc84de..3e687d227a 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
 #include "hw/i386/pc.h"
+#include "hw/pci/pci.h"
 #include "qemu/error-report.h"
=20
 #define CPU_EJECT_METHOD "CPEJ"
--=20
2.21.1


