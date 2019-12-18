Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C989C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689E12176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnUPh49R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689E12176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZ3V-0002Vi-Fg
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY43-0007Z5-I3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY42-00049s-9e
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:27 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY42-000475-1L
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:26 -0500
Received: by mail-wm1-x333.google.com with SMTP id 20so1485472wmj.4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RqZ6EtuRaEedpHWuCxAMFOQ9c7FiAv/LhujsQ09biqY=;
 b=bnUPh49REdb5UYwxnJyJq3R2GGpHWfII7Hl5hO9viXcccHW2FZwV4zKSmCm0+jedbr
 5hoRmdxS4stlEgOqNwNUe5ybXMF7s3hyP4XkOqGlyEXNilhTVaJH88wRFqWv5Oi/jj1t
 65YxhEGfpCuMS9+pB4/TA0PVhAw3KrbRdBLbf1mSwwzaWolbhCQ2O9xxzX+L/VQTWbOr
 o7yZ7qKG6oXxnmzD4XQ9kCw+ArbIjW1S4tLx0+w/xR/hJKzk/Vb3qBC3SGVqnZQ8Avkt
 kSQv7hyanzk9Gna3g5kGydnrOo+NmM7NWt+Rk5ECb+Pan4VKv/11ZySdVxm7b4m91672
 +/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RqZ6EtuRaEedpHWuCxAMFOQ9c7FiAv/LhujsQ09biqY=;
 b=ReAIG7W4po8xK7xW2pUZDZvg60MxOhmqUxrGONxcBtxWW63HAfSQLFRD+uCaD0EELf
 t3ByeJ1sohMxDh3qyqP7D7R8dj4SoprOxip2naz0FfZFS3T0WNSm0gwkONqy9c0HrNm7
 PCiCRX0uQt5HrwQEOrPnifBDGORf9tFH9h/kc0oxIrJKCLmxJl9OnquEkCwb8BIj8qPs
 WDgRs3AolYpCs2N6Xrk6ovDm/1WMgH5OVvzOelZzfoWuWRz+dRA/AfrAn5ENYacY4/Ec
 dpFYzFetsnfo5f+UVknFR2iQk52riBp7lGpwkYUVOgaj3V7enCfUhUbX3fQw08+LZjyL
 EJqQ==
X-Gm-Message-State: APjAAAXZ9vD7sKxzUYIJljoYx6bz5cdQWktUtMMGoaj2XlPkIM78fExS
 ZW+z9YxPR9/NLIHLOGGf8WWeP0n7
X-Google-Smtp-Source: APXvYqwL+K5r9yIeL6/zLurLszf+jK8yLl3+g74D7D3p5YdsM77snXttRg+Ilc0Itzm7qwW7eLLUiQ==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr2957558wmc.111.1576670664758; 
 Wed, 18 Dec 2019 04:04:24 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 82/87] hw/pci-host: Add Kconfig entry to select the IGD
 Passthrough Host Bridge
Date: Wed, 18 Dec 2019 13:02:48 +0100
Message-Id: <1576670573-48048-83-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Add the XEN_IGD_PASSTHROUGH Kconfig option.

Xen build has that option selected by default. Non-Xen builds now
have to select this feature manually.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191209095002.32194-7-philmd@redhat.com>
Acked-by: Paul Durrant <paul@xen.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/Kconfig       | 5 +++++
 hw/pci-host/Makefile.objs | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index b0aa835..9642c77 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -1,6 +1,11 @@
 config PAM
     bool
 
+config XEN_IGD_PASSTHROUGH
+    bool
+    default y
+    depends on XEN && PCI_I440FX
+
 config PREP_PCI
     bool
     select PCI
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index fa6d155..9c466fa 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -14,7 +14,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) += versatile.o
 common-obj-$(CONFIG_PCI_SABRE) += sabre.o
 common-obj-$(CONFIG_FULONG) += bonito.o
 common-obj-$(CONFIG_PCI_I440FX) += i440fx.o
-common-obj-$(CONFIG_PCI_I440FX) += xen_igd_pt.o
+common-obj-$(CONFIG_XEN_IGD_PASSTHROUGH) += xen_igd_pt.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) += q35.o
 common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) += gpex.o
 common-obj-$(CONFIG_PCI_EXPRESS_XILINX) += xilinx-pcie.o
-- 
1.8.3.1



