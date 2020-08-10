Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA36C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBDB20578
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 18:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAyGmUzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBDB20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5CPJ-0000K6-1o
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 14:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BMI-0004G3-UV
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:13:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29889
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BMG-0003Pw-7t
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=dYdKiCkdStqxDQTQYURdCoB9Apg77KU1oTgN49LYhQ0=;
 b=iAyGmUzHrkYWBV0spLecB58VYDrTxWdKZ6WrLex+ysZlJB5HvWK5xzzRNBtJV9JxCzLLwo
 0FjDlYiC4gkokUJQ8Bo0u/tAdxBANr+AlcnQShMVQ6G7LoVY/CXDhrnp3jN7VlYoXuYLRS
 jko6Y+HwIfKa5fO18Uwtl50szK0LeKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-g12LH0hSPFe1XhiQn8Rcog-1; Mon, 10 Aug 2020 13:13:07 -0400
X-MC-Unique: g12LH0hSPFe1XhiQn8Rcog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3A19800473
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:13:06 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8F2F5F1E9
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:13:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 145/147] acceptance: use stable URLs for the Debian and Ubuntu
 installer
Date: Mon, 10 Aug 2020 19:09:03 +0200
Message-Id: <1597079345-42801-146-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 73cc69c..57ba632 100644
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
1.8.3.1



