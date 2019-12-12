Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0EBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61443214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 13:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7BHyjNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61443214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifOdL-0006TQ-UB
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 08:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyp-0004DP-0P
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifNyn-0007ex-Nn
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifNyn-0007dg-Fc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:54:05 -0500
Received: by mail-wm1-x335.google.com with SMTP id p17so2391054wma.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 04:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5sLKEsC2AjqCYXP02DMsL82Clyu5WweyfT29QYZ6O8w=;
 b=W7BHyjNICO3HQoVmcTNvWa+W1/N0jTgubmwDbqtBDfwikx6x2U8pkX+swYe+PIJHHF
 WJaGcgkIUjp4G/c3Qon05VN/QIn7fIvwDDLcQ8Sc9gKAjlLANd2rNuxBhuenR3rcPlxQ
 rUEbVyKfnDLss2D98Pz2fn6iMd2ipfGCIXDRw8VZlckvHNMHq9FlbFSc2T60iab+Db3e
 9SuiVH1kfK7Uojwko+cZ6huU6WjW1Ttir/i7eiNnY2DZ8JyOCtGx7JIc/UDPuwFv0nYA
 BqrT/E7syOPM2hP/N1gmZJh8qdzkAX06aPYpOu4EQe+HbksfXAnNtWcbsMxbwj29TQ3m
 7BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5sLKEsC2AjqCYXP02DMsL82Clyu5WweyfT29QYZ6O8w=;
 b=jSSYN6t4wvqs3YIllGrF08r+1U87BCLOU/B03t4LWPhhAg7gxrlzhS6T+Rm9hrEkyE
 tVbmpTUJi3VrKjwfgLFg7JhCBCCVIMmrHv9+Qz9oKy72dZGtSfblkZBG6oT357s5kxmD
 pZPNZwPWrceW2jW9NQSfcrobZ1BvNGqCN/VKzbr6AcrqwTY2L19/kPvvyQifBDNhuUwb
 8XV7Lyihg40IXBZ627p/umMXBOuBStOXcuPtu6qyeUHE9Y2yOqBbS7d2lTdh0WXmde2H
 +TsQy0//w1VZkZlHJxWUIwoZQwrw1VB/XEjaGHeJ+yzp7eS0lORBuR0CgIQfH4QkYIG8
 /MBA==
X-Gm-Message-State: APjAAAWbBx/oO76TKYEWaGAhxluYXzomMEamRRPEViLXrgFnt4UAI9Ts
 TZKgLUaPKPrCUL3Clj5RRqYMZU3G
X-Google-Smtp-Source: APXvYqze+HnRgSQH2c7rAST6/EYRYw8RKVylv+k7ggbvh806W6kkxNaO4n0i6AEtlRgZA7tjIPU8Qg==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr6831350wmh.30.1576155244308; 
 Thu, 12 Dec 2019 04:54:04 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n189sm5193825wme.33.2019.12.12.04.54.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 04:54:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 066/132] meson: convert hw/smbios
Date: Thu, 12 Dec 2019 13:51:50 +0100
Message-Id: <1576155176-2464-67-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/Makefile.objs        |  1 -
 hw/meson.build          |  1 +
 hw/smbios/Makefile.objs | 10 ----------
 hw/smbios/meson.build   | 13 +++++++++++++
 4 files changed, 14 insertions(+), 11 deletions(-)
 delete mode 100644 hw/smbios/Makefile.objs
 create mode 100644 hw/smbios/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 1e23cb9..f5c2ab4 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -35,7 +35,6 @@ devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-y += virtio/
 devices-dirs-y += watchdog/
 devices-dirs-$(CONFIG_MEM_DEVICE) += mem/
-devices-dirs-y += smbios/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index 66a2f6c..80da62d 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,3 +1,4 @@
 subdir('core')
 subdir('semihosting')
+subdir('smbios')
 subdir('xen')
diff --git a/hw/smbios/Makefile.objs b/hw/smbios/Makefile.objs
deleted file mode 100644
index 23bb2ba..0000000
--- a/hw/smbios/Makefile.objs
+++ /dev/null
@@ -1,10 +0,0 @@
-ifeq ($(CONFIG_SMBIOS),y)
-common-obj-y += smbios.o
-common-obj-$(CONFIG_IPMI) += smbios_type_38.o
-common-obj-$(call lnot,$(CONFIG_IPMI)) += smbios_type_38-stub.o
-else
-common-obj-y += smbios-stub.o
-endif
-
-common-obj-$(CONFIG_ALL) += smbios-stub.o
-common-obj-$(CONFIG_ALL) += smbios_type_38-stub.o
diff --git a/hw/smbios/meson.build b/hw/smbios/meson.build
new file mode 100644
index 0000000..9e762c7
--- /dev/null
+++ b/hw/smbios/meson.build
@@ -0,0 +1,13 @@
+smbios_ss = ss.source_set()
+smbios_ss.add(files('smbios.c'))
+smbios_ss.add(when: 'CONFIG_IPMI',
+              if_true: files('smbios_type_38.c'),
+              if_false: files('smbios_type_38-stub.c'))
+
+softmmu_ss.add_all(when: 'CONFIG_SMBIOS', if_true: smbios_ss)
+softmmu_ss.add(when: 'CONFIG_SMBIOS', if_false: files('smbios-stub.c'))
+
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files(
+  'smbios-stub.c',
+  'smbios_type_38-stub.c',
+))
-- 
1.8.3.1



