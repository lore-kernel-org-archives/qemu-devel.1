Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19940C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6292204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwhnzKwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6292204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k548W-00089v-4X
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k547m-0007gv-UO
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:29:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:36705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k547l-0000fC-33
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:29:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id 3so7657827wmi.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Y5p6tnd5BAiBsFkbSTHI4azK3cPkhW4bGUgbGxdos+c=;
 b=ZwhnzKwVPynqNs5iI1MqhvEoIq+E70wTNkVFDtXUo+ftk39qsRYZtCHeP8hMcukGjm
 o5/Xxm/w1UgIpmGsQVnHnAa9itAys+Uf+tyi2DDjVdRubwshQuCPWUCrJEJrDfQlxUPI
 /LFvR4fRtiQHWvd50nt2ooZVvRXM9/+zKsru3SmLbRoMwMVjztpx6m+PiVj8Cf5G/F7t
 KxX14qr03PS82JFj+wmB1yJ9FkVOG+mSo+LrkKs9YD6hEwAUWznOI1f3EqP44Q/8R156
 iINfTrS9bP6opaCDtq02j6nC1zE+Herx6wJb/6U8B1muLb9aEjj/Hr3/KdR+OHEIOhAe
 KPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Y5p6tnd5BAiBsFkbSTHI4azK3cPkhW4bGUgbGxdos+c=;
 b=IEvXD3Tw3GyNIsoD02qyNTTwT8kcCwqMgt2dCBCnj2lZsiyOq+Nu6f98aGINCKbJto
 iuFoMN8ZD5TR1vPEBSNfBoq5tU/m9zHq4wKDa660BqnMQqeadGNDjtPBNfEXyHa4+tLQ
 JY0kSPV12WLjHw9Q2Z+JjRDcACg5OxxHxknw8cfnRDAXVEoKzO6ITZ6N8kdFaVE475wx
 Rv4PaGMibw6zNTKJPh2kb6KqKdDIvxlEXLT29VdqNOEJgri3B/3X/y/iitYVa7SM8dXb
 3TSxM6goxCqvVOVdDX7C3NhvdtLIhcpOzaYA0hRQN3uWIMc0vbgl9FqaZJrgkoMQ0YxZ
 Z96Q==
X-Gm-Message-State: AOAM5338/WkSd4x2HktVeeL9mMLSM4iHVHOGZQrcWe9AdSoXR80TW4ED
 wKGOe8NcVX55ZWT3bZe0fY8XZGFW
X-Google-Smtp-Source: ABdhPJxKcsKhsD/4ov37pHhTP544hx3MMuQPnzzs6BQPZ/bGqJYXu9Y4K9He24P1MKx6bn83W9USXw==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr25395694wmk.145.1597051782815; 
 Mon, 10 Aug 2020 02:29:42 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id
 t133sm24891209wmf.0.2020.08.10.02.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 02:29:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1 v2] acceptance: use stable URLs for the Debian and
 Ubuntu installer
Date: Mon, 10 Aug 2020 11:29:41 +0200
Message-Id: <20200810092941.154911-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel and initrd hashes seem to have changed for the Bionic
aarch64 installer, causing BootLinuxConsole.test_aarch64_xlnx_versal_virt
to fail.  Correct the paths to use the previous binaries instead of
the latest.  Do the same for the Lenny alpha installer for
consistency, even though those are unlikely to change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 73cc69c499..57ba6328de 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -336,13 +336,13 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=device:arm_gicv3
         """
         kernel_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
-                      'bionic-updates/main/installer-arm64/current/images/'
+                      'bionic-updates/main/installer-arm64/20101020ubuntu543.15/images/'
                       'netboot/ubuntu-installer/arm64/linux')
         kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         initrd_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
-                      'bionic-updates/main/installer-arm64/current/images/'
+                      'bionic-updates/main/installer-arm64/20101020ubuntu543.15/images/'
                       'netboot/ubuntu-installer/arm64/initrd.gz')
         initrd_hash = 'd385d3e88d53e2004c5d43cbe668b458a094f772'
         initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
@@ -822,7 +822,7 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=machine:clipper
         """
         kernel_url = ('http://archive.debian.org/debian/dists/lenny/main/'
-                      'installer-alpha/current/images/cdrom/vmlinuz')
+                      'installer-alpha/20090123lenny10/images/cdrom/vmlinuz')
         kernel_hash = '3a943149335529e2ed3e74d0d787b85fb5671ba3'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
-- 
2.26.2


