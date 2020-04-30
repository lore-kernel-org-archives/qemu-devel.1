Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90373C83002
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15EC720757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKkJ6w0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EC720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3dQ-0006wR-15
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3Xg-0004ta-Qb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU3X2-00075T-Gk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:23:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46671
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU3X2-00072c-0F
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 03:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588231370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVhlFpv+f84RpzWP6OH4lJHW+HRs9QdFeUz5yKsHN0A=;
 b=gKkJ6w0jFo8gbR035HLO+e4FNYbLvzTMBHynBE0voxigIYjiHQn/Eui6bBh4moyngKxods
 RrS1AoNRZoi5PHZ/kIocRsHwcvzpb7yK+3rfZakpL2d6wwSUMoZGEuDfbIARAi0FPdQ6yc
 3/i8/6SlYIJiJWX3Qu3tQBxcuJOeleA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-278CWI6UPWuuldCYRBo3KA-1; Thu, 30 Apr 2020 03:22:49 -0400
X-MC-Unique: 278CWI6UPWuuldCYRBo3KA-1
Received: by mail-wm1-f71.google.com with SMTP id w2so422717wmc.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 00:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jZUXhb8YNetWww0w5AYbEk8Tg0zEUWH0ZLnlt3/8i5I=;
 b=eIHTxviAszGBAJaWRH/k8OYcSCUEBeqF8RKKoo1hSxX16dIBFiscWJqNaktvquOISZ
 9caxvaBr7p6H3RooFgJ/WF3Ztiic1di4UUZDxFJJqQMldIsMJ/YbhcE5J/KvHj4g9HUQ
 KZxB7zMOLxKVbTTZWNTLCJM2KMWLd1Is3er3vwMPKbBWdMTtZ2GT6jL76HBr55iDMsQ2
 RqoYO486uObfNVLHzPIdy7n9QUs66FQ6hl+4egZOtjf6hUpWBnxK39w6OUtgljCrHgaS
 o21tWr34F8H+BUM6TbUGx+lsYgidBmcYYCCEca3EqGfunDSDVz7szPJdaq0J60d3qXne
 ZwOg==
X-Gm-Message-State: AGi0PuZobEddMo4vfdbaRt9kWsgcq4BJDSbON63eSVPCC14fbI6rRPMm
 6ax96rL1Z0c2GnKbyWQvxKT/1sCA2FDGtUkK+YItGCsS+0t2d/1TYtv7GNFUCNFyfrW2rjZvuff
 UfNBV6xMaqgsGlr0=
X-Received: by 2002:a5d:4e02:: with SMTP id p2mr2374940wrt.302.1588231368190; 
 Thu, 30 Apr 2020 00:22:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKmX3CuGFQCU7zwOwstmpdFzj8EjvdrPSLUg8UWfxJBSCGRVipbrLoa+2peurN2K6+sVgAsjA==
X-Received: by 2002:a5d:4e02:: with SMTP id p2mr2374911wrt.302.1588231367983; 
 Thu, 30 Apr 2020 00:22:47 -0700 (PDT)
Received: from localhost.localdomain (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id 92sm2730272wrm.71.2020.04.30.00.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 00:22:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] stubs: add isa_create_simple
Date: Thu, 30 Apr 2020 09:22:38 +0200
Message-Id: <20200430072240.18142-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200430072240.18142-1-philmd@redhat.com>
References: <20200430072240.18142-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Message-Id: <20200429110214.29037-2-kraxel@redhat.com>
[PMD: Use g_assert_not_reached()]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 stubs/isa-bus.c     | 7 +++++++
 stubs/Makefile.objs | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 stubs/isa-bus.c

diff --git a/stubs/isa-bus.c b/stubs/isa-bus.c
new file mode 100644
index 0000000000..522f448997
--- /dev/null
+++ b/stubs/isa-bus.c
@@ -0,0 +1,7 @@
+#include "qemu/osdep.h"
+#include "hw/isa/isa.h"
+
+ISADevice *isa_create_simple(ISABus *bus, const char *name)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 45be5dc0ed..c61ff38cc8 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -13,6 +13,7 @@ stub-obj-y +=3D get-vm-name.o
 stub-obj-y +=3D iothread.o
 stub-obj-y +=3D iothread-lock.o
 stub-obj-y +=3D is-daemonized.o
+stub-obj-y +=3D isa-bus.o
 stub-obj-$(CONFIG_LINUX_AIO) +=3D linux-aio.o
 stub-obj-$(CONFIG_LINUX_IO_URING) +=3D io_uring.o
 stub-obj-y +=3D machine-init-done.o
--=20
2.21.1


