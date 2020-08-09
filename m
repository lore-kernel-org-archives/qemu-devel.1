Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DAAC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 22:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34679206D8
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 22:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlFF2+Ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34679206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4txW-0001Ic-G9
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 18:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k4twr-0000q6-W8
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 18:37:50 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k4twp-0003vH-Vg
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 18:37:49 -0400
Received: by mail-wm1-x341.google.com with SMTP id 9so6088005wmj.5
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2020 15:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9ZZmwIxo4qTqyVKX9ndi1Z4icWtyhCpIqbnEgequLhw=;
 b=dlFF2+KoceNAAh8ay5WuevbNmQIPuHsqcgCLAIromA3ZFYIBVliY8HbKXFTfVEdXdF
 Bj/zuy9sfYqBT8xkOF1FXm2QP5uINqXlsZvtwXaVXRCbY4PeCX8+l/whra/RzoWFndiB
 1l9CNOundQmS3N074b/ioLqFGuz8VrtoRxE7rGxf4Whh9RFC2OPTER5yCRpiasVO1FHf
 0nEmyaTQ8y/bpRVEWUZ966pC0b+cEX0uB0R+ybRu4A4Mp6TEk4xQtT3FK9bGQEKeh033
 nOQZsZlUxDi/vSa7sYdcyrpY2luCuK8m7xbuJ06gmumJvCbbYNo+hX2rMzNutgnGsurM
 CtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=9ZZmwIxo4qTqyVKX9ndi1Z4icWtyhCpIqbnEgequLhw=;
 b=QQbzPCWrvRos7rfmtiMux7KFOtEYFJOr1GzBU3kIsG05TvONgE5kjEFWQtMIb21uGs
 NbBviIoK4Nnc4NfUqdqvnj6PUhsOCNuKmEXjnhbpTc6yXChnqPm+XHsl2IPUp8g5tI8I
 uNVPAgdTHYPpunZdNPTPrgpXRecKglRxVYXJAT9fDNNChdDsfrqvBXgK/3bITm5WO5vq
 MOPG+xHC2KLjYxTLWoDpmrOkuETF2O9wmMXz6C0AT6SJqchjZz2Hw4CAJ43qhgKMv/Hm
 +cj8GnvaA9o9FkRzzjyUyUZ2NgoLbWnreN6rKz7dsrqZhdLI4X/pYew+84zVoa+LTEbX
 XzCw==
X-Gm-Message-State: AOAM533xR+RhKo4DlIXicsAPvu01tkNlb812UWrC6qUNIG5rsZkIuZa/
 EHXZNBzIJ3PZ7RxcjJ6iuff7a9I2
X-Google-Smtp-Source: ABdhPJwHLu/u+WiW4WbmDVWFqa80ysisHayAK6Qr7BvY+vZGAe7SmGofoLomQQ5doVb210l7YyXeXQ==
X-Received: by 2002:a1c:5f44:: with SMTP id t65mr21134807wmb.99.1597012664241; 
 Sun, 09 Aug 2020 15:37:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id
 m16sm17869600wrr.71.2020.08.09.15.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2020 15:37:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] acceptance: update asset hashes for the Bionic aarch64
 installer
Date: Mon, 10 Aug 2020 00:37:41 +0200
Message-Id: <20200809223741.56570-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel and initrd hashes seem to have changed for the Bionic
aarch64 installer, causing BootLinuxConsole.test_aarch64_xlnx_versal_virt
to fail.  Correct them based on the latest.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 73cc69c499..1fcd154a7c 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -338,13 +338,13 @@ class BootLinuxConsole(LinuxKernelTest):
         kernel_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
                       'bionic-updates/main/installer-arm64/current/images/'
                       'netboot/ubuntu-installer/arm64/linux')
-        kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
+        kernel_hash = 'd6d17cc43d14f503493bd38e8277870f2b79132e'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         initrd_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
                       'bionic-updates/main/installer-arm64/current/images/'
                       'netboot/ubuntu-installer/arm64/initrd.gz')
-        initrd_hash = 'd385d3e88d53e2004c5d43cbe668b458a094f772'
+        initrd_hash = '7363cd9211b572add76a68df086be24545813b5f'
         initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
 
         self.vm.set_console()
-- 
2.26.2


