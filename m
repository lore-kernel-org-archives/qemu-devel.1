Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF72DC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8408420716
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 18:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/IShE9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8408420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwVZe-0008Ac-Ng
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 13:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6Q-0001nQ-3V
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV6O-0004z6-VL
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:50743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV6O-0004ws-N0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:56:40 -0500
Received: by mail-wm1-x329.google.com with SMTP id a5so3530569wmb.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rlcX0g3gZr1RKZ26KMKoAK10o27TGbBldeE4UAtXzII=;
 b=K/IShE9R+4WNkfWJPvewnZlNJYr/rQ4T3szEJuRmAzNC8b/VVayhnlRAWwTWiLlX98
 DtIzn4P/aXexMYKjRY7uMAFDyaIMcKJGC8s1JmvinYnFfF2N45NyS62JXXPFXSTDv0Do
 gGAFkPloHEjA2mO7NHWl3KE5W8QnMC2Y5yjNGIG/GFHhqCMD0A5HANAJD1z/JsfMhDIZ
 t1g6xyCXFxL9ilNeLrWd7KUZkdWnBoeU7KUs1xmalbqmrrvPamiZ+Z09MKjdy+KuZ3GK
 LZh8nbCnjT3v8VEU2R40WScC48brwsL5YL8d8qXJXP1bGJlU/em95DBbJuM5aU76WV9g
 ft8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rlcX0g3gZr1RKZ26KMKoAK10o27TGbBldeE4UAtXzII=;
 b=YLUEnQHM4DR6FhDiREUHNTvi361mkNdLxEq55R778wKpnuIb32FmSt5WNraCRqw8gj
 2maXnmW3BFAqMi/6nmNOiC7f9qjfsB6VtQNRhhy1a5LcBFg+1l+jCVmtj5pxj3jrz31f
 ufLlqOomZZirieseBTVRPBi1WIFUrRvz9VesbYFoO092DKhXoDxK4GlVCLIFEDiypEWQ
 QjaUB55E4va9qip2qAZQqvB0jDTil4++hPNsZfD11kWplLPO2I2GbWZfKqu7WMgF+fX/
 86VN+zhvsV7kqpWxTybhDUDqR9vFrqmB6+Q5wu1EzXb2zzxhBZxbvcwuAnwepnBo5tY/
 hezQ==
X-Gm-Message-State: APjAAAW5++psiiAYTHSPZW8MzyduUcFYTrykOs3nk3bsyUk9CBRODsJ/
 Jrm+p6JigzUsV34SO6NQtmlmmLzT
X-Google-Smtp-Source: APXvYqyohJIWgJKJ5ZxiPkHtxXqGdWGSnLUjrizc14UZ0qqcPaicBCT1cFEwCP7W8o8JkHUUKd+gdg==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr6515223wmb.33.1580234199559; 
 Tue, 28 Jan 2020 09:56:39 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.56.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:56:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 072/142] meson: convert hw/nubus
Date: Tue, 28 Jan 2020 18:52:32 +0100
Message-Id: <20200128175342.9066-73-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs       | 1 -
 hw/meson.build         | 1 +
 hw/nubus/Makefile.objs | 4 ----
 hw/nubus/meson.build   | 7 +++++++
 4 files changed, 8 insertions(+), 5 deletions(-)
 delete mode 100644 hw/nubus/Makefile.objs
 create mode 100644 hw/nubus/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 3501559584..29c4aa20b7 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,6 @@ devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
-devices-dirs-$(CONFIG_NUBUS) += nubus/
 devices-dirs-y += smbios/
 endif
 
diff --git a/hw/meson.build b/hw/meson.build
index 66a2f6cddd..03ef30212e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
 subdir('core')
+subdir('nubus')
 subdir('semihosting')
 subdir('xen')
diff --git a/hw/nubus/Makefile.objs b/hw/nubus/Makefile.objs
deleted file mode 100644
index 135ba7878d..0000000000
--- a/hw/nubus/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-common-obj-y += nubus-device.o
-common-obj-y += nubus-bus.o
-common-obj-y += nubus-bridge.o
-common-obj-$(CONFIG_Q800) += mac-nubus-bridge.o
diff --git a/hw/nubus/meson.build b/hw/nubus/meson.build
new file mode 100644
index 0000000000..9287c633aa
--- /dev/null
+++ b/hw/nubus/meson.build
@@ -0,0 +1,7 @@
+nubus_ss = ss.source_set()
+nubus_ss.add(files('nubus-device.c'))
+nubus_ss.add(files('nubus-bus.c'))
+nubus_ss.add(files('nubus-bridge.c'))
+nubus_ss.add(when: 'CONFIG_Q800', if_true: files('mac-nubus-bridge.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_NUBUS', if_true: nubus_ss)
-- 
2.21.0



