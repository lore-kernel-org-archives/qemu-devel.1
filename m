Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2166C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC9F246AC
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUj6SSB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC9F246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eDx-0004Jk-OV
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e8h-0002Gi-9p
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e8b-0001gH-Ms
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:49:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25393
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e8b-0001fa-JQ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpvhBcgDEFXbW4nnsILUgB/YwCbsH+JgLvDjsUesnxw=;
 b=YUj6SSB9Ta0MX0beBL5PUKYoH6oH9xU4RKP5pha9kutCTYAlKNKAq8TizJA6S0DAjbM+3u
 pzZqjDl6lfX4LGj2py4QDfibebfTt+W07tDojMUhtMTOsdJ/6s2vePoOMR+850Q4/PZF6m
 ZTVebsWmdQJz5BrcM6Zj3WoGw+c8/rs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-WuA10LXOPia12mY7TbPupw-1; Fri, 28 Feb 2020 06:48:57 -0500
X-MC-Unique: WuA10LXOPia12mY7TbPupw-1
Received: by mail-wm1-f69.google.com with SMTP id j130so1046319wmj.9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TAAC6hBU6t+zLFkPHrngSmK6nZvpAvnMhu+yhsKCpbQ=;
 b=igVsA/9tfqBL9IEgw1oYHzdJG2naErDMSqgp2Ygnza6nyFmu23iNyqdDu/+19K4Sx+
 QzeAHhPcpp7CT8bU2lxfAgCic3m7S5SZ0k1ICf3MrRCLaVKnk5uNY8IIM7EFLBzUzSGY
 xUYxaWwHOqBPgEmXJoQVmXCvtY5lGfH8H7i8L4DJ5kmnmTbHuzr0YZJDs4gq9324ZZw7
 Ydb2qLv7tUFXXRt/d9O4I8U/uBtLbt73/A6sjtplVXPTSY0fdP9lPMR6O8aSakByPjnX
 M9qdOx38/pVQSS76xMcSD3BJgwsAyhYwG35NHpXJZ/ir8l4iqKXtJXsHVhdbdqIYfqr8
 q2mA==
X-Gm-Message-State: APjAAAUy50cp/sJbKgwp/X6B8Afut4ownv2yhT9O/KVQrS4WM4MTIAov
 N8FsiXIkEO57bLBAd8KwoeHoj5TN0s0/cnSgYt7mjLqGSVcPb2vm5ukqSU3b1xOwgd+LnPzBwb/
 OtiZyZwqG2MrChao=
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr4452250wma.84.1582890535988; 
 Fri, 28 Feb 2020 03:48:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZl9sQglFXX2f58Og2cQLISqqwnYjcxfrvyrAnaP7z/50j7WPYiaW2EQvhFtgE5mUHQ9bYdA==
X-Received: by 2002:a05:600c:2503:: with SMTP id
 d3mr4452232wma.84.1582890535765; 
 Fri, 28 Feb 2020 03:48:55 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id 133sm2082799wmd.5.2020.02.28.03.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:48:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/18] hw/pci-host/q35: Remove unused includes
Date: Fri, 28 Feb 2020 12:46:48 +0100
Message-Id: <20200228114649.12818-18-philmd@redhat.com>
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
X-Received-From: 205.139.110.120
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
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only q35.c requires declarations from "hw/i386/pc.h", move it there.
Remove all the includes not used by "q35.h".

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/pci-host/q35.h | 7 -------
 hw/pci-host/q35.c         | 1 +
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 47086c645e..070305f83d 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -22,16 +22,9 @@
 #ifndef HW_Q35_H
 #define HW_Q35_H
=20
-#include "hw/isa/isa.h"
-#include "hw/sysbus.h"
-#include "hw/i386/pc.h"
-#include "hw/isa/apm.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
-#include "hw/acpi/acpi.h"
-#include "hw/acpi/ich9.h"
 #include "hw/pci-host/pam.h"
-#include "hw/i386/intel_iommu.h"
 #include "qemu/units.h"
 #include "qemu/range.h"
=20
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index a9b9ccc876..993f467668 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -29,6 +29,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/i386/pc.h"
 #include "hw/pci-host/q35.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
--=20
2.21.1


