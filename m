Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C980DC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:30:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957B220757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6JHY9vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957B220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3ec-0008TV-QI
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3Xh-0004vG-SW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3X8-0007NU-M8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45231
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU3X8-0007I4-96
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588231377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q+fi+ab969SQu9dA9GtFzLVvXM+17Y97fMPjeA0Nq50=;
 b=b6JHY9vb0Zp79fdSMo5LliQNkdyDlchOBkTvGqSZUe7RsN6aKSXj9Hack40K8mPC+GJEio
 oi9UwEX1TDHjTNvaEpF336rjT1kok69Y5waKY4KQ0IHyhDsCi+HPJcexBRruJyrs6nLr1e
 PCApAak/pdYaV/+KKwdLK2tLYfnGiTg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-QseMpGmSOViJKwJ0JVriLw-1; Thu, 30 Apr 2020 03:22:54 -0400
X-MC-Unique: QseMpGmSOViJKwJ0JVriLw-1
Received: by mail-wm1-f69.google.com with SMTP id n17so217556wmi.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 00:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KdRNZgdA5b0/C1y3FdN4GHVKxlSt7z8OY/WJHLHVpMc=;
 b=AjkYBfBqcLd0EBYXPOWa3KN4KofETkCVKiBo2O7+JY3aTzUiNoekSNkaWJtx33J9Ge
 FptuLW/MMYwFcq7/FeNr2YTk3weKBwp2/cuIpBTRmIvj5/BzLwNlfZuxfdbaFcefv7xW
 KT/xUld3Ad2OOFrRnyiZKlVX5q9fEuRVqHfkXLDVQph/wkaaA6DVWh7XP4uCdo3LR4l/
 /0L4x1TbF7y67gg//cVxvcX7+EfwV+UlLAb4DWi2EGz+kZU9gKai35MHdFIaaVIg3hnx
 4Ng4tAGa+5UaJ8WNtCLCXWve6GV7tEP6WFpCJ8CCcMlgZLpOev2aCqdJlDI5a3oZDLYj
 Stpw==
X-Gm-Message-State: AGi0Pubwudszq/ClwcGLdBKNDc86Ni86icCUmL2KwrOPKuxKjF2m7wxf
 hJaw6mQmpU6cJk5afu2U4xJI8BMPL35U49ouukEn9SQi8us7IQdX3NhIH3y4f4/BGGTpaTB9ve5
 Hi4muc6TPWS5kqQM=
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr1689358wrc.424.1588231373484; 
 Thu, 30 Apr 2020 00:22:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypKF7yPCdUWEh+3iH/Y0z1EBLHDUuEyIcnM2H7dEfe6LYecxTSPXLA3CXfad+fqPYM5+pJ36ZQ==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr1689346wrc.424.1588231373333; 
 Thu, 30 Apr 2020 00:22:53 -0700 (PDT)
Received: from localhost.localdomain (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id h2sm2838826wro.9.2020.04.30.00.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 00:22:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] stubs: add pci_create_simple
Date: Thu, 30 Apr 2020 09:22:39 +0200
Message-Id: <20200430072240.18142-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200430072240.18142-1-philmd@redhat.com>
References: <20200430072240.18142-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Needed for -soundhw cleanup.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200429110214.29037-3-kraxel@redhat.com>
[PMD: Use g_assert_not_reached()]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 stubs/pci-bus.c     | 7 +++++++
 stubs/Makefile.objs | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 stubs/pci-bus.c

diff --git a/stubs/pci-bus.c b/stubs/pci-bus.c
new file mode 100644
index 0000000000..a8932fa932
--- /dev/null
+++ b/stubs/pci-bus.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "hw/pci/pci.h"
+
+PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index c61ff38cc8..5e7f2b3f06 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -40,6 +40,7 @@ stub-obj-y +=3D target-get-monitor-def.o
 stub-obj-y +=3D vmgenid.o
 stub-obj-y +=3D xen-common.o
 stub-obj-y +=3D xen-hvm.o
+stub-obj-y +=3D pci-bus.o
 stub-obj-y +=3D pci-host-piix.o
 stub-obj-y +=3D ram-block.o
 stub-obj-y +=3D ramfb.o
--=20
2.21.1


